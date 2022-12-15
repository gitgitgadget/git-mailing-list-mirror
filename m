Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E3C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLOJtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiLOJsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:20 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65FB15FC6
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b69so1369628edf.6
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzt8H4M7o0teUOfZ21EDt22kqmDYwP7BmJnBssdNeEA=;
        b=ATFeCWuCCUiwaSmnKr7f4iq0qDAvT5VXXUZRmcdd0oLieZ4Sb4ZNpyg7IOfdZK72Vi
         56feDKsaKj2N+u+1nvDFctHXi6ytc6yqjxyR3rpaisnd3NcugbavzIbaGWei9+ubTkch
         hk/xofm4R1/jxuAzwRsJiWeoa51Zwom9tXOQmlMwRnT1cKYByDspftASaxJLChSNJ0Vx
         qoarPFWGobxZdR3aX1OwNpKLU7u1HzvM7+a+ZSTb+RSpdzQEHODzul2PGjy+x+SxRK0m
         Ib2/J/uADfOTj3+6yNhSDxdDqc1RT6OuA43YSHck5pUhcGQ3Q766GzRuN52eLy+ohfm4
         jiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzt8H4M7o0teUOfZ21EDt22kqmDYwP7BmJnBssdNeEA=;
        b=jqZd6EkjSGBcdLRBG+7txLyNBqaURk4javaWQj6bVYhijJ6UwRuTrbIcRBFR/4sM5A
         fIo9Q6DHeRoKGySPC1siqrBBd4QE6kfiH0tyTao3BANL5pkz8amt2TQHPL+8GAtI1iTU
         1sd3sG3GweC9oTv4DEET1aUspUQ5gCS2gM89CTiLtiP/ra5hT2WPnlUdwX7dLbFIkFBL
         JXONnHj19FpbiTIyNpB8dNdGxnjuvfbr0ck3Vrwf6J4toui4cGqKnVdL6FVhL3dg70yB
         jd79444JINelj7bCrSDvek0Flr5heOJ7LY4gf0RWwMi4qPWcrJD1cg9T2Irmm1W0D06J
         0jwA==
X-Gm-Message-State: ANoB5pkY7F0KWU6nPFuPqSvqz3m4jj0h/kPoN6+XjodW4/IvHeRcZav7
        UqlpZl/535rGPy+nll8qMHSv1Fb5ZyEfpA==
X-Google-Smtp-Source: AA0mqf4NkLq8mzs1JIG09EJrgPGeSuvkqWCLNCshkujj9Po50Na8q5j5YQjOUteCi8ip7DoBCYwYMA==
X-Received: by 2002:a05:6402:249c:b0:464:5ec3:c46 with SMTP id q28-20020a056402249c00b004645ec30c46mr26494863eda.16.1671097672827;
        Thu, 15 Dec 2022 01:47:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] bisect: follow-up fixes from js/bisect-in-c
Date:   Thu, 15 Dec 2022 10:47:43 +0100
Message-Id: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The js/bisect-in-c topic got replaced by dd/bisect-helper-subcommand
and later dd/git-bisect-builtin to fix a regression in "bisect".

This small set of fixes is a cherry-pick of various miscellanious
fixes that were part of js/bisect-in-c that are still worth
having. Johannes and I have coordinated my submission of this
follow-up topic off-list.

The only "new" commit here is the 2/6. It's a cherry-pick of
Johannes's commit to do the same, but as the change to the base was so
extensive (the range diff won't even pick it up anymore with the
default --creation-factor) he suggested I change the authorship, which
I've done here.

There's still other stuff worth picking up from js/bisect-in-c. In
particular we should be using parse_options() for the various
sub-commands of "bisect". But as those changes had much more extensive
conflicts let's leave them for later.

The range-diff here is to pr-1132/dscho/bisect-in-c-v6[1]. My own
branch & CI for this is at [2].

1. https://lore.kernel.org/git/pull.1132.v6.git.1661885419.gitgitgadget@gmail.com/
2. https://github.com/avar/git/tree/avar-js/bisect-in-c-rebased

Johannes Schindelin (5):
  bisect--helper: simplify exit code computation
  bisect: verify that a bogus option won't try to start a bisection
  bisect run: fix the error message
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

Ævar Arnfjörð Bjarmason (1):
  bisect--helper: make the order consistently `argc, argv`

 bisect.c                    |  3 ---
 builtin/bisect.c            | 52 ++++++++++++++-----------------------
 t/t6030-bisect-porcelain.sh | 21 ++++++++++++++-
 3 files changed, 40 insertions(+), 36 deletions(-)

Range-diff:
 1:  05262b6a7d1 <  -:  ----------- bisect--helper: retire the --no-log option
 2:  1e43148864a <  -:  ----------- bisect--helper: really retire --bisect-next-check
 3:  1a1649d9d0d <  -:  ----------- bisect--helper: really retire `--bisect-autostart`
 4:  9ab30552c6a !  1:  c8c648e4b8c bisect--helper: simplify exit code computation
    @@ Commit message
         Let's use it instead of duplicating the logic.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/bisect--helper.c ##
    -@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
    + ## builtin/bisect.c ##
    +@@ builtin/bisect.c: int cmd_bisect(int argc, const char **argv, const char *prefix)
    + 		res = fn(argc, argv, prefix);
      	}
    - 	free_terms(&terms);
      
     -	/*
     -	 * Handle early success
 5:  92b3b116ef8 <  -:  ----------- bisect--helper: make `terms` an explicit singleton
 6:  c9dc0281e38 <  -:  ----------- bisect--helper: make the order consistently `argc, argv`
 7:  e97e187bbec <  -:  ----------- bisect--helper: migrate to OPT_SUBCOMMAND()
 -:  ----------- >  2:  a0de7ad6836 bisect--helper: make the order consistently `argc, argv`
 8:  30c87f2e92e !  3:  e1e31278fef bisect: verify that a bogus option won't try to start a bisection
    @@ Commit message
         by "git bisect start"` and fail if it was found.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t6030-bisect-porcelain.sh ##
     @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect start with one term1 and term2' '
 9:  4696652b99c !  4:  59a8a3085b1 bisect run: fix the error message
    @@ Commit message
     
         Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/bisect--helper.c ##
    -@@ builtin/bisect--helper.c: static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
    - 			printf(_("bisect found first bad commit"));
    + ## builtin/bisect.c ##
    +@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
    + 			puts(_("bisect found first bad commit"));
      			res = BISECT_OK;
      		} else if (res) {
    --			error(_("bisect run failed: 'git bisect--helper --bisect-state"
    -+			error(_("bisect run failed: 'git bisect"
    - 			" %s' exited with error code %d"), new_state, res);
    +-			error(_("bisect run failed: 'bisect-state %s'"
    ++			error(_("bisect run failed: 'git bisect %s'"
    + 				" exited with error code %d"), new_state, res);
      		} else {
      			continue;
     
10:  b202a0e386c <  -:  ----------- bisect: avoid double-quoting when printing the failed command
11:  3376b450867 <  -:  ----------- bisect--helper: calling `bisect_state()` without an argument is a bug
12:  e7623508f90 <  -:  ----------- bisect--helper: make `state` optional
13:  3f052580c95 <  -:  ----------- bisect: move even the command-line parsing to `bisect--helper`
14:  a83fe3dc3c2 <  -:  ----------- Turn `git bisect` into a full built-in
15:  f2132b61ff7 !  5:  1b70cd79cae bisect: remove Cogito-related code
    @@ Commit message
         remove the last remnant of Cogito-accommodating code.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bisect.c ##
     @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
    @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXP
      static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
      static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
      static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
    -@@ builtin/bisect.c: static int cmd_bisect_start(int argc, const char **argv, const char *prefix)
    +@@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
      			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
      		} else if (!get_oid(head, &head_oid) &&
      			   skip_prefix(head, "refs/heads/", &head)) {
16:  4f93692e071 !  6:  2ad89aca728 bisect: no longer try to clean up left-over `.git/head-name` files
    @@ Commit message
         So let's remove that code, at long last.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## bisect.c ##
     @@ bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
-- 
2.39.0.rc2.1048.g0e5493b8d5b

