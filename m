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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1287C432BE
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80E560C40
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhHORJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHORJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 13:09:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A60EC0613CF
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 10:08:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so8695319wma.0
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ntXViu71GIOetWOh8eDmUhIUFVQ3Ux4MT5xMdEh5wbk=;
        b=pJoPBS8V8cRGaSkhgRqnfXRt6ycW2FDzh21Zx+gr/0nlLxJR9HmnCZUwWu6p00PyN1
         BTgm3qDkjJynNXe+VcaC5agi7cT+d/ykfNY2nujMLaY/a0Rk4eXzKYid4b6XD7ykLpNZ
         FJShOzQ91fI3R9mQYSD2GvBTEmBuUEGjO6anj8sCJg4WDgngOsbOWofzhCwrkovwAMRL
         FODFPjPukl3jpF1VEnZz7m4z1aI7S3STzV7qyyEkyOVwJdQEIyOqZdQw8ueTCJSZ/CzQ
         VZsfUiM4ST8KDAEhlL8WRvQwGjl/LzOt2THEjqXMx8FNMnTbNgd1TagPe16zdZuymm2z
         1FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ntXViu71GIOetWOh8eDmUhIUFVQ3Ux4MT5xMdEh5wbk=;
        b=sN2nDjuK7kQUx4tU5A5NTCr5Fv6yjnXkpjMzNUEdLD7l1AXRamo8pxPOWZRpameavG
         oiIpg15G0f7LOaNcWEUeJMRqj9RSK51ygGV8ABPBI47prmbrmuJnfm3BYjc4cgm2qWpM
         Qsl1n2TO5roMdJoxx9En4Hf9NWUa1Yz+OhOwjrf4yvoJCVPbudeiQJ0IIk5JZUPTZmXU
         kiCNGNLqf1G1+HpXwwSyqlRXKpD4Er7s1HVS90O9fHzRON0vKdqOr3Ij/OB4po9RrG+k
         hpdWY4gcg8XIesYa7EGKMHr5ohiixq4D8NnHQKEKdYBytUUcWIG2S5xVomC0dzyog/+f
         hghw==
X-Gm-Message-State: AOAM532kbXHPoY9JR7G3mDyI2y8I1fvIbOfbWQME5+5AsTS4hwYH9ZUb
        W+Ct1O1k69paZg9Ey2UbUhUqqNMFMOc=
X-Google-Smtp-Source: ABdhPJxhrwruG5JdVZXJMRfyU3hNlbrkRN2IRbEnprfsyffpiiBhySZmKWw1DSsYl7qJ9Z0/h3ZouA==
X-Received: by 2002:a1c:7dd0:: with SMTP id y199mr11511910wmc.23.1629047328746;
        Sun, 15 Aug 2021 10:08:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm3551205wrx.38.2021.08.15.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 10:08:48 -0700 (PDT)
Message-Id: <81afc69d22c0c782eea80719557161ae19a4f72e.1629047327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1043.v4.git.git.1629047327.gitgitgadget@gmail.com>
References: <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
        <pull.1043.v4.git.git.1629047327.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 15 Aug 2021 17:08:46 +0000
Subject: [PATCH v4 1/2] packfile: rename `derive_filename()` to
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

