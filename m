Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C074EC04FDF
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjHHQQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHHQOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:14:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547F83D8
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:48:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c0290f0a8so764862166b.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509682; x=1692114482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDRxcXsgxxKjxN0Swbk+ESqawJpwFyyiyqpcsjNz6Kw=;
        b=BUj2LRvJdeqMJHrPA1GCSyscz33gRuj0J3FFl1qdsoTWtri9n7pGvf6hgjOxn79ied
         JbErXYdkg2u4jKToO8gYMAw44D1CfMqBwedYr4pr5lzRH2Fl0llajGUveI/XBwbVohtu
         GdktrQI+Y7eVHVNuHQv/ZsaNaG60ufX7C9Ng/llHhXbeCVpopfcPfAi1CfOiz7IJl6dv
         bwHJn/lNYRpQ9NohvQNZVTDvjy/QNbCCKjVTjyuZ0lPe+loPvXj0lI6hq6bfAQPgkurx
         tpvDeENtqkkiZBF1F6rfvPQZxBHAo4ZAQy8S2ZbPhR0NLhtjg1o5f/jhvUEY9YSuZSSa
         xTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509682; x=1692114482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDRxcXsgxxKjxN0Swbk+ESqawJpwFyyiyqpcsjNz6Kw=;
        b=BMIHjzigRL80MpjJd8/IiaKBYYGMP87UKj/dvPmcw5b0g2y4tkR71kzdIw2s3kNC8S
         2UT0kJRp/Gc0LeMF93cvIGEg5efjxTEcz/849Cp6gKorA+x1mEphID3/px2qD4sAJ7ng
         yDLTk3cUHp4M18u7kCVb9ZfOme3rLD7WRxBtQfuvRipxSnrthG6N3QGmg8FNfKp/mEv5
         MKBZJXa+tY+PQSapL1DSN1NRxuHWwkTb5IQhfiEGsaDHKQK4lDUf5PwYKlZDOe5gTGQZ
         sZVffR6vw7r5mgDL/kSs8bztzgRQMS9nFaGnAA4hUSiq6XtxHENT0QCREsn7iBuxzi4i
         n6ZA==
X-Gm-Message-State: AOJu0YymYT1YlICpMhxB98aRouU2IxUYlSol+eTxr2vyA1WGo6bD/pXH
        7R1hCpR6I/KjOpvqgXYYIWuPCOyBecI=
X-Google-Smtp-Source: AGHT+IEkb3u5DDVUoFoIp6awFdoq6Pa5iKPc9pQXB5lGVmQlOvk2r2FywY81fVqMME1GWYFkYPSeOg==
X-Received: by 2002:a7b:c7d9:0:b0:3fc:5606:c243 with SMTP id z25-20020a7bc7d9000000b003fc5606c243mr8031677wmk.13.1691483196257;
        Tue, 08 Aug 2023 01:26:36 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:35 -0700 (PDT)
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
Subject: [PATCH v4 7/8] repack: implement `--filter-to` for storing filtered out objects
Date:   Tue,  8 Aug 2023 10:26:07 +0200
Message-ID: <20230808082608.582319-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
index 876c115cdc..f5bc650c1e 100644
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
 
@@ -1071,6 +1074,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (po_args.filter_options.choice)
 		strvec_pushf(&cmd.args, "--filter=%s",
 			     expand_list_objects_filter_spec(&po_args.filter_options));
+	else if (filter_to)
+		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
 
 	if (geometry)
 		cmd.in = -1;
@@ -1159,8 +1164,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
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
index 5d3e53134c..9b1e189a62 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -461,6 +461,68 @@ test_expect_success '--filter works with --pack-kept-objects and .keep packs' '
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
2.42.0.rc0.8.g76fac86b0e

