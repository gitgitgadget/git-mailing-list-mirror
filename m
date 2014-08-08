From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 20/22] refs.c: add methods for head_ref*
Date: Fri,  8 Aug 2014 09:45:07 -0700
Message-ID: <1407516309-27989-21-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIU-0007cZ-QB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbaHHQpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:35 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:52062 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so1045293iec.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xY72hHWryxNCMo5fkhP4VkLFnxskGXRrq/C0aquJoaA=;
        b=clVHwfvCDgIHzwgIKYD9PFjlATHQtpbcMNWTPvrBrEUzZYvVnCiChNI+Hqk90a8uui
         hpH/a/KmxUDrucGLJYpvJcacyvDKx+3HX6n2SPyWw9oYGIz5d2OkvNDMHMUXUgnyY01u
         ghYdr3GtdGClqELbabVZ+BzXOo1NPb/b9uDhbyECUcW+pWZVxqGWXvNsI754lPVOs5os
         696/DiEhmrKaGMOaVU+XLEt8OIW4e6US2r8j6YLCgGw1q7KuAu64ctAjzMJYuFgIDkxD
         PwUWEXaHqsZcVFZMyOYGpsf42C586GJxv+MC7zZEKM5RrqY2pcRAJ6Lwknq4deW69r1S
         p/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xY72hHWryxNCMo5fkhP4VkLFnxskGXRrq/C0aquJoaA=;
        b=VLFFPi24yUmEFXY2wQ5jgbUtNwVCKYjAiIHyWN8HZh5P2SnblVmT4I58eikrJh1X9k
         UPBNPepuA7VHcJYbq3/l/uhqn2PTrFmKeM1rei+AI2M4ekLXF+Zv90Os2o92X7K2s1aW
         Q/1PSP2S26fcALRcPTSFWQ/Xmy62qORK6cE6eUCVcg1YbB5vIAzQj5HpcN7jrmif91Lp
         M8IVa5+7VXq83bqMeTLExCuYytZYZpEfenc71DkKjxWlpRukAbg7HNDA4kolZAWoml88
         /kkrVjYrkBtBarQdY1aySaI+rUhISzGmawZlthzTrN6xQNxo3rilyeMrivnyp9FjpA8B
         dgng==
X-Gm-Message-State: ALoCoQmjojPpatuFMFZgEq72cQsa2j84gfWxsD6gbsoRSJxW8t8iNfOHEMVP+3qdgCJuwavmm9D6
X-Received: by 10.50.171.233 with SMTP id ax9mr2488426igc.6.1407516316007;
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si503973yhh.5.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D1CB05A4619;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AEFF4E064D; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255031>

Add methods for the head_ref* functions.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 15 +++++++++++++++
 refs.c        | 10 +++++++---
 refs.h        |  8 ++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 45e6fca..d9308a3 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -903,3 +903,18 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return refs->resolve_gitlink_ref(path, refname, sha1);
 }
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs->head_ref(fn, cb_data);
+}
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return refs->head_ref_submodule(submodule, fn, cb_data);
+}
+
+int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+{
+	return refs->head_ref_namespaced(fn, cb_data);
+}
diff --git a/refs.c b/refs.c
index c4076f3..94d6160 100644
--- a/refs.c
+++ b/refs.c
@@ -1600,12 +1600,12 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+static int files_head_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
@@ -1636,7 +1636,7 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
-int head_ref_namespaced(each_ref_fn fn, void *cb_data)
+static int files_head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
@@ -3326,6 +3326,10 @@ struct ref_be refs_files = {
 	.peel_ref			= files_peel_ref,
 	.create_symref			= files_create_symref,
 	.resolve_gitlink_ref		= files_resolve_gitlink_ref,
+
+	.head_ref			= files_head_ref,
+	.head_ref_submodule	       	= files_head_ref_submodule,
+	.head_ref_namespaced		= files_head_ref_namespaced,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index c56bfcd..b35c406 100644
--- a/refs.h
+++ b/refs.h
@@ -397,6 +397,11 @@ typedef int (*create_symref_fn)(const char *ref_target,
 typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 				      unsigned char *sha1);
 
+typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
+				     void *cb_data);
+typedef int (*head_ref_namespaced_fn)(each_ref_fn fn, void *cb_data);
+
 struct ref_be {
 	transaction_begin_fn transaction_begin;
 	transaction_update_sha1_fn transaction_update_sha1;
@@ -420,6 +425,9 @@ struct ref_be {
 	create_symref_fn create_symref;
 	resolve_gitlink_ref_fn resolve_gitlink_ref;
 
+	head_ref_fn head_ref;
+	head_ref_submodule_fn head_ref_submodule;
+	head_ref_namespaced_fn head_ref_namespaced;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.553.geee1b3e
