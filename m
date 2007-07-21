From: Jeff King <peff@peff.net>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 02:24:48 -0400
Message-ID: <20070721062448.GA8722@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org> <20070721050912.GB20622@coredump.intra.peff.net> <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org> <20070721061857.GB29820@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC8Oo-00066G-NV
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772AbXGUGZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbXGUGZD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:25:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1266 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755441AbXGUGZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 02:25:00 -0400
Received: (qmail 14332 invoked from network); 21 Jul 2007 06:25:18 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jul 2007 06:25:18 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jul 2007 02:24:48 -0400
Content-Disposition: inline
In-Reply-To: <20070721061857.GB29820@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53146>

On Sat, Jul 21, 2007 at 02:18:57AM -0400, Jeff King wrote:

> correct to me (though there are some unrelated formatting changes which
> made it a little harder to read).

By which I mean you can keep the 'for' loop, since in either case we are
always reading p->next (if we skip, then we set *pp to p->next anyway,
and if we don't, then pp becomes a pointer to p->next).

So this is a more readable patch which I believe is equivalent.

---
diff --git a/revision.c b/revision.c
index 28b5f2e..7def867 100644
--- a/revision.c
+++ b/revision.c
@@ -1329,10 +1329,11 @@ static void remove_duplicate_parents(struct commit *commit)
 	/* Examine existing parents while marking ones we have seen... */
 	for (p = commit->parents; p; p = p->next) {
 		struct commit *parent = p->item;
-		if (parent->object.flags & TMP_MARK)
+		if (parent->object.flags & TMP_MARK) {
+			*pp = p->next;
 			continue;
+		}
 		parent->object.flags |= TMP_MARK;
-		*pp = p;
 		pp = &p->next;
 	}
 	/* ... and clear the temporary mark */
