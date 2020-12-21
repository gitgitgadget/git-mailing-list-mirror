Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E623C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA1822BED
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgLUFAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLUFAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:00:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE34C0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:00:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jx16so11628261ejb.10
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1N3+yolDSC3fOEh4rbCuDBFGYL9LJUciEWx4OpFHbk0=;
        b=McGXfl88DSTpn2W9C+FIyrw+6844OUx8TZlrnpFdojJsZsjbgmZi7RS/4MaCE1x8PW
         T+uMOzsmLJIzW6fJLvV5vqmFoDnugwT0PURtFjNVZeux2kKzJ8R8BbVXciCpbi6Ut9AT
         RnoOXxg2NYle4OEKCXyyT6NTrQkZ3XnUGh7VP9pjghsHhjZvGZB/mY5HMEPrJkVkyuT5
         tKVpbPet+3hkEEMvrRoxjCWTIhLmvy9ZB9nd+yjd6Zme+G2MYMGGNyY/rQCQT4MYNHVo
         4KPHltrTpqcrvsDa/HkRrIrsxESovZC6iIR21AfAxcL1YQnmS38KG9HYIunl4Od3ZB3u
         UqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1N3+yolDSC3fOEh4rbCuDBFGYL9LJUciEWx4OpFHbk0=;
        b=pKXynfRRG88Ku1ZJJJh8NCSdb/CXBPTZvxmjVVOjKSQrW9Y+HqxZtCDsf7PwZO6F14
         542b0iF1AOPLf+Z0FbgICvpM3kzZSgnMz+Ym8+sZsB4ArUvvi+2mibII+IhjY5ODyTcJ
         mjjzCcRagwi9fPWZ+fcrS5PdMVHqwVu8lgNkX+N05x5nL2SR6hdPTe5+pj/nhMwu95Yl
         9OErYAuNE4ZWF8IF80YDs1hNzRczUJ2vI/O2NYpqQppVpFiPZCnKnTBdeQzs3z6ldujF
         CUzdLAzl5V6m1wuE+l1nXMP1rkGbVKZy/XaxHu+qG2CLHht3uR4ieoBf5L0+jEJ2iKaN
         tJUw==
X-Gm-Message-State: AOAM530pBpRJ4HNd/zJj1C2cUFKULru2c2jc6yliEGhbJVpi4O7/cypK
        W81Hm+9SfFnSq59k3EXo0/VsbYf2rd4=
X-Google-Smtp-Source: ABdhPJwv+tZgr7WOcmF5vEcr7urL6h2isMxOgkL/111J+k8jMuGY/TEUFO5KnuT8qNIeg4PjY/QSpA==
X-Received: by 2002:adf:ea43:: with SMTP id j3mr16080271wrn.393.1608516322277;
        Sun, 20 Dec 2020 18:05:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm20896639wmm.17.2020.12.20.18.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 18:05:21 -0800 (PST)
Message-Id: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Dec 2020 02:05:17 +0000
Subject: [PATCH v3 0/3] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If remote.origin.push was set to ":", git segfaults during a push operation,
due to bad parsing logic in query_matches_negative_refspec. Per bisect, the
bug was introduced in: c0192df630 (refspec: add support for negative
refspecs, 2020-09-30)

We found this issue when rolling out git 2.29 at Dropbox - as several folks
had "push = :" in their configuration. I based my diff off the master
branch, but also confirmed that it patches cleanly onto maint - if the
maintainers would like to also fix the segfault on 2.29

Update since Patch series V1:

 * Handled matching refspec explicitly
 * Added testing for "+:" case
 * Added comment explaining how the two loops work together

Update since Patch series V2

 * style suggestion in remote.c
 * Use test_config
 * Add test for a case with a matching refspec + negative refspec
 * Fix test_config to work with --add
 * Updated commit message to describe what git is told to do instead of
   segfaulting

Nipunn Koorapati (3):
  test-lib-functions: handle --add in test_config
  negative-refspec: fix segfault on : refspec
  negative-refspec: improve comment on query_matches_negative_refspec

 remote.c                          | 16 +++++++++++++---
 t/t5582-fetch-negative-refspec.sh | 22 ++++++++++++++++++++++
 t/test-lib-functions.sh           |  9 ++++++++-
 3 files changed, 43 insertions(+), 4 deletions(-)


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-820%2Fnipunn1313%2Fnk%2Fpush-refspec-segfault-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-820/nipunn1313/nk/push-refspec-segfault-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/820

Range-diff vs v2:

 -:  ----------- > 1:  733c674bd19 test-lib-functions: handle --add in test_config
 1:  e42200b644a ! 2:  20cff2f5c59 negative-refspec: fix segfault on : refspec
     @@ Commit message
          remote.origin.push is set to ":", then refspec->src is NULL,
          causing a segfault within strcmp
      
     -    Added testing for this case in fetch-negative-refspec
     +    Tell git to handle matching refspec by adding the needle to the
     +    set of positively matched refspecs, since matching ":" refspecs
     +    match anything as src.
     +
     +    Added testing for matching refspec pushes fetch-negative-refspec
     +    both individually and in combination with a negative refspec
      
          Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
      
     @@ remote.c: static int query_matches_negative_refspec(struct refspec *rs, struct r
      +		} else if (refspec->matching) {
      +			/* For the special matching refspec, any query should match */
      +			string_list_append(&reversed, needle);
     -+		} else if (refspec->src == NULL) {
     ++		} else if (!refspec->src) {
      +			BUG("refspec->src should not be null here");
      +		} else if (!strcmp(needle, refspec->src)) {
      +			string_list_append(&reversed, refspec->src);
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "fetch --prune with negat
       '
       
      +test_expect_success "push with matching ':' refspec" '
     -+	(
     -+		cd two &&
     -+		git config remote.one.push : &&
     -+		# Fails w/ tip behind counterpart - but should not segfault
     -+		test_must_fail git push one master &&
     ++	test_config -C two remote.one.push : &&
     ++	# Fails w/ tip behind counterpart - but should not segfault
     ++	test_must_fail git -C two push one
     ++'
     ++
     ++test_expect_success "push with matching '+:' refspec" '
     ++	test_config -C two remote.one.push +: &&
     ++	# Fails w/ tip behind counterpart - but should not segfault
     ++	test_must_fail git -C two push one
     ++'
      +
     -+		git config remote.one.push +: &&
     -+		# Fails w/ tip behind counterpart - but should not segfault
     -+		test_must_fail git push one master &&
     ++test_expect_success "push with matching and negative refspec" '
     ++	test_config -C two --add remote.one.push : &&
     ++	# Fails to push master w/ tip behind counterpart
     ++	test_must_fail git -C two push one &&
      +
     -+		git config --unset remote.one.push
     -+	)
     ++	# If master is in negative refspec, then the command will succeed
     ++	test_config -C two --add remote.one.push ^refs/heads/master &&
     ++	git -C two push one
      +'
      +
       test_done
 2:  8da8d9cd1c5 = 3:  0fd4e9f7459 negative-refspec: improve comment on query_matches_negative_refspec

-- 
gitgitgadget
