Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD423C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 10:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354651AbhKYKqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 05:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347648AbhKYKoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 05:44:17 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF89C061748
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:41:06 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so23744681edd.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sA3vOrkvMySHPLvsK9Hz4/hpdMM1DbUAge0ZBeVPx6I=;
        b=amen08HS+fq7nwb5/sDehbRYuyV/J6k4qqeiuVucQcJKwvAikmrXQyZuJUushvrhI2
         bfFDpv46yoo+lX2aOeLPBxigprDd/6rUqJk//jXSBQhwBqMGov53AF4PGWnA3YbLZFU3
         lVVAwGAimbGsT0ICoVf14rTprYBtHef0Hq/3srGNCmcKS0md3sK5HPloX+V7wfkcBPRO
         g5Gi5SAsG6FxMdYHX+9dNvCXsRPvlA5Z4QjmaBPBGkWLtTpQRrqFK09ZGh4u7h5cHsUM
         FAj4f2jx8NpKZHZy0gKNyp04c8e/SIqdwnJouAj+VuGZOwxxoOMLfpdE3B60wp6R5kO+
         e3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sA3vOrkvMySHPLvsK9Hz4/hpdMM1DbUAge0ZBeVPx6I=;
        b=7hQofKiwytiTIZyvTk+RbYtxEbWN0pR/pYjizD7Wv+1iRa/pSZU/0XcZtd8+Cr47gb
         imOiWH2wyFW/yV+racWejyrmcIl5xSz/rZ1hM/gERLnTSJVfaS9k+V37f02ainyMFCNV
         kUIV/QU1tYFDO4FoxEBNe1LnqmKrRvBmOUQ5cranA9keqitG8ZnrzbFcmCSDFQKi17DE
         4RR1pkDMWuwj98tV/LRPIL7Hzks872cYFSNDIEFXsnAgDf5OGSEIoD2gRRtf0IQ2M+D3
         xT2P/KQISSYVrO3QBZNIpLrt7uazdDQUKT3Z9Q+2u0+oXoMN+IfboAU3DDG7B5Awvcy4
         dK9A==
X-Gm-Message-State: AOAM530jkpzbJKoX3gtjbHLO2Wvq82eWsHR93+jralJUlPWCJ5I1BHuR
        uWnklUDwazbLsEhOa6YnAo9vgaBezLU=
X-Google-Smtp-Source: ABdhPJxTqphbeMvM0TXvrpP4ftS9cJXqDwo0ZfU5VeaoxU0bagW8iaPsAQ7uxoXtYFiIxA+ANnz+Rw==
X-Received: by 2002:a17:906:741:: with SMTP id z1mr30708680ejb.421.1637836864468;
        Thu, 25 Nov 2021 02:41:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm1541080edf.85.2021.11.25.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 02:41:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqCBa-0004Kc-W6;
        Thu, 25 Nov 2021 11:41:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/9] t2501: add various tests for removing the
 current working directory
Date:   Thu, 25 Nov 2021 11:21:30 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <38a120f5c0379daabc1f9730039ff7166037410d.1637829556.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <38a120f5c0379daabc1f9730039ff7166037410d.1637829556.git.gitgitgadget@gmail.com>
Message-ID: <211125.86fsrkjz5t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Numerous commands will remove empty working directories, especially if
> they are in the way of placing needed files.  That is normally fine, but
> removing the current working directory can cause confusion for the user
> when they run subsequent commands.  For example, after one git process
> has removed the current working directory, git status/log/diff will all
> abort with the message:
>
>     fatal: Unable to read current working directory: No such file or directory
>
> Since there are several code paths that can result in the current
> working directory being removed, add several tests of various different
> codepaths that check for the behavior we would instead like to see.
> This include a number of new error messages that we will be adding in
> subsequent commits as we implement the desired checks.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t2501-cwd-empty.sh | 255 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 255 insertions(+)
>  create mode 100755 t/t2501-cwd-empty.sh
>
> [...]

As noted on v1 (and particularly if we're going to have something like
my proposed alternate "let's not make setup.c die then?" I really think
this should positively assert our existing behavior, and we can then
update this later for the behavior change.

I got that ~working locally, I think you can squash the below in, and
then cherry-pick this version on top in the actual change that adds the
"Refusing to remove" behavior change.

I think this really helps to explain the change, and to make sure we
test existing behavior.

I added a new test for "rm" with the "-f" flag, and by the "~" in
"working" I mean that this worked as I expected aside from the last
couple of tests.

I think that's a bug in your existing test that's hidden by the use of
test_expect_failure here. I.e. in the clean test we'll exit with:

    [...]
    + git clean -fd -e warnings :/
    warning: failed to remove ./: Invalid argument

A "bug" in the sense that this AFAICT would never have removed that
directory anyway since "clean" puts out before, but with your change
we'll catch that earlier and emit a new "error". Also do we need ":/"
there, isn't "." more obvious? In any case, the updated test below shows
that we already punt out in that case, but perhaps it's incomplete. Will
"clean" remove these directories in other cases already?

The "status" then had to be removed from the "stash" test, was it
leftover debugging cruft?

Finally these are quite repetitive. It would be very welcome to factor
these into e.g.:

    test_expect_untracked_dir hard foo/bar/baz -- <command>

Where we just do the common case of "if $1 = hard" we do the setup with
"reset --hard", otherwise the "git clean -dxf" etc. Then if it's the
"foo/bar/baz" case add the 3x "test_path_is_missing" for that etc.

Another issue: You have a "git cmd | other git cmd" with "| git apply"
there, should be moved into two split by a && to not potentially hide an
error on the LHS of the pipe.

I think there's also probably numerous missing tests here when it comes
to how other commands behaved before/after we removed the CWD. E.g. the
case of:

    # in x/
    git rm -r ../x
    git reset ../some-file.txt

Which I noted in another follow-up to v1, i.e. that fails currently due
to our path construction in setup.c. I.e. in terms of "selling" the
change and showing the greater behavior impact, i.e. we from:

    # works
    git rm -r ../x
    # fails
    git reset ../some-file.txt

To:

    # fails (or keeps x/?)
    git rm -r ../x
    # works
    git reset ../some-file.txt

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 5dfb456a691..f1fb8b4a872 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	git commit -m dirORfile
 '
 
-test_expect_failure 'checkout does not clean cwd incidentally' '
+test_expect_success 'checkout cleans cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_path_is_dir foo/bar &&
 
@@ -35,10 +35,10 @@ test_expect_failure 'checkout does not clean cwd incidentally' '
 	) &&
 	test_path_is_missing foo/bar/baz &&
 	test_path_is_missing foo/bar &&
-	test_path_is_dir foo
+	test_path_is_missing foo
 '
 
-test_expect_failure 'checkout fails if cwd needs to be removed' '
+test_expect_success 'checkout if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -46,14 +46,14 @@ test_expect_failure 'checkout fails if cwd needs to be removed' '
 	(
 		cd dirORfile &&
 
-		test_must_fail git checkout fd_conflict 2>../error &&
-		grep "Refusing to remove the current working directory" ../error
+		git checkout fd_conflict 2>../error &&
+		grep "Switched to branch" ../error
 	) &&
 
-	test_path_is_dir dirORfile
+	test_path_is_file dirORfile
 '
 
-test_expect_failure 'reset --hard does not clean cwd incidentally' '
+test_expect_success 'reset --hard cleans cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_path_is_dir foo/bar &&
 
@@ -64,10 +64,10 @@ test_expect_failure 'reset --hard does not clean cwd incidentally' '
 	) &&
 	test_path_is_missing foo/bar/baz &&
 	test_path_is_missing foo/bar &&
-	test_path_is_dir foo
+	test_path_is_missing foo
 '
 
-test_expect_failure 'reset --hard fails if cwd needs to be removed' '
+test_expect_success 'reset --hard succeeds if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -75,14 +75,14 @@ test_expect_failure 'reset --hard fails if cwd needs to be removed' '
 	(
 		cd dirORfile &&
 
-		test_must_fail git reset --hard fd_conflict 2>../error &&
-		grep "Refusing to remove.*the current working directory" ../error
+		git reset --hard fd_conflict 2>../error &&
+		test_must_be_empty ../error
 	) &&
 
-	test_path_is_dir dirORfile
+	test_path_is_file dirORfile
 '
 
-test_expect_failure 'merge does not remove cwd incidentally' '
+test_expect_success 'merge removes cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -92,24 +92,24 @@ test_expect_failure 'merge does not remove cwd incidentally' '
 	) &&
 
 	test_path_is_missing subdir/file.t &&
-	test_path_is_dir subdir
+	test_path_is_missing subdir
 '
 
-test_expect_failure 'merge fails if cwd needs to be removed' '
+test_expect_success 'merge succeeds if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
 	mkdir dirORfile &&
 	(
 		cd dirORfile &&
-		test_must_fail git merge fd_conflict 2>../error &&
-		grep "Refusing to remove the current working directory" ../error
+		git merge fd_conflict 2>../error &&
+		test_must_be_empty ../error
 	) &&
 
-	test_path_is_dir dirORfile
+	test_path_is_file dirORfile
 '
 
-test_expect_failure 'cherry-pick does not remove cwd incidentally' '
+test_expect_success 'cherry-pick removes cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -119,24 +119,23 @@ test_expect_failure 'cherry-pick does not remove cwd incidentally' '
 	) &&
 
 	test_path_is_missing subdir/file.t &&
-	test_path_is_dir subdir
+	test_path_is_missing subdir
 '
 
-test_expect_failure 'cherry-pick fails if cwd needs to be removed' '
+test_expect_success 'cherry-pick suceeds if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
 	mkdir dirORfile &&
 	(
 		cd dirORfile &&
-		test_must_fail git cherry-pick fd_conflict 2>../error &&
-		grep "Refusing to remove the current working directory" ../error
+		git cherry-pick fd_conflict 2>../error
 	) &&
 
-	test_path_is_dir dirORfile
+	test_path_is_file dirORfile
 '
 
-test_expect_failure 'rebase does not remove cwd incidentally' '
+test_expect_success 'rebase does removes cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -146,24 +145,23 @@ test_expect_failure 'rebase does not remove cwd incidentally' '
 	) &&
 
 	test_path_is_missing subdir/file.t &&
-	test_path_is_dir subdir
+	test_path_is_missing subdir
 '
 
-test_expect_failure 'rebase fails if cwd needs to be removed' '
+test_expect_success 'rebase succeeds if cwd needs to be removed' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
 	mkdir dirORfile &&
 	(
 		cd dirORfile &&
-		test_must_fail git rebase foo/bar/baz fd_conflict 2>../error &&
-		grep "Refusing to remove the current working directory" ../error
+		git rebase foo/bar/baz fd_conflict 2>../error
 	) &&
 
-	test_path_is_dir dirORfile
+	test_path_is_file dirORfile
 '
 
-test_expect_failure 'revert does not remove cwd incidentally' '
+test_expect_success 'revert removes cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -173,10 +171,10 @@ test_expect_failure 'revert does not remove cwd incidentally' '
 	) &&
 
 	test_path_is_missing subdir/file.t &&
-	test_path_is_dir subdir
+	test_path_is_missing subdir
 '
 
-test_expect_failure 'revert fails if cwd needs to be removed' '
+test_expect_success 'revert succeeds if cwd needs to be removed' '
 	git checkout fd_conflict &&
 	git revert HEAD &&
 	test_when_finished "git clean -fdx" &&
@@ -184,14 +182,13 @@ test_expect_failure 'revert fails if cwd needs to be removed' '
 	mkdir dirORfile &&
 	(
 		cd dirORfile &&
-		test_must_fail git revert HEAD 2>../error &&
-		grep "Refusing to remove the current working directory" ../error
+		git revert HEAD 2>../error
 	) &&
 
-	test_path_is_dir dirORfile
+	test_path_is_file dirORfile
 '
 
-test_expect_failure 'rm does not remove cwd incidentally' '
+test_expect_success 'rm removes cwd incidentally' '
 	test_when_finished "git reset --hard" &&
 	git checkout foo/bar/baz &&
 
@@ -202,10 +199,24 @@ test_expect_failure 'rm does not remove cwd incidentally' '
 
 	test_path_is_missing foo/bar/baz &&
 	test_path_is_missing foo/bar &&
-	test_path_is_dir foo
+	test_path_is_missing foo
 '
 
-test_expect_failure 'apply does not remove cwd incidentally' '
+test_expect_success 'rm -f removes cwd incidentally' '
+	test_when_finished "git reset --hard" &&
+	git checkout foo/bar/baz &&
+
+	(
+		cd foo &&
+		git rm -f bar/baz.t
+	) &&
+
+	test_path_is_missing foo/bar/baz &&
+	test_path_is_missing foo/bar &&
+	test_path_is_missing foo
+'
+
+test_expect_success 'apply removes cwd incidentally' '
 	test_when_finished "git reset --hard" &&
 	git checkout foo/bar/baz &&
 
@@ -215,10 +226,10 @@ test_expect_failure 'apply does not remove cwd incidentally' '
 	) &&
 
 	test_path_is_missing subdir/file.t &&
-	test_path_is_dir subdir
+	test_path_is_missing subdir
 '
 
-test_expect_failure 'clean does not remove cwd incidentally' '
+test_expect_success 'clean does not remove cwd incidentally (cannot match pathspec)' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -227,16 +238,15 @@ test_expect_failure 'clean does not remove cwd incidentally' '
 	>untracked/random &&
 	(
 		cd untracked &&
-		git clean -fd -e warnings :/ >../warnings &&
-		grep "Refusing to remove current working directory" ../warnings
+		test_must_fail git clean -fd .
 	) &&
 
-	test_path_is_missing empty &&
+	test_path_is_dir empty &&
 	test_path_is_missing untracked/random &&
 	test_path_is_dir untracked
 '
 
-test_expect_failure 'stash does not remove cwd incidentally' '
+test_expect_success 'stash removes cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
@@ -244,12 +254,11 @@ test_expect_failure 'stash does not remove cwd incidentally' '
 	>untracked/random &&
 	(
 		cd untracked &&
-		git stash --include-untracked &&
-		git status
+		git stash --include-untracked
 	) &&
 
 	test_path_is_missing untracked/random &&
-	test_path_is_dir untracked
+	test_path_is_missing untracked
 '
 
 test_done
