Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2605AC2BB84
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28F021582
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZACUfKPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgIPSMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgIPSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:10:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B4C06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e11so2769228wme.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tCkRWc/JN5apVJncc4cDoLLyNyQbhm9Sn6RH2cstiG8=;
        b=ZACUfKPMfqaq0O+90X5AmXPL6OA9sYnuecCjLzJGWIx5uKNlz/JP9cqTpv3E4E2SYe
         n8I2CulplTdTY7nClKOtZa+DOY0HcWXr17z2ZBzI2+pCFQky8G7tj/j6y5tf5JPkg+we
         S9sVe/ur0hqfGjEX5Hpb8I0LEwQjAmzAiOvbB83DJ+2WF1vLNxoxZK+LGXe4CR5RT1qK
         66IK1Pt7h5FRCtbEY0zegcDr2uBDWh/xwHTjSzJ6tKbWrKTHoDhbVjzBUVZg1G7a40m2
         dk7qwxx6khPzyk5yyERmuxjLxWWWOV7/NZNxj4q5kF2YqlLLYxRtdCyLdygKWOQi/eHG
         9yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tCkRWc/JN5apVJncc4cDoLLyNyQbhm9Sn6RH2cstiG8=;
        b=N+ev1w5lOHrsT80UqsQFxzWsn2gSHXw+Fti3jxZD556bpZInH7o14bY4WeLs3cgx7/
         FkvftM6D1IRy1YK76FOf5LTJOzB7CZO/d79rLMFxCuS+FezfD3rcjavFhbGivZo4AfSf
         LKjhH+/f+RjKpXLm69ScJnWhqXdH9qFwZDEsmed4NOmiu+i6dD6e/PRWkzE0UDRnaj1S
         1RV8FHPSd/TdciEbaM+XKUrvGb4TQMCqRfE321gnKNJkgndkvJ6CT7EI+9CbFxedl6ae
         OyWGivLcddUf+8W0WsoEtJho4URvfXL23gKGK03xZwq+9YuP6D7wLQ1otAXtmeMoNQF7
         Noag==
X-Gm-Message-State: AOAM531NrqZuWLIyfBXBj+rPDN+zW8GKgDAoJwy3RQScAcirh5uTYRY1
        DTFuVyCRMMy7PPJP3DwQEO4S8SBsol0=
X-Google-Smtp-Source: ABdhPJwY10aXuq4tKFVQJLDSNxGmGQCLnk3H2DhyRlazybjtIQwGQLDxzcJf7BhFlFMnD214fovF0A==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr6076114wmb.170.1600279854272;
        Wed, 16 Sep 2020 11:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm36046553wrr.40.2020.09.16.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:10:53 -0700 (PDT)
Message-Id: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 18:10:48 +0000
Subject: [PATCH 0/5] Inclusive naming, part II
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series represents the logical next step on the journey begun with
introducing init.defaultBranch: in these patches, we avoid a couple
unnecessary mentions of the branch name "master".

This patch series does not try to change the default branch name, although I
have that patch series ready to go. You can see the overall idea here: 
https://github.com/gitgitgadget/git/pull/655. Concretely, I plan on
submitting three more patch series after this one:

 1. a relatively small patch series to avoid using the branch name main in
    the test suite. This is necessary because my plan is to change the
    default branch name to that name, therefore it cannot be used as the
    name of a topic branch any longer.
 2. a relatively large patch series (currently consisting of 18 patches) to
    change the default branch name to main. Most of the patches provide
    non-trivial (read: non-scriptable) adjustments to the test suite in an
    incremental fashion, with a big patch toward the end that reflects a
    fully-automated search-and-replace of all the trivial cases.
 3. a very small patch series with fall-out patches that are not necessary
    to pass the test suite, but are still required to complete the rename
    (adjusted code comment, file rename).

(Note: I am still debating whether I should move one or two patches from the
second to the third patch series)

Johannes Schindelin (5):
  fast-export: avoid using unnecessary language in a code comment
  t/test-terminal: avoid non-inclusive language
  t3200: avoid variations of the `master` branch name
  tests: avoid variations of the `master` branch name
  t9902: avoid using the branch name `master`

 builtin/fast-export.c        |  2 +-
 t/t3200-branch.sh            | 34 ++++++++++++++---------------
 t/t3427-rebase-subtree.sh    | 42 ++++++++++++++++++------------------
 t/t4150-am.sh                |  8 +++----
 t/t5515-fetch-merge-logic.sh |  6 +++---
 t/t5523-push-upstream.sh     | 20 ++++++++---------
 t/t6018-rev-list-glob.sh     |  6 +++---
 t/t6040-tracking-info.sh     | 20 ++++++++---------
 t/t6409-merge-subtree.sh     | 14 ++++++------
 t/t9902-completion.sh        | 10 ++++-----
 t/test-terminal.perl         | 32 +++++++++++++--------------
 11 files changed, 97 insertions(+), 97 deletions(-)


base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-734%2Fdscho%2Favoid-unnecessary-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-734/dscho/avoid-unnecessary-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/734
-- 
gitgitgadget
