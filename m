Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086BC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiHUOCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHUOBu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114AA2495C
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u5so2477999wrt.11
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XT44CLW4W2BYWbE4JQfpcND42Q9EQ7f51e4CKLRSCUk=;
        b=HMM2wrey9GnPraR06zIEbMtqfJoNSD6Kbt8P5GhES0QFcCh9vBzS0hNWSyp7BQ3JJs
         VXFITtBrhSWclJm1yQPwGq/wZMRF1e14ouGsHXBya7bKk/+nZuAV2JAiEKoqpzcRqp6E
         fiTU59rat9Qn2X2AJ2MG1MffEpnJfGA+kgOIVBY696rvqjjNcq6iqUKugxdIyXr6zxZS
         ITgrA6OgLbwpzgLJH86Oha1P7KVjqfzFCqrKPUwRFFpwvduBI728qBLbqpSKukw/o9WA
         smeH6MnMXTJaGvgRX9jtEaOfCNUg2sc0DV4W2gzyyycVqYiij25FgkypTn7EyJzzCYtx
         y1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XT44CLW4W2BYWbE4JQfpcND42Q9EQ7f51e4CKLRSCUk=;
        b=pqj27fIB0DgV7wUQMBU0GCi6oJ95vtWSy3lWDNt9s3yXaYttli8j5buvcDK9U5Jp4A
         bXOzJnlFgfTdaGoa/1x2N7itHlrzjWpEbXmfQLPIK6xjZ8yp0aRKBMEIITbxABLlkRRm
         ojwNFxWv/TBKFmxaixNSxiKvmVt5m9JE9VKoJy6UO1FypoNlGy1s5TWsL1u51ieZr7FV
         fit70VKUltb2Hv1FzIxXoXsjCtTeXIp0HRFbUn8V10tBejOqIGfa/NBU1neHA+X//Uhp
         8W36UlwCe+i1eW/Ps41i78nWb5YCXGAJncgUVF/2eZI8CtWJTN/QcHVOrbMaiNl3DwAb
         eM9A==
X-Gm-Message-State: ACgBeo2NWtx3CHgiXxwtRG6aPW/UVODfuzTNudmGorhi3i3LZD9kzjeU
        2/NARPKehaBziXtW/oMYClIkYingMfQcanKI
X-Google-Smtp-Source: AA6agR4Zb3FArcrl1CE+KgnNGj2zNTCbHbq+6yVhP+dP+2jq5XfSfdz4LxwKUPAd6BdEWa+Dn9lkyQ==
X-Received: by 2002:adf:db06:0:b0:220:7a57:6665 with SMTP id s6-20020adfdb06000000b002207a576665mr8829041wri.55.1661090461023;
        Sun, 21 Aug 2022 07:01:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 00/17] submodule--helper: fix memory leaks
Date:   Sun, 21 Aug 2022 15:59:24 +0200
Message-Id: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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

This re-roll is on top of the just-now re-rolled v3 of the base
topic[1].

Changes in v6:

 * Rebase on top of the base topic.
 * Mark new tests as leak-free within this series (due to changes on
   "master")
 * Various minor changes, see range-diff below.

1. https://lore.kernel.org/git/cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com/

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

 builtin/submodule--helper.c        | 239 +++++++++++++++++++++--------
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
 12 files changed, 187 insertions(+), 65 deletions(-)

Range-diff against v5:
 1:  118e965d401 =  1:  0f60ea6f7c6 submodule--helper: fix a leak in "clone_submodule"
 2:  d885e1dd59a !  2:  c14e00f39cb submodule--helper: fix trivial get_default_remote_submodule() leak
    @@ Commit message
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    - 		const char *branch = remote_submodule_branch(update_data->sm_path);
    - 		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
    + 			return code;
    + 		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
      
     +		free(remote_name);
     +
 3:  1f90348d61f !  3:  a2ecdb301d3 submodule--helper: fix most "struct pathspec" memory leaks
    @@ Commit message
         Call clear_pathspec() at the end of various functions that work with
         and allocate a "struct pathspec".
     
    +    In some cases the zero-initialization here isn't strictly needed, but
    +    as we're moving to a "goto cleanup" pattern let's make sure that it's
    +    safe to call clear_pathspec(), we don't want the data to be
    +    uninitialized.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 4:  f768ff2e34d =  4:  8fc3dad316e submodule--helper: "struct pathspec" memory leak in module_update()
 5:  509133c37fa !  5:  a3886d36366 submodule--helper: don't leak {run,capture}_command() cp.dir argument
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
     -	cp.dir = xstrdup(ud->sm_path);
     +	cp.dir = ud->sm_path;
      	prepare_submodule_repo_env(&cp.env);
    - 	if (run_command(&cp)) {
    - 		int ret;
    + 	if ((ret = run_command(&cp))) {
    + 		switch (ud->update_strategy.type) {
 6:  25377f1d06c =  6:  173dbb7d8fc submodule--helper: add and use *_release() functions
 7:  1a85057cd0c =  7:  cd394814370 submodule--helper: fix "errmsg_str" memory leak
 8:  3c4f734e958 !  8:  2110b991913 submodule--helper: fix "sm_path" and other "module_cb_list" leaks
    @@ Commit message
         submodule--helper: fix "sm_path" and other "module_cb_list" leaks
     
         Fix leaks in "struct module_cb_list" and the "struct module_cb" which
    -    it contains, these fixes leaks in e83e3333b57 (submodule: port
    -    submodule subcommand 'summary' from shell to C, 2020-08-13).
    +    it contains, these fix leaks in e83e3333b57 (submodule: port submodule
    +    subcommand 'summary' from shell to C, 2020-08-13).
     
         The "sm_path" should always have been a "char *", not a "const
         char *", we always create it with xstrdup().
    @@ builtin/submodule--helper.c: static int compute_summary_module_list(struct objec
      	return ret;
      }
      
    +
    + ## t/t7401-submodule-summary.sh ##
    +@@ t/t7401-submodule-summary.sh: This test script tries to verify the sanity of summary subcommand of git submodu
    + # various reasons, one of them being that there are lots of commands taking place
    + # outside of 'test_expect_success' block, which is no longer in good-style.
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + add_file () {
 9:  3aebff9f8e3 =  9:  a0d1a03166f submodule--helper: fix a leak with repo_clear()
10:  38345ec76bc ! 10:  84f162f320b submodule--helper: fix a memory leak in get_default_remote_submodule()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static char *repo_get_default_remote(struct repository *repo)
    - static char *get_default_remote_submodule(const char *module_path)
    +@@ builtin/submodule--helper.c: static int repo_get_default_remote(struct repository *repo, char **default_remot
    + static int get_default_remote_submodule(const char *module_path, char **default_remote)
      {
      	struct repository subrepo;
    -+	char *ret;
    ++	int ret;
      
    - 	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
    --	return repo_get_default_remote(&subrepo);
    -+	ret = repo_get_default_remote(&subrepo);
    + 	if (repo_submodule_init(&subrepo, the_repository, module_path,
    + 				null_oid()) < 0)
    + 		return die_message(_("could not get a repository handle for submodule '%s'"),
    + 				   module_path);
    +-	return repo_get_default_remote(&subrepo, default_remote);
    ++	ret = repo_get_default_remote(&subrepo, default_remote);
     +	repo_clear(&subrepo);
     +
     +	return ret;
11:  4b1e5ced969 = 11:  dc5e8504354 submodule--helper: fix "reference" leak
12:  e74c396073b = 12:  50d58bfb19b submodule--helper: fix obscure leak in module_add()
13:  71a56c59864 = 13:  56590508180 submodule--helper: fix a leak in module_add()
14:  2429db2f1c7 = 14:  38ceb0a36ab submodule--helper: fix a memory leak in print_status()
15:  613d077c4ec ! 15:  f3cf49dd029 submodule--helper: free some "displaypath" in "struct update_data"
    @@ t/t7412-submodule-absorbgitdirs.sh: This test verifies that `git submodue absorb
      . ./test-lib.sh
      
      test_expect_success 'setup a real submodule' '
    +
    + ## t/t7419-submodule-set-branch.sh ##
    +@@ t/t7419-submodule-set-branch.sh: This test verifies that the set-branch subcommand of git-submodule is working
    + as expected.
    + '
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + TEST_NO_CREATE_REPO=1
    + . ./test-lib.sh
    + 
16:  8f150a81507 ! 16:  a99a7736fab submodule--helper: free rest of "displaypath" in "struct update_data"
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
      
     -		code = update_submodule(update_data);
     +		code = update_submodule_outer(update_data);
    - 		if (code)
    - 			ret = code;
    - 		if (code == 128)
    + 		if (!code)
    + 			continue;
    + 		ret = code;
17:  17c77ceba01 = 17:  ec0b02d8ee2 submodule--helper: fix a configure_added_submodule() leak
-- 
2.37.2.1279.g64dec4e13cf

