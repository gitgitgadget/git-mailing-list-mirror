From: Jeff King <peff@peff.net>
Subject: Re: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 18:20:48 -0400
Message-ID: <20080820222048.GB8137@coredump.intra.peff.net>
References: <20080820140517.GA1304@atjola.homenet> <20080820172825.GC27773@sigill.intra.peff.net> <7v7iabsgfk.fsf@gitster.siamese.dyndns.org> <7vskszr0it.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVw3v-0006bJ-DT
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYHTWUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYHTWUv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:20:51 -0400
Received: from peff.net ([208.65.91.99]:3734 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343AbYHTWUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:20:50 -0400
Received: (qmail 29536 invoked by uid 111); 20 Aug 2008 22:20:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Aug 2008 18:20:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 18:20:48 -0400
Content-Disposition: inline
In-Reply-To: <7vskszr0it.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93062>

On Wed, Aug 20, 2008 at 11:42:34AM -0700, Junio C Hamano wrote:

> Ahhh, what idiot wrote the logic for checking trailing blank lines in
> checkdiff_consume().
> 
> It does not ask for any context lines.  Sheesh.
> 
> This should fix it.

Ah, that was much easier than I expected. ;)

Maybe this should be squashed in?

---
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 6110566..974efd0 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -341,4 +341,13 @@ test_expect_success 'checkdiff detects trailing blank lines' '
 	git diff --check | grep "ends with blank"
 '
 
+test_expect_success 'checkdiff does not mistake trailing blank lines in hunk' '
+	echo content >x &&
+	git add x &&
+	echo "" >x &&
+	echo content >>x &&
+	git diff --check >out &&
+	! grep "ends with blank" out
+'
+
 test_done
