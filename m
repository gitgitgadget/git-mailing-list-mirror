Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E6EECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiHaXSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiHaXSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6F39F1B8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so426600wmb.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=njIWk/CAG+VV+HlX84ofRoJNTKSwwEl2dL68yLMJF18=;
        b=WYXtnSRHZwUExvrZhD8xFPz8MskqzZntyPeM5TLR5bkN8ZwrHBNaIySgc0XZtCutiZ
         Npblna8wrqrObaYFR5YdMOedqbpPP40pENrnhDfDcu159Tkh2bJVeKRZTuH3bsD0NDoN
         +tKyiFOlqom6FOh+dyy++PUfpiWA7SmepWzh9LMHXv4T4epFj70IoTTvtv5IvhoCUecG
         epLGjdTVZkwCwNKboORqdss3LBEnMh9xtMydQD96WOdb01hVW5VV4eZCNkjjGQjPcb9F
         T6vK/WNTPqLH2nFGu9+5RY91gNnkumoAtjIsbDWumLhWmLmpmePYYqCj2WnPhyv4i/Ru
         ud8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=njIWk/CAG+VV+HlX84ofRoJNTKSwwEl2dL68yLMJF18=;
        b=rWCm3Z0BEj6qs/4trz/RRZOCx586AoECEJ/Dw9eNvcqANILiCzfNaVpOqppnGhXcf7
         InAt7oD360UcwglidtXn9v5qtRTn6sZCnGNcIZUg5OaQtxlnzXtENzkTy5/yL+O/cvkK
         5M3bh6Tk9qs+44Trac485uMPtID2ImvsdDFKw+7Vwn/2z0yg5PmFMLmWstWGqUuI5S8w
         JYHu9JtIXp8l4DyhmaLZhPQEcTOqEt56Eix1e1V5trRhOR6eplo9/ikC1be4amjQxlCd
         kLkU+3wJusZdv9hi9WLziRxwq6UvwHdEeF31p0kfXgo86ZI9887owDNEI3d3qEyMAIny
         75yA==
X-Gm-Message-State: ACgBeo3EOR2UpycAa6HB4oQDnb0Rs3f1qc3C4g4N86EWehOvH7CpmnLW
        1yJ/eIp9oNx61O3S89ueuFoEBfXOTiM8mQ==
X-Google-Smtp-Source: AA6agR4jX/pAEHtfcuogXJdWx23xTxLkat/U1XhIUa9kdl9s1zmhmBAGxUnrzHvI+1/mnLfdC/AjTA==
X-Received: by 2002:a05:600c:4fcb:b0:3a5:f2cc:2f19 with SMTP id o11-20020a05600c4fcb00b003a5f2cc2f19mr3219586wmq.142.1661987900278;
        Wed, 31 Aug 2022 16:18:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/33] submodule--helper: add tests, rm dead code, refactor & leak prep
Date:   Thu,  1 Sep 2022 01:17:42 +0200
Message-Id: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a "prep" series for the meaty leak fixes for
submodule--helper, see [1] (which will be re-rolled on top of this
v3). The v7 re-roll will be at [2].

Changes since v3:

 * Addressed (hopefully) all of the small feedback, just typo fixes &
   commit message clarifications.

 * Marked a parameter as "const", which helps reason about subsequent
   things in the "leak" series.

Hopefully this is ready to proceed past "seen" in its current form...

1. https://lore.kernel.org/git/cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com

This series & passing CI can be seen at:
https://github.com/avar/git/tree/avar/submodule--helper-cleanup-and-tests-4

Glen Choo (2):
  submodule--helper: add "const" to copy of "update_data"
  submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Ævar Arnfjörð Bjarmason (31):
  submodule tests: test usage behavior
  submodule tests: test for "add <repository> <abs-path>"
  submodule--helper: remove unused "name" helper
  submodule--helper: remove unused "list" helper
  test-tool submodule-config: remove unused "--url" handling
  submodule--helper: move "is-active" to a test-tool
  submodule--helper: move "check-name" to a test-tool
  submodule--helper: move "resolve-relative-url-test" to a test-tool
  submodule--helper style: don't separate declared variables with \n\n
  submodule--helper style: add \n\n after variable declarations
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: use xstrfmt() in clone_submodule()
  submodule--helper: move "sb" in clone_submodule() to its own scope
  submodule--helper: add "const" to passed "module_clone_data"
  submodule--helper: add "const" to passed "struct update_data"
  submodule--helper: don't redundantly check "else if (res)"
  submodule--helper: rename "int res" to "int ret"
  submodule--helper: return "ret", not "1" from update_submodule()
  submodule--helper: add missing braces to "else" arm
  submodule--helper: don't call submodule_strategy_to_string() in BUG()
  submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string()
  submodule--helper: use "code" in run_update_command()
  submodule--helper: don't exit() on failure, return
  submodule--helper: libify determine_submodule_update_strategy()
  submodule--helper: libify "must_die_on_failure" code paths
  submodule--helper update: don't override 'checkout' exit code
  submodule--helper: libify "must_die_on_failure" code paths (for die)
  submodule--helper: check repo{_submodule,}_init() return values
  submodule--helper: libify more "die" paths for module_update()
  submodule--helper: libify even more "die" paths for module_update()
  submodule--helper: fix bad config API usage

 Makefile                         |   1 +
 builtin/submodule--helper.c      | 546 ++++++++++++++-----------------
 git-compat-util.h                |   3 +
 repository.h                     |   3 +
 submodule.c                      |  12 +-
 submodule.h                      |   2 +-
 t/helper/test-submodule-config.c |  11 +-
 t/helper/test-submodule.c        | 146 +++++++++
 t/helper/test-tool-utils.h       |   9 +
 t/helper/test-tool.c             |   7 +-
 t/helper/test-tool.h             |   1 +
 t/t0060-path-utils.sh            |   2 +-
 t/t7400-submodule-basic.sh       |  56 ++--
 t/t7406-submodule-update.sh      |   2 +-
 t/t7413-submodule-is-active.sh   |  35 +-
 t/t7450-bad-git-dotfiles.sh      |   2 +-
 16 files changed, 467 insertions(+), 371 deletions(-)
 create mode 100644 t/helper/test-submodule.c
 create mode 100644 t/helper/test-tool-utils.h

Range-diff against v3:
 1:  77586985ab3 =  1:  2e882837026 submodule tests: test usage behavior
 2:  7425f0025da =  2:  a015be8e89a submodule tests: test for "add <repository> <abs-path>"
 3:  1be48c0b22f =  3:  27a455d231a submodule--helper: remove unused "name" helper
 4:  10189ba3da7 =  4:  6714a04a5c8 submodule--helper: remove unused "list" helper
 5:  ef66dfcd45f =  5:  83516cdcb5c test-tool submodule-config: remove unused "--url" handling
 6:  4727fbb4b64 =  6:  51d2d946b4f submodule--helper: move "is-active" to a test-tool
 7:  9c644460b1d =  7:  3258b5a609d submodule--helper: move "check-name" to a test-tool
 8:  03c8383b8e7 =  8:  4e6929f05ec submodule--helper: move "resolve-relative-url-test" to a test-tool
 9:  b1eaa6a796b =  9:  76b55b9105f submodule--helper style: don't separate declared variables with \n\n
10:  fd7fbe08536 = 10:  44b27475864 submodule--helper style: add \n\n after variable declarations
11:  356f07db436 = 11:  008c6f4ac59 submodule--helper: replace memset() with { 0 }-initialization
12:  241ac5c7eee = 12:  84504a86a72 submodule--helper: use xstrfmt() in clone_submodule()
13:  f2f412f50c1 = 13:  474d1a9e13e submodule--helper: move "sb" in clone_submodule() to its own scope
14:  ad7848067a9 = 14:  e514f0b68c0 submodule--helper: add "const" to passed "module_clone_data"
15:  ab283479b92 = 15:  30be00d5cf7 submodule--helper: add "const" to copy of "update_data"
 -:  ----------- > 16:  b77364015cf submodule--helper: add "const" to passed "struct update_data"
16:  ab0fd2c60f0 = 17:  52da0d60b47 submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
17:  fa2417c7a17 ! 18:  1786e40ec99 submodule--helper: don't redundantly check "else if (res)"
    @@ Commit message
                         return 0;
     
         So we don't need to guard the "return 1" with an "else if (res)", we
    -    an return unconditionally at this point. See b3c5f5cb048 (submodule:
    +    can return unconditionally at this point. See b3c5f5cb048 (submodule:
         move core cmd_update() logic to C, 2022-03-15) for the initial
         introduction of this code, this check of "res" has always been
         redundant.
18:  be1ffbf2e26 = 19:  bc7d401bfb3 submodule--helper: rename "int res" to "int ret"
19:  92e17c37839 = 20:  fdd9ef8b6f6 submodule--helper: return "ret", not "1" from update_submodule()
20:  55e3ea5f9dd = 21:  9edd68f9c5a submodule--helper: add missing braces to "else" arm
21:  2bb45302392 ! 22:  f0ada6854c2 submodule--helper: don't call submodule_strategy_to_string() in BUG()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      		must_die_on_failure = 1;
      		break;
      	default:
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      	}
      	strvec_push(&cp.args, oid);
      
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      			    ud->update_strategy.command, oid, ud->displaypath);
      			break;
      		default:
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      		}
      		if (must_die_on_failure)
      			exit(128);
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      		       ud->displaypath, ud->update_strategy.command, oid);
      		break;
      	default:
22:  0131c197427 = 23:  d101aa6c8c5 submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string()
23:  6cac6cb2fa6 ! 24:  77d21b570e3 submodule--helper: use "code" in run_update_command()
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      {
      	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      
      	switch (ud->update_strategy.type) {
      	case SM_UPDATE_CHECKOUT:
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      		strvec_push(&cp.args, "rebase");
      		if (ud->quiet)
      			strvec_push(&cp.args, "--quiet");
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      		break;
      	default:
      		BUG("unexpected update strategy type: %d",
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      	cp.dir = xstrdup(ud->sm_path);
      	prepare_submodule_repo_env(&cp.env);
      	if (run_command(&cp)) {
24:  6d56f671c7a ! 25:  99717171578 submodule--helper: don't exit() on failure, return
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
    +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet,
      	return run_command(&cp);
      }
      
    --static int run_update_command(struct update_data *ud, int subforce)
    -+static int run_update_command(struct update_data *ud, int subforce,
    +-static int run_update_command(const struct update_data *ud, int subforce)
    ++static int run_update_command(const struct update_data *ud, int subforce,
     +			      int *must_die_on_failure)
      {
      	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      		}
      
      		if (ret == 128)
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      		return ret;
      	}
      
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      	return 0;
      }
      
    --static int run_update_procedure(struct update_data *ud)
    -+static int run_update_procedure(struct update_data *ud,
    +-static int run_update_procedure(const struct update_data *ud)
    ++static int run_update_procedure(const struct update_data *ud,
     +				int *must_die_on_failure)
      {
      	int subforce = is_null_oid(&ud->suboid) || ud->force;
      
    -@@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data *ud)
    +@@ builtin/submodule--helper.c: static int run_update_procedure(const struct update_data *ud)
      			    ud->displaypath, oid_to_hex(&ud->oid));
      	}
      
    @@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data
      }
      
      static const char *remote_submodule_branch(const char *path)
    -@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
    +@@ builtin/submodule--helper.c: static void update_data_to_args(const struct update_data *update_data,
      				    "--no-single-branch");
      }
      
25:  dfd5c8bcd61 ! 26:  512106bc6be submodule--helper: libify determine_submodule_update_strategy()
    @@ builtin/submodule--helper.c: static void determine_submodule_update_strategy(str
      }
      
      struct update_clone_data {
    -@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
    +@@ builtin/submodule--helper.c: static void update_data_to_args(const struct update_data *update_data,
      static int update_submodule(struct update_data *update_data,
      			    int *must_die_on_failure)
      {
26:  da1a07afd25 ! 27:  2b066190739 submodule--helper: libify "must_die_on_failure" code paths
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
    +@@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet,
      	return run_command(&cp);
      }
      
    --static int run_update_command(struct update_data *ud, int subforce,
    +-static int run_update_command(const struct update_data *ud, int subforce,
     -			      int *must_die_on_failure)
    -+static int run_update_command(struct update_data *ud, int subforce)
    ++static int run_update_command(const struct update_data *ud, int subforce)
      {
      	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce,
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce,
      			    ud->update_strategy.type);
      		}
      
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      		return ret;
      	}
      
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce,
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce,
      	return 0;
      }
      
    --static int run_update_procedure(struct update_data *ud,
    +-static int run_update_procedure(const struct update_data *ud,
     -				int *must_die_on_failure)
    -+static int run_update_procedure(struct update_data *ud)
    ++static int run_update_procedure(const struct update_data *ud)
      {
      	int subforce = is_null_oid(&ud->suboid) || ud->force;
      
    -@@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data *ud,
    +@@ builtin/submodule--helper.c: static int run_update_procedure(const struct update_data *ud,
      			    ud->displaypath, oid_to_hex(&ud->oid));
      	}
      
    @@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data
      }
      
      static const char *remote_submodule_branch(const char *path)
    -@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
    +@@ builtin/submodule--helper.c: static void update_data_to_args(const struct update_data *update_data,
      				    "--no-single-branch");
      }
      
27:  2795a3738c8 ! 28:  72e3cdf6543 submodule--helper update: don't override 'checkout' exit code
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      {
      	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
      
      	switch (ud->update_strategy.type) {
      	case SM_UPDATE_CHECKOUT:
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    +@@ builtin/submodule--helper.c: static int run_update_command(const struct update_data *ud, int subforce)
      
      	cp.dir = xstrdup(ud->sm_path);
      	prepare_submodule_repo_env(&cp.env);
28:  6d9bccb34c3 ! 29:  a283ae61e6e submodule--helper: libify "must_die_on_failure" code paths (for die)
    @@ Commit message
     
         Continue the libification of codepaths that previously relied on
         "must_die_on_failure". In these cases we've always been early aborting
    -    by calling die(), but as we know that these codpaths will properly
    +    by calling die(), but as we know that these codepaths will properly
         handle return codes of 128 to mean an early abort let's have them use
         die_message() instead.
     
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data *ud)
    +@@ builtin/submodule--helper.c: static int run_update_procedure(const struct update_data *ud)
      		 */
      		if (!is_tip_reachable(ud->sm_path, &ud->oid) &&
      		    fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
29:  d4b55f07a30 = 30:  ba5c170c3a4 submodule--helper: check repo{_submodule,}_init() return values
30:  15c2490a978 ! 31:  a0d71b4e8bb submodule--helper: libify more "die" paths for module_update()
    @@ Commit message
                 char *remote_name = get_default_remote_submodule(update_data->sm_path);
                 const char *branch = remote_submodule_branch(update_data->sm_path);
     
    +    We can safely remove the "!default_remote" case from sync_submodule(),
    +    because our get_default_remote_submodule() function now returns a
    +    die_message() on failure, so we can have it an dother callers check if
    +    the exit code should be non-zero instead.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
31:  1694ccfe882 ! 32:  3254a8ca6eb submodule--helper: libify even more "die" paths for module_update()
    @@ Commit message
         2022-03-04):
     
         We were assuming that remote_submodule_branch() would always return
    -    on-NULL, but if the submodule_from_path() call in that function fails
    +    non-NULL, but if the submodule_from_path() call in that function fails
         we'll return NULL. See its introduction in
    -    92bbe7ccf1f (submodule--helper: add remote-branch helper, 2016-08-03).
    +    92bbe7ccf1f (submodule--helper: add remote-branch helper,
    +    2016-08-03). I.e. we'd previously have segfaulted in the xstrfmt()
    +    call in update_submodule() seen in the context.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int run_update_procedure(struct update_data *ud)
    +@@ builtin/submodule--helper.c: static int run_update_procedure(const struct update_data *ud)
      	return run_update_command(ud, subforce);
      }
      
32:  d133402462f = 33:  1e38bfa7f95 submodule--helper: fix bad config API usage
-- 
2.37.3.1420.g76f8a3d556c

