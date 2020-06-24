Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F07C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FA820702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XksxAgiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbgFXOru (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389400AbgFXOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:47:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E200C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so2552095wrv.9
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ex6RgWZmP3QiNVu1syKHC25B/0boIfpHgovRzmw1Z7s=;
        b=XksxAgiq+x+UK+bfFwUENwkpvyLNABQKCnROaEbSzn2g44sMd9uhxY/IQoavi9L7uW
         ljPIaOyfMTlnL/v4tQehMqqbOFck8P8kwn9MEFkAE1jkLZkpJU69MueST10YQ/0d5Yyo
         dVBmQDQdGnIkzVJC25M4eFQmtMJnyIg6HST8C+g6XnTQf9CyYQx24AICEee4hS5WIgOC
         pwbuxQcEwFpExjS50i6nvLb7NPrA3VuTA80jF2ZyhhPY9bcgvMlK9wJM/jg4AloDy8Dd
         pg7F5P83K9xXEvmy05esBZR+rcs+789jY+Xm/xr1l9q4nXaqsBNEzwPdccqkuDbQCFDQ
         HYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ex6RgWZmP3QiNVu1syKHC25B/0boIfpHgovRzmw1Z7s=;
        b=HUq29QB2Jb4vNY5Sw1W2M6e26Z1F+JMcC9EEATR+4XYXWsJ7qdFkiziOM1RywWXkb5
         7E4lXYMzUVRWZskLQz2XViGSOBL4dBHt8U6acEJPuTjrY2rmu5sc14KAZud2QIyFv7xA
         EoUjTgWiGCstzcK9kX+u0T+2UMB+zpVm2Fn5xQVkH6SZxBz35KVxFV159i6raS7omXo6
         hWrGwrai88Bofx6bIhZAd3Yx3LqTV9QkwPoz7UugMw3E8/q0akaL+yKkNb9WUtVroB8+
         BDBxfl2UdE4UuArSGaRR4DE5E0orPOp+VuWIXtw/JdHiPBmWq57qFS5DBJyKSVp6zfld
         PWTg==
X-Gm-Message-State: AOAM530fnoMh/AhdzEBJ91rLzAsUHOyMJHF4TIr+60fEY0qapKK8FXt8
        CEX1sqAcOdNMT6DJDeV2z5ut7R+WoYo=
X-Google-Smtp-Source: ABdhPJwPc7juQfYC4SLjtScN2dr1n29LXyRce8LROQngMbQMA/SIvfFDmKQW/K69uu30n5ED6dq1Kg==
X-Received: by 2002:adf:f484:: with SMTP id l4mr21686873wro.248.1593010067812;
        Wed, 24 Jun 2020 07:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16sm21070180wrq.39.2020.06.24.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:47:47 -0700 (PDT)
Message-Id: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
References: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:47:43 +0000
Subject: [PATCH v3 0/3] Fix difftool problem with intent-to-add files
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

Johannes Schindelin (3):
  diff-files --raw: handle intent-to-add files correctly
  diff-files: fix incorrect usage of an empty tree
  difftool -d: ensure that intent-to-add files are handled correctly

 diff-lib.c             | 16 +++++++++++++++-
 t/t2203-add-intent.sh  |  5 ++---
 t/t4000-diff-format.sh | 10 ++++++++++
 t/t7800-difftool.sh    |  8 ++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)


base-commit: feea6946a5b746ff4ebf8ccdf959e303203a6011
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-654%2Fdscho%2Fdifftool-ita-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-654/dscho/difftool-ita-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/654

Range-diff vs v2:

 1:  640e225550 ! 1:  8c27c78831 diff-files --raw: handle intent-to-add files correctly
     @@ diff-lib.c: int run_diff_files(struct rev_info *revs, unsigned int option)
      
       ## t/t2203-add-intent.sh ##
      @@ t/t2203-add-intent.sh: test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
     + 
     + 	hash_e=$(git hash-object empty) &&
     + 	hash_n=$(git hash-object not-empty) &&
     +-	hash_t=$(git hash-object -t tree /dev/null) &&
     + 
     + 	cat >expect.diff_p <<-EOF &&
     + 	diff --git a/empty b/empty
     +@@ t/t2203-add-intent.sh: test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
       	 create mode 100644 not-empty
       	EOF
       	cat >expect.diff_a <<-EOF &&
 2:  b9633315a2 = 2:  a9e06427ec diff-files: fix incorrect usage of an empty tree
 3:  d2e9f704c9 = 3:  f51cbedd3f difftool -d: ensure that intent-to-add files are handled correctly

-- 
gitgitgadget
