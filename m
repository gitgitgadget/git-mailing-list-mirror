From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 05/23] refs.c: move delete_ref to the common code
Date: Tue, 19 Aug 2014 09:30:29 -0700
Message-ID: <1408465847-30384-6-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:31:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmJR-0002OV-8m
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbaHSQa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:30:56 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:57704 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbaHSQax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:53 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so1812679pab.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9jcWhLLDaTvVyxJMRfoFxHzTLueHB83VAm4P+t2qkx8=;
        b=QAlO7+0Snba+rg49F9t9OBjTwz1zcLFHvEcQL1Bn3eeu7lHscsvxy6at851To64hzz
         f5zKQez/p1Tyds2fnqbQHAu4tqm8FCOjRc1Vg+s4Et5yAE0hAs0qPxijL4RcOH9L4wxy
         OzCeSAVTTFhO+OlptHjzsEFuh/yW5loVe+xj9T1uwIgfoBuKYV0+woa/zh4hjG0wjwy/
         1FHVu9WuBMY8WTpw7QepRHUo/mE6YIl/DDHhJ5sr+WzGWrH8tJ0lO3LKnux/TJZMcxpA
         RTLSwLOOop5LYH2R5D+14+LE88eUEVmtKSPq3ntpkLkFVmV+0UR5Kh8c9enuUxf0HDSO
         sTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9jcWhLLDaTvVyxJMRfoFxHzTLueHB83VAm4P+t2qkx8=;
        b=KTuLxXPGrK+t07a8bT7PuyFP4JPji+F68cgZyClBsepEf8BUY6iLRPo/QO5HoeDiDk
         DjCHS9QrH46PHQReZVuIkfFCpdXn4cDapQUNcT/O3BAz5mkecYdTx+4q8YmwLjGrmTkC
         lBsZgV/oie+Bggm7jQKtFvPLnpdDcCGtdPerZyirxiRaveHi9kfJf8FdpfHhhY92l+/K
         NFT+RnEsgVDv0li6alX8dmazGyOokTgHfx1HOHgwDX8Lmh02r+voKI4OpTGXAabhnRKr
         +oNqwu3ilhpmE6SMNUslJQEC78HlgiiJO32RRxDda5YUnzqqgpIvomfGJW/Ywt0BEI0S
         8MzQ==
X-Gm-Message-State: ALoCoQl4ZrnQ5y+NCQXWraWtE30YnhNhBoyd2LL5UpGnoXcdSog33PMsVTDvuq3mlU7p29geE+c/
X-Received: by 10.66.141.70 with SMTP id rm6mr12918573pab.37.1408465853092;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h42si332677yhj.3.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D7BCC31C537;
	Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7F501E106D; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255478>

This change moves delete_ref() to the refs.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 19 -------------------
 refs.c          | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index eb66cf7..faf794c 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2622,25 +2622,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
-{
-	struct ref_transaction *transaction;
-	struct strbuf err = STRBUF_INIT;
-
-	transaction = transaction_begin(&err);
-	if (!transaction ||
-	    transaction_delete_sha1(transaction, refname, sha1, delopt,
-				    sha1 && !is_null_sha1(sha1), NULL, &err) ||
-	    transaction_commit(transaction, &err)) {
-		error("%s", err.buf);
-		transaction_free(transaction);
-		strbuf_release(&err);
-		return 1;
-	}
-	transaction_free(transaction);
-	return 0;
-}
-
 struct rename_reflog_cb {
 	struct ref_transaction *transaction;
 	const char *refname;
diff --git a/refs.c b/refs.c
index 5f6a1e7..70b12eb 100644
--- a/refs.c
+++ b/refs.c
@@ -26,3 +26,22 @@ int update_ref(const char *action, const char *refname,
 	}
 	return 0;
 }
+
+int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+{
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+
+	transaction = transaction_begin(&err);
+	if (!transaction ||
+	    transaction_delete_sha1(transaction, refname, sha1, delopt,
+				    sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		transaction_free(transaction);
+		strbuf_release(&err);
+		return 1;
+	}
+	transaction_free(transaction);
+	return 0;
+}
-- 
2.0.1.552.g1af257a
