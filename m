Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BCEC43460
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682D96137D
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 14:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhDYORE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhDYORD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 10:17:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F215C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k14so3203111wrv.5
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hbPMY0egvX/xuhI9Y219XI6BhrhsQmZJwQEpOrgISm4=;
        b=lt4E03CTiSRdjeVtyc2rLmZ8uO5677d9d8eoPXUBN/kaEGNVFKc1E4Inxs3xWvyufT
         yKGRteSs8VQDRToqsx7RAPEiAzJ1bGq/Bq96Z7ASBgN/Sb48H6sG46pbUQwwKUP1IlhD
         7GhCAEgZd2OruNNQgy2k+9llT/U5kAo/4gyw2InxschirkTujCq6cVHvXAkmovCa6uEC
         PeMGKxHYAs1rqYbcsEEhEFYf5xfHDkOihL2KUs+08MhsO9FN/8Kl8hYUDuR7tBZ2BmkE
         j8z6mtX9F2SyZYzjHKUGakyzXPBNC1k/Hnaj+MeVVqYBjlR+wdotUY8clpx/ADQh7kJM
         tyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hbPMY0egvX/xuhI9Y219XI6BhrhsQmZJwQEpOrgISm4=;
        b=cf0y3ghb7iQOAK/VO7UR17Kq4A7+co1wk5EHp3J1nTujSrQEGgVa8UecBC0spqUEFo
         DrdNZc/hgdkZbtDnjYK13cjd32p1h958PAh7u36vJIJvDXelU7V5aABqJeXY0vgkCIIw
         BorHzeTJyxsLePIAnQY9GzWRtWUPVQ8Nge5n4+FIFbtQpU8tfrTAV92I8xXJncc29R8P
         5bUbhkIxm+Z9ia3cvbISWn/0GLGnFpySwkG6ByDq+0/JCWwHPb09jF3IBcyEl6sqJwoT
         I6+n4Q0Z4+CvB9bF0nV2ZtB34GiEiAzv7pZkcd7U0KYUHoyR/AMDL4poHdgpCdu7zQPv
         Mebw==
X-Gm-Message-State: AOAM531J0xLx4aOPai4G0wOkaq6kYGfFpnISg8rweeWNIleYfkCaMh7Z
        bk/bgWT3Wruolqmb8X4OnGRqbndAQgI=
X-Google-Smtp-Source: ABdhPJzQhwia6W5+bBQappL7kt5D0YLhP5OAAbm5OpyzNrSAZ6xYdoafU+znjz3sL9ZC6zSD3UgdbA==
X-Received: by 2002:adf:f2cf:: with SMTP id d15mr17600345wrp.114.1619360182483;
        Sun, 25 Apr 2021 07:16:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm2137348wrr.77.2021.04.25.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 07:16:22 -0700 (PDT)
Message-Id: <d97307edca4202a8755b0f4a33f0d7434e3afa7f.1619360180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
References: <pull.929.git.1617994052.gitgitgadget@gmail.com>
        <pull.929.v2.git.1619360180.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 25 Apr 2021 14:16:08 +0000
Subject: [PATCH v2 01/12] revision: free remainder of old commit list in
 limit_list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

limit_list() iterates over the original revs->commits list, and consumes
many of its entries via pop_commit. However we might stop iterating over
the list early (e.g. if we realise that the rest of the list is
uninteresting). If we do stop iterating early, list will be pointing to
the unconsumed portion of revs->commits - and we need to free this list
to avoid a leak. (revs->commits itself will be an invalid pointer: it
will have been free'd during the first pop_commit.)

However the list pointer is later reused to iterate over our new list,
but only for the limiting_can_increase_treesame() branch. We therefore
need to introduce a new variable for that branch - and while we're here
we can rename the original list to original_list as that makes its
purpose more obvious.

This leak was found while running t0090. It's not likely to be very
impactful, but it can happen quite early during some checkout
invocations, and hence seems to be worth fixing:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac084 in do_xmalloc wrapper.c:41:8
    #2 0x9ac05a in xmalloc wrapper.c:62:9
    #3 0x7175d6 in commit_list_insert commit.c:540:33
    #4 0x71800f in commit_list_insert_by_date commit.c:604:9
    #5 0x8f8d2e in process_parents revision.c:1128:5
    #6 0x8f2f2c in limit_list revision.c:1418:7
    #7 0x8f210e in prepare_revision_walk revision.c:3577:7
    #8 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
    #9 0x512f05 in switch_branches builtin/checkout.c:1250:3
    #10 0x50f8de in checkout_branch builtin/checkout.c:1646:9
    #11 0x50ba12 in checkout_main builtin/checkout.c:2003:9
    #12 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
    #13 0x4cd91d in run_builtin git.c:467:11
    #14 0x4cb5f3 in handle_builtin git.c:719:3
    #15 0x4ccf47 in run_argv git.c:808:4
    #16 0x4caf49 in cmd_main git.c:939:19
    #17 0x69dc0e in main common-main.c:52:11
    #18 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Indirect leak of 48 byte(s) in 3 object(s) allocated from:
    #0 0x49a85d in malloc ../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:145:3
    #1 0x9ac084 in do_xmalloc wrapper.c:41:8
    #2 0x9ac05a in xmalloc wrapper.c:62:9
    #3 0x717de6 in commit_list_append commit.c:1609:35
    #4 0x8f1f9b in prepare_revision_walk revision.c:3554:12
    #5 0x514170 in orphaned_commit_warning builtin/checkout.c:1185:6
    #6 0x512f05 in switch_branches builtin/checkout.c:1250:3
    #7 0x50f8de in checkout_branch builtin/checkout.c:1646:9
    #8 0x50ba12 in checkout_main builtin/checkout.c:2003:9
    #9 0x5086c0 in cmd_checkout builtin/checkout.c:2055:8
    #10 0x4cd91d in run_builtin git.c:467:11
    #11 0x4cb5f3 in handle_builtin git.c:719:3
    #12 0x4ccf47 in run_argv git.c:808:4
    #13 0x4caf49 in cmd_main git.c:939:19
    #14 0x69dc0e in main common-main.c:52:11
    #15 0x7faaabd0e349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 revision.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 553c0faa9b38..568d73c0b331 100644
--- a/revision.c
+++ b/revision.c
@@ -1393,20 +1393,20 @@ static int limit_list(struct rev_info *revs)
 {
 	int slop = SLOP;
 	timestamp_t date = TIME_MAX;
-	struct commit_list *list = revs->commits;
+	struct commit_list *original_list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 	struct commit_list *bottom = NULL;
 	struct commit *interesting_cache = NULL;
 
 	if (revs->ancestry_path) {
-		bottom = collect_bottom_commits(list);
+		bottom = collect_bottom_commits(original_list);
 		if (!bottom)
 			die("--ancestry-path given but there are no bottom commits");
 	}
 
-	while (list) {
-		struct commit *commit = pop_commit(&list);
+	while (original_list) {
+		struct commit *commit = pop_commit(&original_list);
 		struct object *obj = &commit->object;
 		show_early_output_fn_t show;
 
@@ -1415,11 +1415,11 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (process_parents(revs, commit, &list, NULL) < 0)
+		if (process_parents(revs, commit, &original_list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			slop = still_interesting(list, date, slop, &interesting_cache);
+			slop = still_interesting(original_list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
 			break;
@@ -1452,14 +1452,17 @@ static int limit_list(struct rev_info *revs)
 	 * Check if any commits have become TREESAME by some of their parents
 	 * becoming UNINTERESTING.
 	 */
-	if (limiting_can_increase_treesame(revs))
+	if (limiting_can_increase_treesame(revs)) {
+		struct commit_list *list = NULL;
 		for (list = newlist; list; list = list->next) {
 			struct commit *c = list->item;
 			if (c->object.flags & (UNINTERESTING | TREESAME))
 				continue;
 			update_treesame(revs, c);
 		}
+	}
 
+	free_commit_list(original_list);
 	revs->commits = newlist;
 	return 0;
 }
-- 
gitgitgadget

