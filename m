Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A008C001B3
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGEGJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGEGIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B71A10C8
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso9794769e87.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537320; x=1691129320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rtt/W9X/PYzk7qi7rcYewaNiWJiEssDMzazzYdPc7vg=;
        b=Mkd1UJ9mgjF0ac1Utj8fH0PFEV3BDmVBG8OQ8X/uST5J/rFx1rkdQe+VLR+zEmQ052
         WxvN9YtTXosMMxPmIqh+ZyGwoM1KJzTTSX0x5MP6NIKuZx45WbnjiG//sY3TYhLdayIP
         +C1Gh8enMAQyW2Sdje5ouxfkG6QPwoJBhpCW92+c7kGxSrnl735lFJ3kUvP4uOKkDTvW
         bTQtCbpick29mTeo/098soQplOhqpHzXllZZiLYJju/9jvAjkFIxCM01dEKsTVUoVwqX
         v8mZJsRKouCN0mYTgu6spD4lmb4G8jmCvRdtOxbg9qBhkveHVxXonA/pYhyPn2CjcvjL
         UMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537320; x=1691129320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtt/W9X/PYzk7qi7rcYewaNiWJiEssDMzazzYdPc7vg=;
        b=BpdMihcWA82O91yBY+RV8qpNa0yjLaMGh8LQueGFMGnoMz04h0M1nHBOT0b4Os0R/9
         PHlXFfGw+oax/9ISgFgvHLB6s+yY29LK4jiN60wm6cnSZRI55kH+8wnvGlg+s23BanWw
         6uKd7aOCyC1ovcmXNcOc+qEZemPzSY6MbyasGmtsiuvZUkE0VVJJJ9o7Yp2CUY5VVX31
         X12PDfUDGcFRmrumnErdyvAXlSZnY1LZ8U8jRlCPTgM/rNc6PTm4AAfTf8q9ujDbTPhQ
         Kq3NBg3/OtAllG59rYCB09dUbFeQ72M5aqXZZWlzs3HCB2ekGK8TT36/zXmHy2rz2FQa
         sZjg==
X-Gm-Message-State: ABy/qLZTUku478tnNT45eioGRqRa7T1MFtP8a8MOvS7tbqCOIBmU4NQK
        46/6FnOaPx7NrtY45kk2e72t+/FGx7Y=
X-Google-Smtp-Source: APBJJlGEeQuTgQPtdnX9o1n2i+1PwdkOjcDqKKNgqErBE1J/mU1EwehtER6S1OV8M+Zwq1Sr57MG7Q==
X-Received: by 2002:a19:e010:0:b0:4fb:89b3:3374 with SMTP id x16-20020a19e010000000b004fb89b33374mr9091805lfg.54.1688537319548;
        Tue, 04 Jul 2023 23:08:39 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:38 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 7/8] repack: implement `--filter-to` for storing filtered out objects
Date:   Wed,  5 Jul 2023 08:08:11 +0200
Message-ID: <20230705060812.2865188-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit has implemented `git repack --filter=<filter-spec>` to
allow users to filter out some objects from the main pack and move them
into a new different pack.

It would be nice if this new different pack could be created in a
different directory than the regular pack. This would make it possible
to move large blobs into a pack on a different kind of storage, for
example cheaper storage. Even in a different directory this pack can be
accessible if, for example, the Git alternates mechanism is used to
point to it.

While at it, as an example to show that `--filter` and `--filter-to`
work well with other options, let's also add a test to check that these
options work well with `--max-pack-size`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

repack: add test with --max-pack-size
---
 Documentation/git-repack.txt |  6 ++++
 builtin/repack.c             | 11 +++++-
 t/t7700-repack.sh            | 66 ++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d702553033..396a91b9ac 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -152,6 +152,12 @@ depth is 4095.
 	this option.  See linkgit:git-rev-list[1] for valid
 	`<filter-spec>` forms.
 
+--filter-to=<dir>::
+	Write the pack containing filtered out objects to the
+	directory `<dir>`. This can be used for putting the pack on a
+	separate object directory that is accessed through the Git
+	alternates mechanism. Only useful with `--filter`.
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index e2661b956c..5695f9734d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -879,6 +879,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
+	const char *filter_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -932,6 +933,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("write a multi-pack index of the resulting packs")),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
+			   N_("pack prefix to store a pack containing filtered out objects")),
 		OPT_END()
 	};
 
@@ -1075,6 +1078,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
+	if (filter_to && !po_args.filter)
+		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
+
 	if (geometry)
 		cmd.in = -1;
 	else
@@ -1162,8 +1168,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (po_args.filter) {
+		if (!filter_to)
+			filter_to = packtmp;
+
 		ret = write_filtered_pack(&po_args,
-					  packtmp,
+					  filter_to,
 					  find_pack_prefix(),
 					  &names,
 					  &existing_nonkept_packs,
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 66589e4217..a96c1635b2 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -309,6 +309,72 @@ test_expect_success 'repacking with a filter works' '
 	test "$blob_pack2" = "$blob_pack"
 '
 
+test_expect_success '--filter-to stores filtered out objects' '
+	git -C bare.git repack -a -d &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+
+	git init --bare filtered.git &&
+	git -C bare.git -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:none \
+		--filter-to=../filtered.git/objects/pack/pack &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/pack-*.pack &&
+	test_stdout_line_count = 1 ls filtered.git/objects/pack/pack-*.pack &&
+
+	commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
+	test -n "$commit_pack" &&
+	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
+	test -z "$blob_pack" &&
+	blob_hash=$(git -C bare.git rev-parse HEAD:file1) &&
+	test -n "$blob_hash" &&
+	blob_pack=$(test-tool -C filtered.git find-pack $blob_hash) &&
+	test -n "$blob_pack" &&
+
+	echo $(pwd)/filtered.git/objects >bare.git/objects/info/alternates &&
+	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
+	test -n "$blob_pack" &&
+	blob_content=$(git -C bare.git show $blob_hash) &&
+	test "$blob_content" = "content1"
+'
+
+test_expect_success '--filter works with --max-pack-size' '
+	rm -rf filtered.git &&
+	git init --bare filtered.git &&
+	git init max-pack-size &&
+	(
+		cd max-pack-size &&
+		test_commit base &&
+		# two blobs which exceed the maximum pack size
+		test-tool genrandom foo 1048576 >foo &&
+		git hash-object -w foo &&
+		test-tool genrandom bar 1048576 >bar &&
+		git hash-object -w bar &&
+		git add foo bar &&
+		git commit -m "adding foo and bar"
+	) &&
+	git clone --no-local --bare max-pack-size max-pack-size.git &&
+	(
+		cd max-pack-size.git &&
+		git -c repack.writebitmaps=false repack -a -d --filter=blob:none \
+			--max-pack-size=1M \
+			--filter-to=../filtered.git/objects/pack/pack &&
+		echo $(cd .. && pwd)/filtered.git/objects >objects/info/alternates &&
+
+		# Check that the 3 blobs are in different packfiles in filtered.git
+		test_stdout_line_count = 3 ls ../filtered.git/objects/pack/pack-*.pack &&
+		test_stdout_line_count = 1 ls objects/pack/pack-*.pack &&
+		foo_pack=$(test-tool find-pack HEAD:foo) &&
+		bar_pack=$(test-tool find-pack HEAD:bar) &&
+		base_pack=$(test-tool find-pack HEAD:base.t) &&
+		test "$foo_pack" != "$bar_pack" &&
+		test "$foo_pack" != "$base_pack" &&
+		test "$bar_pack" != "$base_pack" &&
+		for pack in "$foo_pack" "$bar_pack" "$base_pack"
+		do
+			case "$foo_pack" in */filtered.git/objects/pack/*) true ;; *) return 1 ;; esac
+		done
+	)
+'
+
 objdir=.git/objects
 midx=$objdir/pack/multi-pack-index
 
-- 
2.41.0.244.g8cb3faa74c

