Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C20EC433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5C64E31
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBWC01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhBWC0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:26:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE698C06178C
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:19 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id q85so14848244qke.8
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rWSKPw4BeEPa0eE4eDcAGTacttRzk18BiUNG1gfxjLI=;
        b=BBqzr85pD0z20YjW5NqSIa7S0xJy5zA2kaR/YDiOgUNXYbJcLX3M2VA9p7b16N34xd
         0b+zyv1LALIbQKqoFkXFBVV+YEiCwlvaRENotn4qUw48CbQZvpYJPsEW+oHARZvARnBm
         ZMWOHCefKYupekyzgXwiYO4hikqjk61mtgNBl4D42+mnwTCXyCdcPC9NhWlb4igiS6MP
         MS1CyupyvKVYYWAlIgB5EGIl/pDev8Ry6ztuUl95lV3kiep7ZCC0BQcsQpI49SHnS5zI
         qQYC/2V2ynuYTbdM9R0A2WmwdUXFZIFPOLt6Shqp4t4QfYNJ1qZ9mFyWbWdkaBUcd64c
         V/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWSKPw4BeEPa0eE4eDcAGTacttRzk18BiUNG1gfxjLI=;
        b=ku2rlDhZshz820hoNDxmL+FgfJTVEuu5l6Fxk8zmTIsCZAXqeySYnsAyWktpD5Zyiy
         YA5dDboGtrfdBKjQY3LfNHFrCeKtHiZJf+aqetiJ/ER7peQHtmdIRPJZUNbajelZoH2P
         hAHcj8ZKZxUPvk0+JiQ64A8NbsVFuvB0ok1WIgSe8i+hrmU4DizqE+c7InBIGmXdWs3P
         s7vYC8D/mpJNUbqP3XopozFrITmUjwG5Ow7V0UzbJX73CkFsYVPe+jQO01HfXAtNl0cA
         S0LeJ6HLpm8ffroUWi9S5jABuE88P65PIrGHUmDtTgdG3PuYpgOy7tKZG+flkIp8DAn0
         adVg==
X-Gm-Message-State: AOAM533WHE71iAEErAyjJF+k7lCvg0DpcPPDutvYz+L3eLpNkxxYm2+a
        EibYC6N9P0SxLSxmOIxDN9B2iXehKUSvL0Ru
X-Google-Smtp-Source: ABdhPJzklvBZDn6snQy5ZgK5RIBVK/OvMA+CS4qCGN8Uymje+Uwsn/RjvJLMNvyxF4sGOo3N9ral3A==
X-Received: by 2002:a05:620a:22e1:: with SMTP id p1mr5055402qki.238.1614047118939;
        Mon, 22 Feb 2021 18:25:18 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id j20sm4592510qtl.36.2021.02.22.18.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:18 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:25:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 5/8] p5303: measure time to repack with keep
Message-ID: <94e4f3ee3af3181c3805ee397d043e343038005a.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Add two new tests to measure repack performance. Both tests split the
repository into synthetic "pushes", and then leave the remaining objects
in a big base pack.

The first new test marks an empty pack as "kept" and then passes
--honor-pack-keep to avoid including objects in it. That doesn't change
the resulting pack, but it does let us compare to the normal repack case
to see how much overhead we add to check whether objects are kept or
not.

The other test is of --stdin-packs, which gives us a sense of how that
number scales based on the number of packs we provide as input. In each
of those tests, the empty pack isn't considered, but the residual pack
(objects that were left over and not included in one of the synthetic
push packs) is marked as kept.

(Note that in the single-pack case of the --stdin-packs test, there is
nothing do since there are no non-excluded packs).

Here are some timings on a recent clone of the kernel:

  5303.5: repack (1)                          57.26(54.59+10.84)
  5303.6: repack with kept (1)                57.33(54.80+10.51)

in the 50-pack case, things start to slow down:

  5303.11: repack (50)                        71.54(88.57+4.84)
  5303.12: repack with kept (50)              85.12(102.05+4.94)

and by the time we hit 1,000 packs, things are substantially worse, even
though the resulting pack produced is the same:

  5303.17: repack (1000)                      216.87(490.79+14.57)
  5303.18: repack with kept (1000)            665.63(938.87+15.76)

That's because the code paths around handling .keep files are known to
scale badly; they look in every single pack file to find each object.
Our solution to that was to notice that most repos don't have keep
files, and to make that case a fast path. But as soon as you add a
single .keep, that part of pack-objects slows down again (even if we
have fewer objects total to look at).

Likewise, the scaling is pretty extreme on --stdin-packs (but each
subsequent test is also being asked to do more work):

  5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
  5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
  5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index d90d714923..35c0cbdf49 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -31,8 +31,15 @@ repack_into_n () {
 	' "$1" >pushes &&
 
 	# create base packfile
-	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack &&
+	base_pack=$(
+		head -n 1 pushes |
+		git pack-objects --delta-base-offset --revs staging/pack
+	) &&
+	test_export base_pack &&
+
+	# create an empty packfile
+	empty_pack=$(git pack-objects staging/pack </dev/null) &&
+	test_export empty_pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
@@ -49,6 +56,12 @@ repack_into_n () {
 		last=$rev
 	done <pushes &&
 
+	(
+		find staging -type f -name 'pack-*.pack' |
+			xargs -n 1 basename | grep -v "$base_pack" &&
+		printf "^pack-%s.pack\n" $base_pack
+	) >stdin.packs
+
 	# and install the whole thing
 	rm -f .git/objects/pack/* &&
 	mv staging/* .git/objects/pack/
@@ -91,6 +104,23 @@ do
 		  --reflog --indexed-objects --delta-base-offset \
 		  --stdout </dev/null >/dev/null
 	'
+
+	test_perf "repack with kept ($nr_packs)" '
+		git pack-objects --keep-true-parents \
+		  --keep-pack=pack-$empty_pack.pack \
+		  --honor-pack-keep --non-empty --all \
+		  --reflog --indexed-objects --delta-base-offset \
+		  --stdout </dev/null >/dev/null
+	'
+
+	test_perf "repack with --stdin-packs ($nr_packs)" '
+		git pack-objects \
+		  --keep-true-parents \
+		  --stdin-packs \
+		  --non-empty \
+		  --delta-base-offset \
+		  --stdout <stdin.packs >/dev/null
+	'
 done
 
 # Measure pack loading with 10,000 packs.
-- 
2.30.0.667.g81c0cbc6fd

