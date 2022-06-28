Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0CFC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbiF1KGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242105AbiF1KGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60722506
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i1so12415345wrb.11
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZDVSNuccYt8S+Mmbfw2mqIKjrBfygBNISJ58Mv9308=;
        b=H3h9XkWyNfo1tnEtCM7Ddy1to12k6dy9keqeW7DHx/c00Xpwu30tIAghnYHO7O7qrY
         6cPttb/F8LRlQO1tUcs8+Eby4Gw1a/EsCHM3/vMyoySQWYmHoKyFyhh3r4FTHcHIy7ht
         6BnbYiDTe/IjYg+67jGMVH0HbvC/OPUSXMHzstFS3ica/San3cXPudI3gwmZY3KYbpTR
         1DEAkYwjWchLK4H+NhhepKGcXwdgftnDiREk99qyU8+7j61vyHwVOnYb80ZZF7o6khW4
         rH6iIvnIvx0nfhpYLcI8bQFQ35Hr1gkQGXVYtBpIAXa0SBpS10vdXG4dS4lY4CWMfDb6
         vFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZDVSNuccYt8S+Mmbfw2mqIKjrBfygBNISJ58Mv9308=;
        b=a0issE6h9ktkjK2+92RgA+75Oe8uSpOdHN1HiTT1hvCToiysC2Tct5sBTQTtuQ0g0D
         pyD5313SQrzZrjSoUMjcLKkLbU3VOhUjEFF3/OEAzoWLLhBRy347fbhQfsfN/y2/uuPY
         m2Al/sgwbs36P2b0+4fggcOucBz2u2xVHtsETkVvxLlP+ZcDOr0lEYgWRSMeCpTtmvqj
         vnYaO6ok9dNsJjTaEBKlQv20FbemGXlWyGUZl4FoB8cxC5/xXkVASqozPdIpsh/vFK/h
         pU6KBoxytjzol5MGvzB1crYN0bmftTdxF1WJNcEmyvlnyW01TtvyP108RTycMyzQ5/O/
         tjDQ==
X-Gm-Message-State: AJIora/DhxoI9pWVVlHRzeKlhmEQ906aK15xZNYEU4C/FjkRYDejEvR5
        K0pNMUIsOG1prJwwExO+5FB8l5HrtXY=
X-Google-Smtp-Source: AGRyM1uC/JNUJSws1r5rmeMOk8xG9EWNLnW7S5tc+o38cLeZEFQYdvJkWRPaibCTsIHTXkAYcyxrMw==
X-Received: by 2002:a05:6000:178d:b0:20f:e960:2f2 with SMTP id e13-20020a056000178d00b0020fe96002f2mr16305716wrg.569.1656410768224;
        Tue, 28 Jun 2022 03:06:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/12] submodule: make "git submodule--helper" behave like "git submodule"
Date:   Tue, 28 Jun 2022 12:05:22 +0200
Message-Id: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are preparatory changes to make "git submodule--helper"'s
behavior align with that of "git submodule". The next step after this
is to get rid of git-submodule.sh entirely, and make "git submodule" a
built-in.

The last two patches here are post-cleanup of related submodule code
that isn't strictly necessary, but good to do. Similarly this starts
with the removal of some dead code in the area.

The goal is to make these changes as small as possible, and as
obviously correct as possible. This will help to make the meaty
changes that follow easier to review.

Changes since v3:

 * Leave the --super-prefix changes aside for now. As discussed in the
   v3 follow-up, now we're only removing the unused $prefix variable.

   Since the v2 was submitted Glen's submitted a series of his own. I
   think any non-trivial updates to --super-prefix are better done
   there, as noted in:
   https://lore.kernel.org/git/220628.86wnd1f9t1.gmgdl@evledraar.gmail.com/

   The overall diffstat is much smaller as a result, and I think this
   series should be ready for "next" now, as the remaining changes are
   well-revieweda at this point, with no outstanding issues.

Glen Choo (1):
  submodule--helper: eliminate internal "--update" option

Ævar Arnfjörð Bjarmason (11):
  git-submodule.sh: remove unused sanitize_submodule_env()
  git-submodule.sh: remove unused $prefix variable
  git-submodule.sh: make the "$cached" variable a boolean
  git-submodule.sh: remove unused top-level "--branch" argument
  submodule--helper: have --require-init imply --init
  submodule update: remove "-v" option
  submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
  submodule--helper: report "submodule" as our name in some "-h" output
  submodule--helper: understand --checkout, --merge and --rebase
    synonyms
  git-submodule.sh: use "$quiet", not "$GIT_QUIET"
  git-sh-setup.sh: remove "say" function, change last users

 builtin/submodule--helper.c    | 74 ++++++++++++++++++----------
 contrib/subtree/git-subtree.sh | 15 ++++--
 git-instaweb.sh                |  2 +-
 git-sh-setup.sh                | 16 -------
 git-submodule.sh               | 88 ++++++++++++----------------------
 submodule.c                    |  2 +-
 t/t7406-submodule-update.sh    |  2 +-
 7 files changed, 96 insertions(+), 103 deletions(-)

Range-diff against v3:
 1:  ed487469d62 =  1:  63150b4091c git-submodule.sh: remove unused sanitize_submodule_env()
 2:  082e015781e !  2:  7bf62497c54 git-submodule.sh: remove unused $prefix var and --super-prefix
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git-submodule.sh: remove unused $prefix var and --super-prefix
    +    git-submodule.sh: remove unused $prefix variable
     
         Remove the $prefix variable which isn't used anymore, and hasn't been
         since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
    @@ Commit message
         "--recursive-prefix" option, but since b3c5f5cb048 that "git
         submodule--helper" option is only used when it invokes itself.
     
    -    Since we haven't used it since then we haven't been passing the
    -    --super-prefix option to "git submodule--helper", and can therefore
    -    remove the handling of it from builtin/submodule--helper.c as well.
    -
    -    Note also that the still-existing code in builtin/submodule--helper.c
    -    to invoke other "git submodule--helper" processes with
    -    "--super-prefix" is not passing the option to
    -    "cmd_submodule__helper()", rather it's an argument to "git" itself.
    -
    -    One way to verify that this is indeed dead code is to try to check out
    -    b3c5f5cb048^ and apply this change to a part of the code being removed
    -    here:
    -
    -            -#define SUPPORT_SUPER_PREFIX (1<<0)
    -            +#define SUPPORT_SUPER_PREFIX 0
    -
    -    Doing that will cause t7406-submodule-update.sh to fail with errors
    -    such as:
    -
    -            -Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa739807ce3521'
    -            +Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa739807ce3521'
    -
    -    I.e. the removal of the --super-prefix handling broke those cases, but
    -    when doing the same ad-hoc test with b3c5f5cb048 all of our tests will
    -    pass, since the "--super-prefix" will now be handled by earlier by
    -    "git" itself.
    -
    -    So this is just one of the things that were overly complex in "git
    -    submodule--helper", because parts of it had to bridge the gap between
    -    *.sh and *.c land, but once we moved more parts to C we ended up
    -    getting that for free.
    +    So the "--recursive-prefix" option is still in use, but at this point
    +    only when the helper invokes itself during submodule recursion. See
    +    the "--recursive-prefix" option added in
    +    c51f8f94e5b (submodule--helper: run update procedures from C,
    +    2021-08-24).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    - 	return 0;
    - }
    - 
    --#define SUPPORT_SUPER_PREFIX (1<<0)
    --
    - struct cmd_struct {
    - 	const char *cmd;
    - 	int (*fn)(int, const char **, const char *);
    --	unsigned option;
    - };
    - 
    - static struct cmd_struct commands[] = {
    --	{"list", module_list, 0},
    --	{"name", module_name, 0},
    --	{"clone", module_clone, 0},
    --	{"add", module_add, SUPPORT_SUPER_PREFIX},
    --	{"update", module_update, 0},
    --	{"resolve-relative-url-test", resolve_relative_url_test, 0},
    --	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
    --	{"init", module_init, SUPPORT_SUPER_PREFIX},
    --	{"status", module_status, SUPPORT_SUPER_PREFIX},
    --	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
    --	{"deinit", module_deinit, 0},
    --	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
    --	{"push-check", push_check, 0},
    --	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
    --	{"is-active", is_active, 0},
    --	{"check-name", check_name, 0},
    --	{"config", module_config, 0},
    --	{"set-url", module_set_url, 0},
    --	{"set-branch", module_set_branch, 0},
    --	{"create-branch", module_create_branch, 0},
    -+	{"list", module_list},
    -+	{"name", module_name},
    -+	{"clone", module_clone},
    -+	{"add", module_add},
    -+	{"update", module_update},
    -+	{"resolve-relative-url-test", resolve_relative_url_test},
    -+	{"foreach", module_foreach},
    -+	{"init", module_init},
    -+	{"status", module_status},
    -+	{"sync", module_sync},
    -+	{"deinit", module_deinit},
    -+	{"summary", module_summary},
    -+	{"push-check", push_check},
    -+	{"absorb-git-dirs", absorb_git_dirs},
    -+	{"is-active", is_active},
    -+	{"check-name", check_name},
    -+	{"config", module_config},
    -+	{"set-url", module_set_url},
    -+	{"set-branch", module_set_branch},
    -+	{"create-branch", module_create_branch},
    - };
    - 
    - int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
    -@@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
    - 	if (argc < 2 || !strcmp(argv[1], "-h"))
    - 		usage("git submodule--helper <command>");
    - 
    --	for (i = 0; i < ARRAY_SIZE(commands); i++) {
    --		if (!strcmp(argv[1], commands[i].cmd)) {
    --			if (get_super_prefix() &&
    --			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
    --				die(_("%s doesn't support --super-prefix"),
    --				    commands[i].cmd);
    -+	for (i = 0; i < ARRAY_SIZE(commands); i++)
    -+		if (!strcmp(argv[1], commands[i].cmd))
    - 			return commands[i].fn(argc - 1, argv + 1, prefix);
    --		}
    --	}
    - 
    - 	die(_("'%s' is not a valid submodule--helper "
    - 	      "subcommand"), argv[1]);
    -
      ## git-submodule.sh ##
     @@ git-submodule.sh: files=
      remote=
 3:  3948aa5d782 =  3:  e4750f190f8 git-submodule.sh: make the "$cached" variable a boolean
 4:  b5967afd59f =  4:  52d97fd4c36 git-submodule.sh: remove unused top-level "--branch" argument
 5:  64e4aa41d21 =  5:  a4632f00a4a submodule--helper: have --require-init imply --init
 6:  b82faad77bb =  6:  ad5aad8fed7 submodule update: remove "-v" option
 7:  ff557f3c81a !  7:  9c8a102acc0 submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
    @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **a
      	};
      
     @@ builtin/submodule--helper.c: static struct cmd_struct commands[] = {
    - 	{"deinit", module_deinit},
    - 	{"summary", module_summary},
    - 	{"push-check", push_check},
    --	{"absorb-git-dirs", absorb_git_dirs},
    -+	{"absorbgitdirs", absorb_git_dirs},
    - 	{"is-active", is_active},
    - 	{"check-name", check_name},
    - 	{"config", module_config},
    + 	{"deinit", module_deinit, 0},
    + 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
    + 	{"push-check", push_check, 0},
    +-	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
    ++	{"absorbgitdirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
    + 	{"is-active", is_active, 0},
    + 	{"check-name", check_name, 0},
    + 	{"config", module_config, 0},
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_sync()
 8:  bb1310b9abe =  8:  b8a9b085633 submodule--helper: report "submodule" as our name in some "-h" output
 9:  e251fc115e1 =  9:  e8ddb95dcbf submodule--helper: understand --checkout, --merge and --rebase synonyms
10:  66a229227a1 = 10:  abb5cb499aa submodule--helper: eliminate internal "--update" option
11:  f8219cd461d = 11:  c7eac40a0f2 git-submodule.sh: use "$quiet", not "$GIT_QUIET"
12:  ecdd8c6ed28 = 12:  f8f332f3c0a git-sh-setup.sh: remove "say" function, change last users
-- 
2.37.0.880.gf07d56b18ba

