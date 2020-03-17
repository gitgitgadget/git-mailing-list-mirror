Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6181AC1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1B520724
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 18:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="l7Z38Ja2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCQS6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:58:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46046 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCQS6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 14:58:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id z8so15070604qto.12
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVln3rObxm2GGO6t0ecAavg03ccKkcaXjzvHzlGKs+Q=;
        b=l7Z38Ja2NalyB6nH6gzLqDt8vC11U4QADI7lZG6LtwJkxmgEN/DEiQuk1I9HG1COPs
         kFpwxIRfYWYaSeQfZ+Nv/oIRYZe/V777ynEuPPhjj9FVC/e7WaMBRbdpj04P2MSWllLw
         sID3tuAnRaZJPI5gEO4pkUrxYuGIipbTS9k8jOFKEqwUMZNc4dYHIr/ZTPy1UrluZhJR
         LWSOE+nkvvc7xnzkl0ZQHIE9UKf8aegixvTx76QdC34Vq6bTwEoniTZzNdrcVsuxbbb2
         cKYeEbIPIk+OZGs6u+7JfkVo0bXBCJgsXgAtlQxC7FsnW/FT/vQLsM5AeGAenmEF9J3h
         MqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVln3rObxm2GGO6t0ecAavg03ccKkcaXjzvHzlGKs+Q=;
        b=pMcyxtT8j3b4QxH7wk4WGVM3tBFqPEoOf+w3dI1vvIKj+RVgqCQ0hPYyDd2xQnI3RZ
         ayx63lgok9d/CNX5G3JMr7qJVXqP203ASmFB5VGW8k0ykuhOBPLDGP93ZzJTZfkZYTFw
         cskiXhE62dbGcFo4uclkY6Qd8AZSxIt9ytIwkgdbMj4hZHA1v7luLf67ZbSh8c4OaNMw
         4gapNlm/5NxhpaEcVSSqXZH43N+nvwcBDsY+2qMBgiDZsCR1Yqhu0EopPdOUi4C+eTGj
         kNSZaoTgDdc3Ww4muRrQPug2Mi08EgWAnueLMuxsbrFak97AYDecoY97L1Shf2Q0xU5X
         v5jA==
X-Gm-Message-State: ANhLgQ2tMkKBN8rC/WZx7R4Q+J5sFeparJfuHU0pRJkIFA7ZcZbIymZV
        FuRUFqNIHfDQjLhryKtR6yaOes0C/Hc=
X-Google-Smtp-Source: ADFU+vvA3z535nZnGtuKOTlUYGr02Ojk/0kKyd1dLjLbtOAVdjPXrj/3zkp5r1I9c707s7E5r8mPtw==
X-Received: by 2002:ac8:60ce:: with SMTP id i14mr607742qtm.87.1584471527261;
        Tue, 17 Mar 2020 11:58:47 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id n190sm2414707qkb.93.2020.03.17.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 11:58:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, dreamer.tan@gmail.com, peff@peff.net
Subject: [PATCH v2 2/3] dir: improve naming of oid_stat fields in two structs
Date:   Tue, 17 Mar 2020 15:57:44 -0300
Message-Id: <776db73a8c2bd95f787d6398c41bc69c063be858.1584471137.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584471137.git.matheus.bernardino@usp.br>
References: <cover.1584471137.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both "struct untracked_cache" and "struct dir_struct" contain fields of
the type "struct oid_stat". The latter used to be called "sha1_stat"
before 4b33e60 ("dir: convert struct sha1_stat to use object_id",
2018-01-28). Although this struct was renamed, the previously mentioned
fields are still named with an "ss_" prefix ("ss_info_exclude" and
"ss_excludes_file"), which refers to the old "sha1_stat". As this can be
confusing, let's rename these fields. Since "struct oid_stat" is used to
query the validity of cached data, a better naming alternative would be
"info_exclude_validity" and "excludes_file_validity".

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir.c                                | 34 ++++++++++++++++------------
 dir.h                                |  8 +++----
 t/helper/test-dump-untracked-cache.c |  5 ++--
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index ab2e5b8717..92226b1af2 100644
--- a/dir.c
+++ b/dir.c
@@ -2613,15 +2613,17 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
-	if (!oideq(&dir->ss_info_exclude.oid,
-		   &dir->untracked->ss_info_exclude.oid)) {
+	if (!oideq(&dir->info_exclude_validity.oid,
+		   &dir->untracked->info_exclude_validity.oid)) {
 		invalidate_gitignore(dir->untracked, root);
-		dir->untracked->ss_info_exclude = dir->ss_info_exclude;
+		dir->untracked->info_exclude_validity =
+			dir->info_exclude_validity;
 	}
-	if (!oideq(&dir->ss_excludes_file.oid,
-		   &dir->untracked->ss_excludes_file.oid)) {
+	if (!oideq(&dir->excludes_file_validity.oid,
+		   &dir->untracked->excludes_file_validity.oid)) {
 		invalidate_gitignore(dir->untracked, root);
-		dir->untracked->ss_excludes_file = dir->ss_excludes_file;
+		dir->untracked->excludes_file_validity =
+			dir->excludes_file_validity;
 	}
 
 	/* Make sure this directory is not dropped out at saving phase */
@@ -2884,14 +2886,16 @@ void setup_standard_excludes(struct dir_struct *dir)
 		excludes_file = xdg_config_home("ignore");
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_patterns_from_file_1(dir, excludes_file,
-					 dir->untracked ? &dir->ss_excludes_file : NULL);
+					 dir->untracked ?
+					 &dir->excludes_file_validity : NULL);
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
 		const char *path = git_path_info_exclude();
 		if (!access_or_warn(path, R_OK, 0))
 			add_patterns_from_file_1(dir, path,
-						 dir->untracked ? &dir->ss_info_exclude : NULL);
+						 dir->untracked ?
+						 &dir->info_exclude_validity : NULL);
 	}
 }
 
@@ -3037,8 +3041,10 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	ouc = xcalloc(1, sizeof(*ouc));
-	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
-	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
+	stat_data_to_disk(&ouc->info_exclude_stat,
+			  &untracked->info_exclude_validity.stat);
+	stat_data_to_disk(&ouc->excludes_file_stat,
+			  &untracked->excludes_file_validity.stat);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
@@ -3046,8 +3052,8 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	strbuf_addbuf(out, &untracked->ident);
 
 	strbuf_add(out, ouc, sizeof(*ouc));
-	strbuf_add(out, untracked->ss_info_exclude.oid.hash, hashsz);
-	strbuf_add(out, untracked->ss_excludes_file.oid.hash, hashsz);
+	strbuf_add(out, untracked->info_exclude_validity.oid.hash, hashsz);
+	strbuf_add(out, untracked->excludes_file_validity.oid.hash, hashsz);
 	strbuf_add(out, untracked->exclude_per_dir, strlen(untracked->exclude_per_dir) + 1);
 	FREE_AND_NULL(ouc);
 
@@ -3250,10 +3256,10 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
-	load_oid_stat(&uc->ss_info_exclude,
+	load_oid_stat(&uc->info_exclude_validity,
 		      next + ouc_offset(info_exclude_stat),
 		      next + offset);
-	load_oid_stat(&uc->ss_excludes_file,
+	load_oid_stat(&uc->excludes_file_validity,
 		      next + ouc_offset(excludes_file_stat),
 		      next + offset + hashsz);
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
diff --git a/dir.h b/dir.h
index 5855c065a6..6c3aaeba71 100644
--- a/dir.h
+++ b/dir.h
@@ -186,8 +186,8 @@ struct untracked_cache_dir {
 };
 
 struct untracked_cache {
-	struct oid_stat ss_info_exclude;
-	struct oid_stat ss_excludes_file;
+	struct oid_stat info_exclude_validity;
+	struct oid_stat excludes_file_validity;
 	const char *exclude_per_dir;
 	struct strbuf ident;
 	/*
@@ -334,8 +334,8 @@ struct dir_struct {
 
 	/* Enable untracked file cache if set */
 	struct untracked_cache *untracked;
-	struct oid_stat ss_info_exclude;
-	struct oid_stat ss_excludes_file;
+	struct oid_stat info_exclude_validity;
+	struct oid_stat excludes_file_validity;
 	unsigned unmanaged_exclude_files;
 };
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index cf0f2c7228..568a4588bb 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -56,8 +56,9 @@ int cmd__dump_untracked_cache(int ac, const char **av)
 		printf("no untracked cache\n");
 		return 0;
 	}
-	printf("info/exclude %s\n", oid_to_hex(&uc->ss_info_exclude.oid));
-	printf("core.excludesfile %s\n", oid_to_hex(&uc->ss_excludes_file.oid));
+	printf("info/exclude %s\n", oid_to_hex(&uc->info_exclude_validity.oid));
+	printf("core.excludesfile %s\n",
+	       oid_to_hex(&uc->excludes_file_validity.oid));
 	printf("exclude_per_dir %s\n", uc->exclude_per_dir);
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
-- 
2.25.1

