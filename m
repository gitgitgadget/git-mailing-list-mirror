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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B39C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7596108D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbhIGTnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbhIGTnv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:43:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5BC06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:42:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u9so16074218wrg.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLBnghxxVIYCOmLvO+X96lpSRdRpQimPxDrz++pbeUM=;
        b=TwuS+IWP7sVjDSjGnxDp8s2vJiH2yiEXbrFYeNIJUose1ZT2Wu2c8k5TAz/Gvr9BX8
         Buat3Lxd4Ph+oDLvJTRo7hZbxUcF9rbUc+GzCrKKTFixALiDjXStgw3eifglgAferxOo
         tsk+onT/qstGJrW/Oh0cZEtafoaPauJu2uabjcvi5ReXeGiTVrb9aQys+jsJBBnuz3l3
         bVrUGEUg6YkoyNFYMWR7OrkO2XeeV4K4sWwTF7NQw364+XLzycJrnbV9AiP6JTtspkhq
         5e+RoDIVukLlt/HLdUCqpLO+A195Q832idjmqHvL0HzymvlyCG4LYYX1dDMiqFmX5FIl
         sPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLBnghxxVIYCOmLvO+X96lpSRdRpQimPxDrz++pbeUM=;
        b=b5wE7jmK0e30hVEgXqrls/KdmaJDaLIB/JqLTEJ0Ixi8b7+DAB5CbmScUaBxdTAizL
         2z6q+UB5v8mxhLH+TYUM3rOqoxcWUVrVauY8s1LggOz6i/ga0xIAYFzgWf/hf39h720d
         1IKapwvfzkEBHRiNOA3Ub4XpBJtf1FL/dk6BaI+pJJPSbtf26zrbIUZrIjZaaqNLrIo4
         GYBm9Tk88rWvtNORbThBhbi3aVD6/RpfMntmLe0RagS48VeSR0RL6fYvDRWovwkdFT+v
         XpnLQn3o4tBgRsXb9+l9Vm12QpwXjUcudWwFTotGWWLbE+sRG5Xt0RlzHLO51l2gNS3N
         ceqA==
X-Gm-Message-State: AOAM533X+yPUH4VYGe3izHVfQiNh5trLCB2AzRVIVocLELdLkOMJgMhp
        zFUCiGVuCXgoU/pF4T/82cOP/MMUsHfC+A==
X-Google-Smtp-Source: ABdhPJz0Mk34fhLAMmepiDmPAaWZZgWI5BcRisCwghN5l6vJ9QcCgJnhBhkv89t3RAL3+NfeqwfGIQ==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr29256wrw.415.1631043763172;
        Tue, 07 Sep 2021 12:42:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a10sm12075320wrd.51.2021.09.07.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:42:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] pack-write: split up finish_tmp_packfile() function
Date:   Tue,  7 Sep 2021 21:42:37 +0200
Message-Id: <patch-2.3-42f83774fe8-20210907T193600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.818.gd2ef2916285
In-Reply-To: <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the finish_tmp_packfile() function and use the split-up
version in pack-objects.c. This change should not change any
functionality, but sets up code flow for a bug fix where we'll be able
to move the *.idx in-place after the *.bitmap is written.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c |  9 ++++++---
 pack-write.c           | 39 +++++++++++++++++++++++++++++++--------
 pack.h                 |  9 +++++++++
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 717003563db..9fa4c6a9be8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1217,6 +1217,7 @@ static void write_pack_file(void)
 		if (!pack_to_stdout) {
 			struct stat st;
 			struct strbuf tmp_basename = STRBUF_INIT;
+			char *idx_tmp_name = NULL;
 
 			/*
 			 * Packs are runtime accessed in their mtime
@@ -1245,9 +1246,10 @@ static void write_pack_file(void)
 					&to_pack, written_list, nr_written);
 			}
 
-			finish_tmp_packfile(&tmp_basename, pack_tmp_name,
-					    written_list, nr_written,
-					    &pack_idx_opts, hash);
+			stage_tmp_packfile(&tmp_basename, pack_tmp_name,
+					   written_list, nr_written,
+					   &pack_idx_opts, hash, &idx_tmp_name);
+			rename_tmp_packfile_idx(&tmp_basename, hash, &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				struct strbuf sb = STRBUF_INIT;
@@ -1267,6 +1269,7 @@ static void write_pack_file(void)
 				strbuf_release(&sb);
 			}
 
+			free(idx_tmp_name);
 			strbuf_release(&tmp_basename);
 			free(pack_tmp_name);
 			puts(hash_to_hex(hash));
diff --git a/pack-write.c b/pack-write.c
index 57b9fc11423..ba5c4767dc8 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -468,16 +468,33 @@ void finish_tmp_packfile(const struct strbuf *tmp_basename,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[])
+{
+	char *idx_tmp_name = NULL;
+
+	stage_tmp_packfile(tmp_basename, pack_tmp_name, written_list,
+			   nr_written, pack_idx_opts, hash, &idx_tmp_name);
+	rename_tmp_packfile_idx(tmp_basename, hash, &idx_tmp_name);
+
+	free(idx_tmp_name);
+}
+
+void stage_tmp_packfile(const struct strbuf *tmp_basename,
+			const char *pack_tmp_name,
+			struct pack_idx_entry **written_list,
+			uint32_t nr_written,
+			struct pack_idx_option *pack_idx_opts,
+			unsigned char hash[],
+			char **idx_tmp_name)
 {
 	struct strbuf sb = STRBUF_INIT;
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
@@ -496,12 +513,18 @@ void finish_tmp_packfile(const struct strbuf *tmp_basename,
 		strbuf_reset(&sb);
 	}
 
+	strbuf_release(&sb);
+}
+
+void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
+			     unsigned char hash[], char **idx_tmp_name)
+{
+	struct strbuf sb = STRBUF_INIT;
+
 	strbuf_addf(&sb, "%s%s.idx", tmp_basename->buf, hash_to_hex(hash));
-	if (rename(idx_tmp_name, sb.buf))
+	if (rename(*idx_tmp_name, sb.buf))
 		die_errno("unable to rename temporary index file");
-	strbuf_reset(&sb);
-
-	free((void *)idx_tmp_name);
+	strbuf_release(&sb);
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
diff --git a/pack.h b/pack.h
index ae0c9e04cd9..6c1508c3de7 100644
--- a/pack.h
+++ b/pack.h
@@ -110,6 +110,15 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
+void stage_tmp_packfile(const struct strbuf *tmp_basename,
+			const char *pack_tmp_name,
+			struct pack_idx_entry **written_list,
+			uint32_t nr_written,
+			struct pack_idx_option *pack_idx_opts,
+			unsigned char hash[],
+			char **idx_tmp_name);
+void rename_tmp_packfile_idx(const struct strbuf *tmp_basename,
+			     unsigned char hash[], char **idx_tmp_name);
 void finish_tmp_packfile(const struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
-- 
2.33.0.818.gd2ef2916285

