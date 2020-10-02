Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EEC4727D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2FD20708
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3V9DrP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbgJBO7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbgJBO7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 10:59:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38292C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 07:58:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so2088861wmi.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jijhfujA550E3vp2b301RA4JLDImQPm9ar/GrXH7SDQ=;
        b=p3V9DrP+Bp/ce1BnUq5lhKI3NHbSMbhB8t97YEL33586mJ84g5J566ShNxfm1cYyyH
         igxxpf9PSz4CU/NG3LWrWF/RIfUejsjiGMcHIHrl4oifkvdBCianNiAruXBZ8950t1ZI
         F/FFrnaYqtj5daCIlfiWveE8VoGeaRONyIvwPnooiuKRjUAlL9iQZuxw4g8CiOJXp/oH
         JJKXvxB+oQB+dqgLvxA8M1GLt5jshaj7PNG10szeV02LQ/X5fxTw/c/RVv4HcO9hnApB
         MxHYrXBqReLeJG6Y9ilu74QZGKCbxHW0mX1e2KcFLDAm8aaRX0n78IPGKvORtTOe/lzU
         ki6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jijhfujA550E3vp2b301RA4JLDImQPm9ar/GrXH7SDQ=;
        b=Cs78CBZwE0BmsiqEzD9d1uLijufD2J6bUsXXHsqXyTEbZk8Hq7g/UyiRJ5/ROTiup5
         XVGgnV2pKrMiVjVCuSBAFxz2tS0ce7ez6Yhs6s+Klcl/zGKQ5pG8ayEo9B+VIfg00LoW
         c1OULdm7R1WNtns2ZJcN3N+GFRC6hy233rrPOEEWlZOMkLRquGnZBbVu41ryhie/9l0a
         bTJAknVKLv9X98FIoBgD/Z5YHzaimN1xQl+c3VI31S+/RpwPBYxliAGOwr8dolzu7XFq
         fHYzUAT+O04wOb61UVSlsmq3ic5cIJvZgU5Irg40NQc8/lRiUHiyIFNQ/zHy544HRQlH
         chBQ==
X-Gm-Message-State: AOAM533KzkjfnXG+W8IN46lMO8K7Afe/L+FErIoQicK3SBsBDLr9LuDv
        IC3nlbnVuiDIw6jvKBSwMZN07DV/cmw=
X-Google-Smtp-Source: ABdhPJyzxNP8sUy0Nhn7glaaCgufEYEqeU0M6BMZaazTJQ0xrvagGYIpQmuvkOxaYAsQie1YObQInA==
X-Received: by 2002:a1c:9d82:: with SMTP id g124mr3389797wme.4.1601650737630;
        Fri, 02 Oct 2020 07:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm2191284wru.55.2020.10.02.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:58:57 -0700 (PDT)
Message-Id: <pull.739.git.1601650736489.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Oct 2020 14:58:56 +0000
Subject: [PATCH] commit-reach: fix in_merge_bases_many bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Way back in f9b8908b (commit.c: use generation numbers for
in_merge_bases(), 2018-05-01), a heuristic was used to short-circuit
the in_merge_bases() walk. This works just fine as long as the
caller is checking only two commits, but when there are multiple,
there is a possibility that this heuristic is _very wrong_.

Some code moves since then has changed this method to
repo_in_merge_bases_many() inside commit-reach.c. The heuristic
computes the minimum generation number of the "reference" list, then
compares this number to the generation number of the "commit".

In a recent topic, a test was added that used in_merge_bases_many()
to test if a commit was reachable from a number of commits pulled
from a reflog. However, this highlighted the problem: if any of the
reference commits have a smaller generation number than the given
commit, then the walk is skipped _even if there exist some with
higher generation number_.

This heuristic is wrong! It must check the MAXIMUM generation number
of the reference commits, not the MINIMUM.

This highlights a testing gap. t6600-test-reach.sh covers many
methods in commit-reach.c, including in_merge_bases() and
get_merge_bases_many(), but since these methods either restrict to
two input commits or actually look for the full list of merge bases,
they don't check this heuristic!

Add a possible input to "test-tool reach" that tests
in_merge_bases_many() and add tests to t6600-test-reach.sh that
cover this heuristic. This includes cases for the reference commits
having generation above and below the generation of the input commit,
but also having maximum generation below the generation of the input
commit.

The fix itself is to swap min_generation with a max_generation in
repo_in_merge_bases_many().

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reported-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    Fix in_merge_bases_many() with commit-graphs
    
    Johannes alerted me to the difficulties Srinidhi was having with 
    in_merge_bases_many() and commit-graphs. Sorry that I hadn't seen that
    thread and the issues therein.
    
    After working with Johannes to investigate what was happening, we found
    a 2-year-old bug in the generation number checks!
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-739%2Fderrickstolee%2Fin-merge-bases-many-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-739/derrickstolee/in-merge-bases-many-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/739

 commit-reach.c        |  8 ++++----
 t/helper/test-reach.c |  2 ++
 t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index efd5925cbb..50175b159e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -321,7 +321,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 {
 	struct commit_list *bases;
 	int ret = 0, i;
-	uint32_t generation, min_generation = GENERATION_NUMBER_INFINITY;
+	uint32_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
 	if (repo_parse_commit(r, commit))
 		return ret;
@@ -330,12 +330,12 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 			return ret;
 
 		generation = commit_graph_generation(reference[i]);
-		if (generation < min_generation)
-			min_generation = generation;
+		if (generation > max_generation)
+			max_generation = generation;
 	}
 
 	generation = commit_graph_generation(commit);
-	if (generation > min_generation)
+	if (generation > max_generation)
 		return ret;
 
 	bases = paint_down_to_common(r, commit,
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 14a3655442..cda804ed79 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -107,6 +107,8 @@ int cmd__reach(int ac, const char **av)
 		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_bases"))
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
+	else if (!strcmp(av[1], "in_merge_bases_many"))
+		printf("%s(A,X):%d\n", av[1], in_merge_bases_many(A, X_nr, X_array));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 475564bee7..f807276337 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -110,6 +110,36 @@ test_expect_success 'in_merge_bases:miss' '
 	test_three_modes in_merge_bases
 '
 
+test_expect_success 'in_merge_bases_many:hit' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-6-9
+	X:commit-5-7
+	EOF
+	echo "in_merge_bases_many(A,X):1" >expect &&
+	test_three_modes in_merge_bases_many
+'
+
+test_expect_success 'in_merge_bases_many:miss' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-7-7
+	X:commit-8-6
+	EOF
+	echo "in_merge_bases_many(A,X):0" >expect &&
+	test_three_modes in_merge_bases_many
+'
+
+test_expect_success 'in_merge_bases_many:miss-heuristic' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-7-5
+	X:commit-6-6
+	EOF
+	echo "in_merge_bases_many(A,X):0" >expect &&
+	test_three_modes in_merge_bases_many
+'
+
 test_expect_success 'is_descendant_of:hit' '
 	cat >input <<-\EOF &&
 	A:commit-5-7

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
