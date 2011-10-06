From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/7] pickaxe: give diff_grep the same signature as has_changes
Date: Thu, 06 Oct 2011 18:50:18 +0200
Message-ID: <4E8DDC4A.8060001@lsrfire.ath.cx>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 18:50:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBr9T-00087B-VT
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052Ab1JFQu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 12:50:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:56174 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965047Ab1JFQu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:50:26 -0400
Received: from [192.168.2.104] (p4FFDBCAF.dip.t-dialin.net [79.253.188.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C55D2F8034;
	Thu,  6 Oct 2011 18:50:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182974>

Change diff_grep() to match the signature of has_changes() as a
preparation for the next patch that will use function pointers to
the two.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diffcore-pickaxe.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 4d66ba9..226fa0c 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -45,7 +45,8 @@ static void fill_one(struct diff_filespec *one,
 	}
 }
 
-static int diff_grep(struct diff_filepair *p, regex_t *regexp, struct diff_options *o)
+static int diff_grep(struct diff_filepair *p, struct diff_options *o,
+		     regex_t *regexp, kwset_t kws)
 {
 	regmatch_t regmatch;
 	struct userdiff_driver *textconv_one = NULL;
@@ -114,7 +115,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (diff_grep(p, &regex, o))
+			if (diff_grep(p, o, &regex, NULL))
 				goto out; /* do not munge the queue */
 		}
 
@@ -129,7 +130,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (diff_grep(p, &regex, o))
+			if (diff_grep(p, o, &regex, NULL))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
-- 
1.7.7
