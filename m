Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B48C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjDAIqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAIqb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71498EB61
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:29 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so11840156otb.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/oDbTG3uIOCUgqKpBJ0cHsJhl8rrZmfHUxfXTXMo7uI=;
        b=Zp5vtYVARvGU7srOEtW7moZweSXDsrRcgkeyikQTm6wYH2lyTZjhb+UAQxoQfZd9BH
         g4qnxu/iQ8BXsoPawNQN3fAnMlQMaaT4EF0qCCiDBj7ohTsC42iNcVYInxb4ZBz2EMDw
         U0fCvOB6GEUt1c9cnY8T53USrXytq9LF3K3JPltI1MMnXjB5f9B13hBmLX/FNEpeD4GT
         7U7/cXMtk2qoNxAblfqmjnhw3TlidGfrjYRz/lqkpJCQjeEs+P93UBRbVAX41V7BpIeV
         7QHbx/VnaUMv0wkSwp1Jd49+91SNsOtO3ERcr9IhmcWN4T2lbMRFzZP+lD0+SD91oyEk
         VSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oDbTG3uIOCUgqKpBJ0cHsJhl8rrZmfHUxfXTXMo7uI=;
        b=A+WDLGB6JT6e1Q6DuwilJjsSUiJ9UOqWyOqc9N4SJXsiJqgjPbLevISJj1jF6+fNzf
         lrp+sj5vjN3li+g928cFukclUyIlIeTsB0hCk0ijUva9bSaYktNiP7Ecw7WgkhBSKL+g
         rCnte/e/l8rI+Tr/xmYzN/Gr6uwcsIJGqyCWlIEE4q205wlrJE2nD2bRCh03kLIGbaMS
         zX4UBx5f/uEpBmiuuNBEnjRKc78GQH1yOZ6IARpol8dfXerstzSxaklRym/u4/DEv7ls
         ABZnedwnp0ENMRMvDnlmP0mahSGIyLfF2KmiFTclm/3BrhqvVUqouD1giU/xZnY4nEZg
         qZDg==
X-Gm-Message-State: AO0yUKUYiuKKNBeHt+9rvI1vZMP8EnBwXHHkdA4wFkrmE9/vGY1+6I7j
        NjfdOW1KzXLyrLmjKwgcnamW7Gw6u6Y=
X-Google-Smtp-Source: AK7set+8ffHUYOCjDFvEW1kj2UKbAf8N10HUbVM4sG1yel0Qbij+w9SkQBXJC+p+0mCwGdfHBQcLug==
X-Received: by 2002:a9d:7dc9:0:b0:699:7244:a372 with SMTP id k9-20020a9d7dc9000000b006997244a372mr14928128otn.28.1680338788236;
        Sat, 01 Apr 2023 01:46:28 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t3-20020a9d7f83000000b0069f9203967bsm2042066otp.76.2023.04.01.01.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 00/49] completion: git-completion 2.0 patches
Date:   Sat,  1 Apr 2023 02:45:37 -0600
Message-Id: <20230401084626.304356-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series revamps the completion code to git-completion 2.0.

It's meant to be applied on top of the zsh completion test series [1].

The zsh code delta between upstream and git-completion 2.0 results in 12
out of 13 failing tests now passing. This patch series now makes that
clear.

Additionally, it adds and fixes one bash completion test pending since
2020 [2].

This patch series started being relatively small (10 patches) [3], but
upstream has never merged them, so it's now 51 patches.

One patch has been merged to master, so that's progress I guess.

Here's a summary of the differences between upstream and git-completion:

# For zsh
 * Fix alias regression
 * Fix main option handling
 * Fix generic completions
 * Fix option relationships
 * Add improved removable suffix
 * Fix suboptions
 * Fix -C handling
 * Fix -c handling
 * Fix configurations with value (e1e00089da)

# Other
 * Fix `COMP_WORDBREAKS` handling
 * Plenty of reorganizations and cleanups

For more information check git-completion's project page [4].

Changes since v6:

 * Run the zsh completion test script directly in zsh
 * Simplify the zsh zpty code for testing
 * Rebase on top of Git 2.40

Past versions:

 * 1.4: https://lore.kernel.org/git/20220830093138.1581538-1-felipe.contreras@gmail.com/
 * 1.3.3: https://lore.kernel.org/git/20210618182518.697912-1-felipe.contreras@gmail.com/
 * 1.3.1: https://lore.kernel.org/git/20210426161458.49860-1-felipe.contreras@gmail.com/
 * 1.3: https://lore.kernel.org/git/20210101021622.798041-1-felipe.contreras@gmail.com/
 * v2: https://lore.kernel.org/git/20201110212136.870769-1-felipe.contreras@gmail.com/
 * v1: https://lore.kernel.org/git/20201104174716.783348-1-felipe.contreras@gmail.com/

Cheers.

[1] https://lore.kernel.org/git/20230401015632.103581-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20201223141950.GA23264@szeder.dev/
[3] https://lore.kernel.org/git/20201104174716.783348-1-felipe.contreras@gmail.com/
[4] https://github.com/felipec/git-completion

Felipe Contreras (48):
  test: completion add test for __git_cmd_idx
  completion: bash: trivial cleanup
  zsh: remove version
  completion: bash: trivial grammar fix
  completion: zsh: add higher-priority location
  zsh: simplify realpath dirname idiom
  test: completion: use global config
  completion: fix __git_cmd_idx regression for zsh
  completion: fix for suboptions with value
  completion: zsh: trivial improvement
  completion: bash: do not modify COMP_WORDBREAKS
  test: completion: fix currently typed words
  test: completion: switch __gitcomp_nl prefix test
  test: completion: add run_func() helper
  completion: bash: remove non-append functionality
  completion: bash: get rid of _append() functions
  completion: bash: get rid of any non-append code
  completion: zsh: fix options with arguments
  completion: zsh: expand --git-dir file argument
  completion: zsh: add support for general -C opts
  completion: zsh: fix for undefined completions
  completion: zsh: add support for general -c opts
  completion: zsh: fix extra space on foo=
  completion: zsh: add excluded options
  completion: zsh: always set compset
  completion: factor out check in __gitcomp
  completion: simplify equal suffix check
  completion: refactor __gitcomp
  completion: simplify __gitcomp
  completion: bash: change suffix check in __gitcomp
  completion: improve __gitcomp suffix code
  test: completion: add missing test
  completion: bash: simplify config_variable_name
  completion: bash: improve __gitcomp description
  completion: add __gitcomp_opts
  completion: bash: cleanup __gitcomp* invocations
  completion: bash: shuffle __gitcomp functions
  completion: zsh: simplify __gitcomp_direct
  completion: zsh: shuffle __gitcomp* functions
  completion: zsh: fix direct quoting
  completion: zsh: add elements individually in __gitcomp_opts
  completion: zsh: add __gitcompadd helper
  completion: zsh: add correct removable suffix
  completion: bash: simplify _get_comp_words_by_ref()
  completion: bash: refactor _get_comp_words_by_ref()
  completion: bash: cleanup _get_comp_words_by_ref()
  completion: bash: trivial cleanup
  completion: bash: rename _get_comp_words_by_ref()

Michael Bianco (1):
  zsh: resolve symlink of script

 contrib/completion/git-completion.bash | 637 +++++++++++--------------
 contrib/completion/git-completion.zsh  | 146 +++---
 t/t9902-completion.sh                  | 167 ++++---
 t/t9904-completion-zsh.sh              |  97 ++--
 4 files changed, 489 insertions(+), 558 deletions(-)

Range-diff against v6:
 1:  e3c5a79c51 =  1:  6d191be41c test: completion add test for __git_cmd_idx
 2:  674c223b68 <  -:  ---------- test: add zsh completion tests
 4:  8a6ec4348b =  2:  a59bf95ff5 completion: bash: trivial cleanup
50:  3dd08cbdf7 =  3:  c5c105bfff zsh: remove version
51:  88beef78a7 =  4:  0217b5641c completion: bash: trivial grammar fix
 5:  c6e3e9c8b4 =  5:  b1548d96a2 completion: zsh: add higher-priority location
 6:  7f34835f6e =  6:  7f2149738a zsh: resolve symlink of script
 7:  b2c9c92c5e =  7:  8af77967ed zsh: simplify realpath dirname idiom
 -:  ---------- >  8:  aeb19ab24c test: completion: use global config
 3:  28fd5901d7 !  9:  152eca2b34 completion: fix __git_cmd_idx regression for zsh
    @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
      	cur=${words[CURRENT]}
      	prev=${words[CURRENT-1]}
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_failure 'options with value' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_failure 'options with value' '
      	EOF
      '
      
 8:  5496fc8ad2 <  -:  ---------- test: reset environment variables
 9:  a70c96e720 <  -:  ---------- completion: prompt: use generic colors
10:  3d949c4ef4 ! 10:  efe2d76308 completion: fix for suboptions with value
    @@ contrib/completion/git-completion.zsh: __gitcomp ()
      	--no-*)
      		local c IFS=$' \t\n'
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - expand/narrow all negative options' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp - expand/narrow all negative options' '
      	EOF
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - expand/narrow all ne
      	test_gitcomp "--option=" "--option=" <<-\EOF &&
      
      	EOF
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'git clone --config= - value' '
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'git clone --config= - value' '
      	EOF
      '
      
11:  39a5e432e8 = 11:  66abcf711f completion: zsh: trivial improvement
12:  d757c1e649 ! 12:  559f5daf27 completion: bash: do not modify COMP_WORDBREAKS
    @@ Commit message
     
      ## contrib/completion/git-completion.bash ##
     @@
    - #     When set to "1" suggest all options, including options which are
    - #     typically hidden (e.g. '--allow-empty' for 'git commit').
    + #     case insensitively, even on systems with case sensitive file systems
    + #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
      
     -case "$COMP_WORDBREAKS" in
     -*:*) : great ;;
13:  06f0430106 ! 13:  dbb1a7410e test: completion: fix currently typed words
    @@ t/t9902-completion.sh: test_expect_success '__gitcomp - prefix' '
      	branch.master.Z
      	branch.maint.Z
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - option parameter' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp - option parameter' '
      '
      
      test_expect_failure '__gitcomp - prefix' '
    @@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - option parameter' '
      		"branch.maint." "me" <<-\EOF
      	branch.maint.merge Z
      	branch.maint.mergeoptions Z
    -@@ t/t9904-zsh-completion.sh: test_expect_failure '__gitcomp - prefix' '
    +@@ t/t9904-completion-zsh.sh: test_expect_failure '__gitcomp - prefix' '
      '
      
      test_expect_failure '__gitcomp - suffix' '
14:  a6f4da3602 ! 14:  2f2c240ac1 test: completion: switch __gitcomp_nl prefix test
    @@ t/t9902-completion.sh: test_expect_success '__gitcomp_nl - trailing space' '
      '
      
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp_nl - trailing space' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp_nl - trailing space' '
      	EOF
      '
      
15:  4e11ca5f72 = 15:  c21c389bb7 test: completion: add run_func() helper
16:  6baf13d85f = 16:  ea93b6cdec completion: bash: remove non-append functionality
17:  2a8298ba7d = 17:  567046e66b completion: bash: get rid of _append() functions
18:  2b6225049f = 18:  1500142923 completion: bash: get rid of any non-append code
19:  dd5e794315 = 19:  655fac83e5 completion: zsh: fix options with arguments
20:  b88875e756 = 20:  9a7591b665 completion: zsh: expand --git-dir file argument
21:  045f42c461 ! 21:  58f8143817 completion: zsh: add support for general -C opts
    @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
      
      		words=( git ${words[@]} )
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'checkout completes ref names' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'checkout completes ref names' '
      	EOF
      '
      
22:  2c69a0d2af ! 22:  3b424c7b78 completion: zsh: fix for undefined completions
    @@ contrib/completion/git-completion.zsh: __git_complete_command ()
      		return 1
      	fi
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
      	EOF
      '
      
23:  40c6608ce6 ! 23:  1c6eddb71e completion: zsh: add support for general -c opts
    @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
      		local command="${words[1]}" __git_dir __git_cmd_idx=1
      
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'git config - value' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'git config - value' '
      	EOF
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success 'git config - value' '
      	test_completion "git -c br" <<-\EOF
      	branch.Z
      	browser.Z
    -@@ t/t9904-zsh-completion.sh: test_expect_failure 'git -c - variable name' '
    +@@ t/t9904-completion-zsh.sh: test_expect_failure 'git -c - variable name' '
      	EOF
      '
      
24:  da05523a98 ! 24:  5ab47aa5e2 completion: zsh: fix extra space on foo=
    @@ contrib/completion/git-completion.zsh: __gitcomp ()
      			esac
      			array+=("$c")
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'git -c - section' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'git -c - section' '
      	EOF
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success 'git -c - section' '
      	test_completion "git -c log.d" <<-\EOF
      	log.date=Z
      	log.decorate=Z
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'git clone --config= - section' '
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'git clone --config= - section' '
      	EOF
      '
      
25:  92720f3b4e ! 25:  8d25832207 completion: zsh: add excluded options
    @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
      		'--namespace=[set the git namespace]:' \
      		'--no-replace-objects[do not use replacement refs to replace git objects]' \
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'general options' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'general options' '
      	test_completion "git --no-r" "--no-replace-objects"
      '
      
26:  a4b22cfc5e = 26:  1ef670094b completion: zsh: always set compset
27:  4246b2dd11 = 27:  f2a9a5cf50 completion: factor out check in __gitcomp
28:  549bdf25c8 = 28:  a57311923f completion: simplify equal suffix check
29:  f2dde0eafc = 29:  48be9110f4 completion: refactor __gitcomp
30:  98ed73aec8 = 30:  beb47c2caa completion: simplify __gitcomp
31:  8b53745ef8 = 31:  f2e7c92b0b completion: bash: change suffix check in __gitcomp
32:  b3ca49a9ee = 32:  ec1e4d358d completion: improve __gitcomp suffix code
33:  24b974a7d6 ! 33:  3417863c0f test: completion: add missing test
    @@ t/t9902-completion.sh: test_expect_success 'git config - value' '
      	test_completion "git -c br" <<-\EOF
      	branch.Z
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'git config - value' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'git config - value' '
      	EOF
      '
      
34:  d2a5c05e2b = 34:  4066b8e02a completion: bash: simplify config_variable_name
35:  8c0220b07f = 35:  2efe630d2d completion: bash: improve __gitcomp description
36:  6aaa7f3b5a ! 36:  688046c606 completion: add __gitcomp_opts
    @@ t/t9902-completion.sh: test_expect_success '__gitcomp - ignore optional negative
      
      read -r -d "" refs <<-\EOF
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_completion ()
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_completion ()
      	test_cmp expected out_sorted
      }
      
    @@ t/t9904-zsh-completion.sh: test_completion ()
      	test_cmp expected out
      }
      
    -@@ t/t9904-zsh-completion.sh: test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
    +@@ t/t9904-completion-zsh.sh: test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
      	git init -b main otherrepo
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success 'setup for __git_find_repo_path/_
      		--reset-author" <<-EOF
      	--reuse-message=Z
      	--reedit-message=Z
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - trailing space - options' '
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp - trailing space - options' '
      	EOF
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - trailing space - opt
      		branch.autosetuprebase browser." <<-\EOF
      	branch.Z
      	branch.autosetupmerge Z
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - trailing space - config keys' '
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp - trailing space - config keys' '
      	EOF
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - trailing space - con
      	--abc Z
      	--def Z
      	--no-one Z
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp - ignore optional negative options' '
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp - ignore optional negative options' '
      	EOF
      '
      
37:  d512f5ebc2 = 37:  d74e8977cd completion: bash: cleanup __gitcomp* invocations
38:  b38b1f6e29 ! 38:  3d8e5655d0 completion: bash: shuffle __gitcomp functions
    @@ Commit message
     
      ## contrib/completion/git-completion.bash ##
     @@
    - #     When set to "1" suggest all options, including options which are
    - #     typically hidden (e.g. '--allow-empty' for 'git commit').
    + #     case insensitively, even on systems with case sensitive file systems
    + #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
      
     +# The following functions are meant to modify COMPREPLY, which should not be
     +# modified directly.  The purpose is to localize the modifications so it's
39:  86ca702ada = 39:  4164cb3b6e completion: zsh: simplify __gitcomp_direct
40:  a5c7949d3f = 40:  866fa2ff1b completion: zsh: shuffle __gitcomp* functions
41:  dcdc3b3626 = 41:  1243854e0d completion: zsh: fix direct quoting
42:  1343263c53 ! 42:  a80b970a46 completion: zsh: add elements individually in __gitcomp_opts
    @@ contrib/completion/git-completion.zsh: __gitcomp_opts ()
      
      __gitcomp_nl ()
     
    - ## t/t9904-zsh-completion.sh ##
    -@@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp_opts - option parameter' '
    + ## t/t9904-completion-zsh.sh ##
    +@@ t/t9904-completion-zsh.sh: test_expect_success '__gitcomp_opts - option parameter' '
      	EOF
      '
      
    @@ t/t9904-zsh-completion.sh: test_expect_success '__gitcomp_opts - option paramete
      	test_gitcomp_opts "branch.maint.me" "remote merge mergeoptions rebase" \
      		"branch.maint." "me" <<-\EOF
      	branch.maint.merge Z
    -@@ t/t9904-zsh-completion.sh: test_expect_failure '__gitcomp_opts - prefix' '
    +@@ t/t9904-completion-zsh.sh: test_expect_failure '__gitcomp_opts - prefix' '
      	EOF
      '
      
43:  5c3621f224 = 43:  66c429c075 completion: zsh: add __gitcompadd helper
44:  7aaaf8f8ed = 44:  22ab31138d completion: zsh: add correct removable suffix
45:  1ac27ad13d = 45:  290b7e753b completion: bash: simplify _get_comp_words_by_ref()
46:  3b32bfe16b = 46:  4d0de6230c completion: bash: refactor _get_comp_words_by_ref()
47:  32b36425ea = 47:  46b5530d25 completion: bash: cleanup _get_comp_words_by_ref()
48:  35cbf711e8 = 48:  039a43b994 completion: bash: trivial cleanup
49:  3a005ae3c4 = 49:  d33a04e5fd completion: bash: rename _get_comp_words_by_ref()
-- 
2.33.0

