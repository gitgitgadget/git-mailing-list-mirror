From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] revision.c: refactor notes ref expansion
Date: Tue, 29 Mar 2011 16:56:04 -0400
Message-ID: <20110329205604.GB23466@sigill.intra.peff.net>
References: <20110329205307.GA30959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fxW-0002rL-34
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab1C2U4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:56:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48175
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975Ab1C2U4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:56:07 -0400
Received: (qmail 321 invoked by uid 107); 29 Mar 2011 20:56:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:56:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:56:04 -0400
Content-Disposition: inline
In-Reply-To: <20110329205307.GA30959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170322>

No need to do it ourselves when there is a library function.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 0f38364..5826e5d 100644
--- a/revision.c
+++ b/revision.c
@@ -1374,13 +1374,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_notes_given = 1;
 		if (!revs->notes_opt.extra_notes_refs)
 			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
-		if (!prefixcmp(arg+13, "refs/"))
-			/* happy */;
-		else if (!prefixcmp(arg+13, "notes/"))
-			strbuf_addstr(&buf, "refs/");
-		else
-			strbuf_addstr(&buf, "refs/notes/");
 		strbuf_addstr(&buf, arg+13);
+		expand_notes_ref(&buf);
 		string_list_append(revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
-- 
1.7.4.2.7.g9407
