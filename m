From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 18/48] update-ref: use err argument to get error from ref_transaction_commit
Date: Thu, 12 Jun 2014 10:21:09 -0700
Message-ID: <1402593699-13983-19-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hP-0006vy-FL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316AbaFLRVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:51 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:41537 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so308952iec.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISA8L0W3le3aYEZnQvI8YTDl7gDNUETtHRL5I6tOR84=;
        b=OtHgnsysVlOwnn9V0aZEwvCPSSO1uzXke3BamLusqBVxLy3W7X+D28Oj9ZPYI+s3yP
         auLMCub+dbThOTaoCIP08+8PRrg6+HSS5rfDuoi/MA948Dw3QCuDl9vqovhhe4Nq/hwM
         bBxD5Q09c3vY/o093ivJPpbxi5crWy/pINpcNw4G9oQJ3dqI8WPP3NBKkRpX81UDQiiG
         WnFikEtNeiFUVPDexPmEiuhNtH37e4uNey1aIK3qwg3QVuCrS3T2LOW/oAnEXWMfx0tD
         0j7a6giYaKW4+wnNSGf5bcPe/WJNKr+PP9Qwo9UnelQAmPaLAScrx/mx9F4rVfurEuYP
         ZbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISA8L0W3le3aYEZnQvI8YTDl7gDNUETtHRL5I6tOR84=;
        b=KOXL1wQYbDvVoUOYKIa01A7uCvgM6kmB7/92EWLmUFco6XFaw+RNgNx0xWsqiapvgp
         q89AlefBShbnclvzOfGW1LCmad3bE7X4NAiskuaj9ToN7L8krgePmKjpO470w4Un8/F8
         by1dNCY74il2rTtxLi6P1TAGZbw8sWpR2PEKxPwqUd2h1/xc1RzwGEUSUJtcy2PI4c4W
         s6ro9GaSfB6u9qWJ1CL5OL5ZIRnJHRHk56J3xtxNTFhnnvx9NBQ8g/Mf/Lb5OHbXmBrg
         Utk1gEqht2Sr5OXO+o/4ySqzIjNfKvZJXRX3vn04L4BWWRBz0nX7/0DHjVsfi7uMc5ND
         GP8w==
X-Gm-Message-State: ALoCoQlTju7BuCq2h9Gz9+Pacrk5ez3sTF+tQDtshWoynHSr9xreMjRJfbUKuaZIiTeLWci8Y0hw
X-Received: by 10.42.136.1 with SMTP id r1mr1215144ict.24.1402593703428;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si112263yhj.5.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 469B35A4749;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 24E9CE0961; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251418>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.0.0.599.g83ced0e
