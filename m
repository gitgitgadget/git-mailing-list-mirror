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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE0C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7BC246F0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT5k/PCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgKSLli (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKSLlh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 06:41:37 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B80C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 03:41:37 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a186so4086571wme.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ypETJm5StzVS+PR5dbpM+JYKJsVWr4oqv+ndR8huqyo=;
        b=DT5k/PCzsWG62Yf7lpLs0f03VdaR1sa1PiuEXQeDpCvf5RGOv9f3qArumRysGta/i2
         7lQp8kIc9QRSFsaZzuBJrM7X9/ZZC91VmXkKMm4ZScN6Br7bcjhAma0C9ipyxNDH6vS2
         qCu6sM2wFBAk9egGX71OMnJaMcz/VaVIYqp5cy70CARwC+GUhVIf478znKMdPFkMO1MK
         7kEryJMC092EX7QtqG0bPnHudXDfmZ3TaRJdCrbrX/pgaUW1eHVMR6zXic1dczWyzPnI
         QamxkrqmhP80MnKEvuhJCbUvxiK+NU5FQne3AILm71xzwL6VT/DvUQgyinS//KKAAy5N
         i9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ypETJm5StzVS+PR5dbpM+JYKJsVWr4oqv+ndR8huqyo=;
        b=eZvMSNfkFWNOJlubHpDS9WqpxPHEUA+9FIQdq+kl8HtFNy1LclRrSzi6Y4xEsmeqkq
         QjAm8kv8juMGvDjrqfr2poo9lq2KG6OjIcEC6t0gaDFiuz0w1BklY+RWxpzauMmvbRKE
         jpCB0QyoOokbrVOgiqRqKt/dh/+c69S3rjTTo8F5kNqbbwAxk6Ilo/SnYvSrmsQU3cmp
         f3OnFjtRFhn7XrbiknO5BxoWe9cGjOKCkLRhK8jM1mDqb3bLmnKjh3UxX9gb683sxH8S
         Ok+3f66YTRaeZyscbQuTkcXhsXs34p7hPn5IryrVH3QKR3+m86JpO4VyqBsw/srx9QRx
         PKWg==
X-Gm-Message-State: AOAM531iXf3d20xgMZSppfGSwMKOzW1xuP1Z+txE2COpp/exZIYI/4YU
        lmKdvtwSTgFm+Fw63Ij9J58nlq0n6ko=
X-Google-Smtp-Source: ABdhPJxTyhMHATBjO5frwRPpzfV6/4sWwy0X/wb4WJ3kfGPoiUxAJlYb1Y9lWhm+hplnajkc2NOd5A==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr4345079wmg.155.1605786095509;
        Thu, 19 Nov 2020 03:41:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d63sm9500511wmd.12.2020.11.19.03.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:41:35 -0800 (PST)
Message-Id: <pull.791.v2.git.1605786094533.gitgitgadget@gmail.com>
In-Reply-To: <pull.791.git.1605709410465.gitgitgadget@gmail.com>
References: <pull.791.git.1605709410465.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 11:41:34 +0000
Subject: [PATCH v2] t1309: use a neutral branch name in the `onbranch` test
 cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `onbranch` test cases touched by this patch do not actually try to
include any other config. Their purpose is to avoid regressing on two
bugs in the `include.onbranch:<name>.path` code that we fixed in the
past, bugs that are actually unrelated to any concrete branch name.

The first bug was fixed in 85fe0e800ca (config: work around bug with
includeif:onbranch and early config, 2019-07-31). Essentially, when
reading early config, there would be a catch-22 trying to access the
refs, and therefore we simply cannot evaluate the condition at that
point. The test case ensures that we avoid emitting this bogus message:

	BUG: refs.c:1851: attempting to get main_ref_store outside of repository

The second test case concerns the non-Git scenario, where we simply do
not have a current branch to begin with (because we don't have a
repository in the first place), and the test case was introduced in
22932d9169f (config: stop checking whether the_repository is NULL,
2019-08-06) to ensure that we don't cause a segmentation fault should
the code still incorrectly try to look at any ref.

In short, neither of these two test cases will ever look at a current
branch name, even in case of regressions. Therefore, the actual branch
name does not matter at all. We can therefore easily avoid
racially-charged branch names here, and that's what this patch does.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t1309: use a non-loaded branch name in the onbranch test cases
    
    Just something I stumbled over while working on 
    https://github.com/gitgitgadget/git/pull/762.
    
    Changes since v1:
    
     * The commit message was obviously not clear at all, which has been
       addressed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-791%2Fdscho%2Ft1309-onbranch-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-791/dscho/t1309-onbranch-tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/791

Range-diff vs v1:

 1:  c78ddaf9ad ! 1:  7897650556 t1309: use a non-loaded branch name in the `onbranch` test cases
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    t1309: use a non-loaded branch name in the `onbranch` test cases
     +    t1309: use a neutral branch name in the `onbranch` test cases
      
     -    The `onbranch` test cases in question do not actually want to include
     -    anything; Instead, they want to verify that the `onbranch` code path
     -    does not regress in the early-config case or in the non-Git case, where
     -    the `onbranch` include is actually ignored.
     +    The `onbranch` test cases touched by this patch do not actually try to
     +    include any other config. Their purpose is to avoid regressing on two
     +    bugs in the `include.onbranch:<name>.path` code that we fixed in the
     +    past, bugs that are actually unrelated to any concrete branch name.
      
     -    Therefore, the actual branch name does not matter at all. We might just
     -    as well avoid racially-charged names here.
     +    The first bug was fixed in 85fe0e800ca (config: work around bug with
     +    includeif:onbranch and early config, 2019-07-31). Essentially, when
     +    reading early config, there would be a catch-22 trying to access the
     +    refs, and therefore we simply cannot evaluate the condition at that
     +    point. The test case ensures that we avoid emitting this bogus message:
     +
     +            BUG: refs.c:1851: attempting to get main_ref_store outside of repository
     +
     +    The second test case concerns the non-Git scenario, where we simply do
     +    not have a current branch to begin with (because we don't have a
     +    repository in the first place), and the test case was introduced in
     +    22932d9169f (config: stop checking whether the_repository is NULL,
     +    2019-08-06) to ensure that we don't cause a segmentation fault should
     +    the code still incorrectly try to look at any ref.
     +
     +    In short, neither of these two test cases will ever look at a current
     +    branch name, even in case of regressions. Therefore, the actual branch
     +    name does not matter at all. We can therefore easily avoid
     +    racially-charged branch names here, and that's what this patch does.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      


 t/t1309-early-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index ebb8e1aecb..b4a9158307 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -91,11 +91,11 @@ test_expect_failure 'ignore .git/ with invalid config' '
 
 test_expect_success 'early config and onbranch' '
 	echo "[broken" >broken &&
-	test_with_config "[includeif \"onbranch:master\"]path=../broken"
+	test_with_config "[includeif \"onbranch:topic\"]path=../broken"
 '
 
 test_expect_success 'onbranch config outside of git repo' '
-	test_config_global includeIf.onbranch:master.path non-existent &&
+	test_config_global includeIf.onbranch:topic.path non-existent &&
 	nongit git help
 '
 

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
