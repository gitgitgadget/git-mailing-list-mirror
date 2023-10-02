Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5842EE748FE
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbjJBQzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbjJBQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC3FD
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so4069880a12.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265737; x=1696870537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcDCGtCuL69vamozo+DX4dhtNjlpqdJbSwNEKqSuzJg=;
        b=X3ktopdr44OKhrtQ9pJYdriM05qaPOG3dXWqHeUhDxwir9syJDcd7IGZa2HLCkqaDz
         UpzV7KHmA1LyY++b+xpGIKpQ+9/Sd3HXEH1vTPn3huU9eEaGG7dbsZFS7DEOa3GkLOs2
         C7JhB5a61x+bL8nwEL8fTrlBKY7Yh9GAfiKoh3RG6HqS7O+6LPMp7RvGlLn9SoPmggPN
         H+OWk35BFQCVh32nvtQi0CjgwSyuyU1/ARc21kMnynis/f0E1++0v6UIsoDQHG2kmVMW
         PcHj9ZZZYXC60QEFz3xLnxY5DZ9wb5vqMSuw2nByghkstU3+j4sWPmSxdWgoXAc/B/2C
         O1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265737; x=1696870537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcDCGtCuL69vamozo+DX4dhtNjlpqdJbSwNEKqSuzJg=;
        b=MZ9HtjFriMRkZg7+bcs6E4VGzv3t0woWIrc2d93cJc1WpjLbPx5J++QaVCeel7QwE5
         Y4sKZq8LYCRI8roRD72T+EhfYw20yqE0hLrGYaTh668ALFghA/3yalVpmgT4xGzKVhoN
         2NCwRFoFrwGkjZqqZzy7ylRSIUHIwkHIhh0UhW6MyTrzgi5rJ6WIjoCo2nK0GS/WVqAc
         d0JuQOaMO9QtpSWXiFa80zr+SWD/2/FoWbDkjr9P/DIeRLbCUt8FIno3C7kpWerA8wQt
         h6D2u+6SQ0aKQ43Gp6R0O/zmImEPFeVkX7U+inPMs4L6XtaI3q7/Rpd4+dMT+AirTwbq
         9JFw==
X-Gm-Message-State: AOJu0YyhmviniP/cxvKlSCbdJXbmiYPUXmunyY7pPMNiy8pQza94MosI
        7XO4N1kqUCQ+S5nZxkUhoqhXlJ9Rk2J8Kg==
X-Google-Smtp-Source: AGHT+IEiw5BZpT03NapE3zmOVeGzEmwv9foY0kVB3zDZT0ux9h5udlerrgyDYpcF9hxUbIPOf6zTPA==
X-Received: by 2002:aa7:d0c7:0:b0:533:ccec:552 with SMTP id u7-20020aa7d0c7000000b00533ccec0552mr240279edo.9.1696265737543;
        Mon, 02 Oct 2023 09:55:37 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:37 -0700 (PDT)
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
Subject: [PATCH v8 8/9] repack: implement `--filter-to` for storing filtered out objects
Date:   Mon,  2 Oct 2023 18:55:03 +0200
Message-ID: <20231002165504.1325153-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
index c7b564192f..db9277081d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -977,6 +977,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int write_midx = 0;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
+	const char *filter_to = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -1029,6 +1030,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			   N_("write a multi-pack index of the resulting packs")),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
+		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
+			   N_("pack prefix to store a pack containing filtered out objects")),
 		OPT_END()
 	};
 
@@ -1177,6 +1180,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (po_args.filter_options.choice)
 		strvec_pushf(&cmd.args, "--filter=%s",
 			     expand_list_objects_filter_spec(&po_args.filter_options));
+	else if (filter_to)
+		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
 
 	if (geometry.split_factor)
 		cmd.in = -1;
@@ -1265,8 +1270,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (po_args.filter_options.choice) {
+		if (!filter_to)
+			filter_to = packtmp;
+
 		ret = write_filtered_pack(&po_args,
-					  packtmp,
+					  filter_to,
 					  find_pack_prefix(packdir, packtmp),
 					  &existing,
 					  &names);
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
2.42.0.305.g5bfd918c90

