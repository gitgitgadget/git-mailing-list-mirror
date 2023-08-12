Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D06C001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbjHLABB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbjHLAA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F71FF0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso1906557b3a.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798456; x=1692403256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af6Idsvllj9+XrEMPM7RyG058LIfLHYt+3X+2+wki2M=;
        b=AHPlqgeDOk5WW9/iXmK9sT7jkJDxr09w6Fy1e9c3RIfedPs23NQYhJnPEVsx2CpmHg
         caGEVru5CvWV3acJCuekHK97uQA7zrxsYvsy1OfeObOGGzIvKJ7jQS52/VN786vgidyI
         q3tD3c/Eh4dh8cRmDTBcHZGYLBgpP7AY8q9ytu0W3mR4JFZfLkanPv77QF2i2aZyDdnk
         iGX/uW1TwX53UGbKLO72vk3Z1NXQmE3VNw0R00FcVbpDPF6TVGQCDxYNDfz3SlkqcYqx
         clgMZntdjB/rNALXq3YTF3aTn+iZ705cuEZojmM0rPOGtKU5hfYiBQ/qe8/WQ+KQXjDB
         Cxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798456; x=1692403256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af6Idsvllj9+XrEMPM7RyG058LIfLHYt+3X+2+wki2M=;
        b=gBPrLISeKhcfVTkOzPll46YHhTKu45JNjsZtswg6/bewPRR0TiLAC67iygw3qK3zGF
         kAPQcswR35bUlHcMZ5RiiPAczQ8JhrdYn+LkXgNH2pRF4PnIxYK54nlBGm7ymVYX/Zgm
         mtUgkIksEoOOl3UP/HaggULM7X1q/tazDKVuA8b3sKXqpDuOiilLZKgXuxV59ymC9OXp
         cG9XyaIhOOl+YXYNTmqslsICXuztVCyhCNMtY+PbW4vLttyGjLC0OJvgLe+q6BtOvsAU
         zOaJlcUMwzOv85Gulx0XIRpVqZhMFAtpKrkDQabnV4TBaeH9ooB5s+dyqY3Dipe2Q2je
         bE+w==
X-Gm-Message-State: AOJu0Yz/fS6MQcpBi8IFsGapjT/jPUEKDkD/WEDEr5sLq0AvjoNv4un4
        zSgXTP1DbMenpmyr4n2jzBCmaV4rNx4VZQ==
X-Google-Smtp-Source: AGHT+IHn+WBjuQ5MTgEta7ATDsxvrd4WsQFYejIp6FJjmMNQZdALlzeGFo/gaL/O0JoR7Ju4Jf5KNA==
X-Received: by 2002:a05:6a21:329a:b0:140:6979:295d with SMTP id yt26-20020a056a21329a00b001406979295dmr4035900pzb.2.1691798456166;
        Fri, 11 Aug 2023 17:00:56 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:55 -0700 (PDT)
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
Subject: [PATCH v5 7/8] repack: implement `--filter-to` for storing filtered out objects
Date:   Sat, 12 Aug 2023 02:00:10 +0200
Message-ID: <20230812000011.1227371-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
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
index c672387ab9..c396029ec9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -870,6 +870,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
+	const char *filter_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -922,6 +923,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("write a multi-pack index of the resulting packs")),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
+			   N_("pack prefix to store a pack containing filtered out objects")),
 		OPT_END()
 	};
 
@@ -1070,6 +1073,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (po_args.filter_options.choice)
 		strvec_pushf(&cmd.args, "--filter=%s",
 			     expand_list_objects_filter_spec(&po_args.filter_options));
+	else if (filter_to)
+		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
 
 	if (geometry)
 		cmd.in = -1;
@@ -1158,8 +1163,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
2.42.0.rc1.8.ga52e3a71db

