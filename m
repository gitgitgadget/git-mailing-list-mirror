Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B506C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DCE650CB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 14:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhCHOoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 09:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCHOnr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 09:43:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B1C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 06:43:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m9so15081705edd.5
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TkQwpmbD/lyxSMp2LoNfIGbdeyzI/v/xlZcDkWoo1A8=;
        b=q2xJ7AxOJUQ3Pq+VAALlr3g7VL5kWOcbYrBMZpSIThT7KYcNJdh59KCgFBcrdB4tK+
         2wFhY6GPQZqe/yGo+NxonVh8Avpx21WbKkz2d/JWPiKYjuna6dM/e0FUQ0xf7nEXP58M
         aRMu5VlVLpPdFJWGSQUhvKZzAfD00gM+zKihtlXlK5mUtkCxdQWoyMaVA6dd1OZOl2eo
         L87p+vrx2kah7Dv2W7Z6SQ4fXjpja0TeD9mKas438Sk98kkrzW3L6HQHSsWcHDlsM+AD
         h8Q74VlkKlM8TDAEY0U/9BbJuMU+RgGbPT57c+cWcB4Gh+6CcUwbqFrUfehqz3QEFeRZ
         aTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TkQwpmbD/lyxSMp2LoNfIGbdeyzI/v/xlZcDkWoo1A8=;
        b=VBFEr6bCrk+j3FDMnePwgXJquwMaIaxDMPe7uDne8vXFCRpsMx9KXhDJFSWWiLsjAR
         Eypsch0Fu7Z5YozrTyXF/vsKMW5xd18hK80RNeEZ9uuwXbrbYp9zVYCnrJm4PzeFRRBA
         hCgPrDo5yvAiKzl1EKjKzH7SAgnITLpuX5n+tdk+vc3DnVC2aewlrVgmlZhlKWZovXiB
         TNz6bMS2J/D9AGLtTHnOl8lHV3+6Qr6aa+CIkqz4q2CnkBGwBFjNiIl+SNCsmNcAdEtH
         jdxdmYc1AobfvqcD6w+g1oydMo+z4AAIntstYg2HIQel5yNFjGZ/qAMMun6JlmPZ5Xhd
         eZSg==
X-Gm-Message-State: AOAM5318NhEVdsEhyI3fQXFPZq46a7pdokb4N1ILFpJUehTb8iuo3j5Q
        h0OgOyWfX6eMrzJ/wROBwWuQxl8YWGCgiw==
X-Google-Smtp-Source: ABdhPJzHAERS93mDsmEGmE9Wi6G6Y2sQ66zuTz1w2Lw+rIkwo/Fn5bDbtT3JEHTaFiiZV+t6jduCqQ==
X-Received: by 2002:a05:6402:30b9:: with SMTP id df25mr22757164edb.136.1615214625643;
        Mon, 08 Mar 2021 06:43:45 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l10sm7355791edr.87.2021.03.08.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:43:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/11] Complete merge-ort implementation...almost
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 15:43:44 +0100
Message-ID: <87pn09iu3j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> In order to help =C3=86var test his tree-walk changes against merge-ort[1=
], this
> series completes the merge-ort implementation and cleans up testsuite
> failures...EXCEPT for some t6423 failures. It also leaves out a lot of
> performance work, which incidentally will fix the t6423 failures and is
> being reviewed independently[2].

For those testing this in combination with their work, the expected
failures are these specific tests:

    ./t6423-merge-rename-directories.sh (Wstat: 256 Tests: 68 Failed: 4)
      Failed tests:  7, 53, 55, 59

Perhaps I'm missing something but why not have [1] below on top of this
series? It makes that test pass in both modes, and means we could
e.g. follow-up by running CI with "ort".

That CI step seems worth doing sooner than later, even if it needs some
GIT_TEST_SKIP for now...

> This 11-patch series could be submitted as 7 independent series, 1-4 patc=
hes
> in length each, but it's probably easier for =C3=86var if we can merge ju=
st one
> more thing and it's only 11 total patches. This series sub-divides as
> follows:
>
>  * Patch 1: Fix bug in already-merged portion of merge-ort affecting
>    rename/rename conflicts on platforms where qsort isn't stable. (Could =
be
>    considered for merging before 2.31 since it is a new bug in the 2.31
>    cycle that I just learned of last night, but not sure it matters since
>    merge-ort wasn't complete anyway and we're not even mentioning merge-o=
rt
>    in the release notes.)
>  * Patches 2-5: Add support for renormalization
>  * Patch 6: Add support for subtree shifting
>  * Patch 7-8: Add test and support for conflicts affecting sparse-checkout
>    entries
>  * Patch 9: Update submodule related merge tests to note the ones that
>    merge-ort fixes relative to merge-recursive
>  * Patch 10: New feature -- allow "git diff AUTO_MERGE" during conflict
>    resolution to let user review changes they made since
>    merge/rebase/cherry-pick/revert stopped and informed them of conflicts
>  * Patch 11: Add comments noting various bugs in merge-recursive
>
> The last two patches aren't needed by =C3=86var, so they could be left ou=
t and
> submitted later. I just figured that it was only two more patches and they
> were part of "completing the merge-ort implementation" in my view.

This whole thing was a pleasant read, and helped me catch a subtle
regression in my WIP "mode" work (which I'm now about to submit).

Reviewing this series suffered from the problem you have with writing
code that's clearly good enough: Mostly all I had were minor nits,
suggestions to re-arrange code differently etc.

That being said I'm not all that familiar with the guts of the merge
logic, so I may have missed other issues...

> [1] https://lore.kernel.org/git/877dmmkhnt.fsf@evledraar.gmail.com/ [2] S=
ee
> https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.co=
m/;
> there are five more waiting after that -- viewable by the curious at
> https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+author%3Anewren+Opt=
imization+batch
>
> Elijah Newren (11):
>   merge-ort: use STABLE_QSORT instead of QSORT where required
>   merge-ort: add a special minimal index just for renormalization
>   merge-ort: add a function for initializing our special attr_index
>   merge-ort: have ll_merge() calls use the attr_index for
>     renormalization
>   merge-ort: let renormalization change modify/delete into clean delete
>   merge-ort: support subtree shifting
>   t6428: new test for SKIP_WORKTREE handling and conflicts
>   merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entries
>   t: mark several submodule merging tests as fixed under merge-ort
>   merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
>   merge-recursive: add a bunch of FIXME comments documenting known bugs
>
>  branch.c                                      |   1 +
>  builtin/rebase.c                              |   1 +
>  merge-ort.c                                   | 230 ++++++++++++++++--
>  merge-recursive.c                             |  37 +++
>  path.c                                        |   1 +
>  path.h                                        |   2 +
>  sequencer.c                                   |   5 +
>  t/t3512-cherry-pick-submodule.sh              |   9 +-
>  t/t3513-revert-submodule.sh                   |   7 +-
>  t/t5572-pull-submodule.sh                     |   9 +-
>  t/t6428-merge-conflicts-sparse.sh             | 158 ++++++++++++
>  t/t6437-submodule-merge.sh                    |   5 +-
>  t/t6438-submodule-directory-file-conflicts.sh |   9 +-
>  13 files changed, 449 insertions(+), 25 deletions(-)
>  create mode 100755 t/t6428-merge-conflicts-sparse.sh
>
>
> base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-973=
%2Fnewren%2Fort-remainder-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-973/ne=
wren/ort-remainder-v1
> Pull-Request: https://github.com/git/git/pull/973

1.:

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-dir=
ectories.sh
index 5d3b711fe68..4f6ead11e51 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -507,7 +507,7 @@ test_setup_2a () {
 	)
 }
=20
-test_expect_success '2a: Directory split into two on one side, with equal =
numbers of paths' '
+test_expect_merge_algorithm success failure '2a: Directory split into two =
on one side, with equal numbers of paths' '
 	test_setup_2a &&
 	(
 		cd 2a &&
@@ -3060,7 +3060,7 @@ test_setup_9g () {
 	)
 }
=20
-test_expect_failure '9g: Renamed directory that only contained immediate s=
ubdirs, immediate subdirs renamed' '
+test_expect_merge_algorithm failure failure '9g: Renamed directory that on=
ly contained immediate subdirs, immediate subdirs renamed' '
 	test_setup_9g &&
 	(
 		cd 9g &&
@@ -4267,7 +4267,7 @@ test_setup_12b1 () {
 	)
 }
=20
-test_expect_merge_algorithm failure success '12b1: Moving two directory hi=
erarchies into each other' '
+test_expect_merge_algorithm failure failure '12b1: Moving two directory hi=
erarchies into each other' '
 	test_setup_12b1 &&
 	(
 		cd 12b1 &&
@@ -4435,7 +4435,7 @@ test_setup_12c1 () {
 	)
 }
=20
-test_expect_merge_algorithm failure success '12c1: Moving one directory hi=
erarchy into another w/ content merge' '
+test_expect_merge_algorithm failure failure '12c1: Moving one directory hi=
erarchy into another w/ content merge' '
 	test_setup_12c1 &&
 	(
 		cd 12c1 &&
@@ -4797,7 +4797,7 @@ test_setup_12f () {
 	)
 }
=20
-test_expect_merge_algorithm failure success '12f: Trivial directory resolv=
e, caching, all kinds of fun' '
+test_expect_merge_algorithm failure failure '12f: Trivial directory resolv=
e, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
