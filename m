Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FF8C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AF361152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJNAIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhJNAIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC61C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g25so13837706wrb.2
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfy+L0Ju34ELGxinFhgtLc8GWe2ePSbl6YjaNh7zGeM=;
        b=cnif7kEM82dJLLfV3bM78uquPt0AEWezA6LdBF459YXS3ef61aKbl/m+aQzpf4qZQS
         fIdseCA4nhuXu0LR258pkqtqzzKqL0sUwQkWJmvFbTYuUf7KfwLu1G6T3za1z/puC7wi
         VHh/kfDjM7f/ENUg8yFU8S445u4X4eLaI1QjvAOAIs5TlCqsi7Ob+DTGT33DeWyy2BLn
         WbQWQEdT132hfeV9slgzsWiCxCvnJAQuTXoj3rHlhI24q/0b+P6ubduW1uEJrkI7tXmX
         tmnH0INjs3EGWg3MSoAkUZUyu6lch68p8+KytgnOfJu1EFSJs1al/UmEn73USoyq84ep
         jskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfy+L0Ju34ELGxinFhgtLc8GWe2ePSbl6YjaNh7zGeM=;
        b=LVpROZyiFwyK3xu9d25CPVDtuWlNbK5yNpW3tYXfgW749ZwPouLnIHGnpmiI3BHPVN
         y1aOPjGVe+6uw1dodsOMWY3OEnStSO1RGDi1/KJPEtE92azhsmVVwLAREUsZj1cWuofF
         v6kb/9FwTP69UDyFMf7azOIxZ6C5vsY+au86yJKAk2FWE7PEh29YQSiuWGpkpSCZRbZR
         Jgl/QDmkOm91Jw0HePX6XxgHDpt+Jn33bcqgDoX0zGQQNFgKVgkcbCOHNRKEhu1DdHlQ
         hLux4+luPGKHn0ufXCBTiph8VuBcTxtWWOPGvVFLEL0OFJ7guxdk9+dZtG+Dfk8fTaY5
         x3NA==
X-Gm-Message-State: AOAM533Wfz0mblRel4ZcPZ78JJqlxp/VjsDpdDEsokfW5nfEwnYPtXzO
        bP3XAK3R7q6GJs15tH48M/AUsxdPVB9pwA==
X-Google-Smtp-Source: ABdhPJz+gRCfasqbNTctFSugDnXG6a4seIscs66pvZUJMT1LEuqtEEZZW0fsagSw9trJ8d8FWiUfEQ==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr2680504wrj.129.1634169998503;
        Wed, 13 Oct 2021 17:06:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/20] refs API: make refs_rename_ref_available() static
Date:   Thu, 14 Oct 2021 02:06:17 +0200
Message-Id: <patch-05.20-cdf17fa34a4-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
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
index b1640b5d582..4398a4c0257 100644
--- a/refs.c
+++ b/refs.c
@@ -1371,25 +1371,6 @@ const char *find_descendant_ref(const char *dirname,
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
2.33.1.1346.g48288c3c089

