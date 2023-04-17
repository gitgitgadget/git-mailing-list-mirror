Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB64DC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjDQU5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjDQU4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:56:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F08CC1D
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r184so11480572ybc.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764863; x=1684356863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufLzWQemmfKm6VPiBYmhZeagjpz2vAilwKvh4+0e+Bk=;
        b=i9REyRCSykzi0v81jksOU2nV5PKCJWnm8nnEeXRZ5A+fCphhu0hfZmyE+ZfwpN5uml
         TZAPdMyDqhhEjX97EDrzWvLfhbiTS5zDIi+FedEcAoROlwNZS7O/kzlsCDNeHn5LQLZ9
         3WXQMYEdKc6iE6gjx3WGECu90+c8dCN8Iz8W69bBWuauUSle6QcTcHSFOWGcBcZXtlcj
         34aXmjzbOMzzssKervonD22+kW8UqW40XVRqC/y8ctyEQ/TGpkJ/4XhfUnrrQhKvSeSD
         y8uE8iYdTz1ggF5Tr4BjGt+fqmaJtVK+CXbBiBLaPKsEEADHHMykWJ8mJr6z6ypYXCjZ
         q2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764863; x=1684356863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufLzWQemmfKm6VPiBYmhZeagjpz2vAilwKvh4+0e+Bk=;
        b=B3eefYOERhEDr+hCUq+gJ7CXG2rD4Id+vg/h/ik5h88JtDSAYTPlyGHA+kXCjkVK6s
         kxKSVXy/YRwtq3Ww8QYvw7Zs2LXzjDFtO8QLqHAxvGzb4CtGXFh+ovOux351FB45/xu6
         Z5e2Q+96pIaIDf5pUKIf01eRdvQrxafctGxBmfGIm/wINqitmdnsPcuSsx59K4rR536J
         oeWYdGwfK1NDTgVGwLb9pCmnbJ9G6d3IWmVTztXcba80aSyA1p8drrFUaDtsyMBjoy8e
         EzgOBwYh7Yw0v7ASmqc5ZiHMHQm0ZXC1goEnCKJSzeP7LmQxp6u/qzCgzX/kMiApUHfO
         J3JA==
X-Gm-Message-State: AAQBX9cfOjMrzPtLYSNVTHabKdNf0U3CJujZJYpA/pyxQB/7hD+yuVSp
        aSzrgHAiyi3Hgkd3GW3y9BygaEeNPeBmqel8WW/xBw==
X-Google-Smtp-Source: AKy350ZUjoCFEeNmxSic+Fq+xCOE6UILKgAi5DLn0H5woYX0YMX1x8S7AIRex+UTg03WrAsQR7jLTg==
X-Received: by 2002:a25:3743:0:b0:b8f:3eda:30b7 with SMTP id e64-20020a253743000000b00b8f3eda30b7mr16998639yba.13.1681764862656;
        Mon, 17 Apr 2023 13:54:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6-20020a259386000000b00b923b9e0a82sm1524900ybm.45.2023.04.17.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:22 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/10] builtin/gc.c: ignore cruft packs with
 `--keep-largest-pack`
Message-ID: <796df920ad6af0ee9101a0f3f80edbc793987336.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cruft packs were implemented, we never adjusted the code for `git
gc`'s `--keep-largest-pack` and `gc.bigPackThreshold` to ignore cruft
packs. This option and configuration option share a common
implementation, but including cruft packs is wrong in both cases:

  - Running `git gc --keep-largest-pack` in a repository where the
    largest pack is the cruft pack itself will make it impossible for
    `git gc` to prune objects, since the cruft pack itself is kept.

  - The same is true for `gc.bigPackThreshold`, if the size of the cruft
    pack exceeds the limit set by the caller.

Ignore cruft packs in the common implementation for both of these
options, and add a pair of tests to prevent any future regressions here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/gc.txt | 10 ++++-----
 Documentation/git-gc.txt    |  7 +++---
 builtin/gc.c                |  2 +-
 t/t6500-gc.sh               | 43 +++++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 38fea076a2..8d5353e9e0 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -43,11 +43,11 @@ gc.autoDetach::
 	if the system supports it. Default is true.
 
 gc.bigPackThreshold::
-	If non-zero, all packs larger than this limit are kept when
-	`git gc` is run. This is very similar to `--keep-largest-pack`
-	except that all packs that meet the threshold are kept, not
-	just the largest pack. Defaults to zero. Common unit suffixes of
-	'k', 'm', or 'g' are supported.
+	If non-zero, all non-cruft packs larger than this limit are kept
+	when `git gc` is run. This is very similar to
+	`--keep-largest-pack` except that all non-cruft packs that meet
+	the threshold are kept, not just the largest pack. Defaults to
+	zero. Common unit suffixes of 'k', 'm', or 'g' are supported.
 +
 Note that if the number of kept packs is more than gc.autoPackLimit,
 this configuration variable is ignored, all packs except the base pack
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a65c9aa62d..2427478314 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -77,9 +77,10 @@ be performed as well.
 	instance running on this repository.
 
 --keep-largest-pack::
-	All packs except the largest pack and those marked with a
-	`.keep` files are consolidated into a single pack. When this
-	option is used, `gc.bigPackThreshold` is ignored.
+	All packs except the largest pack, any packs marked with a
+	`.keep` file, and any cruft pack(s) are consolidated into a
+	single pack. When this option is used, `gc.bigPackThreshold` is
+	ignored.
 
 AGGRESSIVE
 ----------
diff --git a/builtin/gc.c b/builtin/gc.c
index edd98d35a5..53ef137e1d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -219,7 +219,7 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	struct packed_git *p, *base = NULL;
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
-		if (!p->pack_local)
+		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
 			if (p->pack_size >= limit)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index d9acb63951..df6f2e6e52 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -298,6 +298,49 @@ test_expect_success 'feature.experimental=false avoids cruft packs by default' '
 	)
 '
 
+test_expect_success '--keep-largest-pack ignores cruft packs' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Generate a pack for reachable objects (of which there
+		# are 3), and one for unreachable objects (of which
+		# there are 6).
+		prepare_cruft_history &&
+		git gc --cruft &&
+
+		mtimes="$(find .git/objects/pack -type f -name "pack-*.mtimes")" &&
+		sz="$(test_file_size "${mtimes%.mtimes}.pack")" &&
+
+		# Ensure that the cruft pack gets removed (due to
+		# `--prune=now`) despite it being the largest pack.
+		git -c gc.bigPackThreshold=$sz gc --cruft --prune=now &&
+
+		assert_no_cruft_packs
+	)
+'
+
+test_expect_success 'gc.bigPackThreshold ignores cruft packs' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Generate a pack for reachable objects (of which there
+		# are 3), and one for unreachable objects (of which
+		# there are 6).
+		prepare_cruft_history &&
+		git gc --cruft &&
+
+		# Ensure that the cruft pack gets removed (due to
+		# `--prune=now`) despite it being the largest pack.
+		git gc --cruft --prune=now --keep-largest-pack &&
+
+		assert_no_cruft_packs
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.38.1

