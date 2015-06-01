From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] suppress errors on missing UNINTERESTING links
Date: Mon, 1 Jun 2015 05:56:40 -0400
Message-ID: <20150601095640.GC31389@peff.net>
References: <20150601095410.GA16976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 11:57:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMT8-00034Q-TM
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 11:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbbFAJ4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 05:56:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:38667 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932075AbbFAJ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 05:56:44 -0400
Received: (qmail 22767 invoked by uid 102); 1 Jun 2015 09:56:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:56:42 -0500
Received: (qmail 27725 invoked by uid 107); 1 Jun 2015 09:56:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:56:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 05:56:40 -0400
Content-Disposition: inline
In-Reply-To: <20150601095410.GA16976@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270386>

When we are traversing commit parents along the
UNINTERESTING side of a revision walk, we do not care if
the parent turns out to be missing. That lets us limit
traversals using unreachable and possibly incomplete
sections of history. However, we do still print error
messages about the missing commits; this patch suppresses
the error, as well.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 29e5143..0b322b4 100644
--- a/revision.c
+++ b/revision.c
@@ -817,7 +817,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			parent = parent->next;
 			if (p)
 				p->object.flags |= UNINTERESTING;
-			if (parse_commit(p) < 0)
+			if (parse_commit_gently(p, 1) < 0)
 				continue;
 			if (p->parents)
 				mark_parents_uninteresting(p);
-- 
2.4.2.690.g2a79674
