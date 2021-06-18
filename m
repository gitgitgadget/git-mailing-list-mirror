Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205FC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E973611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhFRS1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFRS1b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BDFC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so10581413otu.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1RtAN6/Ziy1RdFdt92qnUFsXUmlfr5Cb0NKYVYd8+ko=;
        b=qBMrH9qbRMOHHPbL7zkLF2zODyu2pxwbEIyDtBYEEtHJT8eMnaiSOJ0IKuy0PWEwqk
         jASt/g9veX2OQwLBG9/BsSZ3VUwZNC6UK8pGxd/1jRzgjgaUPCr8MlMvX6jGLeUS7OG3
         chWIAtrPJS08V1oeYwGZq2qEjFJUkYrNqdAqQgbnFNDgBqLKw/T9bJ+L2hoKeqbcGQPG
         5LSQfluQ9JjSfn2peiwrAqlpDoESRbmuEwNgtwM7sr1wdO8U/ZMHwV2Pj9FGUjgdh6yo
         o4PzIRElU7fZcAhUMC5sr4wltzxh5DWURTu6oO8NTFFjwepE3zpi+dKAivbDo5w1aWaj
         SA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1RtAN6/Ziy1RdFdt92qnUFsXUmlfr5Cb0NKYVYd8+ko=;
        b=LDaUcDUYn75pQChj+GZtDrzVs9bVrwLFcZ+SyEfaMAYo8dxAPJjyXTW3+aNa4bOhtf
         NMR2SGR3GO6XFWuKFibh/zeLAWRZQCt3jFds/bW76twmJntB5xfJuzAWfvNV5rm4XHBU
         5krMRVgpVBpaYbslSfQDydcvBOrGkSwm1FfQKgl9lpJqMBPg2IxdsK+TIzPnPGNPRsWu
         vXqkiNwicuA7eyfoqdfaP0TqPlZWufvFbL9vHpQlnCHGj0J+bBTKujPR5RC0/pnuvebu
         4Tcd5NuVoDXowg6J/NEgGsGGO0f+5eU4QtSrmb+ddm2nULqqkXoah+4gE9rrif2oi2er
         UMrg==
X-Gm-Message-State: AOAM53332bSbtoRIWu/x8qaPXzmiAs5tYKup+FLjcgYly46CYQhlLE84
        V0mDmoHov6SOh3TyRntym1mxMZfW0WBWCw==
X-Google-Smtp-Source: ABdhPJwG7HStWi+NvOWoBhRATlt1Zd69BNKQuuPrmM2y3PdOuKhpXt5YdhFMFdamZRxOdsSRGHiyRA==
X-Received: by 2002:a05:6830:1ac6:: with SMTP id r6mr10795545otc.198.1624040720169;
        Fri, 18 Jun 2021 11:25:20 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l5sm1974123otq.46.2021.06.18.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/45] completion: git-completion 1.3.3 patches
Date:   Fri, 18 Jun 2021 13:24:33 -0500
Message-Id: <20210618182518.697912-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

completion: git-completion 1.3.1 patches

These patches represent what comprises git-completion 1.3.1, a friendly
fork I'm maintaining.

Some of these have already been sent, and should be in "seen", but for
some reason they are not [1]. Others have been sent, but probably won't
receive any review soon.

Since the patches for git-completion 1.3.0 the only differece is a
rebase on top of v2.31.0.

Cheers.

[1] https://lore.kernel.org/git/5fea87e816fff_23821208d4@natae.notmuch/

Felipe Contreras (45):
  completion: fix __git_cmd_idx regression
  completion: bash: fix prefix detection in branch.*
  completion: fix for suboptions with value
  completion: bash: fix for multiple dash commands
  completion: bash: add correct suffix in variables
  completion: zsh: add higher-priority location
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
  completion: bash: simplify config_variable_name
  test: completion: add missing test
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

 contrib/completion/git-completion.bash | 642 +++++++++++--------------
 contrib/completion/git-completion.zsh  | 141 +++---
 t/t9902-completion.sh                  | 159 +++---
 3 files changed, 435 insertions(+), 507 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  68e7376872 completion: fix __git_cmd_idx regression
 1:  f318584861 =  2:  f942d5884a completion: bash: fix prefix detection in branch.*
 2:  ce536d6e53 =  3:  c073c68d77 completion: fix for suboptions with value
 3:  50a4e412d3 =  4:  60596a5f3a completion: bash: fix for multiple dash commands
 4:  bf7dfb35d1 =  5:  40f67ea5fd completion: bash: add correct suffix in variables
43:  8f1399c468 =  6:  20c22f5337 completion: zsh: add higher-priority location
 -:  ---------- >  7:  120a675092 completion: zsh: trivial improvement
 5:  6338c510b4 =  8:  c58f5f8649 completion: bash: do not modify COMP_WORDBREAKS
 6:  ab79e84b26 =  9:  46bfd0d7ca test: completion: fix currently typed words
 7:  da3b5837df = 10:  4f44215d5e test: completion: switch __gitcomp_nl prefix test
 8:  1f2278ea0f ! 11:  99954f41d4 test: completion: add run_func() helper
    @@ t/t9902-completion.sh: test_path_completion ()
      	test_cmp expected out
      }
     @@ t/t9902-completion.sh: do
    - 		(
      			words=(git push '$flag' other ma) &&
      			cword=${#words[@]} cur=${words[cword-1]} &&
    + 			__git_cmd_idx=1 &&
     -			__git_complete_remote_or_refspec &&
     -			print_comp
     +			run_func __git_complete_remote_or_refspec
    @@ t/t9902-completion.sh: do
      		test_cmp expected out
      	'
     @@ t/t9902-completion.sh: do
    - 		(
      			words=(git push other '$flag' ma) &&
      			cword=${#words[@]} cur=${words[cword-1]} &&
    + 			__git_cmd_idx=1 &&
     -			__git_complete_remote_or_refspec &&
     -			print_comp
     +			run_func __git_complete_remote_or_refspec
 9:  106cbd3e72 = 12:  3e2ea37938 completion: bash: remove non-append functionality
10:  5145f47503 = 13:  d1162c8aa7 completion: bash: get rid of _append() functions
11:  1bf917c007 = 14:  ca88e56fa2 completion: bash: get rid of any non-append code
12:  ef1d6a3037 = 15:  54c3401eee completion: zsh: fix options with arguments
13:  b8d3bcb7a0 = 16:  3bca7df93a completion: zsh: expand --git-dir file argument
14:  89599ea5da ! 17:  2a3a5c3220 completion: zsh: add support for general -C opts
    @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
      {
      	local curcontext="$curcontext" state state_descr line
      	typeset -A opt_args
    --	local -a orig_words
    -+	local -a orig_words __git_C_args
    - 
    - 	orig_words=( ${words[@]} )
    ++	local -a __git_C_args
      
    + 	_arguments -C \
    + 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
     @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
      		'--namespace=[set the git namespace]:' \
      		'--no-replace-objects[do not use replacement refs to replace git objects]' \
    @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
     +
      		(( $+opt_args[--help] )) && command='help'
      
    - 		words=( ${orig_words[@]} )
    + 		words=( git ${words[@]} )
15:  ebc2bf8df1 = 18:  1bfe88f60c completion: zsh: fix for undefined completions
16:  4e2762f040 = 19:  ad75eccb20 completion: zsh: add support for general -c opts
17:  b856d42169 = 20:  d1587d19f7 completion: zsh: fix extra space on foo=
18:  d61682bc45 ! 21:  a18f9d962b completion: zsh: add excluded options
    @@ Commit message
     
      ## contrib/completion/git-completion.zsh ##
     @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
    - 	orig_words=( ${words[@]} )
    + 	local -a __git_C_args
      
      	_arguments -C \
     -		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
19:  07819100c1 = 22:  c824921fa5 completion: zsh: always set compset
20:  391372ddf7 = 23:  daf7bc19bb completion: factor out check in __gitcomp
21:  1fd7477427 = 24:  41a9cd3e8d completion: simplify equal suffix check
22:  fc7bcb5122 = 25:  dd47842d0d completion: refactor __gitcomp
23:  85b5e719c7 = 26:  674a7ca73b completion: simplify __gitcomp
24:  30124bf50f = 27:  f3f77bb5a6 completion: bash: change suffix check in __gitcomp
25:  70653f57c0 = 28:  81e518f5a7 completion: improve __gitcomp suffix code
26:  ae6bab5e4f = 29:  9b3242d412 completion: bash: simplify config_variable_name
27:  f67cc99935 = 30:  869fafc5a7 test: completion: add missing test
28:  17bc28a487 = 31:  7b1b05352f completion: bash: improve __gitcomp description
29:  69f6533ef8 ! 32:  282221f9b6 completion: add __gitcomp_opts
    @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
      		;;
      	*)
      		;;
    -@@ contrib/completion/git-completion.bash: _git_stash ()
    - 	if [ -z "$subcommand" ]; then
    - 		case "$cur" in
    - 		--*)
    --			__gitcomp "$save_opts"
    -+			__gitcomp_opts "$save_opts"
    - 			;;
    - 		sa*)
    - 			if [ -z "$(__git_find_on_cmdline "$save_opts")" ]; then
    -@@ contrib/completion/git-completion.bash: _git_stash ()
    - 	else
    - 		case "$subcommand,$cur" in
    - 		push,--*)
    --			__gitcomp "$save_opts --message"
    -+			__gitcomp_opts "$save_opts --message"
    - 			;;
    - 		save,--*)
    --			__gitcomp "$save_opts"
    -+			__gitcomp_opts "$save_opts"
    - 			;;
    - 		apply,--*|pop,--*)
    --			__gitcomp "--index --quiet"
    -+			__gitcomp_opts "--index --quiet"
    - 			;;
    - 		drop,--*)
    --			__gitcomp "--quiet"
    -+			__gitcomp_opts "--quiet"
    - 			;;
    - 		list,--*)
    --			__gitcomp "--name-status --oneline --patch-with-stat"
    -+			__gitcomp_opts "--name-status --oneline --patch-with-stat"
    - 			;;
    - 		show,--*)
    --			__gitcomp "$__git_diff_common_options"
    -+			__gitcomp_opts "$__git_diff_common_options"
    - 			;;
    - 		branch,--*)
    - 			;;
     @@ contrib/completion/git-completion.bash: _git_submodule ()
      	if [ -z "$subcommand" ]; then
      		case "$cur" in
    @@ contrib/completion/git-completion.bash: _git_svn ()
      		*)
      			;;
     @@ contrib/completion/git-completion.bash: __git_main ()
    - 			;;
      		esac
      		case "$cur" in
    --		--*)   __gitcomp "
    -+		--*)   __gitcomp_opts "
    + 		--*)
    +-			__gitcomp "
    ++			__gitcomp_opts "
      			--paginate
      			--no-pager
      			--git-dir=
30:  a1a9dbb915 = 33:  2d00a52d65 completion: bash: cleanup __gitcomp* invocations
31:  9c17b3d3af = 34:  c34a4e0f93 completion: bash: shuffle __gitcomp functions
32:  37f2c72c9e = 35:  12de564dae completion: zsh: simplify __gitcomp_direct
33:  57ef037e81 = 36:  5c8aa847da completion: zsh: shuffle __gitcomp* functions
34:  ecb79bc877 = 37:  b2e1bb7a02 completion: zsh: fix direct quoting
35:  ae49a7c597 = 38:  43c3374fb2 completion: zsh: add elements individually in __gitcomp_opts
36:  135f68ca27 = 39:  a1f335b841 completion: zsh: add __gitcompadd helper
37:  e4f8591b72 = 40:  1416f590a7 completion: zsh: add correct removable suffix
38:  49217d4aa3 = 41:  081982e432 completion: bash: simplify _get_comp_words_by_ref()
39:  ef00c6e76e = 42:  2bd0507a7a completion: bash: refactor _get_comp_words_by_ref()
40:  993d5c83ae = 43:  188c8749cc completion: bash: cleanup _get_comp_words_by_ref()
41:  8b13e46fd3 = 44:  e08dc59d07 completion: bash: trivial cleanup
42:  658b5cccc8 ! 45:  893c8527d6 completion: bash: rename _get_comp_words_by_ref()
    @@ contrib/completion/git-completion.bash: if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOU
     +
      __git_func_wrap ()
      {
    - 	local cur words cword prev
    + 	local cur words cword prev __git_cmd_idx=1
     -	_get_comp_words_by_ref -n =: cur words cword prev
     +	__git_get_comp_words_by_ref
      	$1
-- 
2.32.0

