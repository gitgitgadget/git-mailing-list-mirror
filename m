From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git log: avoid segfault with --all-match
Date: Wed, 18 Mar 2009 19:06:16 +0100
Message-ID: <1237399576-27323-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 18:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk03N-0000s2-Cw
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 18:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272AbZCRR5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 13:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759173AbZCRR5u
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 13:57:50 -0400
Received: from smtp.katamail.com ([62.149.157.154]:53135 "HELO smtp2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1759026AbZCRR5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 13:57:49 -0400
Received: (qmail 21876 invoked by uid 89); 18 Mar 2009 17:57:41 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.57.140)
  by smtp2-pc with SMTP; 18 Mar 2009 17:57:41 -0000
X-Mailer: git-send-email 1.6.2.22.gc2ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113639>

Avoid a segfault when the command

	git log --all-match

was issued.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

Not sure if this is the right fix, nor if it would be better a
warning or an error.

 grep.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 062b2b6..cb4666d 100644
--- a/grep.c
+++ b/grep.c
@@ -190,7 +190,8 @@ void compile_grep_patterns(struct grep_opt *opt)
 	 * A classic recursive descent parser would do.
 	 */
 	p = opt->pattern_list;
-	opt->pattern_expression = compile_pattern_expr(&p);
+	if (p)
+		opt->pattern_expression = compile_pattern_expr(&p);
 	if (p)
 		die("incomplete pattern expression: %s", p->pattern);
 }
-- 
1.6.2.22.gc2ac
