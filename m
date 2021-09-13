Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94EAC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD91B610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbhIMPqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbhIMPql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB91C0A888D
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so10255724wrq.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QRas0SmFtBZFriSj5Hd5C7/OdOHZEUgfewpDdqYhYqU=;
        b=n+b+r59ijaUjmyZnB1UJCWEPKq9rsgokFFBbpzdoNl4PWrhDgjRPQmm7iVd7Cs8cw0
         9Rlo44/yH3+sOyXfzUhH25R8b/RIGSTXw+4P9vAVXZw9+nkFm4lZKlZvZIRveSCypK52
         YeXVBTNg3CN+DjYocTfYa3WmyvtPbwYzN9lT8N4JVGOj9iNE+JiX13etc011BP2/MzF0
         mGToV3lxsgSd4hey4hMriNUaFtCUgXo6hC/rEEztDEnJ4VzOiKKV4vErQYfe4c1AWvGv
         ClyA5sBZUw0rnaMelKWoSJdRwf2atQRIpL7NtbKD8eg4b4bq9eiUuCKWoO/zHUcyoVQh
         LZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QRas0SmFtBZFriSj5Hd5C7/OdOHZEUgfewpDdqYhYqU=;
        b=PhTJjdXGR+nbyP6AYmFzQMW3rl9cJmoICxFFG9uUau9GHARZ7GObbkzjSmbCdOQw9q
         bEygpjA6xv5uP36yPBD65j38oe0gsdz3KY9aTcgHYzZCclNfA4xJbBS0bs2VgvobWb47
         4b91f7dkyvz18Ud8fcFj6WHe02Xy898SWQJ0427Dovv1KWdO98wqq0XdB93C4+7KA5j9
         18JT7b/rfM/t+uk/XTe6xbHWtN2E7ZMAnjNDp0QoAsjF83UNHSaeFQ/mE+YU1onXXA/0
         ijvL4gf/heNTixkaE1rb6ZgIUFffcLdF+jVrQ7skh9d5LM41Z20R8aig11WJt8RUv4uC
         Sswg==
X-Gm-Message-State: AOAM533DNdMZF1gGV6QG6i8HsC9vNEJ9bXjNlyiazhQ6XgSBue/4SoRS
        HLwJY2/wb97QHZqb55mohtaH0SC4tJY=
X-Google-Smtp-Source: ABdhPJyTWDVolNjg9ZYcaEXBhip+z6IgZuPKzUJYYoq3GKPZajFztkZ7TKy4S95vmthVTR7w6uVgTg==
X-Received: by 2002:adf:d1b3:: with SMTP id w19mr13300107wrc.152.1631546364166;
        Mon, 13 Sep 2021 08:19:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm4474848wmf.11.2021.09.13.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:23 -0700 (PDT)
Message-Id: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:11 +0000
Subject: [PATCH v2 00/11] rebase: dereference tags
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Ævar and Johannes for their comments.

 * Changed "! test_cmp_rev" to "test_cmp_rev !" (suggested by Ævar)
 * Fixed the quoting for the title of the "rebase --quit" tests.
 * Reworked the last commit to handle the error case first (suggested by
   Ævar)
 * Tweaked the commit messages for patches 8 & 11
 * Rebased onto 31e4a0db03 ("Merge branch 'ab/rebase-fatal-fatal-fix'",
   2021-09-08) to avoid a merge conflict that upset gitgitgadget

Cover letter for V1:

Aborting a rebase stated with git rebase <upstream> <tag-object> should
checkout the commit pointed to by . Instead it gives

    error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'


The fix for that is in the last patch, the rest of the patches are cleanups
to t3407 and builtin/rebase.c

Phillip Wood (11):
  t3407: run tests in $TEST_DIRECTORY
  t3407: use test_commit
  t3407: use test_cmp_rev
  t3407: rename a variable
  t3407: use test_path_is_missing
  t3407: strengthen rebase --abort tests
  t3407: rework rebase --quit tests
  rebase: remove redundant strbuf
  rebase: use our standard error return value
  rebase: use lookup_commit_reference_by_name()
  rebase: dereference tags

 builtin/rebase.c        |  63 +++++++++++-------------
 t/t3407-rebase-abort.sh | 105 ++++++++++++++++++----------------------
 2 files changed, 73 insertions(+), 95 deletions(-)


base-commit: 31e4a0db0337e2aa972d9b9f11a332dff7c4cbcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1033%2Fphillipwood%2Fwip%2Frebase-handle-tags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1033/phillipwood/wip/rebase-handle-tags-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1033

Range-diff vs v1:

  1:  0f5992e8cab =  1:  bac009d8543 t3407: run tests in $TEST_DIRECTORY
  2:  79b6dec910e =  2:  abfffb31a56 t3407: use test_commit
  3:  dfa27d7a8e7 !  3:  7755ce17fef t3407: use test_cmp_rev
     @@ t/t3407-rebase-abort.sh: testrebase() {
       		git add a &&
       		test_must_fail git rebase --continue &&
      -		test $(git rev-parse HEAD) != $(git rev-parse main) &&
     -+		! test_cmp_rev HEAD main &&
     ++		test_cmp_rev ! HEAD main &&
       		git rebase --abort &&
      -		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
      +		test_cmp_rev to-rebase pre-rebase &&
  4:  bef70d86d53 !  4:  38eee11baf5 t3407: rename a variable
     @@ t/t3407-rebase-abort.sh: test_expect_success setup '
       		echo d >> a &&
       		git add a &&
      @@ t/t3407-rebase-abort.sh: testrebase() {
     - 		! test_cmp_rev HEAD main &&
     + 		test_cmp_rev ! HEAD main &&
       		git rebase --abort &&
       		test_cmp_rev to-rebase pre-rebase &&
      -		test ! -d "$dotest"
  5:  d9376fe0818 !  5:  61a37c89f1e t3407: use test_path_is_missing
     @@ t/t3407-rebase-abort.sh: testrebase() {
       
       	test_expect_success "rebase$type --abort after --continue" '
      @@ t/t3407-rebase-abort.sh: testrebase() {
     - 		! test_cmp_rev HEAD main &&
     + 		test_cmp_rev ! HEAD main &&
       		git rebase --abort &&
       		test_cmp_rev to-rebase pre-rebase &&
      -		test ! -d "$state_dir"
  6:  87d7e9bf2d4 !  6:  6866630528b t3407: strengthen rebase --abort tests
     @@ t/t3407-rebase-abort.sh: testrebase() {
       
      @@ t/t3407-rebase-abort.sh: testrebase() {
       		test_must_fail git rebase --continue &&
     - 		! test_cmp_rev HEAD main &&
     + 		test_cmp_rev ! HEAD main &&
       		git rebase --abort &&
      -		test_cmp_rev to-rebase pre-rebase &&
      +		check_head &&
  7:  9a4f6ea73c5 !  7:  fd55a3196b1 t3407: rework rebase --quit tests
     @@ t/t3407-rebase-abort.sh: testrebase() {
       		git rebase --abort
       	'
      +
     -+	test_expect_success 'rebase$type --quit' '
     ++	test_expect_success "rebase$type --quit" '
      +		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
      +		# Clean up the state from the previous one
      +		git reset --hard pre-rebase &&
  8:  35b6c26c8f9 =  8:  ad3c4efc027 rebase: remove redundant strbuf
  9:  f0644cde725 =  9:  ad940b633d0 rebase: use our standard error return value
 10:  c537897006c = 10:  bc103e703e8 rebase: use lookup_commit_reference_by_name()
 11:  e87ce4fe253 ! 11:  951de6bb199 rebase: dereference tags
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      -		} else if (!get_oid(branch_name, &options.orig_head) &&
      -			   lookup_commit_reference(the_repository,
      -						   &options.orig_head))
     --			options.head_name = NULL;
     --		else
     --			die(_("fatal: no such branch/commit '%s'"),
     --			    branch_name);
      +		} else {
      +			struct commit *commit =
      +				lookup_commit_reference_by_name(branch_name);
     -+			if (commit) {
     -+				oidcpy(&options.orig_head, &commit->object.oid);
     -+				options.head_name = NULL;
     -+			} else {
     -+				die(_("fatal: no such branch/commit '%s'"),
     ++			if (!commit)
     ++				die(_("no such branch/commit '%s'"),
      +				    branch_name);
     -+			}
     ++			oidcpy(&options.orig_head, &commit->object.oid);
     + 			options.head_name = NULL;
     +-		else
     +-			die(_("no such branch/commit '%s'"),
     +-			    branch_name);
      +		}
       	} else if (argc == 0) {
       		/* Do not need to switch branches, we are already on it. */

-- 
gitgitgadget
