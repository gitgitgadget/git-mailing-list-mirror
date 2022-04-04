Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACF4C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 02:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiDECVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 22:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiDECVe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 22:21:34 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41F2EAE13
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 18:16:34 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id b17so12805790lfv.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRtwmzUjI7S48c2c6VOlmemDATR8YlgXRRaZOEzVKxI=;
        b=Dpc7czxX/1rqhBAj/K+xaXcG1TqkaJCSS3ZRw8nlzSe5wC8K37rVOa4nGxYEI7DUu0
         pwpUBl+CscPjQ2ZRtWlbeFZE6q3bo6DjcsKHRTnHOytArT7EBSieohQ6v6aQLVJaJaL6
         Lpi7s3FrFKTgtLEXdmJVgl/7bc4vcW0yTvdrR8Nr54CY5n+bEGrRU6Lmp0R+GsBgBvIN
         rG15GZfcwzetNv6CYfKhqo6zlj3WIpW5li1bhxFrP8IfGqtVli7vUiJGzCoEC8qqvFNF
         CpZ1rDz7iQnxQ+YzuYe9iYe5/zvG7vRcmTDFNRU8BkzC46OHdsgOFnUGCiexwsSthHrC
         NCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRtwmzUjI7S48c2c6VOlmemDATR8YlgXRRaZOEzVKxI=;
        b=fJZDrOFj+TIJFKrhQcgNq4JkSUT9lX2VhLLX+BdVAoU4qWCdDd4cSQQJE2RgdLOhdW
         4z8BdqRXShmd4maL7fXvs1fcXN2LSD4GRjjwJ8ocvMuxIibx6oEatfSnUBUw0O3mjqWU
         UfxZBggQH9RjwERWm8OWy05ZXn3jzZCYWO16cgcPfdeSs8PydbGJ+aZWEPHKDVwZP9Gg
         h41LeDLKiOs2ItX5VQ0ZSFfQew0f2SC2AO4zJaXZ0sm2WhMQwy1Xs691YiBbGeiwinLW
         0HMz2UrmljBSPPuKO9ep/l/ctgJbP0531U1u/T0i/g7u9AJHxH5uXkgV1le442y1AVMo
         FbxA==
X-Gm-Message-State: AOAM530E2ZR7njJK3w9LrMGj5UK5wDtgBiVKqqFkG63S8mainEv5Qa3G
        u+u1K2fmaW0qB5sZnVGEMwgib3pZSnMwCQ==
X-Google-Smtp-Source: ABdhPJztgUzFfCs3Jip80hKbM9gvUaiRiKaSIEk7gFdij8w9S2ENPewF6O247PE333pBr6Miv/ZI+g==
X-Received: by 2002:a5d:6484:0:b0:205:8a53:f365 with SMTP id o4-20020a5d6484000000b002058a53f365mr446287wri.121.1649115933406;
        Mon, 04 Apr 2022 16:45:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b0038e785baac7sm388632wme.11.2022.04.04.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 16:45:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v2] ls-tree: fix --long implying -r regression in 9c4d58ff2c3
Date:   Tue,  5 Apr 2022 01:45:30 +0200
Message-Id: <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1604.g35dc6517170
In-Reply-To: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
References: <9ce4dadf140204e934f7025bb91385c376118940.1649111831.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression introduced in 9c4d58ff2c3 (ls-tree: split up "fast
path" callbacks, 2022-03-23), and improve the tests added in the
1041d58b4d9 (Merge branch 'tl/ls-tree-oid-only', 2022-04-04) topic it
was merged as part of to test the full expected output of various
"ls-tree" options with and without -r.

Let's fix it, and also add tests not only for that blindspot, but also
any other potential blindspots. To that end test the "modes" of -d, -r
and -t (as well as "no mode") against all of the format options.

These tests all pass with that topic reverted (except those that would
fail because they're testing the new --object-only feature introduced
in that topic), which should give us confidence that there were no
further regressions in this area.

Reported-By: Josh Steadmon <steadmon@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Apr 04 2022, Josh Steadmon wrote:

> I believe this is the correct fix for the change in `git ls-tree -l`
> output. I would also like to add tests in a future fix, but I do not
> have time to add them today.

Indeed. I guess that makes this a proposed v2,

I refreshed my E-Mail when I was just about to submit this and spotted
that you'd sent your fix in, but I came up with this (in retrospect a
pretty obvious think-o) fix independently, sorry about the bug.

The tests took me a bit longer though...

Haing written them I guess we could do them post-release, since the
important thing is to validate the changes. As noted in the commit
message we're now testing all combinations of the "mode" and "format"
options.

 builtin/ls-tree.c         |   2 +-
 t/t3104-ls-tree-format.sh | 126 +++++++++++++++++++++++++++++++++++---
 2 files changed, 119 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 5dac9ee5b9d..e279be8bb63 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -255,7 +255,7 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
 	       find_unique_abbrev(data.oid, abbrev), size_text);
 	show_tree_common_default_long(base, pathname, data.base->len);
-	return 1;
+	return recurse;
 }
 
 static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 0769a933d69..520b5a95c08 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -23,6 +23,19 @@ test_ls_tree_format () {
 	fmtopts=$3 &&
 	shift 2 &&
 
+	cat >expect &&
+	cat <&6 >expect.-d &&
+	cat <&7 >expect.-r &&
+	cat <&8 >expect.-t &&
+
+	for opt in '' '-d' '-r' '-t'
+	do
+		test_expect_success "'ls-tree $opts${opt:+ $opt}' output" '
+			git ls-tree ${opt:+$opt }$opts $opt HEAD >actual &&
+			test_cmp expect${opt:+.$opt} actual
+		'
+	done
+
 	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
 		git ls-tree $opts -r HEAD >expect &&
 		git ls-tree --format="$format" -r $fmtopts HEAD >actual &&
@@ -39,38 +52,135 @@ test_ls_tree_format () {
 
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
-	""
+	"" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	OUT_D
+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_R
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_T
 
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
-	"--long"
+	"--long" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	040000 tree $(git rev-parse HEAD:dir)       -	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)       9	top-file.t
+	OUT
+	040000 tree $(git rev-parse HEAD:dir)       -	dir
+	OUT_D
+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)      13	dir/sub-file.t
+	100644 blob $(git rev-parse HEAD:top-file.t)       9	top-file.t
+	OUT_R
+	040000 tree $(git rev-parse HEAD:dir)       -	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)       9	top-file.t
+	OUT_T
 
 test_ls_tree_format \
 	"%(path)" \
-	"--name-only"
+	"--name-only" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	dir
+	top-file.t
+	OUT
+	dir
+	OUT_D
+	dir/sub-file.t
+	top-file.t
+	OUT_R
+	dir
+	top-file.t
+	OUT_T
 
 test_ls_tree_format \
 	"%(objectname)" \
-	"--object-only"
+	"--object-only" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	$(git rev-parse HEAD:dir)
+	$(git rev-parse HEAD:top-file.t)
+	OUT
+	$(git rev-parse HEAD:dir)
+	OUT_D
+	$(git rev-parse HEAD:dir/sub-file.t)
+	$(git rev-parse HEAD:top-file.t)
+	OUT_R
+	$(git rev-parse HEAD:dir)
+	$(git rev-parse HEAD:top-file.t)
+	OUT_T
 
 test_ls_tree_format \
 	"%(objectname)" \
 	"--object-only --abbrev" \
-	"--abbrev"
+	"--abbrev" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	$(git rev-parse HEAD:dir | test_copy_bytes 7)
+	$(git rev-parse HEAD:top-file.t| test_copy_bytes 7)
+	OUT
+	$(git rev-parse HEAD:dir | test_copy_bytes 7)
+	OUT_D
+	$(git rev-parse HEAD:dir/sub-file.t | test_copy_bytes 7)
+	$(git rev-parse HEAD:top-file.t | test_copy_bytes 7)
+	OUT_R
+	$(git rev-parse HEAD:dir | test_copy_bytes 7)
+	$(git rev-parse HEAD:top-file.t | test_copy_bytes 7)
+	OUT_T
 
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"-t" \
-	"-t"
+	"-t" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	OUT_D
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_R
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_T
 
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"--full-name" \
-	"--full-name"
+	"--full-name" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	OUT_D
+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_R
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_T
 
 test_ls_tree_format \
 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
 	"--full-tree" \
-	"--full-tree"
+	"--full-tree" \
+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	OUT_D
+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_R
+	040000 tree $(git rev-parse HEAD:dir)	dir
+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
+	OUT_T
 
 test_done
-- 
2.35.1.1604.g35dc6517170

