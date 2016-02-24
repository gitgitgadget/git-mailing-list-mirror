From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 11/32] refs: add method for initial ref transaction commit
Date: Wed, 24 Feb 2016 17:58:43 -0500
Message-ID: <1456354744-8022-12-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQb-0004iM-Vk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152AbcBXW7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:33 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35974 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759091AbcBXW70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:26 -0500
Received: by mail-qg0-f53.google.com with SMTP id y9so27391099qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bqq3+BSAm3nDsRhtkjWHCv+SgxMAMtwf+q359SVvCjc=;
        b=EYVE2PLiKgzxMiJz51cL43cmCnWellG8OvpyhWyyvLB3jARHr3CuAQXJQGdRKYj+3N
         8BMj2Gtwi2y/eRQsR0oeFk0p+P/e+QmMoX7NMzQYge2APdT1RNvxQq1TaJkA6KXH9jon
         9zpG1Mgrv2SxRfPdK3+Obkwx3uQ1mQu1+LIGrDw8FeSyxQ38VRSPE48OYbphG2gc0C1P
         gGE3BEsAlYuo+p/mYMmnk2/LO1TQ9Gsc0aEt4IkxKD6aocAbmlPVe6TGJiU0bPdvoQDK
         QjfgH5h57cV9MvQsOeZ0JLEOR3Zww6fkdMIjGZZQXHVwWJ/YEBVqAYsqDOu93oxS5NLs
         zzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bqq3+BSAm3nDsRhtkjWHCv+SgxMAMtwf+q359SVvCjc=;
        b=JC4T3wCtdt+Hd6uPuxHx2COi890pcuTyeWDyRWIPdouQIk4O94aokuQZG2sTVRc18+
         hGANIEDTGJVCTqE9ZyDbfcDTB7CBIf0G9oKWpd0Zk4AO/Boko62BGkeS8a5bzDytxzJg
         E7DCpwSbe1/fn1X639SiKOwgJyxnywKriDlx18iAPoudninYg2UKM1lQexy1zSSupn8J
         Hr8kreH1MPbpQ04bscjm+1iJuxWqdvxKsDqCJxZB9ut46/FPg9Qzi3i+aBNTMKKQUgXe
         oehbLg8hRqqedMxBQhdRKMn2L8cjLBBtIPXH1Vp2hTieflvZGl6cxUM7yb5AcOrj9cYt
         BT3A==
X-Gm-Message-State: AG10YOQBErgpNgjLsiRTMR4KT7I4j9zs6MSFfF9WtOsTOF6lBXIU8kM43rgA9Ffa07xMtg==
X-Received: by 10.140.105.97 with SMTP id b88mr51488708qgf.74.1456354765268;
        Wed, 24 Feb 2016 14:59:25 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:24 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287269>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 9f06686..5ae1903 100644
--- a/refs.c
+++ b/refs.c
@@ -1396,3 +1396,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5e44b10..7621a41 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3203,8 +3203,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3428,6 +3428,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c92e0c3..5aa3fa0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -255,6 +255,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
-- 
2.4.2.767.g62658d5-twtrsrc
