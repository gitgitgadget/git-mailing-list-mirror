Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D7C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9374320774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRzRe2UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbgFWMsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbgFWMsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:48:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE910C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so3072623wml.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ptmd3+SX1Ez39giafl+W56iE7yNK5gzgdcAU2oV+3x8=;
        b=kRzRe2UJA4UWlhuKbUvUUBL75f/wDSPwakKyyC5Fce6lJ677UydFJP6ZwaWy67VWUf
         SoJ/t49mVAO3yhf9F7b0NjhP5BOcCfot0kKaEjmr7n/3Jd2ZALThdVZgLv9daszpmsxf
         txDiE3B0ULUpK9QneVRQ+o2dM6GGwoyXcjxPgjAsVGaFLC3GVR2mXy5ZgsI5vbaI8mWd
         TO/CzAXFa6a45MBkJZ6Fr8yaTDno1ARnRD4aZdzXqLm4ooPrPowzoL/Dw/hsVGf4q2zr
         vkgIV8/Dm9o2pXJAuj2wz4dC1U1Y3X5VLC3qQPzm+wRthCwWwwsf+UbbEwOIrtKg+AFW
         +BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ptmd3+SX1Ez39giafl+W56iE7yNK5gzgdcAU2oV+3x8=;
        b=cki1u9UKoS96H5vVmMM81qiS/UL8KUNui5A1uqXiw7iK5YPD9yGLAC2NuilLUBQ/Ib
         SRnbL1r+dAx22WBqIwCFsNe+MEkjVhHcv7GcZNQzyvEnzopvIcqCJvSPB7F0uLlq4Ezx
         1OUvTlznQA1pnvxyGkthxw7lCk++9cIPVanCUBMjDE5GAjNIAVG+GGy8ZGNcZvsPWEes
         aWO+/iqiRwxUv3slItFLS52k14rGDtRk5JM3mIS34Gv6c/rY3RNR1WcThENPohfnD81s
         H2awj0QhHjnF7co6679WJH3SrhtlPmEAMmeMo3cJ5U/VBa2DDxhYSqFl23jrLy7+T6xo
         jctw==
X-Gm-Message-State: AOAM532nBU+esO5EPmx0gYPfbcrhZhEG0BkX09h2rXj/GnAIg3QmkRxn
        yMrK85SAoVrUKmI7DcxLRJLJn/Hk
X-Google-Smtp-Source: ABdhPJwU7pwPkvnui7lc/Dahv6/rtG4sDYfN6Yg+DGAzWDgRa5YIR8A9QX0iqVYcEs1n83MvGezR+Q==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr10404975wma.134.1592916487176;
        Tue, 23 Jun 2020 05:48:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm3480456wmi.3.2020.06.23.05.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:48:06 -0700 (PDT)
Message-Id: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.git.1591879139.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 12:48:02 +0000
Subject: [PATCH v2 0/3] Fix difftool problem with intent-to-add files
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
since--intent-to-add was introduced.

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

Johannes Schindelin (3):
  diff-files --raw: handle intent-to-add files correctly
  diff-files: fix incorrect usage of an empty tree
  difftool -d: ensure that intent-to-add files are handled correctly

 diff-lib.c             | 16 +++++++++++++++-
 t/t2203-add-intent.sh  |  4 ++--
 t/t4000-diff-format.sh | 10 ++++++++++
 t/t7800-difftool.sh    |  8 ++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)


base-commit: feea6946a5b746ff4ebf8ccdf959e303203a6011
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-654%2Fdscho%2Fdifftool-ita-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-654/dscho/difftool-ita-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/654

Range-diff vs v1:

 2:  6d423928512 ! 1:  640e2255508 diff-files --raw: handle intent-to-add files correctly
     @@ Commit message
      
          This fixes https://github.com/git-for-windows/git/issues/2677
      
     +    This patch _also_ fixes the expectations set by the regression test
     +    introduced in feea6946a5b (diff-files: treat "i-t-a" files as
     +    "not-in-index", 2020-06-20).
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## diff-lib.c ##
      @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
     - 					       the_hash_algo->empty_blob, 0,
     + 					       !is_null_oid(&ce->oid),
       					       ce->name, 0);
       				continue;
      +			} else if (ce_intent_to_add(ce) &&
     @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      +				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
      +					       &oid, ret >= 0, ce->name, 0);
      +				continue;
     - 			}
     + 			} else if (revs->diffopt.ita_invisible_in_index &&
     + 				   ce_intent_to_add(ce)) {
     + 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
     +
     + ## t/t2203-add-intent.sh ##
     +@@ t/t2203-add-intent.sh: test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
     + 	 create mode 100644 not-empty
     + 	EOF
     + 	cat >expect.diff_a <<-EOF &&
     +-	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
     +-	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
     ++	:000000 100644 0000000 $(git rev-parse --short $hash_e) A$(printf "\t")empty
     ++	:000000 100644 0000000 $(git rev-parse --short $hash_n) A$(printf "\t")not-empty
     + 	EOF
       
     - 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
     + 	git add -N empty not-empty &&
      
       ## t/t4000-diff-format.sh ##
      @@ t/t4000-diff-format.sh: test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 1:  9c96c43f3d7 ! 2:  b9633315a2f diff-files: fix incorrect usage of an empty tree
     @@ Commit message
      
          In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
          2017-05-30), the OID to use for intent-to-add files was inadvertently
     -    changed from the empty blob to the empty tree. Let's revert that.
     +    changed from the empty blob to the empty tree.
     +
     +    Let's revert that.
     +
     +    To be able to do that, we just taught the regression test introduced in
     +    feea6946a5b (diff-files: treat "i-t-a" files as "not-in-index",
     +    2020-06-20) to _not_ expect the raw diff to contain the hash of the
     +    empty tree (we also had to fix the code to actually produce the expected
     +    output, but for the sake of this here patch, that's beside the point).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 3:  a1c889e2cd1 = 3:  d2e9f704c9e difftool -d: ensure that intent-to-add files are handled correctly

-- 
gitgitgadget
