Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18562ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiHaXPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiHaXOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A51F996E
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:44 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so376294wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s2dSzJMr+H4skDFC8kbSsZOy0AUd4k9CMnyOkNlB2iE=;
        b=PivKeshmdmtPMeouac4K1HeUbu5noEBUa2njro4GIwR6daOabH7cLa6o3JciV7+b5m
         mLBxDF7bscYKMuRu+5QffCgVVTn4HyHEWPoRSsIORrvtMqia5Fiv1kowgX06bjbdoGUC
         60T8idZbvWRh4Hs4MARdbJGy4U3oU0gu6OxUDmWTsshdvo8w/MFh2H4RGNU5KJEb4SYf
         RqGmE9SMVk5/s4VAbnNmNc3s31IuCrGIKIPG7dqphNXu50ZHh9IGPUL0DGpLu5/006Re
         VJTBM4iBnTuqP83IGU0lKPv7NFCKjVS92vpj9yrBLmaWsR1mvYBYUjxA7yvaYYSJjYqj
         2hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s2dSzJMr+H4skDFC8kbSsZOy0AUd4k9CMnyOkNlB2iE=;
        b=SHS8SKB+GznNZNAHSje+ZVI6PT6p2NnNSjwxh2ShV+gCXmSE7izVPIhjWPNitWQjKy
         tsxj5SM2lsg0VrM/prtxTW72buvCpx0//+MvFxeUpA3fOsJdxXvKMNjBf56M+hQYr+Vr
         SXLMjShKSyeT8LCO7sNIK6xlobsaMuINtmQA6FIRVu9PRybA1UD22v/giLmtH426swzB
         wKwbdImaYrv3lDttpuvGqXH4zb3hYzP8qF5zBU4kruqqAb2xDIdpf8OGUnewI2mTAn/r
         W/S92HZ7+H5tehV9YrEW67DIDufbE/B1wvWXzrGERzTzXSp0AQGrxgImiQWtYBZmJP6t
         uE/g==
X-Gm-Message-State: ACgBeo3rCeqSlph364u33aNMbK0WASmgjOgGLHSREJCcGBT7KpsvF6KR
        4ksEL52ECL+6EbBXrVB1HmTTZFAtcx03wg==
X-Google-Smtp-Source: AA6agR5c2/GmvGUK9zyCTXf04Mu5byZ7MroH6iYfWQdX+cqe8wB/y3J1JHJjhmY1XH80rmFYJv3byw==
X-Received: by 2002:a05:600c:4f09:b0:3a8:3d5f:371f with SMTP id l9-20020a05600c4f0900b003a83d5f371fmr3285360wmq.94.1661987682058;
        Wed, 31 Aug 2022 16:14:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 00/17] submodule--helper: fix memory leaks
Date:   Thu,  1 Sep 2022 01:14:07 +0200
Message-Id: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes all of the memory leaks in
builtin/submodule--helper.c that our test suite spots, except for
those where the leak is downstream of cmd_submodule__helper() and
caused by code that's not in builtin/submodule--helper.c (e.g. leaks
in the object or config APIs, and in submodule.c).

This re-roll is on top of the just-now re-rolled v4 of the base
topic[1].

Changes in v7:

 * Rebase on top of the base topic.
 * Clarify some questions on v6 in updated commit messages.
 * Go with Glen's suggested "displaypath" fix. I also tried another
   way which the commit discusses. The end result was better, but it
   requires further submodule--helper cleanups, and this is already
   quite an Odyssey. So FREE_AND_NULL() will do.

1. https://lore.kernel.org/git/cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com

This series & passing CI can be seen at:
https://github.com/avar/git/tree/avar/submodule--helper-memory-leaks-7

Ævar Arnfjörð Bjarmason (17):
  submodule--helper: fix a leak in "clone_submodule"
  submodule--helper: fix trivial get_default_remote_submodule() leak
  submodule--helper: fix most "struct pathspec" memory leaks
  submodule--helper: "struct pathspec" memory leak in module_update()
  submodule--helper: don't leak {run,capture}_command() cp.dir argument
  submodule--helper: add and use *_release() functions
  submodule--helper: fix "errmsg_str" memory leak
  submodule--helper: fix "sm_path" and other "module_cb_list" leaks
  submodule--helper: fix a leak with repo_clear()
  submodule--helper: fix a memory leak in get_default_remote_submodule()
  submodule--helper: fix "reference" leak
  submodule--helper: fix obscure leak in module_add()
  submodule--helper: fix a leak in module_add()
  submodule--helper: fix a memory leak in print_status()
  submodule--helper: free some "displaypath" in "struct update_data"
  submodule--helper: free rest of "displaypath" in "struct update_data"
  submodule--helper: fix a configure_added_submodule() leak

 builtin/submodule--helper.c        | 227 +++++++++++++++++++++--------
 t/t1500-rev-parse.sh               |   1 +
 t/t2403-worktree-move.sh           |   1 +
 t/t6008-rev-list-submodule.sh      |   1 +
 t/t6134-pathspec-in-submodule.sh   |   1 +
 t/t7401-submodule-summary.sh       |   1 +
 t/t7412-submodule-absorbgitdirs.sh |   1 +
 t/t7413-submodule-is-active.sh     |   1 +
 t/t7414-submodule-mistakes.sh      |   2 +
 t/t7419-submodule-set-branch.sh    |   1 +
 t/t7506-status-submodule.sh        |   1 +
 t/t7507-commit-verbose.sh          |   2 +
 12 files changed, 176 insertions(+), 64 deletions(-)

Range-diff against v6:
 1:  0f60ea6f7c6 =  1:  40d4aef60fa submodule--helper: fix a leak in "clone_submodule"
 2:  c14e00f39cb =  2:  104f0777d50 submodule--helper: fix trivial get_default_remote_submodule() leak
 3:  a2ecdb301d3 !  3:  3e1948ddc02 submodule--helper: fix most "struct pathspec" memory leaks
    @@ Commit message
         safe to call clear_pathspec(), we don't want the data to be
         uninitialized.
     
    +    E.g. for module_foreach() we can see from looking at
    +    module_list_compute() that if it returns non-zero that the "pathspec"
    +    will always have been initialized. But relying on that both assumes
    +    knowledge about parse_pathspec(), and would set up a fragile pattern
    +    going forward.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 4:  8fc3dad316e =  4:  505d7d5077e submodule--helper: "struct pathspec" memory leak in module_update()
 5:  a3886d36366 !  5:  41672ffa55c submodule--helper: don't leak {run,capture}_command() cp.dir argument
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int is_tip_reachable(const char *path, struct object_id *oid)
    +@@ builtin/submodule--helper.c: static int is_tip_reachable(const char *path, const struct object_id *oid)
      	char *hex = oid_to_hex(oid);
      
      	cp.git_cmd = 1;
    @@ builtin/submodule--helper.c: static int is_tip_reachable(const char *path, struc
      	cp.no_stderr = 1;
      	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
      
    -@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
    +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet,
      
      	prepare_submodule_repo_env(&cp.env);
      	cp.git_cmd = 1;
    @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
      
      	strvec_push(&cp.args, "fetch");
      	if (quiet)
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      	}
      	strvec_push(&cp.args, oid);
      
 6:  173dbb7d8fc =  6:  07a4cda579f submodule--helper: add and use *_release() functions
 7:  cd394814370 =  7:  600526e1301 submodule--helper: fix "errmsg_str" memory leak
 8:  2110b991913 =  8:  2c5db495189 submodule--helper: fix "sm_path" and other "module_cb_list" leaks
 9:  a0d1a03166f =  9:  71ebaac73c1 submodule--helper: fix a leak with repo_clear()
10:  84f162f320b = 10:  8a016f3d58c submodule--helper: fix a memory leak in get_default_remote_submodule()
11:  dc5e8504354 = 11:  6a4c22d07b9 submodule--helper: fix "reference" leak
12:  50d58bfb19b = 12:  b8654647601 submodule--helper: fix obscure leak in module_add()
13:  56590508180 = 13:  c922e04f3d1 submodule--helper: fix a leak in module_add()
14:  38ceb0a36ab = 14:  33babb1a165 submodule--helper: fix a memory leak in print_status()
15:  f3cf49dd029 = 15:  bfafd31746e submodule--helper: free some "displaypath" in "struct update_data"
16:  a99a7736fab ! 16:  63ff554e306 submodule--helper: free rest of "displaypath" in "struct update_data"
    @@ Commit message
         update_submodule() function itself can use it, and for the
         run_update_procedure() called within this function.
     
    -    To make managing that clobbering easier let's wrap the
    -    update_submodule() in a new update_submodule_outer() function, which
    -    will do the clobbering and free(to_free) dance for us.
    +    Fix a leak in code added in 51f8f94e5b (submodule--helper: run update
    +    procedures from C, 2021-08-24). We'd always clobber the old
    +    "displaypath" member of the previously passed-in "struct update_data".
     
    +    A better fix for this would be to remove the "displaypath" member from
    +    the "struct update_data" entirely. Along with "oid", "suboid",
    +    "just_cloned" and "sm_path" it's managing members that mainly need to
    +    be passed between 1-3 stack frames of functions adjacent to this
    +    code. But doing so would be a much larger change (I have it locally,
    +    and fully untangling that in an incremental way is a 10 patch
    +    journey).
    +
    +    So let's go for this much more isolated fix suggested by Glen. We
    +    FREE_AND_NULL() the "update_data->displaypath", the "AND_NULL()" part
    +    of that is needed due to the later "free(ud->displaypath)" in
    +    "update_data_release()" introduced in the preceding commit
    +
    +    Moving ensure_core_worktree() out of update_submodule() may not be
    +    strictly required, but in doing so we are left with the exact same
    +    ordering as before, making this a smaller functional change.
    +
    +    Helped-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      	ret = determine_submodule_update_strategy(the_repository,
      						  update_data->just_cloned,
      						  update_data->sm_path,
    -@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    - 	return 0;
    - }
    - 
    -+static int update_submodule_outer(struct update_data *update_data)
    -+{
    -+	char *to_free, *restore = update_data->displaypath;
    -+	int ret;
    -+
    -+	ensure_core_worktree(update_data->sm_path);
    -+
    -+	update_data->displaypath = to_free = get_submodule_displaypath(
    -+		update_data->sm_path, update_data->prefix);
    -+
    -+	ret = update_submodule(update_data);
    -+
    -+	free(to_free);
    -+	update_data->displaypath = restore;
    -+
    -+	return ret;
    -+}
    -+
    - static int update_submodules(struct update_data *update_data)
    - {
    - 	int i, ret = 0;
     @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
      		update_data->just_cloned = ucd.just_cloned;
      		update_data->sm_path = ucd.sub->path;
      
    --		code = update_submodule(update_data);
    -+		code = update_submodule_outer(update_data);
    ++		code = ensure_core_worktree(update_data->sm_path);
    ++		if (code)
    ++			goto fail;
    ++
    ++		update_data->displaypath = get_submodule_displaypath(
    ++			update_data->sm_path, update_data->prefix);
    + 		code = update_submodule(update_data);
    ++		FREE_AND_NULL(update_data->displaypath);
    ++fail:
      		if (!code)
      			continue;
      		ret = code;
17:  ec0b02d8ee2 = 17:  3056bfcf607 submodule--helper: fix a configure_added_submodule() leak
-- 
2.37.3.1420.g76f8a3d556c

