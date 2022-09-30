Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119AAC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiI3Wrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiI3Wrf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:47:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B453115FC51
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:47:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so5816285wml.5
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=7YhQ9trXU1VYMs/G/Xt1U1Zh0k2E515UZZx2BvrV0LE=;
        b=NsVAOAZcREOiD85Vba/EwA4+mp+pjiiQNcCSNP4GAcLCNw8UvT500VRQ7p9jqUL6eM
         oDiGEuugEtep4z38/5bJVchlozWdWMwagxOLqxsUfXacu7Wuinm9iTJw9sPtW53/svxV
         EFVdOS9eNys8NFV+o1YMA/z080U/yq5rMMGFR+uHzx3j0sdDl2wK/4lpkyJcTM/zAwui
         Wxo4RP+cVBeXXLKea+wNBc7U2RbiN4srwEIbsdH3re6W8B6cO89JhC/k9edFqKdISHYg
         lkEGxAGMZU6YvRAgTvJVKlN+b1mcPi2erpkup+VgXYmJtTiBLQx5W49IBBdyHIjiLlfF
         Xd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7YhQ9trXU1VYMs/G/Xt1U1Zh0k2E515UZZx2BvrV0LE=;
        b=b1UONr6YxUDdrBSyRUrsvTClxJbQ74cPK9UdIrtQQArFprZHSO68ZBdJmWG7LUfGI8
         c1EykXaBNLuU1ElBLdJyY0dXzfGTn50d3Cf5TnTi83Mk9PG5bFMDVROosyPy1iKWQjEV
         Y/+OlK0J+NR3+SrtwixmDQ51UCHQVV08NFxofPALMYogYn9OiqjMpsOzeanuQXF5pW+N
         0ohKBzWpAbNoyXA83Fam5nTKjcgPeT74wlD7RVBtyApT0s6OYWm2BjnaVJwRc8GsdhCx
         pY+shQHMgWisufbYpHVwF4acvr6bEF50rj8mLS0tnJnMV3uMq9iOQ68QSU9/2Q3hHKcf
         1cVA==
X-Gm-Message-State: ACrzQf0QjVMvWZYuUGTA5hD/wvzROTxLZ+Lpsxo9aGhhmE0B3aq9Dmfd
        eBDjXDhYN5cysIYgu+1HPWZets7pBrA=
X-Google-Smtp-Source: AMsMyM6laDyPegrLf0QVseI13tRPfO8sisVkTSfEr8MxsCZhOLMCiTRG0irOe7CuXmVMM1T52iCOMg==
X-Received: by 2002:a1c:f009:0:b0:3b4:9398:49c9 with SMTP id a9-20020a1cf009000000b003b4939849c9mr202026wmb.174.1664578052227;
        Fri, 30 Sep 2022 15:47:32 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600003c400b0022a3a887ceasm2917841wrg.49.2022.09.30.15.47.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 15:47:31 -0700 (PDT)
Subject: [PATCH v2] branch: description for non-existent branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
Message-ID: <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
Date:   Sat, 1 Oct 2022 00:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the repository does not yet have commits, some errors describe that
there is no branch:

    $ git init -b first

    $ git branch --edit-description first
    error: No branch named 'first'.

    $ git branch --set-upstream-to=upstream
    fatal: branch 'first' does not exist

    $ git branch -c second
    error: refname refs/heads/first not found
    fatal: Branch copy failed

That "first" branch is unborn but to say it doesn't exists is confusing.

Options "-c" (copy) and "-m" (rename) show the same error when the
origin branch doesn't exists:

    $ git branch -c non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch copy failed

    $ git branch -m non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch rename failed

Note that "--edit-description" without an explicit argument is already
considering the _empty repository_ circumstance in its error.  Also note
that "-m" on the initial branch it is an allowed operation.

This commit makes the error descriptions for those branch operations
with unborn or non-existent branches, more informative.

This is the result of the change:

    $ git init -b first

    $ git branch --edit-description first
    error: No commit on branch 'first' yet.

    $ git branch --set-upstream-to=upstream
    fatal: No commit on branch 'first' yet.

    $ git branch -c second
    fatal: No commit on branch 'first' yet.

    $ git branch [-c/-m] non-existent-branch second
    fatal: No branch named 'non-existent-branch'.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

Changes since V1:

 * Fixed the message, non precise descriptions.
 * Error renaming non-existent branch was not correct.
 * Tests for the new errors.


Range-diff:
1:  bba7096c4b ! 1:  096c443a29 branch: description for non-existent branch errors
    @@ Metadata
      ## Commit message ##
         branch: description for non-existent branch errors
     
    -    When the repository does not yet has commits, some errors describe that
    +    When the repository does not yet have commits, some errors describe that
         there is no branch:
     
             $ git init -b first
     
    -        $ git --edit-description first
    -        fatal: branch 'first' does not exist
    +        $ git branch --edit-description first
    +        error: No branch named 'first'.
     
    -        $ git --set-upstream-to=upstream
    +        $ git branch --set-upstream-to=upstream
             fatal: branch 'first' does not exist
     
             $ git branch -c second
    @@ Commit message
     
             $ git init -b first
     
    -        $ git --edit-description first
    -        fatal: No commit on branch 'first' yet.
    +        $ git branch --edit-description first
    +        error: No commit on branch 'first' yet.
     
    -        $ git --set-upstream-to=upstream
    +        $ git branch --set-upstream-to=upstream
             fatal: No commit on branch 'first' yet.
     
    -        $ git -c second
    +        $ git branch -c second
             fatal: No commit on branch 'first' yet.
     
    -        $ git [-c/-m] non-existent-branch second
    +        $ git branch [-c/-m] non-existent-branch second
             fatal: No branch named 'non-existent-branch'.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
    @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      			die(_("Invalid branch name: '%s'"), oldname);
      	}
      
    -+	if (copy && !ref_exists(oldref.buf)) {
    -+		if (!strcmp(head, oldname))
    ++	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
    ++		if (copy && !strcmp(head, oldname))
     +			die(_("No commit on branch '%s' yet."), oldname);
     +		else
     +			die(_("No branch named '%s'."), oldname);
    @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
      
      		dwim_and_setup_tracking(the_repository, branch->name,
      					new_upstream, BRANCH_TRACK_OVERRIDE,
    +
    + ## t/t3202-show-branch.sh ##
    +@@ t/t3202-show-branch.sh: test_description='test show-branch'
    + # arbitrary reference time: 2009-08-30 19:20:00
    + GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
    + 
    ++test_expect_success 'error descriptions on empty repository' '
    ++	current=$(git branch --show-current) &&
    ++	cat >expect <<-EOF &&
    ++	error: No commit on branch '\''$current'\'' yet.
    ++	EOF
    ++	test_must_fail git branch --edit-description 2>actual &&
    ++	test_cmp expect actual &&
    ++	test_must_fail git branch --edit-description $current 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'fatal descriptions on empty repository' '
    ++	current=$(git branch --show-current) &&
    ++	cat >expect <<-EOF &&
    ++	fatal: No commit on branch '\''$current'\'' yet.
    ++	EOF
    ++	test_must_fail git branch --set-upstream-to=non-existent 2>actual &&
    ++	test_cmp expect actual &&
    ++	test_must_fail git branch -c new-branch 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'setup' '
    + 	test_commit initial &&
    + 	for i in $(test_seq 1 10)
    +@@ t/t3202-show-branch.sh: done <<\EOF
    + --reflog --current
    + EOF
    + 
    ++test_expect_success 'error descriptions on non-existent branch' '
    ++	cat >expect <<-EOF &&
    ++	error: No branch named '\''non-existent'\'.'
    ++	EOF
    ++	test_must_fail git branch --edit-description non-existent 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'fatal descriptions on non-existent branch' '
    ++	cat >expect <<-EOF &&
    ++	fatal: branch '\''non-existent'\'' does not exist
    ++	EOF
    ++	test_must_fail git branch --set-upstream-to=non-existent non-existent 2>actual &&
    ++	test_cmp expect actual &&
    ++
    ++	cat >expect <<-EOF &&
    ++	fatal: No branch named '\''non-existent'\''.
    ++	EOF
    ++	test_must_fail git branch -c non-existent new-branch 2>actual &&
    ++	test_cmp expect actual &&
    ++	test_must_fail git branch -m non-existent new-branch 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_done

 builtin/branch.c       | 14 +++++++++++--
 t/t3202-show-branch.sh | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..499ebec99e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,6 +538,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
+	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
+		if (copy && !strcmp(head, oldname))
+			die(_("No commit on branch '%s' yet."), oldname);
+		else
+			die(_("No branch named '%s'."), oldname);
+	}
+
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
@@ -805,7 +812,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch_ref.buf)) {
 			strbuf_release(&branch_ref);
 
-			if (!argc)
+			if (!argc || !strcmp(head, branch_name))
 				return error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
@@ -848,8 +855,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname))
+		if (!ref_exists(branch->refname)) {
+			if (!argc || !strcmp(head, branch->name))
+				die(_("No commit on branch '%s' yet."), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
+		}
 
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index f2b9199007..ea7cfd1951 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -7,6 +7,28 @@ test_description='test show-branch'
 # arbitrary reference time: 2009-08-30 19:20:00
 GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 
+test_expect_success 'error descriptions on empty repository' '
+	current=$(git branch --show-current) &&
+	cat >expect <<-EOF &&
+	error: No commit on branch '\''$current'\'' yet.
+	EOF
+	test_must_fail git branch --edit-description 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git branch --edit-description $current 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fatal descriptions on empty repository' '
+	current=$(git branch --show-current) &&
+	cat >expect <<-EOF &&
+	fatal: No commit on branch '\''$current'\'' yet.
+	EOF
+	test_must_fail git branch --set-upstream-to=non-existent 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git branch -c new-branch 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup' '
 	test_commit initial &&
 	for i in $(test_seq 1 10)
@@ -175,4 +197,28 @@ done <<\EOF
 --reflog --current
 EOF
 
+test_expect_success 'error descriptions on non-existent branch' '
+	cat >expect <<-EOF &&
+	error: No branch named '\''non-existent'\'.'
+	EOF
+	test_must_fail git branch --edit-description non-existent 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fatal descriptions on non-existent branch' '
+	cat >expect <<-EOF &&
+	fatal: branch '\''non-existent'\'' does not exist
+	EOF
+	test_must_fail git branch --set-upstream-to=non-existent non-existent 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+	fatal: No branch named '\''non-existent'\''.
+	EOF
+	test_must_fail git branch -c non-existent new-branch 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git branch -m non-existent new-branch 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.36.1
