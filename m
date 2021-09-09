Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA71C433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D0861178
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350099AbhIID0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350109AbhIID0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:26:08 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA9C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:24:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i13so511273ilm.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=snPumuC91c2nde8TXJfK77FvS3+EXY1MFjkDnno6nlU=;
        b=Y8n0M3thBruf/7NdAGn+bW572ryMQBTto1Wzy6YS0XCZO1T+n3pW9EsaBLSk7L7+CI
         IHf6mka+zwcTx+QpmtlXSg3ZrQUvC+ppirs8qTtd1Kq4th1jov2L1/3tKztPuoZBWP0i
         HyZpA60k+RiytAWBll+lmEJ/hosa1ty73jFGE4xDz8Gonarh4YCnAgGS9EkUWGgOPQ64
         2OvYe/YGzXMW91+IZv7wgI61TzlI/ikmS+3AR9Noeg2AZIcdk/pP+Vz2aC3PLaud2dQs
         0+7ydgRnZqzLyPyr+g7aJWwqGYijoXKHGCBrEAiBeE/QtF1O0+LBZOdu8fRfA6sfXqul
         vxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=snPumuC91c2nde8TXJfK77FvS3+EXY1MFjkDnno6nlU=;
        b=wRyv7jrqKNdx1M273TaDpSH1cB4PBUINXQ3QIMG8g0/f1ldgGoZwK3geT7guNoWKOf
         B2O62ScE7y1BZAmh7vp0AHA4agj8AUb+ovo5P9p4ofBNuH7i061Gh+hzDlpSx3lxjcZm
         qivLAMxXR/FwED4j/VD9IGqcOnitNIMMZolHSoqGIpPWnezY8p+CZ/Dn1PkSjYgs1Y0O
         yYYTBPth/bCTV2RKT4oVBUrZbjvtHIlAdCd8LgXq0gGc8DJqwR9k+o4fH1GBRJLnJJoz
         fpCRGS2FuRScHyEKhEQs4OIaTxhoqToHlDZf7ANPXNvZDk2SvDtDIDU8E9skBOnl4c92
         gI8A==
X-Gm-Message-State: AOAM532C5MiGOevHSSppdMTQuLi/gsNM/8TZbffBoA5rfYKuqoH8e7fA
        kWjfLYftELKK1TGuF/2eac0eNdsnJyed2wbI
X-Google-Smtp-Source: ABdhPJy2Ql4oUR63U+swXyFL/Uyh+5gyzouwm8nczqPtodh5gynnMRFNH24YIhHL0TRKLtgzpBNu5g==
X-Received: by 2002:a92:c56d:: with SMTP id b13mr681331ilj.317.1631157896617;
        Wed, 08 Sep 2021 20:24:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a21sm266123iot.43.2021.09.08.20.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:24:56 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:24:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 3/9] pack-write: refactor renaming in finish_tmp_packfile()
Message-ID: <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover.1631157880.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1631157880.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Refactor the renaming in finish_tmp_packfile() into a helper function.
The callers are now expected to pass a "name_buffer" ending in
"pack-OID." instead of the previous "pack-", we then append "pack",
"idx" or "rev" to it.

By doing the strbuf_setlen() in rename_tmp_packfile() we reuse the
buffer and avoid the repeated allocations we'd get if that function had
its own temporary "struct strbuf".

This approach of reusing the buffer does make the last user in
pack-object.c's write_pack_file() slightly awkward, since we needlessly
do a strbuf_setlen() before calling strbuf_release() for consistency. In
subsequent changes we'll move that bitmap writing code around, so let's
not skip the strbuf_setlen() now.

The previous strbuf_reset() idiom originated with 5889271114a
(finish_tmp_packfile():use strbuf for pathname construction,
2014-03-03), which in turn was a minimal adjustment of pre-strbuf code
added in 0e990530ae (finish_tmp_packfile(): a helper function,
2011-10-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  7 +++++--
 bulk-checkin.c         |  3 ++-
 pack-write.c           | 37 ++++++++++++++++---------------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df49f656b9..2a105c8d6e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1237,7 +1237,8 @@ static void write_pack_file(void)
 					warning_errno(_("failed utime() on %s"), pack_tmp_name);
 			}
 
-			strbuf_addf(&tmpname, "%s-", base_name);
+			strbuf_addf(&tmpname, "%s-%s.", base_name,
+				    hash_to_hex(hash));
 
 			if (write_bitmap_index) {
 				bitmap_writer_set_checksum(hash);
@@ -1250,8 +1251,9 @@ static void write_pack_file(void)
 					    &pack_idx_opts, hash);
 
 			if (write_bitmap_index) {
-				strbuf_addf(&tmpname, "%s.bitmap", hash_to_hex(hash));
+				size_t tmpname_len = tmpname.len;
 
+				strbuf_addstr(&tmpname, "bitmap");
 				stop_progress(&progress_state);
 
 				bitmap_writer_show_progress(progress);
@@ -1260,6 +1262,7 @@ static void write_pack_file(void)
 				bitmap_writer_finish(written_list, nr_written,
 						     tmpname.buf, write_bitmap_options);
 				write_bitmap_index = 0;
+				strbuf_setlen(&tmpname, tmpname_len);
 			}
 
 			strbuf_release(&tmpname);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6283bc8bd9..c19d471f0b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -46,7 +46,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 		close(fd);
 	}
 
-	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
+	strbuf_addf(&packname, "%s/pack/pack-%s.", get_object_directory(),
+		    hash_to_hex(hash));
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, hash);
diff --git a/pack-write.c b/pack-write.c
index 2767b78619..95b063be94 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -458,6 +458,18 @@ struct hashfile *create_tmp_packfile(char **pack_tmp_name)
 	return hashfd(fd, *pack_tmp_name);
 }
 
+static void rename_tmp_packfile(struct strbuf *nb, const char *source,
+				const char *ext)
+{
+	size_t nb_len = nb->len;
+
+	strbuf_addstr(nb, ext);
+	if (rename(source, nb->buf))
+		die_errno("unable to rename temporary '*.%s' file to '%s'",
+			  ext, nb->buf);
+	strbuf_setlen(nb, nb_len);
+}
+
 void finish_tmp_packfile(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
@@ -466,7 +478,6 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 			 unsigned char hash[])
 {
 	const char *idx_tmp_name, *rev_tmp_name = NULL;
-	int basename_len = name_buffer->len;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -479,26 +490,10 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
 				      pack_idx_opts->flags);
 
-	strbuf_addf(name_buffer, "%s.pack", hash_to_hex(hash));
-
-	if (rename(pack_tmp_name, name_buffer->buf))
-		die_errno("unable to rename temporary pack file");
-
-	strbuf_setlen(name_buffer, basename_len);
-
-	strbuf_addf(name_buffer, "%s.idx", hash_to_hex(hash));
-	if (rename(idx_tmp_name, name_buffer->buf))
-		die_errno("unable to rename temporary index file");
-
-	strbuf_setlen(name_buffer, basename_len);
-
-	if (rev_tmp_name) {
-		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
-		if (rename(rev_tmp_name, name_buffer->buf))
-			die_errno("unable to rename temporary reverse-index file");
-	}
-
-	strbuf_setlen(name_buffer, basename_len);
+	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
+	rename_tmp_packfile(name_buffer, idx_tmp_name, "idx");
+	if (rev_tmp_name)
+		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
 
 	free((void *)idx_tmp_name);
 }
-- 
2.33.0.96.g73915697e6

