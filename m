From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/13] builtin-apply.c: pass ws_rule down to match_fragment()
Date: Sat,  2 Feb 2008 02:54:17 -0800
Message-ID: <1201949659-27725-12-git-send-email-gitster@pobox.com>
References: <1201949659-27725-1-git-send-email-gitster@pobox.com>
 <1201949659-27725-2-git-send-email-gitster@pobox.com>
 <1201949659-27725-3-git-send-email-gitster@pobox.com>
 <1201949659-27725-4-git-send-email-gitster@pobox.com>
 <1201949659-27725-5-git-send-email-gitster@pobox.com>
 <1201949659-27725-6-git-send-email-gitster@pobox.com>
 <1201949659-27725-7-git-send-email-gitster@pobox.com>
 <1201949659-27725-8-git-send-email-gitster@pobox.com>
 <1201949659-27725-9-git-send-email-gitster@pobox.com>
 <1201949659-27725-10-git-send-email-gitster@pobox.com>
 <1201949659-27725-11-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLG2t-0005Ue-RO
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763219AbYBBKzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763059AbYBBKzE
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:55:04 -0500
Received: from rune.pobox.com ([208.210.124.79]:50282 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762655AbYBBKy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:54:59 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DF50F1917E9
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 759BE1917E3
	for <git@vger.kernel.org>; Sat,  2 Feb 2008 05:55:18 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.g41ac4
In-Reply-To: <1201949659-27725-11-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72256>

This is necessary to allow match_fragment() to attempt a match
with a preimage that is based on a version before whitespace
errors were fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 2af625a..5f3c047 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1614,6 +1614,7 @@ static int match_fragment(struct image *img,
 			  struct image *postimage,
 			  unsigned long try,
 			  int try_lno,
+			  unsigned ws_rule,
 			  int match_beginning, int match_end)
 {
 	int i;
@@ -1656,6 +1657,7 @@ static int find_pos(struct image *img,
 		    struct image *preimage,
 		    struct image *postimage,
 		    int line,
+		    unsigned ws_rule,
 		    int match_beginning, int match_end)
 {
 	int i;
@@ -1691,7 +1693,7 @@ static int find_pos(struct image *img,
 
 	for (i = 0; ; i++) {
 		if (match_fragment(img, preimage, postimage,
-				   try, try_lno,
+				   try, try_lno, ws_rule,
 				   match_beginning, match_end))
 			return try_lno;
 
@@ -1930,8 +1932,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 
 	for (;;) {
 
-		applied_pos = find_pos(img, &preimage, &postimage,
-				       pos, match_beginning, match_end);
+		applied_pos = find_pos(img, &preimage, &postimage, pos,
+				       ws_rule, match_beginning, match_end);
 
 		if (applied_pos >= 0)
 			break;
-- 
1.5.4.2.g41ac4
