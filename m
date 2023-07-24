Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606A2C001DE
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 09:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGXJAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjGXI7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD069E4F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so10688750a12.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189185; x=1690793985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayFhYX9N8prj0BLiW1EZaoSp1ab2Zg9ZMd3bxPsoo4E=;
        b=Z6tlff02j5RPKBQ1E43o3VmSc741ifomaIjE5zz+OoDHrp4qaYNgv0cwp4U7MGuXAa
         ZF4BqPy0fdKNrOaGCKOlaSNK6qTfFEjobyKfdHSB04KhEMvyq14wsirOkH2Vi59jOkS4
         Bbn8yDztfpHSEObOKf0bWMc8N5BtDOy1RgwFEMs/uXxw3JRt8UtGK7Dh9jYSHQuHw18N
         4NiTg0J2dmJou7p4aCgXpebAl0orz+B5XMXCr/XcXj3w1aQbFoU13LiAE2cSB7QdV//3
         muuqAk1XL6ObbZbm1/c4TtLrabUPinmnK35glwUjK9+O512VTjvJFLRDKH1ggnEaSuW0
         5G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189185; x=1690793985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayFhYX9N8prj0BLiW1EZaoSp1ab2Zg9ZMd3bxPsoo4E=;
        b=OivbnVwEoMwaKnoVwUN8C69TopPU4VMZWUIgTp2VLK4ZSK6d9ML69FDU5rpo5sQdD2
         ukwf/eSnwNHb+RvdCmMAwonSpDH4re5NKBo5qM1aXu0EEM/Pnu4iV1BOTlaO48iKosx5
         S3sJtrcD78UCtP+L5ExQMD0Qjo80t+2dLqQhhs+ybCIrRq6vTpfDfMKWL+zVeJnM1gqG
         ZYXRYMxfYlsUx2Qe6UxHPSSWP1qiazPJsgpKf+DRPrrO7uwDqBGyRlIpPBFORva8lLC/
         veco2/YspQbFipSQ4DU6FdIiVIedFZXUG829quyOHxURCvIiQBliABzJUSEvWFOeJ0vp
         SMHA==
X-Gm-Message-State: ABy/qLZlGalvLVwChDEG7DxXL0wkg5iugf/vkS4lKHDqLI8CVVxZfvs1
        nuYxcNFgnU0nvn437w8Y6cjkKDpJrtU=
X-Google-Smtp-Source: APBJJlEYspjopbaLYbGl245vNtrRWW8iKdg9fKIYdNPY+5t3FTpGh3OK1MjwYq2pbFcEy9Ho3t8DcQ==
X-Received: by 2002:a17:906:76c7:b0:994:1805:1fad with SMTP id q7-20020a17090676c700b0099418051fadmr9381394ejn.10.1690189184744;
        Mon, 24 Jul 2023 01:59:44 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:43 -0700 (PDT)
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
Subject: [PATCH v3 7/8] repack: implement `--filter-to` for storing filtered out objects
Date:   Mon, 24 Jul 2023 10:59:08 +0200
Message-ID: <20230724085909.3831831-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
example cheaper storage.

Even in a different directory, this pack can be accessible if, for
example, the Git alternates mechanism is used to point to it. In fact
not using the Git alternates mechanism can corrupt a repo as the
generated pack containing the filtered objects might not be accessible
from the repo any more. So setting up the Git alternates mechanism
should be done before using this feature if the user wants the repo to
be fully usable while this feature is used.

In some cases, like when a repo has just been cloned or when there is no
other activity in the repo, it's Ok to setup the Git alternates
mechanism afterwards though. It's also Ok to just inspect the generated
packfile containing the filtered objects and then just move it into the
'.git/objects/pack/' directory manually. That's why it's not necessary
for this command to check that the Git alternates mechanism has been
already setup.

While at it, as an example to show that `--filter` and `--filter-to`
work well with other options, let's also add a test to check that these
options work well with `--max-pack-size`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

repack: add test with --max-pack-size
---
 Documentation/git-repack.txt | 11 ++++++
 builtin/repack.c             | 11 +++++-
 t/t7700-repack.sh            | 66 ++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 6d5bec7716..c0fbb0ed0c 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -155,6 +155,17 @@ depth is 4095.
 	a single packfile containing all the objects. See
 	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
 
+--filter-to=<dir>::
+	Write the pack containing filtered out objects to the
+	directory `<dir>`. Only useful with `--filter`. This can be
+	used for putting the pack on a separate object directory that
+	is accessed through the Git alternates mechanism. **WARNING:**
+	If the packfile containing the filtered out objects is not
+	accessible, the repo could be considered corrupt by Git as it
+	migh not be able to access the objects in that packfile. See
+	the `objects` and `objects/info/alternates` sections of
+	linkgit:gitrepository-layout[5].
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index 2c81b7738e..626284191b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -871,6 +871,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
+	const char *filter_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -924,6 +925,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("write a multi-pack index of the resulting packs")),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
+			   N_("pack prefix to store a pack containing filtered out objects")),
 		OPT_END()
 	};
 
@@ -1067,6 +1070,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--incremental");
 	}
 
+	if (filter_to && !po_args.filter)
+		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
+
 	if (geometry)
 		cmd.in = -1;
 	else
@@ -1154,8 +1160,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index 0a2c73bca7..2bf237ba3a 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -351,6 +351,72 @@ test_expect_success '--filter fails with --write-bitmap-index' '
 		--filter=blob:none
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
2.41.0.384.ged66511823

