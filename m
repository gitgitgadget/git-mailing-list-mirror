Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6824DC433E1
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A2220707
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 17:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngiJ1Zo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406954AbgFYRxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406934AbgFYRxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 13:53:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E597EC08C5DB
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 10:53:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so6781090wrm.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v1qlVZh/bk9O5g9ZY75MilSZ3dU+acrXrr2X0F4jOo4=;
        b=ngiJ1Zo/W9M0Kqzdk3FBJLVy+fuTTh/2F/JxUR+bNoMIrBuIut2RPYoaCnoTvHQbJR
         aClUdbMwLTYdLZgIg3YJOiOR64NaAloFFKqcY3XsTIovw53MHfUltofgjv8wg1UOm9MB
         eawq1EFf+9jN4ZctToIa5v30Odhoid5H8VSt4bc+g//k0JEgspjQOeFy63wiP67t58sS
         w+ICrKRU8xCkA2Blx3Ruo5etxRcoKifvl42VsHCTs1SNVWkVEqGRtrGdmIE/UyKdaR82
         WrB0zprvkvR3w5Z6BWAtfULktx5Pu9cgD446ev4UVaJdJ4rn/h0JP9qLxeJQkD2euRqb
         G7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v1qlVZh/bk9O5g9ZY75MilSZ3dU+acrXrr2X0F4jOo4=;
        b=nFI98hwsZPYir5lu7qjMwNxK5/vSgf8s606k8qdmKL7R3JRWBXW/fjt9yKt2NjKuLL
         lRgZ6S4NrAgTTswevWRdMp4m5ZHfgJ5trOPaAhSq2O6zU6gHCmvgjBglYVn5O45Xv582
         HiCAE/SlI0QpBVbclKAOLLaAkWqML+8jaRF+hde6noPs9dsRBQAQxiVuL5WQDfen4x6A
         oWqljTKUSnqAacImg/6sBkQsjfUk9PmeM2MJQ2R1vhSTJSmJxpdkTIBaO2rPEHlu4dph
         asao6Mub9coaiLVyTAkTjNYt5cPn6+IP4BX8UhEgSPYTOI8kQp5zHBmy2YKF9DJlddp5
         O4gQ==
X-Gm-Message-State: AOAM531QEF+nkiWlX6zNOXguY3gfPnaZSCKC+xPCliHiekGQ+VAqGUkM
        wHZcUvsvm9pgPd+AyyWHNXNq43hk
X-Google-Smtp-Source: ABdhPJxuB+EVpeAK+qfMXKaFK6A8OEuvIvyrG5pzA5WNSzbAhsVJETiuRMOAi4S9Hkrv4B5tW0YZpw==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr36846464wrw.194.1593107622205;
        Thu, 25 Jun 2020 10:53:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm12523445wmb.33.2020.06.25.10.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:53:41 -0700 (PDT)
Message-Id: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 17:53:39 +0000
Subject: [PATCH v4 0/2] Fix difftool problem with intent-to-add files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This problem was reported in 
https://github.com/git-for-windows/git/issues/2677, but the problem actually
lies with git diff --raw, and it seems that the bug has been with us ever
since --intent-to-add was introduced.

Changes since v3:

 * Instead of showing the same OID in git diff-files --raw as in git
   diff-files -p for intent-to-add files, we now imitate the logic for
   modified (non-intent-to-add) files: we show the "null" OID (i.e.
   all-zero).
   
   
 * As a consequence, we no longer just undo the inadvertent change where
   intent-to-add files were reported with the empty tree instead of the
   empty blob, but we fix the bug that has been with us since 
   run_diff_files() was taught about intent-to-add files, i.e. we fix the
   original bug of 425a28e0a4e (diff-lib: allow ita entries treated as "not
   yet exist in index", 2016-10-24), at long last.
   
   

Changes since v2:

 * Now we also drop the no-longer-used definition of hash_t in t2203.

Changes since v1:

 * Rebased onto sk/diff-files-show-i-t-a-as-new.
 * Verified that sk/diff-files-show-i-t-a-as-new does not completely resolve
   the issue (the --raw output still claims the empty blob as the
   post-image, although the difftool symptom "went away").
 * Amended the central patch of this PR to include a fix for the regression
   test that was introduced in sk/diff-files-show-i-t-a-as-new: it expected
   the raw diff to contain the hash of the empty tree object (which is
   incorrect no matter how you turn it: any hash in any raw diff should
   refer to blob objects).
 * Reordered the patches so that the central patch comes first (otherwise,
   the "empty tree" fix would cause a test failure in t2203).

Johannes Schindelin (2):
  diff-files --raw: show correct post-image of intent-to-add files
  difftool -d: ensure that intent-to-add files are handled correctly

 diff-lib.c            | 3 +--
 t/t2203-add-intent.sh | 5 ++---
 t/t7800-difftool.sh   | 8 ++++++++
 3 files changed, 11 insertions(+), 5 deletions(-)


base-commit: feea6946a5b746ff4ebf8ccdf959e303203a6011
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-654%2Fdscho%2Fdifftool-ita-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-654/dscho/difftool-ita-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/654

Range-diff vs v3:

 1:  8c27c78831 ! 1:  69256ab910 diff-files --raw: handle intent-to-add files correctly
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    diff-files --raw: handle intent-to-add files correctly
     +    diff-files --raw: show correct post-image of intent-to-add files
      
     -    In `run_diff_files()`, files that have been staged with the intention to
     -    add are queued without a valid OID in the `diff_filepair`.
     +    The documented behavior of `git diff-files --raw` is to display
      
     -    When the output mode is, say, `DIFF_FORMAT_PATCH`, the
     -    `diff_fill_oid_info()` function, called from `run_diff()`, will remedy
     -    that situation by reading the file contents from disk.
     +            [...] 0{40} if creation, unmerged or "look at work tree".
      
     -    However, when the output mode is `DIFF_FORMAT_RAW`, that does not hold
     -    true, and the output will contain a bogus OID (and the flag `M` for
     -    "modified" instead of the correct `A` for "added").
     +    This happens for example when showing modified, unstaged files.
      
     -    As a consequence, `git difftool -d` (which relies on `git diff-files
     -    --raw`'s output) does not work correctly.
     +    For intent-to-add files, we used to show the empty blob's hash instead.
     +    In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
     +    2017-05-30), we made that worse by inadvertently changing that to the
     +    hash of the empty tree.
      
     -    Let's fix this specifically by imitating `diff_fill_oid_info()`.
     +    Let's make the behavior consistent with modified files by showing
     +    all-zero values also for intent-to-add files.
      
     -    Note: we can only do that for diff formats that do not actually need the
     -    file contents, such as `DIFF_FORMAT_PATCH`: `run_diff()` would try to
     -    read the blob contents, but that blob might not have been written to
     -    Git's object database.
     -
     -    This fixes https://github.com/git-for-windows/git/issues/2677
     -
     -    This patch _also_ fixes the expectations set by the regression test
     -    introduced in feea6946a5b (diff-files: treat "i-t-a" files as
     +    Accordingly, this patch adjusts the expectations set by the regression
     +    test introduced in feea6946a5b (diff-files: treat "i-t-a" files as
          "not-in-index", 2020-06-20).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## diff-lib.c ##
      @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
     - 					       !is_null_oid(&ce->oid),
     - 					       ce->name, 0);
     - 				continue;
     -+			} else if (ce_intent_to_add(ce) &&
     -+				   !(revs->diffopt.output_format &
     -+				     ~(DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))) {
     -+				struct object_id oid;
     -+				int ret = lstat(ce->name, &st);
     -+
     -+				if (ret < 0)
     -+					oidclr(&oid);
     -+				else
     -+					ret = index_path(istate, &oid,
     -+						 ce->name, &st, 0);
     -+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
     -+					       &oid, ret >= 0, ce->name, 0);
     -+				continue;
       			} else if (revs->diffopt.ita_invisible_in_index &&
       				   ce_intent_to_add(ce)) {
       				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
     +-					       the_hash_algo->empty_tree, 0,
     +-					       ce->name, 0);
     ++					       &null_oid, 0, ce->name, 0);
     + 				continue;
     + 			}
     + 
      
       ## t/t2203-add-intent.sh ##
      @@ t/t2203-add-intent.sh: test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
     @@ t/t2203-add-intent.sh: test_expect_success 'i-t-a files shown as new for "diff",
       	cat >expect.diff_a <<-EOF &&
      -	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
      -	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
     -+	:000000 100644 0000000 $(git rev-parse --short $hash_e) A$(printf "\t")empty
     -+	:000000 100644 0000000 $(git rev-parse --short $hash_n) A$(printf "\t")not-empty
     ++	:000000 100644 0000000 0000000 A$(printf "\t")empty
     ++	:000000 100644 0000000 0000000 A$(printf "\t")not-empty
       	EOF
       
       	git add -N empty not-empty &&
     -
     - ## t/t4000-diff-format.sh ##
     -@@ t/t4000-diff-format.sh: test_expect_success 'git diff-files --patch --no-patch does not show the patch'
     - 	test_must_be_empty err
     - '
     - 
     -+test_expect_success 'git diff-files --raw handles intent-to-add files correctly' '
     -+	echo 123 >ita &&
     -+	git add -N ita &&
     -+	printf ":000000 100644 %s %s A\\tita\n" \
     -+		$ZERO_OID $(git hash-object --stdin <ita) >expect &&
     -+	git diff-files --raw ita >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+
     - test_done
 2:  a9e06427ec < -:  ---------- diff-files: fix incorrect usage of an empty tree
 3:  f51cbedd3f = 2:  9bb8d84ea9 difftool -d: ensure that intent-to-add files are handled correctly

-- 
gitgitgadget
