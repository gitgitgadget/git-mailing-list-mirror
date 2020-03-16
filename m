Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB28C18E5B
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 03:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EA620409
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 03:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wpnl64cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgCPDsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:48:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41072 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgCPDsE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 23:48:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so3269195qtq.8
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 20:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2vFCs5R9V9zY3OofOIGwWE+KiVZ9VbNR7yiVb/qlMk=;
        b=wpnl64czmxY+gPGImh/TUURdg8TUqo9Z5hYdsJYCjcfletns+7JmI/LOsnaf+st8nY
         V70SehY2MPlL4JlgWnbOD5OG0yKLZe7yy1L5WUVu6xNTliQ3B5Iw2OsqFzR+WIwFHQ7d
         a4uEX15qT+IujHWpiETImJr0JAub3LtPRtzszLkpo4iaaIIJDrvlTD1R3/ZMD4LCm0n4
         Zg6g0Ou77YLuf9p57o/vREbuF63ZeolaleF4CXgdhmtPeQDM3BooOTSviXZif+dYwP0i
         vJ/xLNIwpeNSymOp5Qk42twjKRAGUSzrI/jBBFyK4DEw5f4ULvlRVx5FGNCyb2Ui7Nwf
         iTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2vFCs5R9V9zY3OofOIGwWE+KiVZ9VbNR7yiVb/qlMk=;
        b=MTVzrAvcRGtIlFWIxJkONDlErMVBDLbSVZcnnMdv8fn8/DpHjcoic+19bQMSgGXeai
         j6oifTeSPHfoKQ1nhpXzcbSDix6ZRBTFZOk3aNYSXzveFZ54wgvcHyGRnDYnzsdRd42J
         IhQ3c8086qTqaTdYm4795eq4UwTbo7sHQI+cHz6hu2bUxVbRcENbUeOHuD5WQ/jPf1zd
         noGiqYTtvMSYn78vJGfm5LagfffaJvZ3HSqRbUkxnJNGBPJDXZj4yE8cCDv7SzxMA6uk
         G2dqL/an3IT8M4IXLO5K3T18LI7KrajQfajpHw9l2emvHDVQL4uwhb10RFmu4Rq3HD9Z
         rzkg==
X-Gm-Message-State: ANhLgQ3PsH5DVr4dv0Q5GVhhts58hKewzsOGs0c85+ejRLY4PYZUqCKy
        dRWSIjtm2mxqRvr/aXfK/QW6YVpZtJg=
X-Google-Smtp-Source: ADFU+vsSxDKyKaVWwACYXXY3h5lDxXFmNLMLmP8mTVaDpw+QPndb7JjDBtdCjRezJUSph1h7kRiTXw==
X-Received: by 2002:ac8:6957:: with SMTP id n23mr23543998qtr.79.1584330482834;
        Sun, 15 Mar 2020 20:48:02 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id r3sm3705930qkd.3.2020.03.15.20.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 20:48:02 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH 2/2] dir: improve naming of oid_stat fields in two structs
Date:   Mon, 16 Mar 2020 00:47:27 -0300
Message-Id: <6fee28469e49d501e5184162bc820350f60cc3de.1584329834.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1584329834.git.matheus.bernardino@usp.br>
References: <cover.1584329834.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both "struct untracked_cache" and "struct dir_struct" contain fields of
the type "struct oid_stat". The latter used to be called "sha1_stat"
before 4b33e60 ("dir: convert struct sha1_stat to use object_id",
2018-01-28). Although this struct was renamed, the previously
mentioned fields are still named in the format "ss_*", which refers to
the old "sha1_stat". Since this might be confusing, rename those fields
as "st_*", referring to "stat", instead.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Note: I choosed to use "st_*", as naming, for simplicity, and to keep
the code lines small. But should we use a more verbose "oidst_*" format,
instead, to avoid confusions with "struct stat"?

 dir.c                                | 28 ++++++++++++++--------------
 dir.h                                |  8 ++++----
 t/helper/test-dump-untracked-cache.c |  4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index ab2e5b8717..e678c8184c 100644
--- a/dir.c
+++ b/dir.c
@@ -2613,15 +2613,15 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
-	if (!oideq(&dir->ss_info_exclude.oid,
-		   &dir->untracked->ss_info_exclude.oid)) {
+	if (!oideq(&dir->st_info_exclude.oid,
+		   &dir->untracked->st_info_exclude.oid)) {
 		invalidate_gitignore(dir->untracked, root);
-		dir->untracked->ss_info_exclude = dir->ss_info_exclude;
+		dir->untracked->st_info_exclude = dir->st_info_exclude;
 	}
-	if (!oideq(&dir->ss_excludes_file.oid,
-		   &dir->untracked->ss_excludes_file.oid)) {
+	if (!oideq(&dir->st_excludes_file.oid,
+		   &dir->untracked->st_excludes_file.oid)) {
 		invalidate_gitignore(dir->untracked, root);
-		dir->untracked->ss_excludes_file = dir->ss_excludes_file;
+		dir->untracked->st_excludes_file = dir->st_excludes_file;
 	}
 
 	/* Make sure this directory is not dropped out at saving phase */
@@ -2884,14 +2884,14 @@ void setup_standard_excludes(struct dir_struct *dir)
 		excludes_file = xdg_config_home("ignore");
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_patterns_from_file_1(dir, excludes_file,
-					 dir->untracked ? &dir->ss_excludes_file : NULL);
+					 dir->untracked ? &dir->st_excludes_file : NULL);
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
 		const char *path = git_path_info_exclude();
 		if (!access_or_warn(path, R_OK, 0))
 			add_patterns_from_file_1(dir, path,
-						 dir->untracked ? &dir->ss_info_exclude : NULL);
+						 dir->untracked ? &dir->st_info_exclude : NULL);
 	}
 }
 
@@ -3037,8 +3037,8 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	ouc = xcalloc(1, sizeof(*ouc));
-	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
-	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
+	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->st_info_exclude.stat);
+	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->st_excludes_file.stat);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
@@ -3046,8 +3046,8 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	strbuf_addbuf(out, &untracked->ident);
 
 	strbuf_add(out, ouc, sizeof(*ouc));
-	strbuf_add(out, untracked->ss_info_exclude.oid.hash, hashsz);
-	strbuf_add(out, untracked->ss_excludes_file.oid.hash, hashsz);
+	strbuf_add(out, untracked->st_info_exclude.oid.hash, hashsz);
+	strbuf_add(out, untracked->st_excludes_file.oid.hash, hashsz);
 	strbuf_add(out, untracked->exclude_per_dir, strlen(untracked->exclude_per_dir) + 1);
 	FREE_AND_NULL(ouc);
 
@@ -3250,10 +3250,10 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
-	load_oid_stat(&uc->ss_info_exclude,
+	load_oid_stat(&uc->st_info_exclude,
 		      next + ouc_offset(info_exclude_stat),
 		      next + offset);
-	load_oid_stat(&uc->ss_excludes_file,
+	load_oid_stat(&uc->st_excludes_file,
 		      next + ouc_offset(excludes_file_stat),
 		      next + offset + hashsz);
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
diff --git a/dir.h b/dir.h
index 5855c065a6..4d30816271 100644
--- a/dir.h
+++ b/dir.h
@@ -186,8 +186,8 @@ struct untracked_cache_dir {
 };
 
 struct untracked_cache {
-	struct oid_stat ss_info_exclude;
-	struct oid_stat ss_excludes_file;
+	struct oid_stat st_info_exclude;
+	struct oid_stat st_excludes_file;
 	const char *exclude_per_dir;
 	struct strbuf ident;
 	/*
@@ -334,8 +334,8 @@ struct dir_struct {
 
 	/* Enable untracked file cache if set */
 	struct untracked_cache *untracked;
-	struct oid_stat ss_info_exclude;
-	struct oid_stat ss_excludes_file;
+	struct oid_stat st_info_exclude;
+	struct oid_stat st_excludes_file;
 	unsigned unmanaged_exclude_files;
 };
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index cf0f2c7228..71a47e974b 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -56,8 +56,8 @@ int cmd__dump_untracked_cache(int ac, const char **av)
 		printf("no untracked cache\n");
 		return 0;
 	}
-	printf("info/exclude %s\n", oid_to_hex(&uc->ss_info_exclude.oid));
-	printf("core.excludesfile %s\n", oid_to_hex(&uc->ss_excludes_file.oid));
+	printf("info/exclude %s\n", oid_to_hex(&uc->st_info_exclude.oid));
+	printf("core.excludesfile %s\n", oid_to_hex(&uc->st_excludes_file.oid));
 	printf("exclude_per_dir %s\n", uc->exclude_per_dir);
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
-- 
2.25.0

