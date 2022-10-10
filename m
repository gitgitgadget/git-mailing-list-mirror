Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ABFC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 04:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJJEJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 00:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJEJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 00:09:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED744D819
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 21:09:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w28so3934033qtv.9
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuyiYSf2yQKiume2HRrDEREZU8mwZ7C0tjqrSkr7RDA=;
        b=Ty5oLY2ctaJajP9EiY0OIN6mrxzT1/sWF1Br+m66owZS+taaabROSac2MUz6triPyP
         FH1icop+X19m/VuUzm/mhzT4BvNSK/bq4VrbWjw52DpAb//qVVvpMQLC8axDCY/WxmBs
         x2aRFydyHQZIyV6eNWxPFleabCZYBlFFnTres=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuyiYSf2yQKiume2HRrDEREZU8mwZ7C0tjqrSkr7RDA=;
        b=LQWKG91ADd6CKmiK5sokn19XAaYsDi6hyt91iGvZBOjVNxkOsfpyMDgIW69JtpwSl2
         /PxrCYqVD++MqlxLrTQHJ6IT95Cbnjd6D0hzkeRXl7xFrmBBHfNA8SnE0HYV6AUCInwv
         07NeiHdnm6H2pz2h3Y29xUsqjVfOzTj/ElrUM59CTxfmauTMai1GHunjTkxMlungcSZn
         0mWNURMsKdy5tHIK4rUcWmrleMlvF8Y4ZST19n82VQz2mIMQWpXZ988G8/AIIXr5DvTU
         hYot/cwGwextb+LUSo0uAeT77g9ERGTCLC7gP1BgLMybev/gnePJRTuEUnzuLPpk56uk
         AgLA==
X-Gm-Message-State: ACrzQf2c2atJ5dcEbOeDlUjf+t/PbDy5p2Dkis6a2nYChkNbYZDynHQz
        8msy36SzPi9oN4UK51Nv988yo/vjNzLZxPqWMl/iyQ==
X-Google-Smtp-Source: AMsMyM421f2qA03YEIcsoUl+oqJ18zqH2Unu4lrXpVFS9J4Yex4oK3d/6gau1+HWPPpWshWlJPXnUDfxisgcQVVTDqI=
X-Received: by 2002:a05:622a:90:b0:394:1a9b:638e with SMTP id
 o16-20020a05622a009000b003941a9b638emr13582053qtw.314.1665374964119; Sun, 09
 Oct 2022 21:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com> <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 10 Oct 2022 06:09:13 +0200
Message-ID: <CAPMMpogQG_ggwQdhwEUtUmhS7JMmf5Ke72+f=+Xox-J6iMpfOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] RFC: apply: support case-only renames in
 case-insensitive filesystems
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

These patches are a few months old now, but they still apply cleanly
and I'm not sure how to improve them.

I'd appreciate any feedback on both the approach, and the detailed
code changes themselves, that could help me make this a viable
patchset to fix case-only renames on file-insensitive filesystems
using "git apply".

Thanks,
Tao

On Sun, Jun 19, 2022 at 6:10 PM Tao Klerks via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> As suggested recently in thread
> CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com,
> proposing a fix to git-apply for case-only renames on case-insensitive
> filesystems.
>
> Changes in V2:
>
>  * Prepended a commit from Junio, with new apply tests to build on
>  * Added a largely-unrelated new known failing test, concerning reset --hard
>    in the presence of index case conflicts on a case-insensitive filesystem,
>    which we later need to work around in a corner-case test
>  * Moved test cases to build on Junio's new test file
>  * Switched fix approach from "allow same-name commit explicitly" to "track
>    files marked for deletion case-insensitively for filesystem checks",
>    which addresses the issue noted and other more obscure ones like "rename
>    swap with case change"
>  * Added a test case for "rename swap with case change"
>  * Added test cases setting "core.ignorecase" on and off explicitly
>  * Added a test case exposing one remaining surprising behavior
>
> POSSIBLE CONCERN:
>
> This fix was originally much simpler - it just made the "fn_table" string
> list use a case-insensitive string comparison - using case-insensitive
> comparisons when dealing with all replacement checks, both on the index and
> on the filesystem.
>
> However, with that simple implementation, there was at least one edge-case
> where data loss could result: If the index contained two files differing
> only by case, with different content, and we were doing a case-only rename,
> a swap, or some other operation involving the deletion and creation of a
> file with that name (ignoring case), then both of the files with that name
> in the index would be overwritten - even though only one of them had the
> expected content, and even though the one deleted might never have been
> committed.
>
> It seems as though the core.ignorecase option should typically only apply to
> filesystem checks - that the index is always case-sensitive.
>
> The current fix proposal therefore splits the string list used for "can I
> create a file that already exists?" checks into two such structures - one
> string list used for filesystem checks, which is case-insensitive when
> specified by core.ignorecase, and one used for index checks, which is always
> case-sensitive.
>
> The resulting duplication is not appealing, but I'm not sure how to address
> it / how to do this more elegantly. I'm also still not completely certain
> that my rule of thumb about the index always being case-sensitive is the
> right way of thinking of things.
>
> Junio C Hamano (1):
>   t4141: test "git apply" with core.ignorecase
>
> Tao Klerks (2):
>   reset: new failing test for reset of case-insensitive duplicate in
>     index
>   apply: support case-only renames in case-insensitive filesystems
>
>  apply.c                |  81 +++++++++----
>  apply.h                |   5 +-
>  t/t4141-apply-icase.sh | 258 +++++++++++++++++++++++++++++++++++++++++
>  t/t7104-reset-hard.sh  |  11 ++
>  4 files changed, 334 insertions(+), 21 deletions(-)
>  create mode 100755 t/t4141-apply-icase.sh
>
>
> base-commit: 1e59178e3f65880188caedb965e70db5ceeb2d64
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1257%2FTaoK%2Ftao-apply-case-insensitive-renames-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1257/TaoK/tao-apply-case-insensitive-renames-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1257
>
> Range-diff vs v1:
>
>  1:  b8bd612aa1e ! 1:  efd3bd4cdda apply: support case-only renames in case-insensitive filesystems
>      @@
>        ## Metadata ##
>      -Author: Tao Klerks <tao@klerks.biz>
>      +Author: Junio C Hamano <gitster@pobox.com>
>
>        ## Commit message ##
>      -    apply: support case-only renames in case-insensitive filesystems
>      +    t4141: test "git apply" with core.ignorecase
>
>      -    "git apply" checks, when validating a patch, to ensure that any files
>      -    being added aren't already in the worktree.
>      +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>      -    When this check runs on a case-only rename, in a case-insensitive
>      -    filesystem, this leads to a false positive - the command fails with an
>      -    error like:
>      -    error: File1: already exists in working directory
>      -
>      -    Fix this existence check to allow the file to exist, for a case-only
>      -    rename when config core.ignorecase is set.
>      -
>      -    Also add a test for this case, while verifying that conflicting file
>      -    conditions are still caught correctly, including case-only conflicts on
>      -    case-sensitive filesystems.
>      -
>      -    Signed-off-by: Tao Klerks <tao@klerks.biz>
>      -
>      - ## apply.c ##
>      -@@ apply.c: static int check_patch(struct apply_state *state, struct patch *patch)
>      -  if ((tpatch = in_fn_table(state, new_name)) &&
>      -      (was_deleted(tpatch) || to_be_deleted(tpatch)))
>      -          ok_if_exists = 1;
>      -+ else if (ignore_case && !strcasecmp(old_name, new_name))
>      -+         ok_if_exists = 1;
>      -  else
>      -          ok_if_exists = 0;
>      -
>      -
>      - ## t/t4141-apply-case-insensitive-rename.sh (new) ##
>      + ## t/t4141-apply-icase.sh (new) ##
>       @@
>       +#!/bin/sh
>       +
>      -+test_description='git apply should handle case-only renames on case-insensitive filesystems'
>      ++test_description='git apply with core.ignorecase'
>       +
>      -+TEST_PASSES_SANITIZE_LEAK=true
>       +. ./test-lib.sh
>       +
>      -+# Please note, this test assumes that core.ignorecase is set appropriately for the filesystem,
>      -+# as tested in t0050. Case-only rename conflicts are only tested in case-sensitive filesystems.
>      ++test_expect_success setup '
>      ++       # initial commit has file0 only
>      ++       test_commit "initial" file0 "initial commit with file0" initial &&
>       +
>      -+if ! test_have_prereq CASE_INSENSITIVE_FS
>      -+then
>      -+ test_set_prereq CASE_SENSITIVE_FS
>      -+ echo nuts
>      -+fi
>      ++       # current commit has file1 as well
>      ++       test_commit "current" file1 "initial content of file1" current &&
>      ++       file0blob=$(git rev-parse :file0) &&
>      ++       file1blob=$(git rev-parse :file1) &&
>       +
>      -+test_expect_success setup '
>      -+ echo "This is some content in the file." > file1 &&
>      -+ echo "A completely different file." > file2 &&
>      -+ git update-index --add file1 &&
>      -+ git update-index --add file2 &&
>      -+ cat >case_only_rename_patch <<-\EOF
>      -+ diff --git a/file1 b/File1
>      -+ similarity index 100%
>      -+ rename from file1
>      -+ rename to File1
>      -+ EOF
>      ++       # prepare sample patches
>      ++       # file0 is modified
>      ++       echo modification to file0 >file0 &&
>      ++       git add file0 &&
>      ++       modifiedfile0blob=$(git rev-parse :file0) &&
>      ++
>      ++       # file1 is removed and then ...
>      ++       git rm --cached file1 &&
>      ++       # ... identical copies are placed at File1 and file2
>      ++       git update-index --add --cacheinfo 100644,$file1blob,file2 &&
>      ++       git update-index --add --cacheinfo 100644,$file1blob,File1 &&
>      ++
>      ++       # then various patches to do basic things
>      ++       git diff HEAD^ HEAD -- file1 >creation-patch &&
>      ++       git diff HEAD HEAD^ -- file1 >deletion-patch &&
>      ++       git diff --cached HEAD -- file1 file2 >rename-file1-to-file2-patch &&
>      ++       git diff --cached HEAD -- file1 File1 >rename-file1-to-File1-patch &&
>      ++       git diff --cached HEAD -- file0 >modify-file0-patch
>       +'
>       +
>      -+test_expect_success 'refuse to apply rename patch with conflict' '
>      -+ cat >conflict_patch <<-\EOF &&
>      -+ diff --git a/file1 b/file2
>      -+ similarity index 100%
>      -+ rename from file1
>      -+ rename to file2
>      -+ EOF
>      -+ test_must_fail git apply --index conflict_patch
>      ++# Basic creation, deletion, modification and renaming.
>      ++test_expect_success 'creation and deletion' '
>      ++       # start at "initial" with file0 only
>      ++       git reset --hard initial &&
>      ++
>      ++       # add file1
>      ++       git -c core.ignorecase=false apply --cached creation-patch &&
>      ++       test_cmp_rev :file1 "$file1blob" &&
>      ++
>      ++       # remove file1
>      ++       git -c core.ignorecase=false apply --cached deletion-patch &&
>      ++       test_must_fail git rev-parse --verify :file1 &&
>      ++
>      ++       # do the same with ignorecase
>      ++       git -c core.ignorecase=true apply --cached creation-patch &&
>      ++       test_cmp_rev :file1 "$file1blob" &&
>      ++       git -c core.ignorecase=true apply --cached deletion-patch &&
>      ++       test_must_fail git rev-parse --verify :file1
>       +'
>       +
>      -+test_expect_success CASE_SENSITIVE_FS 'refuse to apply case-only rename patch with conflict, in case-sensitive FS' '
>      -+ test_when_finished "git mv File1 file2" &&
>      -+ git mv file2 File1 &&
>      -+ test_must_fail git apply --index case_only_rename_patch
>      ++test_expect_success 'modificaiton' '
>      ++       # start at "initial" with file0 only
>      ++       git reset --hard initial &&
>      ++
>      ++       # modify file0
>      ++       git -c core.ignorecase=false apply --cached modify-file0-patch &&
>      ++       test_cmp_rev :file0 "$modifiedfile0blob" &&
>      ++       git -c core.ignorecase=false apply --cached -R modify-file0-patch &&
>      ++       test_cmp_rev :file0 "$file0blob" &&
>      ++
>      ++       # do the same with ignorecase
>      ++       git -c core.ignorecase=true apply --cached modify-file0-patch &&
>      ++       test_cmp_rev :file0 "$modifiedfile0blob" &&
>      ++       git -c core.ignorecase=true apply --cached -R modify-file0-patch &&
>      ++       test_cmp_rev :file0 "$file0blob"
>      ++'
>      ++
>      ++test_expect_success 'rename file1 to file2' '
>      ++       # start from file0 and file1
>      ++       git reset --hard current &&
>      ++
>      ++       # rename file1 to file2
>      ++       git -c core.ignorecase=false apply --cached rename-file1-to-file2-patch &&
>      ++       test_must_fail git rev-parse --verify :file1 &&
>      ++       test_cmp_rev :file2 "$file1blob" &&
>      ++       git -c core.ignorecase=false apply --cached -R rename-file1-to-file2-patch &&
>      ++       test_must_fail git rev-parse --verify :file2 &&
>      ++       test_cmp_rev :file1 "$file1blob" &&
>      ++
>      ++       # do the same with ignorecase
>      ++       git -c core.ignorecase=true apply --cached rename-file1-to-file2-patch &&
>      ++       test_must_fail git rev-parse --verify :file1 &&
>      ++       test_cmp_rev :file2 "$file1blob" &&
>      ++       git -c core.ignorecase=true apply --cached -R rename-file1-to-file2-patch &&
>      ++       test_must_fail git rev-parse --verify :file2 &&
>      ++       test_cmp_rev :file1 "$file1blob"
>      ++'
>      ++
>      ++test_expect_success 'rename file1 to file2' '
>      ++       # start from file0 and file1
>      ++       git reset --hard current &&
>      ++
>      ++       # rename file1 to File1
>      ++       git -c core.ignorecase=false apply --cached rename-file1-to-File1-patch &&
>      ++       test_must_fail git rev-parse --verify :file1 &&
>      ++       test_cmp_rev :File1 "$file1blob" &&
>      ++       git -c core.ignorecase=false apply --cached -R rename-file1-to-File1-patch &&
>      ++       test_must_fail git rev-parse --verify :File1 &&
>      ++       test_cmp_rev :file1 "$file1blob" &&
>      ++
>      ++       # do the same with ignorecase
>      ++       git -c core.ignorecase=true apply --cached rename-file1-to-File1-patch &&
>      ++       test_must_fail git rev-parse --verify :file1 &&
>      ++       test_cmp_rev :File1 "$file1blob" &&
>      ++       git -c core.ignorecase=true apply --cached -R rename-file1-to-File1-patch &&
>      ++       test_must_fail git rev-parse --verify :File1 &&
>      ++       test_cmp_rev :file1 "$file1blob"
>      ++'
>      ++
>      ++# We may want to add tests with working tree here, without "--cached" and
>      ++# with and without "--index" here.  For example, should modify-file0-patch
>      ++# apply cleanly if we have File0 with $file0blob in the index and the working
>      ++# tree if core.icase is set?
>      ++
>      ++test_expect_success CASE_INSENSITIVE_FS 'a test only for icase fs' '
>      ++       : sample
>       +'
>       +
>      -+test_expect_success 'apply case-only rename patch without conflict' '
>      -+ git apply --index case_only_rename_patch
>      ++test_expect_success !CASE_INSENSITIVE_FS 'a test only for !icase fs' '
>      ++       : sample
>       +'
>       +
>       +test_done
>  -:  ----------- > 2:  1226fbd3caf reset: new failing test for reset of case-insensitive duplicate in index
>  -:  ----------- > 3:  04d83283716 apply: support case-only renames in case-insensitive filesystems
>
> --
> gitgitgadget
