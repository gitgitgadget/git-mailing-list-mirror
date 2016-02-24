From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 14/32] refs: add method to rename refs
Date: Wed, 24 Feb 2016 17:58:46 -0500
Message-ID: <1456354744-8022-15-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPM-0003fn-27
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154AbcBXW7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:34 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34967 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759089AbcBXW73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:29 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so26980962qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8Zclv0JxcnxL3Vf5jUqnjB1MnqNcvnsrzK+doJypjk=;
        b=GdVwhUbAyIllRGlg2kNKGWucWsAz/dm+bYRRq6hfKNBADAp+G5/QTmzjvqA0M6ymc5
         CQhiuTDePP1+SYIp7frPdm0xlRdq+coP8gEf84Ks2HWwZiYtUJ07umgiuisfLLQe7chN
         UoL2uPQBCtx2+VozluhdR8kZ69GM5AluUco22UFqkL/RLV+JeBnvUbiDM4gVwaSCLq2Y
         QiRZIybGft56KetS4iGKVlC8qcG0xG3oAyV1R6szh0RzaOZgs4DC5vycFfLJKBEELDFe
         y59KFiUxkM5ErDCuxtQ9vV9ep8xJofKhvGT2HWJTQMhymTcl79gTorGou4m+yvgj4KBO
         zidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R8Zclv0JxcnxL3Vf5jUqnjB1MnqNcvnsrzK+doJypjk=;
        b=k0W4mRmwvGVBNSHGNEPrK9r1dtUvJhK8XQnG0UGDuZKjl7qVrUfezMquW5jyGX3/9S
         F5Ewq8a4sVS+n5K/J7C8G/z/bZ5DhKrNDsxScfFuR7RGxZmcIOmLok5l4n92FCJ78/kK
         Lw1HnkrIM6Vih3NFOAkJsgwxLcGM/lY3X3on2Dn5VeCI4ql0AboxoVh0BzIvDVJsSDYg
         HqqJzBcimb1YhyX5M/ve9vJY7dtjgLNNVDJzv7l2FaaB4kpnDyy+aAJzeYAZCqYGGdCz
         H3Z/IGtmEQR8QstC3S+T8rOWIoWZLuAapb1nWPbbHWKjRkr0nbvkeaXEdczCBQoVUb2a
         u5oA==
X-Gm-Message-State: AG10YOSmgqNNYWMptpWqXqVxljLSg6IJQRjtn2LEyoKwFUVKQ7CD9OdFaSVGvnrMSe0clQ==
X-Received: by 10.140.98.232 with SMTP id o95mr52285710qge.43.1456354768667;
        Wed, 24 Feb 2016 14:59:28 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:27 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287244>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 4 +++-
 refs/refs-internal.h | 8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index baf83ac..3a2ad5e 100644
--- a/refs.c
+++ b/refs.c
@@ -1412,3 +1412,8 @@ int delete_refs(struct string_list *refnames)
 {
 	return the_refs_backend->delete_refs(refnames);
 }
+
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 67ba4c2..4e4b852 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2368,7 +2368,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3458,6 +3459,7 @@ struct ref_storage_be refs_be_files = {
 	files_peel_ref,
 	files_create_symref,
 	files_delete_refs,
+	files_rename_ref,
 
 	files_read_raw_ref,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dfd0326..d6fe199 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -195,6 +195,11 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip);
 
+/*
+ * Check if the new name does not conflict with any existing refs
+ * (other than possibly the old ref).  Return 0 if the ref can be
+ * renamed to the new name.
+ */
 int rename_ref_available(const char *oldname, const char *newname);
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
@@ -241,6 +246,8 @@ typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
 typedef int delete_refs_fn(struct string_list *refnames);
+typedef int rename_ref_fn(const char *oldref, const char *newref,
+			  const char *logmsg);
 
 /* resolution methods */
 typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
@@ -272,6 +279,7 @@ struct ref_storage_be {
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
+	rename_ref_fn *rename_ref;
 
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.767.g62658d5-twtrsrc
