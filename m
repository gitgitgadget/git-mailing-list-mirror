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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1559C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB09A6112F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbhIGTnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbhIGTnu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:43:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B9C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:42:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e26so7697470wmk.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raBne3wJrd4STWFqd5EtanWa1BaTBMWmMCu1TaJps+I=;
        b=JTGjXnxE3/FUeDuMWTd7A0yH7Hi+VLslP642auSWpG1sgGljXEAQrk8f0ndE3Xczac
         cGZBO7TMF0RMTQFOzYv7Qn3sbGFYbdUFyLuB7i4xbkuzo7M9VL0pCY5x2s8rvMj8lYfq
         VUWUAMjUsiDftk1Y2D388WFHPG14aE6Zjw04askbkvdHdfJq/MKNMK14WvuHYqsIXj0t
         +UQIqJ2v+KwhUGtkV15pyM0MTFanVDZnuhj25PG1wu841d/j9hYWyLV+ohJDMFTbeOcr
         aBdn8JIET99yciCIdqC9Pk43gavBABv+lfULjI5G13w/f5IY/uaA9kQdd8M33uYDwnXq
         gULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raBne3wJrd4STWFqd5EtanWa1BaTBMWmMCu1TaJps+I=;
        b=IZbt6SbVJpc2cKb/9+fl7nR/a9k6mdQl8hZFOKvrsTngqFP0pYPTOZsl6W+aRcvSHj
         32hllTmLv2p8gDDiYqo6GEKYJwwlXUHDo/xM9IZDF/bWzwvf7kpF7dLtBhQT+aCbhaON
         YvXWxoTaLtkEwpbyYQsIrxVoR2fIhrrnHK1/SPSFCd9Tpj74xCVGy2lI3WCz5Hv+8Hfj
         CzqL6AHUjHvWy92MmYWzvqush9+uBN7uTRU77UmaHb25P614rR0R9Xk1gFOuSr3RSodV
         7WsFZKcE61tx5RfYEYZMVBtzXXFsgWy3alChmuDvHR0lLJlvPiyNGnMVwt7GxLbvhzaR
         +WDQ==
X-Gm-Message-State: AOAM530Hw8RkEtk7FLC0ZGptDfw2kS5XbGIQbr1Z8LmDrDf0ciGxRrSl
        fh8y5QUEw83TxD6SzUPIHq7+U0Bf4Q+f0g==
X-Google-Smtp-Source: ABdhPJzijgTnIo/Cl4iQHKc8M8eV5U9CiEch44CyQd4ynIq8vmZqHWsfbiNeVm58YhAJ6e5OqjLEEg==
X-Received: by 2002:a1c:cc03:: with SMTP id h3mr5523960wmb.73.1631043762183;
        Tue, 07 Sep 2021 12:42:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a10sm12075320wrd.51.2021.09.07.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:42:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] pack-write: use more idiomatic strbuf usage for packname construction
Date:   Tue,  7 Sep 2021 21:42:36 +0200
Message-Id: <patch-1.3-0e6ef07ce00-20210907T193600Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.818.gd2ef2916285
In-Reply-To: <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 5889271114a (finish_tmp_packfile():use strbuf for
pathname construction, 2014-03-03) to do strbuf_reset() instead of
noting the length of the base template, and doing a strbuf_setlen() to
reset it, also change the spacing in the finish_tmp_packfile() so that
each setup of the template, rename, and strbuf_reset() is grouped
together.

Since the prototype of the previous "name_buffer" now has a "const"
use this chance to wrap the overly long definition of the
finish_tmp_packfile() function.

This doesn't really matter for now, but as we'll see makes the
subsequent change much easier, as we won't need to juggle the basename
template v.s. its current contents anymore when writing bitmaps.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 17 +++++++++++------
 pack-write.c           | 27 ++++++++++++---------------
 pack.h                 |  7 ++++++-
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df49f656b96..717003563db 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1216,7 +1216,7 @@ static void write_pack_file(void)
 
 		if (!pack_to_stdout) {
 			struct stat st;
-			struct strbuf tmpname = STRBUF_INIT;
+			struct strbuf tmp_basename = STRBUF_INIT;
 
 			/*
 			 * Packs are runtime accessed in their mtime
@@ -1237,7 +1237,7 @@ static void write_pack_file(void)
 					warning_errno(_("failed utime() on %s"), pack_tmp_name);
 			}
 
-			strbuf_addf(&tmpname, "%s-", base_name);
+			strbuf_addf(&tmp_basename, "%s-", base_name);
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(hash);
@@ -1245,12 +1245,16 @@ static void write_pack_file(void)
 					&to_pack, written_list, nr_written);
 			}
 
-			finish_tmp_packfile(&tmpname, pack_tmp_name,
+			finish_tmp_packfile(&tmp_basename, pack_tmp_name,
 					    written_list, nr_written,
 					    &pack_idx_opts, hash);
 
 			if (write_bitmap_index) {
-				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
+				struct strbuf sb = STRBUF_INIT;
+
+				strbuf_addf(&sb, "%s%s.bitmap",
+					    tmp_basename.buf,
+					    hash_to_hex(hash));
 
 				stop_progress(&progress_state);
 
@@ -1258,11 +1262,12 @@ static void write_pack_file(void)
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				bitmap_writer_build(&to_pack);
 				bitmap_writer_finish(written_list, nr_written,
-						     tmpname.buf, write_bitmap_options);
+						     sb.buf, write_bitmap_options);
 				write_bitmap_index = 0;
+				strbuf_release(&sb);
 			}
 
-			strbuf_release(&tmpname);
+			strbuf_release(&tmp_basename);
 			free(pack_tmp_name);
 			puts(hash_to_hex(hash));
 		}
diff --git a/pack-write.c b/pack-write.c
index 277c60165e8..57b9fc11423 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -462,15 +462,15 @@ struct hashfile *create_tmp_packfile(char **pack_tmp_name)
 	return hashfd(fd, *pack_tmp_name);
 }
 
-void finish_tmp_packfile(struct strbuf *name_buffer,
+void finish_tmp_packfile(const struct strbuf *tmp_basename,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[])
 {
+	struct strbuf sb = STRBUF_INIT;
 	const char *idx_tmp_name, *rev_tmp_name = NULL;
-	int basename_len = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -483,26 +483,23 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
 				      pack_idx_opts->flags);
 
-	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
-
-	if (rename(pack_tmp_name, name_buffer->buf))
+	strbuf_addf(&sb, "%s%s.pack", tmp_basename->buf, hash_to_hex(hash));
+	if (rename(pack_tmp_name, sb.buf))
 		die_errno("unable to rename temporary pack file");
-
-	strbuf_setlen(name_buffer, basename_len);
+	strbuf_reset(&sb);
 
 	if (rev_tmp_name) {
-		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
-		if (rename(rev_tmp_name, name_buffer->buf))
+		strbuf_addf(&sb, "%s%s.rev", tmp_basename->buf,
+			    hash_to_hex(hash));
+		if (rename(rev_tmp_name, sb.buf))
 			die_errno("unable to rename temporary reverse-index file");
-
-		strbuf_setlen(name_buffer, basename_len);
+		strbuf_reset(&sb);
 	}
 
-	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
-	if (rename(idx_tmp_name, name_buffer->buf))
+	strbuf_addf(&sb, "%s%s.idx", tmp_basename->buf, hash_to_hex(hash));
+	if (rename(idx_tmp_name, sb.buf))
 		die_errno("unable to rename temporary index file");
-
-	strbuf_setlen(name_buffer, basename_len);
+	strbuf_reset(&sb);
 
 	free((void *)idx_tmp_name);
 }
diff --git a/pack.h b/pack.h
index fa139545262..ae0c9e04cd9 100644
--- a/pack.h
+++ b/pack.h
@@ -110,6 +110,11 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+void finish_tmp_packfile(const struct strbuf *name_buffer,
+			 const char *pack_tmp_name,
+			 struct pack_idx_entry **written_list,
+			 uint32_t nr_written,
+			 struct pack_idx_option *pack_idx_opts,
+			 unsigned char sha1[]);
 
 #endif
-- 
2.33.0.818.gd2ef2916285

