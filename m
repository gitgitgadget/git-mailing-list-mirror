Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748B36AEB
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WRkqp4Bv"
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A431213A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:23:04 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67131800219so40915506d6.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699381383; x=1699986183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fI+D4IMqk4r9R7LsBjQLBvIeLqQkjS+RkfVlR2YZTiA=;
        b=WRkqp4BvGEBYeAH7oXCBTGtqjvWsf8HU6ICW6yd5/fQDEwUWYnyy36vcWEHnVa46To
         MvTQpJMXFXgXD7FcEaioXr6Oea80ZfPRNgQMqOTAUfzsTCC6dFOhj/0nF3+ssPciHOV5
         pXVsQT0lcgb8OkqAgRxXrgeuHPdbJFVFmh/QW+ofWoxTBDMKjWwaqO5UZiOnq0uTE73O
         VPemtfnd939gbBSu4ah7sRlKc/TiAvLy7SLCDqDLrMuImHYhMcNqZbbh9x3r6a3XY4LB
         vVd8WPl7PMNFhVBKsCwRaS65AGGXsHGrg8uyLJY5UUpRM683ePByXH1JnjdWRbWInoNQ
         0fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381383; x=1699986183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI+D4IMqk4r9R7LsBjQLBvIeLqQkjS+RkfVlR2YZTiA=;
        b=de94E8mS7gZ2Kkw8qFElPB+Q+HzfB+Gk2UQFUPpZ28cXzHQV0h35KuHK+kGDNGtHr8
         uCG82fGJsTb4VV+ICgJVV/xq2PELh2sC33DSTqIiz4vT6GGhO1LUqk7zWJeReU6vBsu5
         Z+quhZ9ZOr0ez9fRDARI5uGcOQMboLMDUg0YTL92AcscsQbqDhRf3MNERo7bMVXkYR8k
         yJI1++E2AIK7YsvgDcmgUK1+gNlFvimDpdQqfZP2niQaUW2JxtrkuyxEpcbrbZ9M3BW0
         sRO1SyJ2YbLfo61/DoXC68sJ93ZQZJ9BF9AoZwTuuXFfp8xtaJfUQrJrZeVAvp1s64Gp
         NhDw==
X-Gm-Message-State: AOJu0YxzXqCjPdRrN7jJ7kk51gmv1KMEduwlL7TLxIIqB+RPYJs59d2c
	tLUE+tupKvO2M1T8GdvauTdQ2oXSrdOKd5Njw2mSZw==
X-Google-Smtp-Source: AGHT+IHeMdnqx1oZ+O1BGIprSxrjSkCZGuiaYiDaXKba1VptPiyAZn9qeZx3bDJinBF+TR/dT+dFkQ==
X-Received: by 2002:ad4:5c88:0:b0:66d:1b4c:e867 with SMTP id o8-20020ad45c88000000b0066d1b4ce867mr47070683qvh.45.1699381383379;
        Tue, 07 Nov 2023 10:23:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q8-20020a05621410e800b006590d020260sm136688qvt.98.2023.11.07.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:23:03 -0800 (PST)
Date: Tue, 7 Nov 2023 13:23:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 3/3] builtin/replay.c: introduce `--write-pack`
Message-ID: <0b9ef904888d45289445638ae59817feab1dc813.1699381371.git.me@ttaylorr.com>
References: <ZUpepnSCSxL8i96b@nand.local>
 <cover.1699381371.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699381371.git.me@ttaylorr.com>

Now that the prerequisites are in place, we can implement a
`--write-pack` option for `git replay`, corresponding to the existing
one in `git merge-tree`.

The changes are mostly limited to:

  - introducing a new option in the builtin
  - replacing the main object store with the temporary one
  - then repacking and migrating the temporary object store back into
    the main object store after the replay has completed

Along with tests and documentation to ensure that the new behavior
matches our expectations.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-replay.txt |  4 ++++
 builtin/replay.c             | 18 ++++++++++++++++++
 t/t3650-replay-basics.sh     | 37 ++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index e7551aec54..f424c1a676 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -42,6 +42,10 @@ When `--advance` is specified, the update-ref command(s) in the output
 will update the branch passed as an argument to `--advance` to point at
 the new commits (in other words, this mimics a cherry-pick operation).
 
+--write-pack::
+	Write any new objects into a separate packfile instead of as
+	individual loose objects.
+
 <revision-range>::
 	Range of commits to replay. More than one <revision-range> can
 	be passed, but in `--advance <branch>` mode, they should have
diff --git a/builtin/replay.c b/builtin/replay.c
index c3d53ff0cd..72b7b7f43a 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -17,6 +17,7 @@
 #include "strmap.h"
 #include <oidset.h>
 #include <tree.h>
+#include "tmp-objdir.h"
 
 static const char *short_commit_name(struct commit *commit)
 {
@@ -272,6 +273,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *onto = NULL;
 	const char *onto_name = NULL;
 	int contained = 0;
+	int write_pack = 0;
 
 	struct rev_info revs;
 	struct commit *last_commit = NULL;
@@ -279,6 +281,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct merge_options merge_opt;
 	struct merge_result result;
 	struct strset *update_refs = NULL;
+	struct tmp_objdir *tmp_objdir = NULL;
 	kh_oid_map_t *replayed_commits;
 	int i, ret = 0;
 
@@ -296,6 +299,8 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &contained,
 			 N_("advance all branches contained in revision-range")),
+		OPT_BOOL(0, "write-pack", &write_pack,
+			 N_("write new objects to a pack instead of as loose")),
 		OPT_END()
 	};
 
@@ -352,8 +357,15 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 0;
+	merge_opt.write_pack = write_pack;
 	last_commit = onto;
 	replayed_commits = kh_init_oid_map();
+
+	if (merge_opt.write_pack) {
+		tmp_objdir = tmp_objdir_create("replay");
+		tmp_objdir_replace_primary_odb(tmp_objdir, 0);
+	}
+
 	while ((commit = get_revision(&revs))) {
 		const struct name_decoration *decoration;
 		khint_t pos;
@@ -417,5 +429,11 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	/* Return */
 	if (ret < 0)
 		exit(128);
+	if (ret && tmp_objdir) {
+		if (tmp_objdir_repack(tmp_objdir) < 0)
+			ret = 0;
+		else if (tmp_objdir_migrate(tmp_objdir) < 0)
+			ret = 0;
+	}
 	return ret ? 0 : 1;
 }
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 389670262e..e7048748c2 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -67,6 +67,43 @@ test_expect_success 'using replay to rebase two branches, one on top of other' '
 	test_cmp expect result
 '
 
+packdir=.git/objects/pack
+
+test_expect_success 'using replay to rebase two branches, with --write-pack' '
+	# Remove the results of the previous rebase, ensuring that they
+	# are pruned from the object store.
+	git gc --prune=now &&
+	test_must_fail git cat-file -t "$(cut -d " " -f 3 expect)" &&
+
+	# Create an extra packfile to ensure that the tmp-objdir repack
+	# takes place outside of the main object store.
+	git checkout --detach &&
+	test_commit unreachable &&
+	git repack -d &&
+	git checkout main &&
+
+	find $packdir -type f -name "*.idx" | sort >packs.before &&
+	git replay --write-pack --onto main topic1..topic2 >result &&
+	find $packdir -type f -name "*.idx" | sort >packs.after &&
+
+	comm -13 packs.before packs.after >packs.new &&
+
+	# Ensure that we got a single new pack.
+	test_line_count = 1 result &&
+	test_line_count = 1 packs.new &&
+
+	# ... and that the rest of the results match our expeectations.
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual &&
+
+	printf "update refs/heads/topic2 " >expect &&
+	printf "%s " $(cut -f 3 -d " " result) >>expect &&
+	git rev-parse topic2 >>expect &&
+
+	test_cmp expect result
+'
+
 test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
 	git -C bare replay --onto main topic1..topic2 >result-bare &&
 	test_cmp expect result-bare
-- 
2.42.0.446.g0b9ef90488
