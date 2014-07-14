From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 17/19] update-ref: use err argument to get error from ref_transaction_commit
Date: Mon, 14 Jul 2014 13:58:59 -0700
Message-ID: <1405371541-32121-18-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLk-00037o-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207AbaGNU7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:44 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:60952 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so375033pab.3
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQ1VqTL0Od2LlHT2gLOaZ7+Yw1L/1Jpp3F1vh/r0Kc8=;
        b=prlo2BW2Ddgl/9Iy5Ds4e+/0/zPR5JlaWxD0Qk3ScCmsYkAd971olRgBRcv1okEvcD
         uPoWlqnb4MLvbv43x8OEllQbsKZo9gwZ5tZ2aVNcWR/RPyEJ3L3weRzu9CbgDVCpZ+6u
         8IdhBhJvsu50wW9ePUdN7E6sFAsEws712SReOx3ZyKm0HUSq7ek2+4gWpjuCkQPSsYqr
         FRXK4B6NRILeQKa/h2JaV7PV6ka2u3JB2emCFKSE26yxCsnUtjHyRQDDAiYq14x0fr2Q
         kcJFMLQkbNlfw74nFT6cx6cE8OgUT4GiGxMVj+h7gQQCiDS98UvPPZbq/WnIZSXtdA0+
         uj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQ1VqTL0Od2LlHT2gLOaZ7+Yw1L/1Jpp3F1vh/r0Kc8=;
        b=micVE0OyLm5q/ZA+T/0rApg1/MmTF7GPGp/Q5L+qZtWUblsH+/Kbpsk6GmSQTGhC+b
         Gyj12heEL/LF2kikAiJMjZ9CcrPHhQ+yYqcHQLvKmsE2fHxbSCKr3Xm8XYo5jLDqpnAI
         cogp207H8uV92Up+CzLSb9AW+iTw6wspWoorP+tjICBqcjcvlzE91cIpqh63tF5RkMz+
         z8V50o5NjAv9WD93X96ex1CqfCxifiCoJcSnfMW+wCZ7sfsBvrG02ldeaJpp83JjprHx
         5LfjdSB0rR8KZvc9s69nnvf4BTineh+gqUnpjlo8klJZNwg7VShD2U2Kp1+LnxDsSFU3
         jU6A==
X-Gm-Message-State: ALoCoQk7Hbs+4UrhIPTLFwE+1LxoUz041D5nOfywDTF4cowyip8wFrRqC5XCT7DTYcq4BE2llmZy
X-Received: by 10.66.160.200 with SMTP id xm8mr317002pab.13.1405371546223;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si820544yhp.6.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0F63E5A43E5;
	Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E406EE0328; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253529>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 22617af..aec9004 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,18 +360,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
-		return ret;
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.1.546.gf603308
