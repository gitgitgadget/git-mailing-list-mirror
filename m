Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2309CC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiHBPyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiHBPys (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D91A83E
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j15so10355273wrr.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8yG0aL4EdiTzCeyXQOeGC4+z9d1q7I8fK+N0quNCBdE=;
        b=IyYAwos7RXBGObohOtmncQ6kjHZI4YNUp7jnoshg4om+bxUtFP0sZj6xLVHhiy4BS4
         k7h5wbezTqCNMMZTSi9aLgCxmjd22gOQKhCsDUWQgYU/5C69yaAPR8ki98BywjqLqj2j
         YEHQSITaGQ6aND44D3/sPjTs6K0LGWmdOhJfzUQ1MpgfBsZG+UNvl/2InZ4gnNllbHLd
         ldPNdTKVw4FIIoeyKp2HoqJ1VOlGsNk5ft8YbdZUL3VTnJkcqCh64wIC4Ntm6h1y40A+
         8VYZaC6irsfkEO8Rm1KE7wV23KZnorFoFaplgNC50PTGlT7AQFN6eK8DzEZq+n/UisfP
         MHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8yG0aL4EdiTzCeyXQOeGC4+z9d1q7I8fK+N0quNCBdE=;
        b=oj3wEI3KxJCg7c/DBe8iQwEum08WdqYq2HKQcSbcR4kywSOub27bYyISjFGG2ndbVj
         NTfWthAnsOjia7TSC/cynJIuagKRBz1+q5MKuqMH4dleC3/qXKGI74Q4usbZBgQ8tl6V
         hIVCU0UW8cK4PTaU4ulXnNvoKPJmEzXK1jDtWvEGDryPt7EaulcFo3bVrakEKFNgV1Xl
         UrnmOYtNaIeWs5uC2Df6no+iww0s5P/HJ1fE+6KK+hf1BUwmlmCd74DLiR9Pxwdh8AQp
         FCxaSBBQqjsiXX3qde47o7MKRIle7gRVrJUWHOsFDlxncjrT+daMBcCVzbudyWh3cm9i
         qfNw==
X-Gm-Message-State: ACgBeo3ywOVQ0cqL0PS/fxnJJCjxwONZKx9fqvcCV1OMVw/mKj+PbpiT
        cANE38gDsWhDwQJRBcPofZgYMa6NGfDY5A==
X-Google-Smtp-Source: AA6agR66RQiQt5G+47r56NEZ8tcmmgDfGSvlYwY5WDcjBT9Or7ceweRpSLaWdwpcvUiSZVC/DqgzUA==
X-Received: by 2002:a5d:5a1a:0:b0:21f:a9b:62c6 with SMTP id bq26-20020a5d5a1a000000b0021f0a9b62c6mr13401225wrb.20.1659455685021;
        Tue, 02 Aug 2022 08:54:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/17] submodule--helper: fix memory leaks
Date:   Tue,  2 Aug 2022 17:54:24 +0200
Message-Id: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
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

This re-roll is on top of the just-now re-rolled v2 of the base
topic[1]. The only changes are to rebase the changes here on top of
those changes.

Changes:

* The base topic renamed another "res" variable (one was left behind
  before).

* The "goto cleanup" pattern in update_submodule() is gone now, which
  makes 16/17 much easier.

For the CI run & pushed branch see [2].

1. https://lore.kernel.org/git/cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com/
2. https://github.com/avar/git/tree/avar/submodule--helper-memory-leaks-5

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
 t/t7412-submodule-absorbgitdirs.sh |   1 +
 t/t7413-submodule-is-active.sh     |   1 +
 t/t7414-submodule-mistakes.sh      |   2 +
 t/t7506-status-submodule.sh        |   1 +
 t/t7507-commit-verbose.sh          |   2 +
 10 files changed, 185 insertions(+), 65 deletions(-)

Range-diff against v4:
 1:  aac987a414a =  1:  118e965d401 submodule--helper: fix a leak in "clone_submodule"
 2:  390c5174e17 !  2:  d885e1dd59a submodule--helper: fix trivial get_default_remote_submodule() leak
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
      		const char *branch = remote_submodule_branch(update_data->sm_path);
      		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
      
 3:  529e10233d5 =  3:  1f90348d61f submodule--helper: fix most "struct pathspec" memory leaks
 4:  683d327752f =  4:  f768ff2e34d submodule--helper: "struct pathspec" memory leak in module_update()
 5:  4e8e9197539 !  5:  509133c37fa submodule--helper: don't leak {run,capture}_command() cp.dir argument
    @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
      
      	strvec_push(&cp.args, "fetch");
      	if (quiet)
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce,
    +@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
      	}
      	strvec_push(&cp.args, oid);
      
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
     +	cp.dir = ud->sm_path;
      	prepare_submodule_repo_env(&cp.env);
      	if (run_command(&cp)) {
    - 		switch (ud->update_strategy.type) {
    + 		int ret;
 6:  575d3e8d2e2 !  6:  25377f1d06c submodule--helper: add and use *_release() functions
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
      cleanup:
     +	submodule_update_clone_release(&suc);
      	string_list_clear(&update_data->references, 0);
    - 	return res;
    + 	return ret;
      }
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
      
 7:  d4c81e04254 =  7:  1a85057cd0c submodule--helper: fix "errmsg_str" memory leak
 8:  ef9e29d5bfe =  8:  3c4f734e958 submodule--helper: fix "sm_path" and other "module_cb_list" leaks
 9:  0798a00c9ef !  9:  3aebff9f8e3 submodule--helper: fix a leak with repo_clear()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static void ensure_core_worktree(const char *path)
    - 		free(abs_path);
    +@@ builtin/submodule--helper.c: static int ensure_core_worktree(const char *path)
      		strbuf_release(&sb);
      	}
    + 
     +	repo_clear(&subrepo);
    + 	return 0;
      }
      
    - static const char *submodule_update_type_to_label(enum submodule_update_type type)
10:  dae2a6f8e07 = 10:  38345ec76bc submodule--helper: fix a memory leak in get_default_remote_submodule()
11:  e7352bb8cfa = 11:  4b1e5ced969 submodule--helper: fix "reference" leak
12:  1adb7b66656 = 12:  e74c396073b submodule--helper: fix obscure leak in module_add()
13:  b27b665d287 = 13:  71a56c59864 submodule--helper: fix a leak in module_add()
14:  53ba1705eb6 = 14:  2429db2f1c7 submodule--helper: fix a memory leak in print_status()
15:  230e5f8ad14 = 15:  613d077c4ec submodule--helper: free some "displaypath" in "struct update_data"
16:  c0fba2f1c56 ! 16:  8f150a81507 submodule--helper: free rest of "displaypath" in "struct update_data"
    @@ Commit message
         update_submodule() function itself can use it, and for the
         run_update_procedure() called within this function.
     
    +    To make managing that clobbering easier let's wrap the
    +    update_submodule() in a new update_submodule_outer() function, which
    +    will do the clobbering and free(to_free) dance for us.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
    - 			    int *must_die_on_failure)
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
      {
    - 	int ret = 1;
    -+	char *to_free, *restore = update_data->displaypath;
    - 
    - 	ensure_core_worktree(update_data->sm_path);
    + 	int ret;
      
    +-	ret = ensure_core_worktree(update_data->sm_path);
    +-	if (ret)
    +-		return ret;
    +-
     -	update_data->displaypath = get_submodule_displaypath(
    -+	update_data->displaypath = to_free = get_submodule_displaypath(
    - 		update_data->sm_path, update_data->prefix);
    - 
    - 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
    -@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
    +-		update_data->sm_path, update_data->prefix);
    +-
    + 	ret = determine_submodule_update_strategy(the_repository,
    + 						  update_data->just_cloned,
    + 						  update_data->sm_path,
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    + 	return 0;
    + }
      
    - 	ret = 0;
    - cleanup:
    ++static int update_submodule_outer(struct update_data *update_data)
    ++{
    ++	char *to_free, *restore = update_data->displaypath;
    ++	int ret;
    ++
    ++	ensure_core_worktree(update_data->sm_path);
    ++
    ++	update_data->displaypath = to_free = get_submodule_displaypath(
    ++		update_data->sm_path, update_data->prefix);
    ++
    ++	ret = update_submodule(update_data);
    ++
     +	free(to_free);
     +	update_data->displaypath = restore;
     +
    - 	return ret;
    - }
    ++	return ret;
    ++}
    ++
    + static int update_submodules(struct update_data *update_data)
    + {
    + 	int i, ret = 0;
    +@@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
    + 		update_data->just_cloned = ucd.just_cloned;
    + 		update_data->sm_path = ucd.sub->path;
      
    +-		code = update_submodule(update_data);
    ++		code = update_submodule_outer(update_data);
    + 		if (code)
    + 			ret = code;
    + 		if (code == 128)
17:  95f8b68bd41 ! 17:  17c77ceba01 submodule--helper: fix a configure_added_submodule() leak
    @@ builtin/submodule--helper.c: static void configure_added_submodule(struct add_da
      		 * current configured pathspec, set the submodule's active flag
     
      ## t/t7413-submodule-is-active.sh ##
    -@@ t/t7413-submodule-is-active.sh: This test verifies that `test-tool submodule is-active` correctly identifies
    - submodules which are "active" and interesting to the user.
    +@@ t/t7413-submodule-is-active.sh: This is a unit test of the submodule.c is_submodule_active() function,
    + which is also indirectly tested elsewhere.
      '
      
     +TEST_PASSES_SANITIZE_LEAK=true
-- 
2.37.1.1233.ge8b09efaedc

