From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 01/21] refs: add a backend method structure with transaction functions
Date: Fri,  5 Feb 2016 14:44:02 -0500
Message-ID: <1454701462-3817-2-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:44:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJI-0000vJ-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbcBEToo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:44 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33762 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945AbcBETon (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:43 -0500
Received: by mail-qk0-f178.google.com with SMTP id s5so38304243qkd.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EI/j7xnx+p8Gb0V5q1X7v4TQjVLNBdbmCqA9Yo3IQ5M=;
        b=ULS1Lb/125Wh4F9k4txqm+NRSJbCtGVkH52YpyMzYk3p8SLrbF7WUa67uePFxcF2bu
         Xhcx8+ntpxA9eICc63DA2irCuPtWZ3wGhaAkTPHphRkXqNl0eC3wzolbEPB0UMb6yvTL
         ZISj/a4i9WpYbbKweliyRRWYOE2sJGjQM4bjinQJTxYkbLrStSEI3Rx1BciNmyfcl6zJ
         ebA69YAH2xuPm0qqJ8kscCBLPz/LqCiRoQ64keQyq1XN3KsMMngS/LuRWDYoe4pVDyfB
         OZiUagcmKI7jBlg9p/dr3utF1jGSvqHbFHGwiBpr2LozX10PKuBD+KJr8WECzO/wm0Yz
         Iouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EI/j7xnx+p8Gb0V5q1X7v4TQjVLNBdbmCqA9Yo3IQ5M=;
        b=Qg6fHLcQUEj8Yt+EsRHB/8EGiLjByZama8Ui9e2EcpcsrClKe02k8BkTZi/qz7jMbx
         WVnljGSPnJQNLBJW5o0Yv3URt6CA6eK6zZ6PLC0exPWFt5ia+tyg/sYd4ZZhUvRbWLXu
         02tbwljR+xBcpFilcIQ1WsqNHwhzWMk31D3k81vCjDhCKktoeqIzo+gpEKn6XVVMDF4k
         C8/ydn6IIvp4L+jbsf2eTuthiekoassYL8aJqGgZbJ9lnBVxueTv/ew8kOZXpkBztcA7
         lThys6fPkL7xiHmos0LbisMXKhSg/J3jGd6jQVR9O1Dz3fmkknply2GLPLpp4gz6+YGY
         gBDA==
X-Gm-Message-State: AG10YOTd5lcas3cwFcuEstRv8uUTihmndtCymuP90NhaQ1hqvsL06V/gLQNDd+8Jg4JlSg==
X-Received: by 10.55.20.208 with SMTP id 77mr12850607qku.98.1454701482110;
        Fri, 05 Feb 2016 11:44:42 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285602>

From: Ronnie Sahlberg <sahlberg@google.com>

Add a ref structure for storage backend methods. Start by adding a
method pointer for the transaction commit function.

Add a function set_refs_backend to switch between storage
backends. The files based storage backend is the default.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 40 ++++++++++++++++++++++++++++++++++++++++
 refs.h               |  7 +++++++
 refs/files-backend.c | 10 ++++++++--
 refs/refs-internal.h | 12 ++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e2d34b2..1c646f5 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,39 @@
 #include "tag.h"
 
 /*
+ * We always have a files backend and it is the default.
+ */
+static struct ref_storage_be *the_refs_backend = &refs_be_files;
+/*
+ * List of all available backends
+ */
+static struct ref_storage_be *refs_backends = &refs_be_files;
+
+int set_ref_storage_backend(const char *name)
+{
+	struct ref_storage_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 0;
+		}
+	return 1;
+}
+
+int ref_storage_backend_exists(const char *name)
+{
+	struct ref_storage_be *be;
+
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name)) {
+			the_refs_backend = be;
+			return 1;
+		}
+	return 0;
+}
+
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
@@ -1082,3 +1115,10 @@ int rename_ref_available(const char *oldname, const char *newname)
 	strbuf_release(&err);
 	return ret;
 }
+
+/* backend functions */
+int ref_transaction_commit(struct ref_transaction *transaction,
+			   struct strbuf *err)
+{
+	return the_refs_backend->transaction_commit(transaction, err);
+}
diff --git a/refs.h b/refs.h
index 3c3da29..5bc3fbc 100644
--- a/refs.h
+++ b/refs.h
@@ -508,4 +508,11 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
 			 reflog_expiry_cleanup_fn cleanup_fn,
 			 void *policy_cb_data);
 
+/*
+ * Switch to an alternate ref storage backend.
+ */
+int set_ref_storage_backend(const char *name);
+
+int ref_storage_backend_exists(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b569762..2a73564 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3146,8 +3146,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+static int files_transaction_commit(struct ref_transaction *transaction,
+				    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3533,3 +3533,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_storage_be refs_be_files = {
+	NULL,
+	"files",
+	files_transaction_commit,
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7dded3..fc0e852 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,4 +197,16 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
+/* refs backends */
+typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
+				      struct strbuf *err);
+
+struct ref_storage_be {
+	struct ref_storage_be *next;
+	const char *name;
+	ref_transaction_commit_fn *transaction_commit;
+};
+
+extern struct ref_storage_be refs_be_files;
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.749.g730654d-twtrsrc
