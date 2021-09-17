Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF6C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA05B61164
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbhIQVWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242289AbhIQVWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C746C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d18so1552410iof.13
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfhOVs8nbYxdCqob3CH1UqT6XmsPZ60KFKOr7k9nZC4=;
        b=XhF0QnRqMVBMWTjOiyk8J5stpuGdhWQWQU6z/6SAhXumnQFSNhf6EmfITciy5ng3Ho
         HKQDG96mYr7NLK9KUezabcLv2TpyAyQE6JPhdqEofbuE6DUd9o36e4bkXWFHnjscE432
         wjjFGmxpwSg0z6uWYT2MdPgHvcpOpyZtRv8VMuHie8687U5BGmY4CTQO+m7tOge2BUlS
         /hOKWNwvVpNlOfHd5tYaNjEOvHlL3cj4o84uSoxfFZhXB9r2PK23ErI8RHsfXaX0DuI+
         2E+Cg0foUqHujCIgcTgcCOHW4usgsm/sh2jdWTzFq4mt1TadvJolJV8lE1HLoEQnY5bL
         e5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfhOVs8nbYxdCqob3CH1UqT6XmsPZ60KFKOr7k9nZC4=;
        b=YeK9+eac2puIGG85eO8v2ulCSjuGTJEj8EmALnPZ63DdYskp0lPE8lKBuLl2JEr7hH
         LxwFN05Ifp4+hR8yxIpHWrKtMA2kQZJIebrAgK7CeF3ZnzLoZCPAZCsiXjS0Jkve2Nix
         zNh/p6DX2G1qSyfPQGfZX6hVocNKcwsBI/RLeBnRoC9clDxVu83Qyp5rgVUBt878dqeZ
         G8Stg9kT1NhI1vbFvmZdrw7gwtTyTY+LlBgrsNzLXuyNkNbK0SIyUeFd+oMIgO44JPIB
         5bN7FSW9dmEm19rItTezAHNtk6W4ibNau+gP1pzJfBw1GAzwiru+NGdkDzlaK1PFgcZS
         hBUw==
X-Gm-Message-State: AOAM5306KfcgS8KETMdrsIdS8A3QgJIEscbrvghvWwNGZcZecgiOs+9v
        tZXkHy3KyRSSQYuz+LtKXmEsw+lBCADmsG9C
X-Google-Smtp-Source: ABdhPJzTvXvOxgmZWMPGqHCJyvC/WxuiqNKm2T7P4F52BG+OFvLV/JJM3tmrzwszx+osrwoe241L6w==
X-Received: by 2002:a6b:5d19:: with SMTP id r25mr5771963iob.11.1631913680802;
        Fri, 17 Sep 2021 14:21:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15sm4285563ila.34.2021.09.17.14.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:20 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 3/7] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Message-ID: <f0d8f106c22dae64eaf4b77d1ecf67ef79c4515c.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631913631.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631913631.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, the bitmap writing code learned to propagate
values from an existing hash-cache extension into the bitmap that it is
writing.

Now that that functionality exists, let's expose it by teaching the 'git
multi-pack-index' builtin to respect the `pack.writeBitmapHashCache`
option so that the hash-cache may be written at all.

Two minor points worth noting here:

  - The 'git multi-pack-index write' sub-command didn't previously read
    any configuration (instead this is handled in the base command). A
    separate handler is added here to respect this write-specific
    config option.

  - I briefly considered adding a 'bitmap_flags' field to the static
    options struct, but decided against it since it would require
    plumbing through a new parameter to the write_midx_file() function.

    Instead, a new MIDX-specific flag is added, which is translated to
    the corresponding bitmap one.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt |  4 ++++
 builtin/multi-pack-index.c    | 21 +++++++++++++++++++++
 midx.c                        |  6 +++++-
 midx.h                        |  1 +
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 763f7af7c4..ad7f73a1ea 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -159,6 +159,10 @@ pack.writeBitmapHashCache::
 	between an older, bitmapped pack and objects that have been
 	pushed since the last gc). The downside is that it consumes 4
 	bytes per object of disk space. Defaults to true.
++
+When writing a multi-pack reachability bitmap, no new namehashes are
+computed; instead, any namehashes stored in an existing bitmap are
+permuted into their appropriate location when writing a new bitmap.
 
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 73c0113b48..578ffea6e8 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -61,6 +61,23 @@ static struct option *add_common_options(struct option *prev)
 	return parse_options_concat(common_opts, prev);
 }
 
+static int git_multi_pack_index_write_config(const char *var, const char *value,
+					     void *cb)
+{
+	if (!strcmp(var, "pack.writebitmaphashcache")) {
+		if (git_config_bool(var, value))
+			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
+		else
+			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
+	}
+
+	/*
+	 * We should never make a fall-back call to 'git_default_config', since
+	 * this was already called in 'cmd_multi_pack_index()'.
+	 */
+	return 0;
+}
+
 static int cmd_multi_pack_index_write(int argc, const char **argv)
 {
 	struct option *options;
@@ -73,6 +90,10 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
+
+	git_config(git_multi_pack_index_write_config, NULL);
+
 	options = add_common_options(builtin_multi_pack_index_write_options);
 
 	trace2_cmd_mode(argv[0]);
diff --git a/midx.c b/midx.c
index 864034a6ad..38c8600458 100644
--- a/midx.c
+++ b/midx.c
@@ -1008,9 +1008,13 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	struct pack_idx_entry **index;
 	struct commit **commits = NULL;
 	uint32_t i, commits_nr;
+	uint16_t options = 0;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
 	int ret;
 
+	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
+		options |= BITMAP_OPT_HASH_CACHE;
+
 	prepare_midx_packing_data(&pdata, ctx);
 
 	commits = find_commits_for_midx_bitmap(&commits_nr, ctx);
@@ -1049,7 +1053,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 		goto cleanup;
 
 	bitmap_writer_set_checksum(midx_hash);
-	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, 0);
+	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, options);
 
 cleanup:
 	free(index);
diff --git a/midx.h b/midx.h
index aa3da557bb..541d9ac728 100644
--- a/midx.h
+++ b/midx.h
@@ -44,6 +44,7 @@ struct multi_pack_index {
 #define MIDX_PROGRESS     (1 << 0)
 #define MIDX_WRITE_REV_INDEX (1 << 1)
 #define MIDX_WRITE_BITMAP (1 << 2)
+#define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 char *get_midx_filename(const char *object_dir);
-- 
2.33.0.96.g73915697e6

