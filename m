Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34215C433DF
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B4B20735
	for <git@archiver.kernel.org>; Sun, 17 May 2020 06:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3vTE6ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgEQGa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 02:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgEQGa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 02:30:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9811C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m185so1876856wme.3
        for <git@vger.kernel.org>; Sat, 16 May 2020 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i1Rk9uUmI7jm90U/Ptj6i3sbrGIlaJvE6un3dIzYmns=;
        b=m3vTE6ZYzIB7NveCbgziYzmxqEmLlwhQGClGAL1eyhn6bYiFfbnqKLu+gjn+XcQhe+
         trFAaarmhWtfJaoBRek+yw87pkQm4g7RsasgzXvevPOSrB+OXsgWf5VmBfhikoYutzO+
         2BH7CEbpb+7o1GyHVjIsOcU+zdTT5FTO9KPLK8QmfghXP1lX6WgrkrKkXF36H3o69yan
         6hlc9nigSQmD/J8a7THXnF4hJQ94PS8IICG9+yedZZxRtO1rYJhseOAVePwSCLAvafTs
         uRoHyIS8WmXCfhd4BCMRpEbUZyeEDW99HmZtN4AZed/2NUpdsGQn6SpYkUzW3OeNjYMG
         01fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i1Rk9uUmI7jm90U/Ptj6i3sbrGIlaJvE6un3dIzYmns=;
        b=syUkDiN/LipuInLm08CqaQyjB3sXhFR8hzWQu3RYvoqOkIVFEuHYTQ4hnBzcNsi82o
         b+TFvD8+Awd1lkh2seBGtQq1neX6ZE0DJM1Go7Tkc8uTsCVpT5SgloXFsU5PXB0fsDFY
         567cC1OFETMsImdenilvhhvK/WuroiG37RzjHxRV2cPRwxEzg13VvCy6ofUsWDbvvu1i
         Kcm8f62x6UEvFePxZ41ieukwRP+JfDH8UyAQYsR7CPQAZyX3nGh7uk6efKvz9CJdzuPt
         ndAbJdUG8c9KN3pLn0n4ylZdMsxFxgB5pjSrug27KUww9Zy5AB2+IWhh4/Hez6ZzFfep
         A2Qw==
X-Gm-Message-State: AOAM530cXGNs0YieoL9qmFWb2fIUItxOANbR+C3D050eXJ/4sKRTbebz
        jZR5YVMkZ/UMik1fjmgtseD0Xbww
X-Google-Smtp-Source: ABdhPJzm1OkfkgwqX2zNGv24I/351bZhmBtwf0VuFP8p7jq1TzkKE9d+oHxGTcvPZ9t3g1bV4YBLVw==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr12149668wme.2.1589697025100;
        Sat, 16 May 2020 23:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a74sm4894791wme.23.2020.05.16.23.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 23:30:24 -0700 (PDT)
Message-Id: <pull.631.v2.git.1589697023.gitgitgadget@gmail.com>
In-Reply-To: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
From:   "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 May 2020 06:30:20 +0000
Subject: [PATCH v2 0/3] submodule--helper.c: add only-active to foreach
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Guillaume G." <guillaume.galeazzi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On repository with multiple submodules, one may need to run a command based
on submodule trait.

This changes add flags to submodule--helper foreachto fulfill this need by:

Adding the flag --[no-]active to filter submodule based on the active state.
Adding the flag --[no-]populated to filter submodule based on the fact that
it is populated or not. Adding the flag -b|--branch <branch> to filter
submodule based on the tracking branch.

Signed-off-by: Guillaume Galeazzi guillaume.galeazzi@gmail.com
[guillaume.galeazzi@gmail.com]

Guillaume Galeazzi (3):
  submodule--helper.c: add active to foreach
  submodule--helper.c: add populated to foreach
  submodule--helper.c: add branch to foreach

 builtin/submodule--helper.c  | 60 ++++++++++++++++++++++++++++++------
 t/t7407-submodule-foreach.sh | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 10 deletions(-)


base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-631%2Fgzzi%2Fsubmodule-only-active-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-631/gzzi/submodule-only-active-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/631

Range-diff vs v1:

 1:  77bb291af5d ! 1:  90defeb5a75 submodule--helper.c: add only-active to foreach
     @@ Metadata
      Author: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
      
       ## Commit message ##
     -    submodule--helper.c: add only-active to foreach
     -
     -    On repository with some submodule not active, it could be needed to run
     -    a command only for active submodule. Today it can be achived with the
     -    command:
     +    submodule--helper.c: add active to foreach
      
     +    On a repository with some submodules not active, one may need to run a
     +    command only for an active submodule or vice-versa. To achieve this,
     +    one may use:
          git submodule foreach 'git -C $toplevel submodule--helper is-active \
          $sm_path && pwd || :'
      
     -    Goal of this change is to make it more accessible by adding the flag
     -    --only-active to the submodule--helper command. Previous example
     -    become:
     -
     -    git submodule--helper foreach --only-active pwd
     +    Simplify this expression to make it more readable and easy-to-use by
     +    adding the flat `--[no-]active` to subcommand `foreach` of `git
     +    submodule`. Thus, simplifying the above command to:
     +    git submodule--helper foreach --active pwd
      
          Signed-off-by: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
      
     @@ builtin/submodule--helper.c: struct foreach_cb {
       	const char *prefix;
       	int quiet;
       	int recursive;
     -+	int only_active;
     ++	int active_only;
       };
     - #define FOREACH_CB_INIT { 0 }
     +-#define FOREACH_CB_INIT { 0 }
     + 
     +-static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
     +-				       void *cb_data)
     ++#define FOREACH_BOOL_FILTER_NOT_SET -1
     ++
     ++#define FOREACH_CB_INIT { .active_only=FOREACH_BOOL_FILTER_NOT_SET }
     ++
     ++static void runcommand_in_submodule(const struct cache_entry *list_item,
     ++				    struct foreach_cb *info)
     + {
     +-	struct foreach_cb *info = cb_data;
     + 	const char *path = list_item->name;
     + 	const struct object_id *ce_oid = &list_item->oid;
       
      @@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
     - 	struct child_process cp = CHILD_PROCESS_INIT;
     - 	char *displaypath;
     + 	free(displaypath);
     + }
       
     -+	if (info->only_active && !is_submodule_active(the_repository, path))
     -+		return;
     ++static void runcommand_in_submodule_filtered_cb(const struct cache_entry *list_item,
     ++						void *cb_data)
     ++{
     ++	const char *path = list_item->name;
     ++	struct foreach_cb *info = cb_data;
     ++	int is_active;
      +
     - 	displaypath = get_submodule_displaypath(path, info->prefix);
     - 
     - 	sub = submodule_from_path(the_repository, &null_oid, path);
     ++	if (info->active_only != FOREACH_BOOL_FILTER_NOT_SET) {
     ++		is_active = is_submodule_active(the_repository, path);
     ++		if (is_active != info->active_only)
     ++			return;
     ++	}
     ++
     ++	runcommand_in_submodule(list_item, info);
     ++}
     ++
     + static int module_foreach(int argc, const char **argv, const char *prefix)
     + {
     + 	struct foreach_cb info = FOREACH_CB_INIT;
      @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
       		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
       		OPT_BOOL(0, "recursive", &info.recursive,
       			 N_("Recurse into nested submodules")),
     -+		OPT_BOOL(0, "only-active", &info.only_active,
     -+			 N_("Call command only for active submodules")),
     ++		OPT_BOOL(0, "active", &info.active_only,
     ++			 N_("Call command depending on submodule active state")),
       		OPT_END()
       	};
       
       	const char *const git_submodule_helper_usage[] = {
      -		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
     -+		N_("git submodule--helper foreach [--quiet] [--recursive] [--only-active] [--] <command>"),
     ++		N_("git submodule--helper foreach [--quiet] [--recursive] [--[no-]active] [--] <command>"),
       		NULL
       	};
       
     +@@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
     + 	info.argv = argv;
     + 	info.prefix = prefix;
     + 
     +-	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
     ++	for_each_listed_submodule(&list, runcommand_in_submodule_filtered_cb, &info);
     + 
     + 	return 0;
     + }
      
       ## t/t7407-submodule-foreach.sh ##
      @@ t/t7407-submodule-foreach.sh: test_expect_success 'test basic "submodule foreach" usage' '
       	test_i18ncmp expect actual
       '
       
     -+sub3sha1=$(cd super/sub3 && git rev-parse HEAD)
      +cat > expect <<EOF
      +Entering 'sub3'
      +$pwd/clone-foo3-sub3-$sub3sha1
      +EOF
      +
     -+test_expect_success 'test "submodule--helper foreach --only-active" usage' '
     ++test_expect_success 'test "submodule--helper foreach --active" usage' '
     ++	test_when_finished "git -C clone config --unset submodule.foo1.active" &&
     ++	(
     ++		cd clone &&
     ++		git config --bool submodule.foo1.active "false" &&
     ++		git submodule--helper foreach --active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
     ++	) &&
     ++	test_i18ncmp expect actual
     ++'
     ++
     ++cat > expect <<EOF
     ++Entering 'sub1'
     ++$pwd/clone-foo1-sub1-$sub1sha1
     ++EOF
     ++
     ++test_expect_success 'test "submodule--helper foreach --no-active" usage' '
      +	test_when_finished "git -C clone config --unset submodule.foo1.active" &&
      +	(
      +		cd clone &&
      +		git config --bool submodule.foo1.active "false" &&
     -+		git submodule--helper foreach --only-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
     ++		git submodule--helper foreach --no-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
      +	) &&
      +	test_i18ncmp expect actual
      +'
 -:  ----------- > 2:  f9cbdcdeacf submodule--helper.c: add populated to foreach
 -:  ----------- > 3:  65504cb780a submodule--helper.c: add branch to foreach

-- 
gitgitgadget
