Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F6C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E660F70
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbhIGVTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347091AbhIGVTM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:19:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C035C06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:18:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y132so123485wmc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gxxkzrGJMqtxNns2UAEc8BJX7ki4xwBkiCITuOHgJ5Y=;
        b=lIeBlpCMEUGc14AWl7vBdMnOG/NuSv3iylRwjZG9HJPI9QykbgcdUWT39tgNzopoQd
         43TvvbGfHMjrSrWJR5jihfxca/iTEnGhfxAa6gfqEeO5dDLW83cFi3T6Rs6Bv+TCWEzR
         Stmzb8ftU+aMexB5nAD2fkYF0maBbQcrRfU5ypXSCR5Xks9UCm+AYENqMjiUb6aiQiON
         03REcihbzAUAXkDsrCNqwaKD5OXqnP+b4ObpSLWAOVnw6H5/k7NBi80Aru9E1WyEknIU
         gTVdpU2qrqvJRGm8EoAisQn22G6McaPPoZdQDR+1hHDMYpYF/48BAJ93MlstMGt4O/An
         /HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gxxkzrGJMqtxNns2UAEc8BJX7ki4xwBkiCITuOHgJ5Y=;
        b=OQOAJyxPtPRoPSWvBve0t5VZRj/aTByblrFIHsXU1o4Md5CdESgj9yFAzFZYQuE4WF
         3HNxgLXw+BNNuPOjB/nbXDoOlPccD4Yxiq1xkNVYaKhoSVFGX5UF6qNaI/66VgA04P30
         QYYD0gDIzr97q7agl3Fqu96dIDo+ijvViJ8Klc44MNcycmFqLi1/zrasZYAnr3mGAtF0
         VgYfys5EFJhpUAWXBtlEOdV8xgrY+65GvuK/KZWYxAsxIlLHrFT99fSemQ1OGhqww/eV
         4Psa932gxudEKI8pgdtVD9+fNsLJqL909fmIpKlpJn/wmZ/ZRZe8yJsxmyGsoSaeIdSE
         GdbQ==
X-Gm-Message-State: AOAM5319r2b4E99/Ii3c463XYOy9kpREqetFwC0NTYrAxi7zYOBQ8Esw
        yYcPJv/btQGJ3CIM+AmB7l+FzpRrtgSmgMDi
X-Google-Smtp-Source: ABdhPJwYlDGFN/fplnGcPfu1EbyaQybg+4TFSYrOaclloEI7Bn9ptzaJDmPgpueO7gsOX8wZOnJg9A==
X-Received: by 2002:a1c:44c5:: with SMTP id r188mr203658wma.9.1631049483747;
        Tue, 07 Sep 2021 14:18:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l17sm139493wrz.35.2021.09.07.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:18:03 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:18:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when writing
 bitmaps
Message-ID: <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631049462.git.me@ttaylorr.com>
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
index 73c0113b48..dd1652531b 100644
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
+	 * No need to fall-back to 'git_default_config', since this was already
+	 * called in 'cmd_multi_pack_index()'.
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
index ccdc3e5702..6c35dcd557 100644
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

