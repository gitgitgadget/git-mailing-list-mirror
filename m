From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 15/33] refs: add method to rename refs
Date: Mon, 29 Feb 2016 19:52:48 -0500
Message-ID: <1456793586-22082-16-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:55:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaX-0007iF-MH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbcCAAyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:43 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35742 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcCAAxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:43 -0500
Received: by mail-qg0-f50.google.com with SMTP id y89so130585631qge.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/6MNysmoHstbHsnDIFOdlKe1WBf0EnLNmOffb6JDP4=;
        b=aA4LEqLFsL5wlH9g+OBkaPJr/XDVzMYIbXl1+PY5DJ+xvxM3VojdnZ6Ax3aSL2mnRC
         YnUzV0Z1y0Dr0nvjIKpjKu2/w//G0OdEMhkSYO/kN1sm+6+NoiLlxj15F066yi7GHY8s
         GyT2x0pK/+GjtnTQiDELZTqkOaanh26Fo5A2qIAJabetLUJPPdPlZIUTN05Hcck6+nAT
         P0yfutX0ForBEi5/C+DuMZZsgjDCb47WfUsPa6wXtV3LR68AT2aeEXiv4jSKzaBMJUJ7
         0OSNw9nm4ILBup0QJi/CVC1BnBmqima5OFUiGYUnKWAAet53CSV2bncbmvSPuLgU5UZr
         GNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/6MNysmoHstbHsnDIFOdlKe1WBf0EnLNmOffb6JDP4=;
        b=gnHC6MbYCy1YlTYUTy8ew7QzSIRd5PSjQ/bqB1f78kImPeJNxX+Xyaw4aHfxcsBPOb
         2gMFxkX7sJZ3D+AZOKRZAL8ctc7PnTfVJ8Y5zkcCUnjgKQqJtrsUkLm9HPKldYeAq5Sm
         zpcCAVdugj9HxYc7Vl46fE/oMqNDkX/V8laRyQA4dI3WQkYrrSMutCbbogqns/AhgNn5
         8MkWK+C3NNOQXQ6q/gZldZLnMqfoMP5br7ZCNZj9DHSdzhlPBOgzPeWyreY2hvWHIkVM
         oIbArE6rTLPCy0jqMmsF1TTPXms9oFpTVjBxx3JHy72kkZlbwNERD8TCfjiKoYB68bRB
         Qoww==
X-Gm-Message-State: AD7BkJKbiBY8XfFUA2pStxEPAoFKUPDSxnGq9Na4jtgCm8KqvU3yw+0ydClwdcgPtdlGhA==
X-Received: by 10.140.173.133 with SMTP id t127mr24820179qht.23.1456793622959;
        Mon, 29 Feb 2016 16:53:42 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:41 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287978>

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 4 +++-
 refs/refs-internal.h | 8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b2697f6..5364dc6 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,3 +1415,8 @@ int delete_refs(struct string_list *refnames)
 {
 	return the_refs_backend->delete_refs(refnames);
 }
+
+int rename_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return the_refs_backend->rename_ref(oldref, newref, logmsg);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index acb4401..534bbaf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2359,7 +2359,8 @@ static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     int flags, struct strbuf *err);
 
-int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
+static int files_rename_ref(const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
@@ -3449,6 +3450,7 @@ struct ref_storage_be refs_be_files = {
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
