Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2830C49EA4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8599560E0B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFWSlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFWSlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 14:41:32 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BB6C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r12so4711881ioa.7
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTZ/xz7y1UHi0uzNhytrogASWWnAkr+j/GBlnneuVa0=;
        b=i+M9vh4h3LuxMXwh6pQIHhgtZEjdLyHFjaAvxzisgzG7IxlaWB48dWrgGy6dYUROfZ
         Wc4j0ZKq5JRJphDaclbtsueKZSb5eA2YcKo9AgsxrO0UxWuwRrolpbLopUFN8ZZnWRfz
         cZldUkIdAadA8qsG9bc2XJtuhRb4cjy7QQy+UHGPtP4tMLaFjfk+eekQAobP/adR2ChB
         /lDlvZ4xXR5ot5fVge53YhTn/hWLpfJKwkeLOwcWgizoDdgYNBvaDi4Ru5IU59S3pacf
         a9epZCE1ZKk6CTtmZxEceFbCnHKYSawnHn6fptbAAzmTkSLlIRb9tmOiCM1+xZwx7PUo
         qOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTZ/xz7y1UHi0uzNhytrogASWWnAkr+j/GBlnneuVa0=;
        b=GX2RrKNnH6cJwUBZmlMa02YzNP1gjwOgitQwIla9fq5ikXEVt4I8lMEsU/wxSQT5TK
         fNXn6WpzQVcwRJ1kXgGPLwGq/CcnI2k1dMCLx0U6UUGAjUH6Ndq9iog+omuw9eZj2N0S
         sydwaVx4U9nIMr1V33LBy//7z8LJyQLZkH8RHpXUtAPMigFFYFY/2m/sVTrQEhySpha3
         0RpG7MRmLvt8DhcnJLO1yvaF1JQpkruZRZnjJ4czRWeoZIe++m+7s/fjCr3jdAio6AlD
         JqyUaZkTwrlbrE3StfYeaPVdCe73dqPY3o/CT9zcn08m5hFfUsLdFxgnldrn2Lhm/YH0
         wuLg==
X-Gm-Message-State: AOAM531+qgtla1/8oTidIpsruA/L5vtynTl6oGWdGn1TynlpPsHGR5/a
        CbS/xdWMXj3e6FqCRS3NxoMqfad+npiEyXVe
X-Google-Smtp-Source: ABdhPJzx4YFw7pyA//GmzWi42Tje5aKHozNvrpq9XkG4gd/TCW444gngrCmlKRNv7Y7vA4QWaqcpMQ==
X-Received: by 2002:a02:9665:: with SMTP id c92mr947428jai.56.1624473553531;
        Wed, 23 Jun 2021 11:39:13 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id k4sm315696ior.55.2021.06.23.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:39:13 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:39:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 3/4] midx: don't reuse corrupt MIDXs when writing
Message-ID: <a216c0c5a3ed5060ffc4d768fc10a663ac0af96d.1624473543.git.me@ttaylorr.com>
References: <cover.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, Git tries to reuse as much of the
data from an existing MIDX as possible, like object offsets. This is
done to avoid re-opening a bunch of *.idx files unnecessarily, but can
lead to problems if the data we are reusing is corrupt.

That's because we'll blindly reuse data from an existing MIDX without
checking its trailing checksum for validity. So if there is memory
corruption while writing a MIDX, or disk corruption in the intervening
period between writing and reuse, we'll blindly propagate those bad
values forward.

Suppose we experience a memory corruption while writing a MIDX such that
we write an incorrect object offset (or alternatively, the disk corrupts
the data after being written, but before being reused). Then when we go
to write a new MIDX, we'll reuse the bad object offset without checking
its validity. This means that the MIDX we just wrote is broken, but its
trailing checksum is in-tact, since we never bothered to look at the
values before writing.

In the above, a "git multi-pack-index verify" would have caught the
problem before writing, but writing a new MIDX wouldn't have noticed
anything wrong, blindly carrying forward the corrupt offset.

Individual pack indexes check their validity by verifying the crc32
attached to each entry when carrying data forward during a repack.
We could solve this problem for MIDXs in the same way, but individual
crc32's don't make much sense, since their entries are so small.
Likewise, checking the whole file on every read may be prohibitively
expensive if a repository has a lot of objects, packs, or both.

But we can check the trailing checksum when reusing an existing MIDX
when writing a new one. And a corrupt MIDX need not stop us from writing
a new one, since we can just avoid reusing the existing one at all and
pretend as if we are writing a new MIDX from scratch.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      | 10 ++++++++++
 t/t5319-multi-pack-index.sh |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/midx.c b/midx.c
index 21d6a05e88..a12cbbf928 100644
--- a/midx.c
+++ b/midx.c
@@ -885,6 +885,11 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 static void clear_midx_files_ext(struct repository *r, const char *ext,
 				 unsigned char *keep_hash);
 
+static int midx_checksum_valid(struct multi_pack_index *m)
+{
+	return hashfile_checksum_valid(m->data, m->data_len);
+}
+
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -911,6 +916,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	else
 		ctx.m = load_multi_pack_index(object_dir, 1);
 
+	if (ctx.m && !midx_checksum_valid(ctx.m)) {
+		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
+		ctx.m = NULL;
+	}
+
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
 	ctx.info = NULL;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 5641d158df..d582f370c4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -410,6 +410,14 @@ test_expect_success 'git-fsck incorrect offset' '
 		"git -c core.multipackindex=true fsck"
 '
 
+test_expect_success 'corrupt MIDX is not reused' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
+		"incorrect object offset" &&
+	git multi-pack-index write 2>err &&
+	test_i18ngrep checksum.mismatch err &&
+	git multi-pack-index verify
+'
+
 test_expect_success 'repack progress off for redirected stderr' '
 	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
 	test_line_count = 0 err
-- 
2.31.1.163.ga65ce7f831

