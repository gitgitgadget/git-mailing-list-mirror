Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2AC7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbjFGKQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbjFGKQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:16:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CAD1BD3
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:16:17 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba829e17aacso9116431276.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686132976; x=1688724976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5MarA02E7dw7eFDVci1aBQYA+1m7FKimAvUcf0+LpM=;
        b=K80sxXkc62HwfPLqGyyeMIP87sGGNAc6accsLZgvPWYg+pCzF/BTpYobj7h/v4sMjj
         CSwc6NLhrAmr0itPX/eN2pSTwj4M053JN3KhklWBv/bfzgEL1mJzppgcDWB82I9NbRZ4
         eKfPr+N9Oy0Pp4uHnjwx2PyKsk0LtCI+WPmj/pODiZrY2u4x3hbQXuePSm1QAro6oCZV
         HaFAoD0Z0CklGcbIujJfyiHy1DiGDsaRIi6LxJ6aI5GaXtHOdSUbSoRFhxyWQOHjZheZ
         WwsOv0j9fxYDhBInh0T2rN2A6FG2UG8w11BqU1UcsxB0N2P1d/pC3szQ3kSv+M4Hixap
         eShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686132976; x=1688724976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5MarA02E7dw7eFDVci1aBQYA+1m7FKimAvUcf0+LpM=;
        b=gscM44sXdovyng48A/n25dmOPnygWC1jsHyv74cPQLU8vHUQM9rQ7it4/4qn31oSU2
         SaNZD4KIMmgcmYVhtIuENyV13g3zU3vPq1eNws6v5PkV6YKwaFaV3GTzNl+YPspRP0Y3
         MZE9YD1FXMP4CU0RDaYHakPwmemkQ/vef5JqVI+EY79yjaCI8ZWsVh6N7xZHJ+Vp3m2L
         DQgrRNAu3bCl71Tsiu1KEYwLR2Vwc+tYAT5VMD5LLLqRmwSW+OJUhZv2CzM/eJGPKehI
         R9potN9L95ZDwdXE0w8cykyKHAGLQosbt6Fmuev0i1LFKSTUJisuVBWQjpGLxP6nR3dJ
         ySOw==
X-Gm-Message-State: AC+VfDx75csEVCgZtQPQbIriKzsxvwdDaZzbswk+6sitp0kcRuhNmPBm
        p0AiabGdCnTU/PupIBh818cufN1DOVhlSUZtpaK8+KQ/
X-Google-Smtp-Source: ACHHUZ4hFyk7wbwRs8MXErlCn2ASInTPWC1wKmUtUJru174HqzIhUGUu6ZNMPJ30R5oKNiqileB58g==
X-Received: by 2002:a0d:ca44:0:b0:561:dd1b:e516 with SMTP id m65-20020a0dca44000000b00561dd1be516mr5923315ywd.35.1686132976429;
        Wed, 07 Jun 2023 03:16:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9-20020a0dd809000000b0055d6ae09dedsm4681782ywe.127.2023.06.07.03.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:16:15 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:16:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/repack.c: only collect fully-formed packs
Message-ID: <dda5a34a3e879787ce8651674962db6cf913b7b2.1686132967.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To partition the set of packs based on which ones are "kept" (either
they have a .keep file, or were otherwise marked via the `--keep-pack`
option) and "non-kept" ones (anything else), `git repack` uses its
`collect_pack_filenames()` function.

Ordinarily, we would rely on a convenience function such as
`get_all_packs()` to enumerate and partition the set of packs. But
`collect_pack_filenames()` uses `readdir()` directly to read the
contents of the "$GIT_DIR/objects/pack" directory, and adds each entry
ending in ".pack" to the appropriate list (either kept, or non-kept as
above).

This is subtly racy, since `collect_pack_filenames()` may see a pack
that is not fully staged (i.e., it is missing its ".idx" file).
Ordinarily, this doesn't cause a problem. But it can cause issues when
generating a cruft pack.

This is because `git repack` feeds (among other things) the list of
existing kept packs down to `git pack-objects --cruft` to indicate that
any kept packs will not be removed from the repository (so that the
cruft pack machinery can avoid packing objects that appear in those
packs as cruft).

But `read_cruft_objects()` lists packfiles by calling `get_all_packs()`.
So if a ".pack" file exists (necessary to get that pack to appear to
`collect_pack_filenames()`), but doesn't have a corresponding ".idx"
file (necessary to get that pack to appear via `get_all_packs()`), we'll
complain with:

    fatal: could not find pack '.tmp-5841-pack-a6b0150558609c323c496ced21de6f4b66589260.pack'

Fix the above by teaching `collect_pack_filenames()` to only collect
packs with their corresponding `*.idx` files in place, indicating that
those packs have been fully staged.

There are a couple of things worth noting:

  - Since each entry in the `extra_keep` list (which contains the
    `--keep-pack` names) has a `*.pack` suffix, we'll have to swap the
    suffix from ".pack" to ".idx", and compare that instead.

  - Since we use the the `fname_kept_list` to figure out which packs to
    delete (with `git repack -d`), we would have previously deleted a
    `*.pack` with no index (since the existince of a ".pack" file is
    necessary and sufficient to include that pack in the list of
    existing non-kept packs).

    Now we will leave it alone (since that pack won't appear in the
    list). This is far more correct behavior, since we don't want
    to race with a pack being staged. Deleting a partially staged pack
    is unlikely, however, since the window of time between staging a
    pack and moving its .idx file into place is miniscule.

    Note that this window does *not* include the time it takes to
    receive and index the pack, since the incoming data goes into
    "$GIT_DIR/objects/tmp_pack_XXXXXX", which does not end in ".pack"
    and is thus ignored by collect_pack_filenames().

In the future, this function should probably be rewritten as a callback
to `for_each_file_in_pack_dir()`, but this is the simplest change we
could do in the short-term.

Reported-by: Michael Haggerty <mhagger@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c  | 14 ++++++++++----
 t/t7700-repack.sh | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0541c3ce15..1e21a21ea8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -95,8 +95,8 @@ static int repack_config(const char *var, const char *value, void *cb)
 }
 
 /*
- * Adds all packs hex strings to either fname_nonkept_list or
- * fname_kept_list based on whether each pack has a corresponding
+ * Adds all packs hex strings (pack-$HASH) to either fname_nonkept_list
+ * or fname_kept_list based on whether each pack has a corresponding
  * .keep file or not.  Packs without a .keep file are not to be kept
  * if we are going to pack everything into one file.
  */
@@ -107,6 +107,7 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 	DIR *dir;
 	struct dirent *e;
 	char *fname;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!(dir = opendir(packdir)))
 		return;
@@ -115,11 +116,15 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		size_t len;
 		int i;
 
-		if (!strip_suffix(e->d_name, ".pack", &len))
+		if (!strip_suffix(e->d_name, ".idx", &len))
 			continue;
 
+		strbuf_reset(&buf);
+		strbuf_add(&buf, e->d_name, len);
+		strbuf_addstr(&buf, ".pack");
+
 		for (i = 0; i < extra_keep->nr; i++)
-			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
+			if (!fspathcmp(buf.buf, extra_keep->items[i].string))
 				break;
 
 		fname = xmemdupz(e->d_name, len);
@@ -136,6 +141,7 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		}
 	}
 	closedir(dir);
+	strbuf_release(&buf);
 
 	string_list_sort(fname_kept_list);
 }
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index faa739eeb9..08b5ba0c15 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -10,6 +10,10 @@ test_description='git repack works correctly'
 commit_and_pack () {
 	test_commit "$@" 1>&2 &&
 	incrpackid=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
+	# Remove any loose object(s) created by test_commit, since they have
+	# already been packed. Leaving these around can create subtly different
+	# packs with `pack-objects`'s `--unpacked` option.
+	git prune-packed 1>&2 &&
 	echo pack-${incrpackid}.pack
 }
 
@@ -209,6 +213,8 @@ test_expect_success 'repack --keep-pack' '
 	test_create_repo keep-pack &&
 	(
 		cd keep-pack &&
+		# avoid producing difference packs to delta/base choices
+		git config pack.window 0 &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
 		P3=$(commit_and_pack 3) &&
@@ -220,6 +226,23 @@ test_expect_success 'repack --keep-pack' '
 		grep -q $P1 new-counts &&
 		grep -q $P4 new-counts &&
 		test_line_count = 3 new-counts &&
+		git fsck &&
+
+		P5=$(commit_and_pack --no-tag 5) &&
+		git reset --hard HEAD^ &&
+		git reflog expire --all --expire=all &&
+		rm -f ".git/objects/pack/${P5%.pack}.idx" &&
+		rm -f ".git/objects/info/commit-graph" &&
+		for from in $(find .git/objects/pack -type f -name "${P5%.pack}.*")
+		do
+			to="$(dirname "$from")/.tmp-1234-$(basename "$from")" &&
+			mv "$from" "$to" || return 1
+		done &&
+
+		git repack --cruft -d --keep-pack $P1 --keep-pack $P4 &&
+
+		ls .git/objects/pack/*.pack >newer-counts &&
+		test_cmp new-counts newer-counts &&
 		git fsck
 	)
 '
-- 
2.41.0.1.gcf79d13182
