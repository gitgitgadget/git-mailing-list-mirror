Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804BC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhLPMy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbhLPMyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 07:54:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E1C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 04:54:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so1700498wmb.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 04:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvtDv0FSPfdJzBMdnkEpwXKhSy19C9yHOd0euOFBSGw=;
        b=U7GcZ/NG40cHhiIJWzwFDqhVdHzlyS8cCLWYUjxiU5dRSLlVl1RcmzscYVi6pz2UIL
         h4lr8Yo8rR40oMqq2dViVVuov/OlfhlfrfHHKrSl70ujiBM3aNeJVwkBd40iVQttSJUu
         v1s6qWKlxrwmtjYYSNigXCEPHi9mWmLee3TAvOHmGWNIZZsxRnyPVXrY7QUS+mRHFUAg
         IH+8gHoaSz+SvJ0K1ZLRdqDkdpGfaDKRJXXwb72D4LfJW/FVFENa3KhsIQtIAumG4WPY
         +zK6Q16FuEUhSPn4NU14D85W/fFG4/nVRC84cqOtfTKlnmDVDZzXDuiwtek29xn2XzKj
         7Hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvtDv0FSPfdJzBMdnkEpwXKhSy19C9yHOd0euOFBSGw=;
        b=lKdcXv6l/oDMczY4+25DQtDgIM64YfCr8S0DEMkpktdqZZAzCNbNR1CDS8fL4+GvJn
         AI2qfNsGATx3Ng01mknr9O0ChhlcRr0hQtM8ZWV4dqWQyjlmCNMSBTac6Kgoh5FjRJI0
         NNHKWfI/JJQ61l5ZT3DO9o+Kq3DWEaj+blgJCqHL3SAmsfxKhgV9Xu5hXv79TnLxSPf1
         vDyK9s+bVSVZnBgY3/66PHRUTrr89yeq6KpP+tMJqGRZDQQ6UpCKUx6KNWd1c/1YUaNW
         rqA48NrG0UZqqLBRTxaAho+GJs88YzoEB1hNC6JiZtaiV/Z4a/ZvD6ly/mh7vyyJuxwK
         rdbQ==
X-Gm-Message-State: AOAM531GR5PRNEh+ulT6yICavZF9sHsyU/0XzNQPJazBHULE/mBt3lce
        8BPaOkFRv+wSFCxQe6ShsD0vbpWUyzsSOw==
X-Google-Smtp-Source: ABdhPJwA3XihN1DXpBQ65I7/nD3GHvdkC17LbPu2yfGsNhBCTKin65nuoGEubPsxXio22lx3B4YwfA==
X-Received: by 2002:a05:600c:3b83:: with SMTP id n3mr4827929wms.116.1639659263357;
        Thu, 16 Dec 2021 04:54:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm4278625wrv.76.2021.12.16.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 04:54:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] stash: don't show "git stash push" usage on bad "git stash" usage
Date:   Thu, 16 Dec 2021 13:54:21 +0100
Message-Id: <patch-v3-1.1-6b33b104c84-20211216T125317Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <patch-v2-1.1-d1b9790904c-20210921T134436Z-avarab@gmail.com>
References: <patch-v2-1.1-d1b9790904c-20210921T134436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage message emitted by "git stash --invalid-option" to
emit usage information for "git stash" in general, and not just for
the "push" command. I.e. before:

    $ git stash --invalid-option
    error: unknown option `invalid-option'
    usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
                     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
                     [--] [<pathspec>...]]
    [...]

After:

    $ git stash --invalid-option
    error: unknown option `invalid-option'
    usage: git stash list [<options>]
       or: git stash show [<options>] [<stash>]
       or: git stash drop [-q|--quiet] [<stash>]
       or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
       or: git stash branch <branchname> [<stash>]
       or: git stash clear
       or: git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
                     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
                     [--pathspec-from-file=<file> [--pathspec-file-nul]]
                     [--] [<pathspec>...]]
       or: git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
                     [-u|--include-untracked] [-a|--all] [<message>]
    [...]

That we emitted the usage for just "push" in the case of the
subcommand not being explicitly specified was an unintentional
side-effect of how it was implemented. When it was converted to C in
d553f538b8a (stash: convert push to builtin, 2019-02-25) the pattern
of having per-subcommand usage information was rightly continued. The
"git-stash.sh" shellscript did not have that, and always printed the
equivalent of "git_stash_usage".

But in doing so the case of push being implicit and explicit was
conflated. A variable was added to track this in 8c3713cede7 (stash:
eliminate crude option parsing, 2020-02-17), but it did not update the
usage output accordingly.

This still leaves e.g. "git stash push -h" emitting the
"git_stash_usage" output, instead of "git_stash_push_usage". That
should be fixed, but is a much deeper misbehavior in parse_options()
not being aware of subcommands at all. I.e. in how
PARSE_OPT_KEEP_UNKNOWN and PARSE_OPT_NO_INTERNAL_HELP combine in
commands such as "git stash".

Perhaps PARSE_OPT_KEEP_UNKNOWN should imply
PARSE_OPT_NO_INTERNAL_HELP, or better yet parse_options() should be
extended to fully handle these subcommand cases that we handle
manually in "git stash", "git commit-graph", "git multi-pack-index"
etc. All of those musings would be a much bigger change than this
isolated fix though, so let's leave that for some other time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I think this was ready the first couple of times, but it wasn't picked
up. Hopefully this relatively trivial UX fix can land this time
around.

The only updates are some commit message nits, including updating the
examples for the now-landed changes to align the parse-options output.

Range-diff against v2:
1:  d1b9790904c ! 1:  6b33b104c84 stash: print the correct usage on "git stash [push] --invalid-option"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    stash: print the correct usage on "git stash [push] --invalid-option"
    +    stash: don't show "git stash push" usage on bad "git stash" usage
     
         Change the usage message emitted by "git stash --invalid-option" to
         emit usage information for "git stash" in general, and not just for
         the "push" command. I.e. before:
     
    -        $ git stash --blah
    -        error: unknown option `blah'
    +        $ git stash --invalid-option
    +        error: unknown option `invalid-option'
             usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    -                  [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    -                  [--] [<pathspec>...]]
    +                         [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    +                         [--] [<pathspec>...]]
             [...]
     
         After:
     
    -        $ git stash --blah
    -        error: unknown option `blah'
    +        $ git stash --invalid-option
    +        error: unknown option `invalid-option'
             usage: git stash list [<options>]
                or: git stash show [<options>] [<stash>]
                or: git stash drop [-q|--quiet] [<stash>]
                or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
                or: git stash branch <branchname> [<stash>]
                or: git stash clear
    -           or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    -                  [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    -                  [--pathspec-from-file=<file> [--pathspec-file-nul]]
    -                  [--] [<pathspec>...]]
    -           or: git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    -                  [-u|--include-untracked] [-a|--all] [<message>]
    +           or: git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
    +                         [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    +                         [--pathspec-from-file=<file> [--pathspec-file-nul]]
    +                         [--] [<pathspec>...]]
    +           or: git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
    +                         [-u|--include-untracked] [-a|--all] [<message>]
             [...]
     
    -    We'll only emit the former on the likes of "git stash push --blah"
    -    now.
    -
         That we emitted the usage for just "push" in the case of the
         subcommand not being explicitly specified was an unintentional
         side-effect of how it was implemented. When it was converted to C in
         d553f538b8a (stash: convert push to builtin, 2019-02-25) the pattern
         of having per-subcommand usage information was rightly continued. The
    -    Git-stash.sh shellscript did not have that, and always printed the
    +    "git-stash.sh" shellscript did not have that, and always printed the
         equivalent of "git_stash_usage".
     
         But in doing so the case of push being implicit and explicit was

 builtin/stash.c  |  1 +
 t/t3903-stash.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 18c812bbe03..5462840a073 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1681,6 +1681,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	if (argc) {
 		force_assume = !strcmp(argv[0], "-p");
 		argc = parse_options(argc, argv, prefix, options,
+				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage,
 				     PARSE_OPT_KEEP_DASHDASH);
 	}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2c66cfbc3b7..b17c52d8807 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -10,6 +10,25 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'usage on cmd and subcommand invalid option' '
+	test_expect_code 129 git stash --invalid-option 2>usage &&
+	grep "or: git stash" usage &&
+
+	test_expect_code 129 git stash push --invalid-option 2>usage &&
+	! grep "or: git stash" usage
+'
+
+test_expect_success 'usage on main command -h emits a summary of subcommands' '
+	test_expect_code 129 git stash -h >usage &&
+	grep -F "usage: git stash list" usage &&
+	grep -F "or: git stash show" usage
+'
+
+test_expect_failure 'usage for subcommands should emit subcommand usage' '
+	test_expect_code 129 git stash push -h >usage &&
+	grep -F "usage: git stash [push" usage
+'
+
 diff_cmp () {
 	for i in "$1" "$2"
 	do
-- 
2.34.1.1020.gc80c40b6642

