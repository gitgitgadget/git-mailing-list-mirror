From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/2] diff --no-index: remove nonfunctional "-q" handling
Date: Tue, 16 Jul 2013 12:28:06 +0200
Message-ID: <1373970487-32595-2-git-send-email-stefanbeller@googlemail.com>
References: <20130714220739.GC13444@google.com>
 <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, jrnieder@gmail.com, trast@student.ethz.ch,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 16 12:28:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz2Uc-0005ds-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 12:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab3GPK2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 06:28:19 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:62590 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab3GPK2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 06:28:17 -0400
Received: by mail-we0-f171.google.com with SMTP id m46so440525wev.16
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 03:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pbS10yxS9MJw30xjEBoqeR5anxn9O1+4hKVg7NbPzI8=;
        b=W/e4d8mOLhzdrVbYMpsrzccbc2VnkbFbJoB7d7g9SoY2VmkG1rcuT711rdDUo/hk5r
         7pBRA81Ejf1QTmmlc87zrH51NUo+zEu30RbzteoGKFkWsx2wqxhzIfsn7WEg2shr6SFL
         3nAYTMr/RmBasuH8y575xfczhJud83nDSFptupaDmmeS+qHOYSrewFx9FiaHh/VXnGSb
         2amyxui/7u8dX9gelXLuUlRY195+gA/Z+i2HYBZhEkiPq9289hHSwNnZXSUkPeEuqK90
         EuKJZCKaQZKwZL5pHfvj/Qvu45Qjic7dDNXTejeHYU0r4nk5XIVEWDVmZs18uHPwqFHQ
         k/Wg==
X-Received: by 10.194.103.226 with SMTP id fz2mr610376wjb.75.1373970495463;
        Tue, 16 Jul 2013 03:28:15 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id iz8sm1417425wic.3.2013.07.16.03.28.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 03:28:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3.10.g2733812
In-Reply-To: <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230561>

Before v1.5.6-rc1~41^2~2, the option parsing for diff --no-index
and "git diff-files" shared code.  In "git diff-files", "-q" means
to be silent about removed files.  In "git diff --no-index", in
various versions it has been an error, an infinite loop, or a no-op.

Simplify the code to clarify that it is now a no-op, continuing to
accept and ignore the -q option in "git diff --no-index" to avoid
breaking scripts.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
---
 diff-no-index.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 74da659..419cd78 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -187,7 +187,6 @@ void diff_no_index(struct rev_info *revs,
 {
 	int i, prefixlen;
 	int no_index = 0;
-	unsigned options = 0;
 	const char *paths[2];
 
 	/* Were we asked to do --no-index explicitly? */
@@ -224,10 +223,8 @@ void diff_no_index(struct rev_info *revs,
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
-		else if (!strcmp(argv[i], "-q")) {
-			options |= DIFF_SILENT_ON_REMOVED;
+		else if (!strcmp(argv[i], "-q"))
 			i++;
-		}
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
-- 
1.8.2.3.10.g2733812
