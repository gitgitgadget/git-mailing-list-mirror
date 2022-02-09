Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB19C433FE
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 19:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiBIT3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:29:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiBIT2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 14:28:06 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1BE017B9A
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 11:26:49 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id b5so2567844ile.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wrnx3Mcy/VmaJfPbWMYx1U4k4kY7f7aBqqdwCAGM7+E=;
        b=sGtgxiSL3Qq5nzuQWE9yktpD7Us+bg3gybtn2aEwmWUJKgY/sef9xhk7c2s/GJkhLB
         MO/LJYbQ/xJCA/+JZvgAz+OAFxk9gDYJmVxg7+0cVFqgu4bgTijKsqUpSqPAC2ahE3fU
         GjQp0Z+F3aMKcblswi3FRqk51Krh/RJf9F/MK9TE0UcCp1y9OLtfU8HH+ICQhrquZjWB
         xuOEB8YQpQZrwfr+uDB0wgJO0CP6cLeWNJEYMnpg6y/Fvt+lQrbSxRoaV1NJCgqwZ6YY
         XKQZY6nzeH3cwd7ysZlVDT+L3Ct4wI5CIPLEShADkwM+NBEkdhGK8sPuGegH1ZJ2LEcV
         VmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wrnx3Mcy/VmaJfPbWMYx1U4k4kY7f7aBqqdwCAGM7+E=;
        b=jP7O9mZ1k7AmGXi9BS6PyV+daYqyOie5ELdzckbePQg7ipBlKg1bQRj6LRsllBuZRg
         SE85+cEbljsyBQ+kCqEwH4LYKRwoyYrmlPRFhhQnFsdTwvzHFqeTJ0E3K3zREvuatbwv
         L9pK2Fz9fW4YT4A1ilagi1Xg1gh8fsZebmSKeZi7Ypnkc5fFqahr+mmWjmP3hhHI1MWK
         Xgs+dbQho9SJBKb7Lbpi6aDXvGOOsmhowYXYz3G6qOBIS4dbIHk8LkZ1n9JK9oscCQYN
         8v/nD/vNR88Rcfy3T8RE0+JDidoTdLwE+d95g7Wr/RLGmGnky0rL/F9tBqx/hBCitovN
         s0+g==
X-Gm-Message-State: AOAM530YurBPAIhb8GP3F3ixPx6aYsNZoNa0Vz3VWt+9tYUASswJaeWV
        isz46WSxkEjnKr0UsMT8/siLGlnDNN6unw==
X-Google-Smtp-Source: ABdhPJwREfn0BZg/oMkhl/VvDWx4yBvq/EIA6jWjx8cyU+xCqaBXFcXZILQ9/Irx3s1ou4YIM9K0XA==
X-Received: by 2002:a05:6e02:15c4:: with SMTP id q4mr1884927ilu.281.1644434808742;
        Wed, 09 Feb 2022 11:26:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u3sm849440ilv.27.2022.02.09.11.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:26:48 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:26:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH 1/1] midx: prevent writing a .bitmap without any objects
Message-ID: <abc67d757cb6b244cf54b7b030985180ce134724.1644434802.git.me@ttaylorr.com>
References: <cover.1644434802.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1644434802.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trying to write a MIDX, we already prevent the case where there
weren't any packs present, and thus we would have written an empty MIDX.

But there is another "empty" case, which is more interesting, and we
don't yet handle. If we try to write a MIDX which has at least one pack,
but those packs together don't contain any objects, we will encounter a
BUG() when trying to use the bitmap corresponding to that MIDX, like so:

    $ git rev-parse HEAD | git pack-objects --revs --use-bitmap-index --stdout >/dev/null
    BUG: pack-revindex.c:394: pack_pos_to_midx: out-of-bounds object at 0

(note that in the above reproduction, both `--use-bitmap-index` and
`--stdout` are important, since without the former we won't even both to
load the .bitmap, and without the latter we wont attempt pack reuse).

The problem occurs when we try to discover the identity of the
preferred pack to determine which range if any of existing packs we can
reuse verbatim. This path is: `reuse_packfile_objects()` ->
`reuse_partial_packfile_from_bitmap()` -> `midx_preferred_pack()`.

    #4  0x000055555575401f in pack_pos_to_midx (m=0x555555997160, pos=0) at pack-revindex.c:394
    #5  0x00005555557502c8 in midx_preferred_pack (bitmap_git=0x55555599c280) at pack-bitmap.c:1431
    #6  0x000055555575036c in reuse_partial_packfile_from_bitmap (bitmap_git=0x55555599c280, packfile_out=0x5555559666b0 <reuse_packfile>,
        entries=0x5555559666b8 <reuse_packfile_objects>, reuse_out=0x5555559666c0 <reuse_packfile_bitmap>) at pack-bitmap.c:1452
    #7  0x00005555556041f6 in get_object_list_from_bitmap (revs=0x7fffffffcbf0) at builtin/pack-objects.c:3658
    #8  0x000055555560465c in get_object_list (ac=2, av=0x555555997050) at builtin/pack-objects.c:3765
    #9  0x0000555555605e4e in cmd_pack_objects (argc=0, argv=0x7fffffffe920, prefix=0x0) at builtin/pack-objects.c:4154

Since neither the .bitmap or MIDX stores the identity of the
preferred pack, we infer it by trying to load the first object in
pseudo-pack order, and then asking the MIDX which pack was chosen to
represent that object.

But this fails our bounds check, since there are zero objects in the
MIDX to begin with, which results in the BUG().

We could catch this more carefully in `midx_preferred_pack()`, but
signaling the absence of a preferred pack out to all of its callers is
somewhat awkward.

Instead, let's avoid writing a MIDX .bitmap without any objects
altogether. We catch this case in `write_midx_internal()`, and emit a
warning if the caller indicated they wanted to write a bitmap before
clearing out the relevant flags. If we somehow got to
write_midx_bitmap(), then we will call BUG(), but this should now be an
unreachable path.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                        |  9 +++++++++
 t/t5326-multi-pack-bitmaps.sh | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/midx.c b/midx.c
index 6e6cb0eb04..865170bad0 100644
--- a/midx.c
+++ b/midx.c
@@ -1077,6 +1077,9 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
 	int ret;
 
+	if (!ctx->entries_nr)
+		BUG("cannot write a bitmap without any objects");
+
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
 
@@ -1401,6 +1404,12 @@ static int write_midx_internal(const char *object_dir,
 		goto cleanup;
 	}
 
+	if (!ctx.entries_nr) {
+		if (flags & MIDX_WRITE_BITMAP)
+			warning(_("refusing to write multi-pack .bitmap without any objects"));
+		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+	}
+
 	cf = init_chunkfile(f);
 
 	add_chunk(cf, MIDX_CHUNKID_PACKNAMES, pack_name_concat_len,
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 3c1ecc7e25..a5329a9f48 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -285,4 +285,26 @@ test_expect_success 'graceful fallback when missing reverse index' '
 	)
 '
 
+test_expect_success 'no .bitmap is written without any objects' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		empty="$(git pack-objects $objdir/pack/pack </dev/null)" &&
+		cat >packs <<-EOF &&
+		pack-$empty.idx
+		EOF
+
+		git multi-pack-index write --bitmap --stdin-packs \
+			<packs 2>err &&
+
+		grep "bitmap without any objects" err &&
+
+		test_path_is_file $midx &&
+		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
+	)
+'
+
 test_done
-- 
2.35.1.73.gccc5557600
