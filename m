Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3330CA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbjIKVd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbjIKPHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:07:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E25FA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:07:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99357737980so568776266b.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444821; x=1695049621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jTqGBy8+r7tHRc+wqddUrpZxQufCgwHdZ5VD4Unzzw=;
        b=se26rCBxpTTY49T3LE6S7i/pTJLGkD1fKCDisQWpnREZzEQPVvtYNQsV0w4yFnd7N0
         Rxy0O3NRPNoE4BeLGI6VquJmOrvoX3B7dvQSXtCyEepAP2lhCiOliY92N4onMSHapb4s
         DheBj43JD9WBj8S21731qQla2NkP0PkJQcRrLGG1eRlZiuTQ5DujnHPKEKGHlOvEnXFR
         Gz9KNVDmtfek5ljNG1C52+S9z6ZIey7GHpkG8Gix30h1Yddgl9CmeKKZAN2mrVEY1oPC
         qShA9HlDcEqJyx/4R4ERMlYoNqtZcZ+cOoSvuAPYuWG+kGAy1kwtYc1Ziik7rUf0Viqy
         mILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444821; x=1695049621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jTqGBy8+r7tHRc+wqddUrpZxQufCgwHdZ5VD4Unzzw=;
        b=FFNQ451Tkn0KI2VttHS/cuoiNB1/D/+jl7cHAmx/bSey3PYEDa0SLUllCfYhFFOk1y
         8WcEjKoos5+oZwOCfzLIAhjvTXcrdECJe4UoYU4VGDzfFkoU6nzyIqg6HZV9Wd1xxeyF
         fH8LybFTlD9hZEXkIUuXQOJG7WHlSSJDlXhFtAB+Pwb/CeDYXltmnZrTyeP5EaeBeTI7
         VZJQuLfAJAxwXue6yx7uh+cCIAzsw+lDIGyd52lx/sXiF2U9H4dQGSDe72EvKw9z6wHM
         XPjJbxJPCcBsHCRNZ6Bm9adqn1NiySNyFf1/i+uLuKWaulsyHdBv2V/PEmYbwSDkoSBn
         p8Aw==
X-Gm-Message-State: AOJu0Yx2w63RaYiOG5cM/QNKMmHUilVUFTwFStOcq0OvMg0uXC9YqSk1
        kSB+JZ7h6UO8GCkZB/c4dTsh5u3ubSY=
X-Google-Smtp-Source: AGHT+IGgSFXGk7zgxZXvTRYZ/MoH4tbeEedHHNRgVTd1P/V4+vqNMifc5pGWuGJZHAS6IXknS1AZeQ==
X-Received: by 2002:a17:906:7499:b0:9a2:200:b68d with SMTP id e25-20020a170906749900b009a20200b68dmr8835754ejl.0.1694444820632;
        Mon, 11 Sep 2023 08:07:00 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:07:00 -0700 (PDT)
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
Subject: [PATCH v6 8/9] repack: implement `--filter-to` for storing filtered out objects
Date:   Mon, 11 Sep 2023 17:06:17 +0200
Message-ID: <20230911150618.129737-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
 <20230911150618.129737-1-christian.couder@gmail.com>
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
---
 Documentation/git-repack.txt | 11 +++++++
 builtin/repack.c             | 10 +++++-
 t/t7700-repack.sh            | 62 ++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 6d5bec7716..8545a32667 100644
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
+	accessible, the repo can become corrupt as it might not be
+	possible to access the objects in that packfile. See the
+	`objects` and `objects/info/alternates` sections of
+	linkgit:gitrepository-layout[5].
+
 -b::
 --write-bitmap-index::
 	Write a reachability bitmap index as part of the repack. This
diff --git a/builtin/repack.c b/builtin/repack.c
index ac70698a41..e0e1b52cf0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -867,6 +867,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
+	const char *filter_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -919,6 +920,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("write a multi-pack index of the resulting packs")),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
+			   N_("pack prefix to store a pack containing filtered out objects")),
 		OPT_END()
 	};
 
@@ -1067,6 +1070,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (po_args.filter_options.choice)
 		strvec_pushf(&cmd.args, "--filter=%s",
 			     expand_list_objects_filter_spec(&po_args.filter_options));
+	else if (filter_to)
+		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
 
 	if (geometry.split_factor)
 		cmd.in = -1;
@@ -1157,8 +1162,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (po_args.filter_options.choice) {
+		if (!filter_to)
+			filter_to = packtmp;
+
 		ret = write_filtered_pack(&po_args,
-					  packtmp,
+					  filter_to,
 					  find_pack_prefix(packdir, packtmp),
 					  &keep_pack_list,
 					  &names,
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 39e89445fd..48e92aa6f7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -462,6 +462,68 @@ test_expect_success '--filter works with --pack-kept-objects and .keep packs' '
 	)
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
+	commit_pack=$(test-tool -C bare.git find-pack -c 1 HEAD) &&
+	blob_pack=$(test-tool -C bare.git find-pack -c 0 HEAD:file1) &&
+	blob_hash=$(git -C bare.git rev-parse HEAD:file1) &&
+	test -n "$blob_hash" &&
+	blob_pack=$(test-tool -C filtered.git find-pack -c 1 $blob_hash) &&
+
+	echo $(pwd)/filtered.git/objects >bare.git/objects/info/alternates &&
+	blob_pack=$(test-tool -C bare.git find-pack -c 1 HEAD:file1) &&
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
+		foo_pack=$(test-tool find-pack -c 1 HEAD:foo) &&
+		bar_pack=$(test-tool find-pack -c 1 HEAD:bar) &&
+		base_pack=$(test-tool find-pack -c 1 HEAD:base.t) &&
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
2.42.0.167.gd6ff314189

