From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 19/22] refs.c: add methods for misc ref operations
Date: Fri,  8 Aug 2014 09:45:06 -0700
Message-ID: <1407516309-27989-20-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIq-00085S-Fb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbaHHQpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:36 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:60540 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so1474377pab.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XmQ7lk8OLxDuFpYhyBJdSrbo/mrQwEq4y7VXiX77pOo=;
        b=NyXkMniY8J1WfpJpjfvtObqerjaOu1o+u8sOqTznvyAXNsAk/Wjm4QQL01ubJWtrXm
         rK2hxAAROHYDptkySuRZoI6MxkA3SqKj6aqP6bTt4ejYoin0Ewl/0Egz0CXoZILiaHC4
         lbJvQshRbjXX5Fa4ej49lcuHyabD/m4hhj5so0I99tq3qK2y21uJEuJax5oQPHsYZ0w1
         MgD9STYZNMfV5xL1h1IbzwjT+KXPmk0i4kxBZ58ZSj+SWl3m3rPrdNTozEwMeIRytcOg
         aqCnU0BgK/s3mIJqt2FC7V/+1VdWUCSEC588s+ZoKo9DZQDCa/zOon6Gv/hY/bSVMDW2
         HuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XmQ7lk8OLxDuFpYhyBJdSrbo/mrQwEq4y7VXiX77pOo=;
        b=OOosP6jFuvxbsdgqH0+5KW9UlfA01IYnOyXGdDmnkMXifxFmqvsFxlvf1BeY7IiG/I
         +UMPnwxLF5PCJ/leHtq4Ro1LD+3FBKGAx2CZ8rPHGCNHoZJf/fj6mb9Ze7q0Ypz1F/A0
         a1wbA0A41W9PbUkxFCXL8LDov9IxszL4lRZh3CchD491KGD80XpsdmKGu5A3tIRZ+e4c
         2U1uCgj09zzZ+rAgwtPWlx3kD2I/k4OlhJpOu5MzOgtbticbAVSpB44USAiPxhZYTVwP
         oQOHS8nRs7ASqQQdaIe3QmtwSD/Qw/ou+YYuXRuIUGD8pA6ApxVFMnPLUUM5BkhoGvuQ
         f1vQ==
X-Gm-Message-State: ALoCoQlgbj5rcPAb3LdmcjXPeDaImzZthDcwFXZmTDJIWPipCAyo0dB6K9BP0aRRw6O3ZktiZthQ
X-Received: by 10.70.89.10 with SMTP id bk10mr8052795pdb.4.1407516316091;
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si504383yhk.4.2014.08.08.09.45.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D471A31C5C0;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B749FE0AA5; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255033>

Add ref backend methods for
	resolve_ref_unsafe_fn resolve_ref_unsafe;
	is_refname_available_fn is_refname_available;
	pack_refs_fn pack_refs;
	peel_ref_fn peel_ref;
	create_symref_fn create_symref;
	resolve_gitlink_ref_fn resolve_gitlink_ref;

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 33 +++++++++++++++++++++++++++++++++
 refs.c        | 23 ++++++++++++++++-------
 refs.h        | 21 +++++++++++++++++++++
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 083964f..45e6fca 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -870,3 +870,36 @@ int delete_reflog(const char *refname)
 {
 	return refs->delete_reflog(refname);
 }
+
+const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1,
+			       int reading, int *flag)
+{
+	return refs->resolve_ref_unsafe(ref, sha1, reading, flag);
+}
+
+int is_refname_available(const char *refname, const char **skip, int skipnum)
+{
+	return refs->is_refname_available(refname, skip, skipnum);
+}
+
+int pack_refs(unsigned int flags, struct strbuf *err)
+{
+	return refs->pack_refs(flags, err);
+}
+
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	return refs->peel_ref(refname, sha1);
+}
+
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	return refs->create_symref(ref_target, refs_heads_master, logmsg);
+}
+
+int resolve_gitlink_ref(const char *path, const char *refname,
+			unsigned char *sha1)
+{
+	return refs->resolve_gitlink_ref(path, refname, sha1);
+}
diff --git a/refs.c b/refs.c
index 49fd360..c4076f3 100644
--- a/refs.c
+++ b/refs.c
@@ -1114,7 +1114,8 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
-int is_refname_available(const char *refname, const char **skip, int skipnum)
+static int files_is_refname_available(const char *refname, const char **skip,
+				      int skipnum)
 {
 	if (!is_refname_available_dir(refname, get_packed_refs(&ref_cache),
 				      skip, skipnum))
@@ -1188,7 +1189,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
 }
 
-int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
+static int files_resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	int len = strlen(path), retval;
 	char *submodule;
@@ -1247,7 +1248,7 @@ static const char *handle_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+static const char *files_resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
@@ -1466,7 +1467,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
@@ -2095,7 +2096,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags, struct strbuf *err)
+static int files_pack_refs(unsigned int flags, struct strbuf *err)
 {
 	struct pack_refs_cb_data cbdata;
 
@@ -2468,8 +2469,9 @@ static int write_ref_sha1(struct ref_lock *lock,
 	return 0;
 }
 
-int create_symref(const char *ref_target, const char *refs_heads_master,
-		  const char *logmsg)
+static int files_create_symref(const char *ref_target,
+			       const char *refs_heads_master,
+			       const char *logmsg)
 {
 	const char *lockpath;
 	char ref[1000];
@@ -3317,6 +3319,13 @@ struct ref_be refs_files = {
 	.reflog_exists			= files_reflog_exists,
 	.create_reflog			= files_create_reflog,
 	.delete_reflog			= files_delete_reflog,
+
+	.resolve_ref_unsafe		= files_resolve_ref_unsafe,
+	.is_refname_available		= files_is_refname_available,
+	.pack_refs			= files_pack_refs,
+	.peel_ref			= files_peel_ref,
+	.create_symref			= files_create_symref,
+	.resolve_gitlink_ref		= files_resolve_gitlink_ref,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index f630e20..c56bfcd 100644
--- a/refs.h
+++ b/refs.h
@@ -384,6 +384,19 @@ typedef int (*reflog_exists_fn)(const char *refname);
 typedef int (*create_reflog_fn)(const char *refname);
 typedef int (*delete_reflog_fn)(const char *refname);
 
+typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
+		unsigned char *sha1, int reading, int *flag);
+
+typedef int (*is_refname_available_fn)(const char *refname, const char **skip,
+				       int skipnum);
+typedef int (*pack_refs_fn)(unsigned int flags, struct strbuf *err);
+typedef int (*peel_ref_fn)(const char *refname, unsigned char *sha1);
+typedef int (*create_symref_fn)(const char *ref_target,
+				const char *refs_heads_master,
+				const char *logmsg);
+typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
+				      unsigned char *sha1);
+
 struct ref_be {
 	transaction_begin_fn transaction_begin;
 	transaction_update_sha1_fn transaction_update_sha1;
@@ -399,6 +412,14 @@ struct ref_be {
 	reflog_exists_fn reflog_exists;
 	create_reflog_fn create_reflog;
 	delete_reflog_fn delete_reflog;
+
+	resolve_ref_unsafe_fn resolve_ref_unsafe;
+	is_refname_available_fn is_refname_available;
+	pack_refs_fn pack_refs;
+	peel_ref_fn peel_ref;
+	create_symref_fn create_symref;
+	resolve_gitlink_ref_fn resolve_gitlink_ref;
+
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.553.geee1b3e
