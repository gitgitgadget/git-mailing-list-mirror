Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B351C433FE
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4623A61073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhJPJmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbhJPJlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64AC06176F
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v127so4277095wme.5
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iBHEptvkAw4q8b+yQzDkVePPfr6NEnD3mUnxcrs9pGw=;
        b=FzriWtVc75DX5wgpvRxyDXmZ6f2dq8XqkmK2eIxtmmFz3c5qfdQpGkyE2NEFjci2Qx
         zkK37gd3zbRkpRbhlOYedqL5XWgHmFcuBCAp4+pArF1KkvlA/EO1QHVi+yZ/WcuEhbts
         eHpJxtBsE2qOq0LzdZTrjh7aIZzfJDK1jBVq+w61RQ/e1EBB9oPdOUMq/3XSya/i8Sqq
         H+xGjpVd0Y4sG+jX+Ea2QwuE6v7ry10nqxU3cJja0Rcm+tDehqw9vKNJ2ePcFJatua+A
         9jdueBbxYpIJ09yC14mUY90aB2oXe36vOxZcoZ4hEqIepYWELkxB1Jvv9I30M3+X5ljr
         oNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iBHEptvkAw4q8b+yQzDkVePPfr6NEnD3mUnxcrs9pGw=;
        b=7//KrrNt8aCs3ZRP5p7otZt4vAjO7mpLjbDFD02hh5SrSDgU6Q/a4pPZLtM47/Y9eL
         yOtaeGOocoWx7KuCNthVcXb0XNVmpSNXV/ABXidd0Xq4BP8dSO/yEFm9sIu8Xe4sO1HN
         L5ZERKqyKvQ1MkTtvKsn1Vg8sVOTAJfotQgiTYZ2cVz3hNZ7b0r+8ia0W8lp7vhvdyxM
         fqFqdv7cMqP11A+Tl4RwASAqfBScy2eej0ySd8DlKVCmP/TDnwhIpFolmtr5xUglv6s8
         EZSzvfPnfc2U5Eq1T9KN6dm4BKZUp0Q1ohSMWjOm6E/MRvllI4T2F6BNMSZU4Vj6GmuQ
         Q6vw==
X-Gm-Message-State: AOAM530+3QciHUlsEWTqiYzGMTgaHoLMjdFPyZRiReI+SUtBXkyRLbF7
        eD8IAQBK3rlGP62/EYsihxijgJ0yYNbwWA==
X-Google-Smtp-Source: ABdhPJwW0oO1Qwk5b3v+rFEM7BVxfx18c5sDKZh8dhrVGFukc2W5R5vNkbAZxXfd32hJeVk99yuPrg==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr18035467wmc.117.1634377173855;
        Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/21] refs API: make refs_rename_ref_available() static
Date:   Sat, 16 Oct 2021 11:39:11 +0200
Message-Id: <patch-v2-05.21-8073f93a904-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the refs_rename_ref_available() function into
"refs/files-backend.c". It is file-backend specific.

This function was added in 5fe7d825da8 (refs.c: pass a list of names
to skip to is_refname_available, 2014-05-01) as rename_ref_available()
and was only ever used in this one file-backend specific codepath. So
let's move it there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               | 19 -------------------
 refs/files-backend.c | 29 +++++++++++++++++++++++++++++
 refs/refs-internal.h | 14 --------------
 3 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index bb09993c2f9..44ddbb14f1d 100644
--- a/refs.c
+++ b/refs.c
@@ -1372,25 +1372,6 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int refs_rename_ref_available(struct ref_store *refs,
-			      const char *old_refname,
-			      const char *new_refname)
-{
-	struct string_list skip = STRING_LIST_INIT_NODUP;
-	struct strbuf err = STRBUF_INIT;
-	int ok;
-
-	string_list_insert(&skip, old_refname);
-	ok = !refs_verify_refname_available(refs, new_refname,
-					    NULL, &skip, &err);
-	if (!ok)
-		error("%s", err.buf);
-
-	string_list_clear(&skip, 0);
-	strbuf_release(&err);
-	return ok;
-}
-
 int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c73ffd1ca33..0af6ee44552 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1363,6 +1363,35 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err);
 
+/*
+ * Check whether an attempt to rename old_refname to new_refname would
+ * cause a D/F conflict with any existing reference (other than
+ * possibly old_refname). If there would be a conflict, emit an error
+ * message and return false; otherwise, return true.
+ *
+ * Note that this function is not safe against all races with other
+ * processes (though rename_ref() catches some races that might get by
+ * this check).
+ */
+static int refs_rename_ref_available(struct ref_store *refs,
+			      const char *old_refname,
+			      const char *new_refname)
+{
+	struct string_list skip = STRING_LIST_INIT_NODUP;
+	struct strbuf err = STRBUF_INIT;
+	int ok;
+
+	string_list_insert(&skip, old_refname);
+	ok = !refs_verify_refname_available(refs, new_refname,
+					    NULL, &skip, &err);
+	if (!ok)
+		error("%s", err.buf);
+
+	string_list_clear(&skip, 0);
+	strbuf_release(&err);
+	return ok;
+}
+
 static int files_copy_or_rename_ref(struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg, int copy)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 121b8fdad08..2ecd3dea9fb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -228,20 +228,6 @@ const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip);
 
-/*
- * Check whether an attempt to rename old_refname to new_refname would
- * cause a D/F conflict with any existing reference (other than
- * possibly old_refname). If there would be a conflict, emit an error
- * message and return false; otherwise, return true.
- *
- * Note that this function is not safe against all races with other
- * processes (though rename_ref() catches some races that might get by
- * this check).
- */
-int refs_rename_ref_available(struct ref_store *refs,
-			      const char *old_refname,
-			      const char *new_refname);
-
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define SYMREF_MAXDEPTH 5
 
-- 
2.33.1.1338.g20da966911a

