From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 17/48] update-ref: use err argument to get error from ref_transaction_commit
Date: Fri, 20 Jun 2014 07:42:58 -0700
Message-ID: <1403275409-28173-18-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05T-000410-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbaFTOq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:26 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:56849 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so505978vcb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P9tx/mqB/nDu7UdCVbOYhsLMcqoDn8i906GX1Vaker8=;
        b=lHtNBEYmXZIqRMDZi26oaM3Mn31Re+81G8EKyNI3kOpA3y9Yvhe/JiYym2+95Y/25H
         Vz78tXV6usp7IIFQuk2Tnz1qB6I7afhLn9ezIECwVrHpbyIFO7NOcoQ7rl7F7fkEwyVZ
         TKaApaqbrzPyI3/4NfJ0iZezhaB/OUtWtVddkCppA1g3l7A48w+9mEV4ty4/0xTPAIXW
         YQVJaUSCaheJWBSYx0LD3dVJBt4PJRILQtu+o3VBkArB8ByTun91nwngnIQLokaKBrzp
         u9kYxa+0URCod+QHi7DvKAmiq8qQbL/M2jTHGB1YBSFV3LUBUuT2RIaelmjisq39ooD4
         Jcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P9tx/mqB/nDu7UdCVbOYhsLMcqoDn8i906GX1Vaker8=;
        b=JDTSH0YhTcAwfnypVGTvR6ab95kcOwF/qm/YYouQnwPSfoO4iKuOtTKWZ/p+n5B0Sc
         N1cvV/kf/XMxra+EAdAdGDaVBrUuHHTyoZQ3pDUW6PqdDm7I5RbVU8wbCHbKzlOp2RzO
         B1mwt6tz0214DPDnS/nUo065idp+GlgY9/MFUY5Yqyu78aS0ZMVfF3KaGJS+Qm4MXF+U
         JZV9mFP8zU4QV836WMopp3bauDFZjg/aRjVUbzXj8siDu3oKbgi+h0wW+IgUnJs20XNR
         KTAKQe9yqgy3W7yzn/ACrVXuk6Ky5A75tCCtEAOrd3aes1ogJgkbHm3UXNtHVtsOgWN3
         w8fw==
X-Gm-Message-State: ALoCoQkxMd56Kp+f8Eivac3f9BafbeFOJxa9mc6T9yLW5OFOKMqDpD4Sgzc7bRK2VkKnSFer6M4j
X-Received: by 10.236.93.238 with SMTP id l74mr1293330yhf.29.1403275412766;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si432419yhh.5.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9EFAD5A40F4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7B5AFE114E; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252265>

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
2.0.0.420.g181e020.dirty
