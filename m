Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8CC4320A
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FCC60F36
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 17:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhHPRGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 13:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhHPRGg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 13:06:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9703C0613C1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:06:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x10so18316779wrt.8
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ntXViu71GIOetWOh8eDmUhIUFVQ3Ux4MT5xMdEh5wbk=;
        b=WOEKYwMYHpbsmaRchIoURktF+HoiBjRfZ93nFPRfXh11byReoh3U9L61tzjabp1orZ
         F/cjTru2tOhkKGHhnC2qWDn1QeQ4vt2iBrpBsx0+s1nwfGYHiVtTm/0T+DFftD8Ybtx8
         N90vU6cmuJuZylgGSRbiTeLUHvY/HNipaY1h7f35nxOmoNFVwMlzAZ1KKnsMftiP5m8l
         +JzorvYl1/N10KnV7+PSesrYmTFterkc0gC+UbPxwXtAddhRFP4Kq7xExVZHtpQl5Ewa
         eE7u/kYruTRwGcUuPIB0xxshD+xuNrqWvscy1HKY97/CvundXAk0YQscYso826eHLp6Q
         L7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ntXViu71GIOetWOh8eDmUhIUFVQ3Ux4MT5xMdEh5wbk=;
        b=fTCoF1GXR/kilUQ3QUv3Ii+GECgyajilJ4OrsSPOYMRB8S502CjiAnpH04VAxm0r6c
         GO4UX+MCIVpHzJGf6bIYf5uRgk/xJDLPbex3upX0tVww6XinYvpZkT6c+oHK64Y5gq7w
         7YXWwBZxADS8hJdIsiViVnSOAafUu/Xd9kqva2oiw1VLXLxYXthKlMDZiGlPbcTKIFid
         3TiCQpMw5zZX4/ooR7bHHRW3ub+zkSq7vc6muGKVPGcU9INp87DOVe47baqovJXoz3Dp
         K63xn7RmnEqLnEtJVnAib5Yx+HnNl+uE3jOWCMBwAoBTlCJc/dzzM2NsnM4PPuAgj1lH
         BgxQ==
X-Gm-Message-State: AOAM531Apj8K7jwKKnkSQphuiDb8YKPaEPFX7Ir1LPqobP5bA34K0wqe
        VNyczNl57SQfUjcm7vlwsMtQGu2YR20=
X-Google-Smtp-Source: ABdhPJzTIuOlHeflmwnfC8ns+WTQm9FIGMNXAiLBcihrSoC8LDXMhghcRDDPUogX7+c3qMwwvrI/WA==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr19650068wrx.144.1629133563557;
        Mon, 16 Aug 2021 10:06:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a77sm79203wmd.31.2021.08.16.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 10:06:03 -0700 (PDT)
Message-Id: <81afc69d22c0c782eea80719557161ae19a4f72e.1629133561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.git.git.1629133561.gitgitgadget@gmail.com>
References: <pull.1066.git.git.1629133561.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 17:06:00 +0000
Subject: [PATCH 1/2] packfile: rename `derive_filename()` to
 `derive_pack_filename()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <16657101987@163.com>

In order to allow some function get a new file name from `.pack` file
with a new suffix, move `derive_filename()` in `builtin/index-pack.c`
to `packfile.c` with a new name `derive_pack_filename(), and export
it from `packfile.h`.

Signed-off-by: Sun Chao <16657101987@163.com>
---
 builtin/index-pack.c | 19 +++----------------
 packfile.c           | 13 +++++++++++++
 packfile.h           |  7 +++++++
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865c..3c83789ccef 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1435,19 +1435,6 @@ static void fix_unresolved_deltas(struct hashfile *f)
 	free(sorted_by_pos);
 }
 
-static const char *derive_filename(const char *pack_name, const char *strip,
-				   const char *suffix, struct strbuf *buf)
-{
-	size_t len;
-	if (!strip_suffix(pack_name, strip, &len) || !len ||
-	    pack_name[len - 1] != '.')
-		die(_("packfile name '%s' does not end with '.%s'"),
-		    pack_name, strip);
-	strbuf_add(buf, pack_name, len);
-	strbuf_addstr(buf, suffix);
-	return buf->buf;
-}
-
 static void write_special_file(const char *suffix, const char *msg,
 			       const char *pack_name, const unsigned char *hash,
 			       const char **report)
@@ -1458,7 +1445,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	int msg_len = strlen(msg);
 
 	if (pack_name)
-		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
+		filename = derive_pack_filename(pack_name, "pack", suffix, &name_buf);
 	else
 		filename = odb_pack_name(&name_buf, hash, suffix);
 
@@ -1853,13 +1840,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && hash_algo)
 		die(_("--object-format cannot be used with --stdin"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
+		index_name = derive_pack_filename(pack_name, "pack", "idx", &index_name_buf);
 
 	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
 	if (rev_index) {
 		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
 		if (index_name)
-			rev_index_name = derive_filename(index_name,
+			rev_index_name = derive_pack_filename(index_name,
 							 "idx", "rev",
 							 &rev_index_name_buf);
 	}
diff --git a/packfile.c b/packfile.c
index 9ef6d982928..315c3da259a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -40,6 +40,19 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	return odb_pack_name(&buf, sha1, "idx");
 }
 
+const char *derive_pack_filename(const char *pack_name, const char *strip,
+				const char *suffix, struct strbuf *buf)
+{
+	size_t len;
+	if (!strip_suffix(pack_name, strip, &len) || !len ||
+	    pack_name[len - 1] != '.')
+		die(_("packfile name '%s' does not end with '.%s'"),
+		    pack_name, strip);
+	strbuf_add(buf, pack_name, len);
+	strbuf_addstr(buf, suffix);
+	return buf->buf;
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
diff --git a/packfile.h b/packfile.h
index 3ae117a8aef..ff702b22e6a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -31,6 +31,13 @@ char *sha1_pack_name(const unsigned char *sha1);
  */
 char *sha1_pack_index_name(const unsigned char *sha1);
 
+/*
+ * Return the corresponding filename with given suffix from "file_name"
+ * which must has "strip" suffix.
+ */
+const char *derive_pack_filename(const char *file_name, const char *strip,
+		const char *suffix, struct strbuf *buf);
+
 /*
  * Return the basename of the packfile, omitting any containing directory
  * (e.g., "pack-1234abcd[...].pack").
-- 
gitgitgadget

