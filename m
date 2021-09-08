Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F5AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2224761139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhIHAjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHAjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:39:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AFDC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:38:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n5so541994wro.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEf6xw8hPAuDqSw+0a54BIDm8CT8PWgMmKtMEly3Gh0=;
        b=a/THvqK25Z9DQV1bVbTApHHukeL9PO2nTaIyGLzXJNjtsh0n1U6663bMfqm4OOsJ/U
         lgG9DWw4Hy1T3FL3Yp7MYPLKt4LuKq4xrfePLYEvaTrWc1kxynK+OYZVvHwWuc81v6FL
         zs4Y/FoZ5pVBefAkZOL0Du3aZYCkkZ7M2GN2PAotFci6qOUTirVUnwuGWHuWqJNzibwG
         bwsgSjwT9t+0g3tdXhCnQ5jmGsGxT+612H2opz7nsfKoPbisjH36asYrppAZVrsNjOn2
         k0Bct5ZKv18COPNKCp6TV5M4yOeNxE7ZYAKwgMV688c1c+n304i4NsdVlY0pX0BzLpwY
         g/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEf6xw8hPAuDqSw+0a54BIDm8CT8PWgMmKtMEly3Gh0=;
        b=Q8bPwd/FO87qihEdMUTsbOVU5BJcVf9FWjPXURZmjvGLJ9XFwJL/6bOmmR5uC1XdfF
         50nGZTBmaeeWkznhlEzgXCH+S3NwgdsTGVs8O9JePh/UScpTuwYH3O4xHRpw8/SEPA1m
         ZhTEWTHdrsASlmfgnNRXERiWFpcYHsS09buG+Xbi6E+/pZYRRaqX2K2xlC6ZAbXZgdsP
         HnC1vghKUI0KvkLHAzuf8ffCKtfRptLwU+uTmnwA3Gzvv1mcNZ/bp0DZ6jXCdD8R3fV/
         SGYLDL7/11gF7V/QPXfQbwm+lvij8bT6ZCrGLUHZ5ja0zlyCiUXoZ/r9sLLEEgnfLo9g
         4TYQ==
X-Gm-Message-State: AOAM533wPwMAAEkCo3xirC1wOn3H647wOdSap0Ya+cO28MIVxGI1Axg/
        McFkFxTjpL+Up2U+tldObwEZz7WL90ZLJw==
X-Google-Smtp-Source: ABdhPJybcp1TKekwo4rhDKDqc2/cZ1WH0rMRbDlXvqpL1LLM9AJ4HQHQiDOCgXwKxLRa4DREvZo7IA==
X-Received: by 2002:adf:f541:: with SMTP id j1mr969181wrp.180.1631061512459;
        Tue, 07 Sep 2021 17:38:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm548962wmf.4.2021.09.07.17.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 17:38:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] pack-write: split up finish_tmp_packfile() function
Date:   Wed,  8 Sep 2021 02:38:27 +0200
Message-Id: <patch-v2-3.4-1205f9d0c2-20210908T003631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.gea1b153a43c
In-Reply-To: <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the finish_tmp_packfile() function and use the split-up
version in pack-objects.c in preparation for moving the step of
renaming the *.idx file later as part of a function change.

Since the only other caller of finish_tmp_packfile() was in
bulk-checkin.c, and it won't be needing a change to its *.idx
renaming, provide a thin wrapper for the old function as a static
function in that file. If other callers end up needing the simpler
version it could be moved back to "pack-write.c" and "pack.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c |  7 +++++--
 bulk-checkin.c         | 16 ++++++++++++++++
 pack-write.c           | 22 +++++++++++++---------
 pack.h                 |  7 +++++--
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f2569b5ca2..33567aaa74 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1217,6 +1217,7 @@ static void write_pack_file(void)
 		if (!pack_to_stdout) {
 			struct stat st;
 			struct strbuf tmpname = STRBUF_INIT;
+			char *idx_tmp_name = NULL;
 
 			/*
 			 * Packs are runtime accessed in their mtime
@@ -1245,9 +1246,10 @@ static void write_pack_file(void)
 					&to_pack, written_list, nr_written);
 			}
 
-			finish_tmp_packfile(&tmpname, pack_tmp_name,
+			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, hash);
+					    &pack_idx_opts, hash, &idx_tmp_name);
+			rename_tmp_packfile_idx(&tmpname, hash, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				struct strbuf sb = STRBUF_INIT;
@@ -1266,6 +1268,7 @@ static void write_pack_file(void)
 				strbuf_release(&sb);
 			}
 
+			free(idx_tmp_name);
 			strbuf_release(&tmpname);
 			free(pack_tmp_name);
 			puts(hash_to_hex(hash));
diff --git a/bulk-checkin.c b/bulk-checkin.c
index b023d9959a..ca7697e9f7 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,6 +23,22 @@ static struct bulk_checkin_state {
 	uint32_t nr_written;
 } state;
 
+static void finish_tmp_packfile(const struct strbuf *basename,
+				const char *pack_tmp_name,
+				struct pack_idx_entry **written_list,
+				uint32_t nr_written,
+				struct pack_idx_option *pack_idx_opts,
+				unsigned char hash[])
+{
+	char *idx_tmp_name = NULL;
+
+	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
+			    pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(basename, hash, &idx_tmp_name);
+
+	free(idx_tmp_name);
+}
+
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	struct object_id oid;
diff --git a/pack-write.c b/pack-write.c
index 363b395d67..09af8fccae 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -476,21 +476,28 @@ static void rename_tmp_packfile(const char *source,
 	strbuf_release(&sb);
 }
 
-void finish_tmp_packfile(const struct strbuf *basename,
+void rename_tmp_packfile_idx(const struct strbuf *basename,
+			      unsigned char hash[], char **idx_tmp_name)
+{
+	rename_tmp_packfile(*idx_tmp_name, basename, hash, "idx");
+}
+
+void stage_tmp_packfiles(const struct strbuf *basename,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char hash[])
+			 unsigned char hash[],
+			 char **idx_tmp_name)
 {
-	const char *idx_tmp_name, *rev_tmp_name = NULL;
+	const char *rev_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
-	idx_tmp_name = write_idx_file(NULL, written_list, nr_written,
-				      pack_idx_opts, hash);
-	if (adjust_shared_perm(idx_tmp_name))
+	*idx_tmp_name = (char *)write_idx_file(NULL, written_list, nr_written,
+					       pack_idx_opts, hash);
+	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
@@ -499,9 +506,6 @@ void finish_tmp_packfile(const struct strbuf *basename,
 	rename_tmp_packfile(pack_tmp_name, basename, hash, "pack");
 	if (rev_tmp_name)
 		rename_tmp_packfile(rev_tmp_name, basename, hash, "rev");
-	rename_tmp_packfile(idx_tmp_name, basename, hash, "idx");
-
-	free((void *)idx_tmp_name);
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
diff --git a/pack.h b/pack.h
index 594d5176aa..d5814f3158 100644
--- a/pack.h
+++ b/pack.h
@@ -110,11 +110,14 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(const struct strbuf *basename,
+void stage_tmp_packfiles(const struct strbuf *basename,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
-			 unsigned char sha1[]);
+			 unsigned char hash[],
+			 char **idx_tmp_name);
+void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
+			     unsigned char hash[], char **idx_tmp_name);
 
 #endif
-- 
2.33.0.819.gea1b153a43c

