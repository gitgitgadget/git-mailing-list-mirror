Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0903C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiBAOx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiBAOxY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C02C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso2158572wmh.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51pd1F1xPIlq4828HwG+r4RwyzRiNsyMQG646qOg+aI=;
        b=JxH6SMBielAd0uc6hO5V/AriGHkCvLz1M9aaKx1z27lkh+bHZUUc9Ykev0CfBuojLC
         0uIopkUnsawpqqS+nmLlsS0Fd1CBxA16OxF7nw748CYzKgKRH7SU1Yn/9hiWm/NQ8mDE
         E/TzT36JXvQarm5z/ZNd5Fh06pP7y9tLtJ8iZn4S7QwARK9VG6u89DwscbywVOcqJvlE
         wfgfSH/ONIBzXTzbVoSxXr6/omLvNHJdidVaR63s1e8bBC7pLWCWUXN6X+PwRDbx1qFD
         pXP8yJ7xDbpGHhfSMkwLLJ08BtP7XrXJUVqW3rUUg4hZ54oxxKPLoapOXMRQca8Ws5BV
         w8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51pd1F1xPIlq4828HwG+r4RwyzRiNsyMQG646qOg+aI=;
        b=xT7tup6G4pl5KrkaKT70yCrXiTWQ+elWtoZXKSPqsoufiDoUJMDy1CcOjq0SbXAdbj
         vlv55JD37+mtvAZ+p8/qDWOenDCvgey1FWote7cYtSXdOdvAphfvHDeTWpz0PD6f7xkW
         Z05jznR3J/WYVWJ34IaFgGqSaWZyF4br3pkT2/aFX/I+BwDM2v3xpJ9vrpATz7fLNtV2
         u7gUF4tQdWiP4UOUCMaau/n53hxmBFI9uZrFbiYy8ATR5wELsXW8axMFbVuE/rMD8eCr
         M6/LDPyWgzIc4Z80jdBnodjfuBM3ArAqxEIrAEzaD4U4Xy9b+rPrQDtItLuWUquKdfah
         uIUw==
X-Gm-Message-State: AOAM531WI8pMBUd45zwle8zQBlBgnEgKRvTBZ3kWDy8uxVLtKqP3TBDn
        +Vn3kTubwWyzUICzjqq/dx11XMfsGdSCyw==
X-Google-Smtp-Source: ABdhPJzW5yEumzsEWKr3e0LDiqbk4/JKRmYApoZGY8hlK9OgZjuUy+RJG/+8SfBympnlqpIptqRtQg==
X-Received: by 2002:a05:600c:21d9:: with SMTP id x25mr2106209wmj.193.1643727202169;
        Tue, 01 Feb 2022 06:53:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] object-file API: provide a hash_object_file_oideq()
Date:   Tue,  1 Feb 2022 15:53:07 +0100
Message-Id: <patch-05.10-719fcfbe13c-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide a new hash_object_file_oideq() for those callers of
check_object_signature() that don't care about its streaming
interface. I.e. at the start of that function we do:

	if (map) {
		hash_object_file(r->hash_algo, map, size, type, real_oid);
		return !oideq(oid, real_oid) ? -1 : 0;
	}

These callers always provide a "map" (or "buf[fer]"). Let's have them
call this simpler hash_object_file_oideq() function instead.

None of them use a non-NULL "real_oid" argument, but let's provide it
like check_object_signature() did. This'll make it easy to have these
emit better error messages in the future as was done in
96e41f58fe1 (fsck: report invalid object type-path combinations,
2021-10-01), i.e. the die() calls here can emit not only the OID we
expected, but also what we got.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-export.c |  4 ++--
 builtin/index-pack.c  |  5 ++---
 builtin/mktag.c       |  5 ++---
 object-file.c         | 13 +++++++++++++
 object-store.h        | 14 ++++++++++++++
 object.c              |  4 ++--
 6 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f1c730e587..f084da198c7 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -299,8 +299,8 @@ static void export_blob(const struct object_id *oid)
 		buf = read_object_file(oid, &type, &size);
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
-		if (check_object_signature(the_repository, oid, buf, size,
-					   type_name(type), NULL) < 0)
+		if (!hash_object_file_oideq(the_repository->hash_algo, buf,
+					    size, type, oid, NULL))
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 01574378ce2..5531a6d8bae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1412,9 +1412,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (!data)
 			continue;
 
-		if (check_object_signature(the_repository, &d->oid,
-					   data, size,
-					   type_name(type), NULL))
+		if (!hash_object_file_oideq(the_repository->hash_algo, data,
+					    size, type, &d->oid, NULL))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 96a3686af53..d8c7cf836b7 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -61,9 +61,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 		    type_name(*tagged_type), type_name(type));
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
-	ret = check_object_signature(the_repository, repl,
-				     buffer, size, type_name(*tagged_type),
-				     NULL);
+	ret = !hash_object_file_oideq(the_repository->hash_algo, buffer, size,
+				      *tagged_type, repl, NULL);
 	free(buffer);
 
 	return ret;
diff --git a/object-file.c b/object-file.c
index 59eb793e0ac..27d10112960 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1862,6 +1862,19 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
+int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
+			   unsigned long len, enum object_type type,
+			   const struct object_id *oid,
+			   struct object_id *real_oidp)
+{
+	struct object_id tmp;
+	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
+
+	hash_object_file(algo, buf, len, type_name(type), real_oid);
+
+	return oideq(oid, real_oid);
+}
+
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(int fd)
 {
diff --git a/object-store.h b/object-store.h
index eab1e2a967e..95907062682 100644
--- a/object-store.h
+++ b/object-store.h
@@ -249,6 +249,20 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      unsigned long len, const char *type,
 		      struct object_id *oid);
 
+/**
+ * hash_object_file_oideq() is like hash_object_file() except that
+ * asserts that "real_oid" is equivalent to an input "oid", and the
+ * return value is that of oideq(oid, real_oid).
+ *
+ * The "real_oid" can be NULL, when non-NULL the caller provides a
+ * "struct object_id *" that can be used to print what the real OID
+ * was.
+ */
+int hash_object_file_oideq(const struct git_hash_algo *algo, const void *buf,
+			   unsigned long len, enum object_type type,
+			   const struct object_id *oid,
+			   struct object_id *real_oidp);
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    enum object_type type, struct object_id *oid,
 			    unsigned flags);
diff --git a/object.c b/object.c
index c37501fc120..d7673332582 100644
--- a/object.c
+++ b/object.c
@@ -289,8 +289,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type), NULL) < 0) {
+		if (!hash_object_file_oideq(r->hash_algo, buffer, size,
+					    type, repl, NULL)) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
-- 
2.35.0.913.g12b4baa2536

