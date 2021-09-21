Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36976C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2148E610E8
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhIUNrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhIUNrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:47:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC8C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:46:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q26so39308594wrc.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpE8hO9bHDZ4ZjjR/NBfGn0aLLRQbY/INTczlG0s3UU=;
        b=M/Gu+P9SJtxIRDQkJE2Vz7jEehMW5KtU9jessvwEbN95cM9utiuNaI7gT7geH2vhx2
         vpqxql7sy71Xu421k02L2zXkSitAnrJUcntVNSb6r1jiI29SfUrZ4+kOzZX9HRav6rEv
         fkxxKDyK0QaOrP9HuL60HwXUVyciL2P+A5Li/S54U0ExFAHFxOsADea+HD2LPc/I94iP
         2afR+EbVRfFRvZpOPb4blWieuNAhIq2m4XabrUH93up0gAFuQsv18AupFidgXz/Kq1iw
         DQW/v4Y3j2LDerzkRV1UpAWxkvp1PM4Sf0HJD9l4JvIVydGCKRC7//gtGZoNgw77hIQo
         DC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpE8hO9bHDZ4ZjjR/NBfGn0aLLRQbY/INTczlG0s3UU=;
        b=1vaLMvKIgHWkExQVc/QkrZ9Hv6B70ttKdOpa+Ln3Gs3o9s1uIHDNBh4biN96sorLVx
         RR0HOOeW2pChm6wOxKFhzFVrYTCbQeUswnztk2EOZ0beKPBYzcS29bhdvet44NhnYSHb
         3MXTsfDYSojza7Purs/0VCgn3jCKMfB6Y6CJP1RZ7d2n0zKMpqel+Z48Ghau6y943yyi
         W0695cmAjMKz/lb9xOz1+lsl5xg+F1fyQrX1ndOqdP68VsEq72a8ncUIwR2NEihB8Ta6
         +nbhCe9vqwFrMItucAdOHf1KimLNL4OpfGzcxh5qPz1BD3E53an0WgNEGgEZ6C4mXnF9
         s+9Q==
X-Gm-Message-State: AOAM5339NT0nxkUxWOkHpSeaGvqxibncg9PE5a8PkgH87BA3O4UGJT99
        5yE82K+EoEPHwVpk0R9M9inDpwz78C+SrQ==
X-Google-Smtp-Source: ABdhPJyJc8QZDluXzFUIk3gCuaV3nimjvNaNHs90LrYetrQheczylxonzmqhbXpk8NtCsoYkwTD+2A==
X-Received: by 2002:a5d:60c8:: with SMTP id x8mr34665617wrt.293.1632231970455;
        Tue, 21 Sep 2021 06:46:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v17sm18953540wrr.69.2021.09.21.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:46:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] stash: print the correct usage on "git stash [push] --invalid-option"
Date:   Tue, 21 Sep 2021 15:46:07 +0200
Message-Id: <patch-v2-1.1-d1b9790904c-20210921T134436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <patch-1.1-47c582f1218-20210901T111930Z-avarab@gmail.com>
References: <patch-1.1-47c582f1218-20210901T111930Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the usage message emitted by "git stash --invalid-option" to
emit usage information for "git stash" in general, and not just for
the "push" command. I.e. before:

    $ git stash --blah
    error: unknown option `blah'
    usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
              [-u|--include-untracked] [-a|--all] [-m|--message <message>]
              [--] [<pathspec>...]]
    [...]

After:

    $ git stash --blah
    error: unknown option `blah'
    usage: git stash list [<options>]
       or: git stash show [<options>] [<stash>]
       or: git stash drop [-q|--quiet] [<stash>]
       or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
       or: git stash branch <branchname> [<stash>]
       or: git stash clear
       or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
              [-u|--include-untracked] [-a|--all] [-m|--message <message>]
              [--pathspec-from-file=<file> [--pathspec-file-nul]]
              [--] [<pathspec>...]]
       or: git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
              [-u|--include-untracked] [-a|--all] [<message>]
    [...]

We'll only emit the former on the likes of "git stash push --blah"
now.

That we emitted the usage for just "push" in the case of the
subcommand not being explicitly specified was an unintentional
side-effect of how it was implemented. When it was converted to C in
d553f538b8a (stash: convert push to builtin, 2019-02-25) the pattern
of having per-subcommand usage information was rightly continued. The
Git-stash.sh shellscript did not have that, and always printed the
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

A trivial patch for a small issue in "git stash" usage, unrelated and
non-conflicting with my other series to improve usage output alignment
at
https://lore.kernel.org/git/cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com/

Range-diff against v1:
1:  47c582f1218 ! 1:  d1b9790904c stash: print the correct usage on "git stash [push] --invalid-option"
    @@ Commit message
     
         Change the usage message emitted by "git stash --invalid-option" to
         emit usage information for "git stash" in general, and not just for
    -    the "push" command.
    +    the "push" command. I.e. before:
    +
    +        $ git stash --blah
    +        error: unknown option `blah'
    +        usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    +                  [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    +                  [--] [<pathspec>...]]
    +        [...]
    +
    +    After:
    +
    +        $ git stash --blah
    +        error: unknown option `blah'
    +        usage: git stash list [<options>]
    +           or: git stash show [<options>] [<stash>]
    +           or: git stash drop [-q|--quiet] [<stash>]
    +           or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    +           or: git stash branch <branchname> [<stash>]
    +           or: git stash clear
    +           or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    +                  [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    +                  [--pathspec-from-file=<file> [--pathspec-file-nul]]
    +                  [--] [<pathspec>...]]
    +           or: git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    +                  [-u|--include-untracked] [-a|--all] [<message>]
    +        [...]
    +
    +    We'll only emit the former on the likes of "git stash push --blah"
    +    now.
     
         That we emitted the usage for just "push" in the case of the
         subcommand not being explicitly specified was an unintentional
    @@ Commit message
         But in doing so the case of push being implicit and explicit was
         conflated. A variable was added to track this in 8c3713cede7 (stash:
         eliminate crude option parsing, 2020-02-17), but it did not update the
    -    usage output accordingly. Let's do that.
    +    usage output accordingly.
     
         This still leaves e.g. "git stash push -h" emitting the
         "git_stash_usage" output, instead of "git_stash_push_usage". That
    @@ t/t3903-stash.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
      . ./test-lib.sh
      
    -+test_expect_success 'usage' '
    -+	test_expect_code 129 git stash -h >out &&
    -+	grep "or: git stash" out &&
    ++test_expect_success 'usage on cmd and subcommand invalid option' '
    ++	test_expect_code 129 git stash --invalid-option 2>usage &&
    ++	grep "or: git stash" usage &&
     +
    -+	test_expect_code 129 git stash --invalid-option >out 2>err &&
    -+	grep "or: git stash" err &&
    ++	test_expect_code 129 git stash push --invalid-option 2>usage &&
    ++	! grep "or: git stash" usage
    ++'
    ++
    ++test_expect_success 'usage on main command -h emits a summary of subcommands' '
    ++	test_expect_code 129 git stash -h >usage &&
    ++	grep -F "usage: git stash list" usage &&
    ++	grep -F "or: git stash show" usage
    ++'
     +
    -+	test_expect_code 129 git stash push --invalid-option >out 2>err &&
    -+	! grep "or: git stash" err
    ++test_expect_failure 'usage for subcommands should emit subcommand usage' '
    ++	test_expect_code 129 git stash push -h >usage &&
    ++	grep -F "usage: git stash [push" usage
     +'
     +
      diff_cmp () {

 builtin/stash.c  |  1 +
 t/t3903-stash.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..cf62c3b3cd8 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1608,6 +1608,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	if (argc) {
 		force_assume = !strcmp(argv[0], "-p");
 		argc = parse_options(argc, argv, prefix, options,
+				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage,
 				     PARSE_OPT_KEEP_DASHDASH);
 	}
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359..655f9be4352 100755
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
2.33.0.1098.gf02a64c1a2d

