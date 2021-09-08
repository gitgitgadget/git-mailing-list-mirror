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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3343EC4332F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16689610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhIHAjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhIHAjk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:39:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C42CC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:38:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q26so569789wrc.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKSO5NqG5eYlJNvLaglwAoZ6U5gCOtopvVQZt+kWIXI=;
        b=EcioPPvoeJ/W/I2fiJD+zozqZINL6F7lgcjtGqeUbGSByqrqv4uK5JcvaKIs5kbQoS
         sMuhp25QYYqu73LfSvEZYjjMBNwLWpJ+GzjJVMBLtWMNYf6/5KRxvXhgdKY3S+Zv5FXA
         2YzhCxt995uRV9FrurV72b+lWpEtM6A48wOpDxbZUkl/pFILASF3ds/kLVjm7c6c3pU1
         AB9/euunDC01dGBRtbCyvwnCHOCCkj1Av3x6WH5sxu1n/3SlaDvGrTjriXRovbM1/Hpj
         Euuh0mSTkPSQidsXRhpXaAQoD3GW6wDPoxVUjz5X8JFwPWUL55To1Ae+oNBzvetXolUR
         oG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKSO5NqG5eYlJNvLaglwAoZ6U5gCOtopvVQZt+kWIXI=;
        b=AFsrkgn2pNLAmG/EJ2aCZmkzz/f6sc6VUQe+gdKbqc+3LdjcryRDSmJiJWbj3ZsqzV
         tR1EPWIaTu/XDzudqvCI4hHcSOOKtBPkObjKASlamFliksrZbH5teIylH6tvQhRVcoJE
         t7hodVrefJ//30hw14jNVJEH10+b4DgdBh9XZ1qWXPJm9ohdmwYqAKNHMO9AX/5X40PE
         sJ10p3g/Y2+jVQRWR1iQikmiFulSXqc2Pi4YzHX8UkZ2ectSGhwxodX6qoctfpVsfjQy
         LtDg1URgvnCJFHn5aC6gLYDZtCcRYPhJiBM7MU1LoVOmiYmlyUgXrRdktCYZKGyyIKCn
         ebWg==
X-Gm-Message-State: AOAM532TE0UrNL/vsxTiDkvGKfrECF2sfIpVNF5zgyG7fMrtffZLWl87
        A9io9MUe9li60mDVyxTbha93/JisRTOc5A==
X-Google-Smtp-Source: ABdhPJyy62WOEB81otENvTeigjjSiZpr+iz6jUB9MTZ6UrZNHN7SxFHuBRbGUeKmnuFVoAMHezQSYQ==
X-Received: by 2002:adf:de09:: with SMTP id b9mr949181wrm.114.1631061511694;
        Tue, 07 Sep 2021 17:38:31 -0700 (PDT)
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
Subject: [PATCH v2 2/4] pack-write: refactor renaming in finish_tmp_packfile()
Date:   Wed,  8 Sep 2021 02:38:26 +0200
Message-Id: <patch-v2-2.4-7b39f4599b-20210908T003631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.gea1b153a43c
In-Reply-To: <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the renaming in finish_tmp_packfile() so that it takes a
"const struct strbuf *" instead of a non-const, and refactor the
repetitive renaming pattern in finish_tmp_packfile() to use a new
static rename_tmp_packfile() helper function.

The previous strbuf_reset() idiom originated with
5889271114a (finish_tmp_packfile():use strbuf for pathname
construction, 2014-03-03), which in turn was a minimal adjustment of
pre-strbuf code added in 0e990530ae (finish_tmp_packfile(): a helper
function, 2011-10-28).

Since the memory allocation is not a bottleneck here we can afford a
bit more readability at the cost of re-allocating this new "struct
strbuf sb".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c |  8 ++++++--
 pack-write.c           | 41 +++++++++++++++++++----------------------
 pack.h                 |  2 +-
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df49f656b9..f2569b5ca2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1250,7 +1250,10 @@ static void write_pack_file(void)
 					    &pack_idx_opts, hash);
 
 			if (write_bitmap_index) {
-				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
+				struct strbuf sb = STRBUF_INIT;
+
+				strbuf_addf(&sb, "%s%s.bitmap", tmpname.buf,
+					    hash_to_hex(hash));
 
 				stop_progress(&progress_state);
 
@@ -1258,8 +1261,9 @@ static void write_pack_file(void)
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				bitmap_writer_build(&to_pack);
 				bitmap_writer_finish(written_list, nr_written,
-						     tmpname.buf, write_bitmap_options);
+						     sb.buf, write_bitmap_options);
 				write_bitmap_index = 0;
+				strbuf_release(&sb);
 			}
 
 			strbuf_release(&tmpname);
diff --git a/pack-write.c b/pack-write.c
index 277c60165e..363b395d67 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -462,7 +462,21 @@ struct hashfile *create_tmp_packfile(char **pack_tmp_name)
 	return hashfd(fd, *pack_tmp_name);
 }
 
-void finish_tmp_packfile(struct strbuf *name_buffer,
+static void rename_tmp_packfile(const char *source,
+				 const struct strbuf *basename,
+				 const unsigned char hash[],
+				 const char *ext)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addf(&sb, "%s%s.%s", basename->buf, hash_to_hex(hash), ext);
+	if (rename(source, sb.buf))
+		die_errno("unable to rename temporary '*.%s' file to '%s'",
+			  ext, sb.buf);
+	strbuf_release(&sb);
+}
+
+void finish_tmp_packfile(const struct strbuf *basename,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
@@ -470,7 +484,6 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 			 unsigned char hash[])
 {
 	const char *idx_tmp_name, *rev_tmp_name = NULL;
-	int basename_len = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -483,26 +496,10 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
 				      pack_idx_opts->flags);
 
-	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
-
-	if (rename(pack_tmp_name, name_buffer->buf))
-		die_errno("unable to rename temporary pack file");
-
-	strbuf_setlen(name_buffer, basename_len);
-
-	if (rev_tmp_name) {
-		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
-		if (rename(rev_tmp_name, name_buffer->buf))
-			die_errno("unable to rename temporary reverse-index file");
-
-		strbuf_setlen(name_buffer, basename_len);
-	}
-
-	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
-	if (rename(idx_tmp_name, name_buffer->buf))
-		die_errno("unable to rename temporary index file");
-
-	strbuf_setlen(name_buffer, basename_len);
+	rename_tmp_packfile(pack_tmp_name, basename, hash, "pack");
+	if (rev_tmp_name)
+		rename_tmp_packfile(rev_tmp_name, basename, hash, "rev");
+	rename_tmp_packfile(idx_tmp_name, basename, hash, "idx");
 
 	free((void *)idx_tmp_name);
 }
diff --git a/pack.h b/pack.h
index 1c17254c0a..594d5176aa 100644
--- a/pack.h
+++ b/pack.h
@@ -110,7 +110,7 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(struct strbuf *name_buffer,
+void finish_tmp_packfile(const struct strbuf *basename,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
-- 
2.33.0.819.gea1b153a43c

