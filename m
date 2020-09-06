Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5850AC433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 05:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD582080A
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 05:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROPkuSqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgIFFel (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 01:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIFFei (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 01:34:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1273C061573
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 22:34:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so11254332wrn.6
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FiC9KeDmwrDVrnxkucVK7uq/OzwW2C/vPPX1hmwQs7w=;
        b=ROPkuSqZb26j/DcFx41rqSLtgZzP2wsIjFvuEoddQ6XDQdTxKaltimh4ed0uAYRXjT
         +VEc8W09cYFVJCPV7OyuaGjrgKdT08pjZH5UXRs306MJccvDVFaZ1g9mPedeS/PWuWrl
         rsxilIM72eSBzrmMukhTuazE9e8OqJ9IsMIKGwhuvjlNHR88B/naTQ+OO5eYkGNWMD8K
         DpyuTu5f8RuBe3gTd5qF6ZZwKC3q83flMuq7EesSTXB85Tor6Zr0zlduUOUvSv14lZor
         qxIp8gmERbT2PZM2/XCjb88Y2G5z/WNGSi1RVYCpeacZklGUga43DdjjbZtzjRArMkjW
         eKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FiC9KeDmwrDVrnxkucVK7uq/OzwW2C/vPPX1hmwQs7w=;
        b=jU0IV8ezW8DdgeYOrEEpPg3kNKAyW5hXzT5w0r59SDtWcLsxKJZbZ3LMXa9dtKMXbM
         jdBhXnKSslrq4RBoGHUFVWVS/dfpEwQH8BNK8QnxwAecYZQ0uBXIdzLZmieoKYUidEeE
         gwias8L2vpsiuokriJ1zUV4ArImCfBq4tVAvrAalatcV3EynRDFSL9QfFEoaGn84TZzb
         APCu/shBxY/arMGe/5G3SN01oyt9qRcbyedrqOIW0BRiQaxY5TZGvuFd4CZJCSAjcZ39
         /I9eXJ1saeX/wBAjQPvj1E5h1y2IJw0+cQWn8XAh1eJ+IxKBImb/mJmsm46kyUZ3eQoy
         h8/g==
X-Gm-Message-State: AOAM533E3kLDG4Qab8kuU4/djpc1ea//DOgN6GNOecwK0s722zmADjpN
        o8EsevgvktqQLAhML2dB0TOno9RaT9s=
X-Google-Smtp-Source: ABdhPJyboohZeEhO4dwl27MRS9dmku90Lf8dJW6kMsbBFmVs+K1Agxm6y+CuycS/pWMmGw8nqUQPjA==
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr16145305wrx.164.1599370474162;
        Sat, 05 Sep 2020 22:34:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm21455499wrx.22.2020.09.05.22.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 22:34:33 -0700 (PDT)
Message-Id: <pull.725.v2.git.1599370473141.gitgitgadget@gmail.com>
In-Reply-To: <pull.725.git.1599231196975.gitgitgadget@gmail.com>
References: <pull.725.git.1599231196975.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Sep 2020 05:34:32 +0000
Subject: [PATCH v2] submodule: suppress checking for file name ambiguity for
 object ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

The argv argument of collect_changed_submodules() contains obly object ids
(the objects references of all the refs).

Notify setup_revisions() that the input is not filenames by passing
assume_dashdash, so it can avoid redundant stat for each ref.

A better improvement would be to pass oid_array instead of stringified argv,
but that will require a larger change, which can be done later.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    submodule: suppress checking for file name ambiguity for object ids
    
    The argv argument of collect_changed_submodules() contains obly object
    ids (submodule references).
    
    Notify setup_revisions() that the input is not filenames by passing
    assume_dashdash, so it can avoid redundant stat for each ref.
    
    A better improvement would be to pass oid_array instead of stringified
    argv, but that will require a larger change, which can be done later.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-725%2Forgads%2Fsubmodule-not-filename-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-725/orgads/submodule-not-filename-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/725

Range-diff vs v1:

 1:  f12112cc88 ! 1:  501ce90e9a submodule: suppress checking for file name ambiguity for object ids
     @@ Commit message
          submodule: suppress checking for file name ambiguity for object ids
      
          The argv argument of collect_changed_submodules() contains obly object ids
     -    (submodule references).
     +    (the objects references of all the refs).
      
          Notify setup_revisions() that the input is not filenames by passing
          assume_dashdash, so it can avoid redundant stat for each ref.


 submodule.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 3cbcf40dfc..9b5bfb12a3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -840,9 +840,12 @@ static void collect_changed_submodules(struct repository *r,
 {
 	struct rev_info rev;
 	const struct commit *commit;
+	struct setup_revision_opt s_r_opt = {
+		.assume_dashdash = 1,
+	};
 
 	repo_init_revisions(r, &rev, NULL);
-	setup_revisions(argv->nr, argv->v, &rev, NULL);
+	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 

base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
-- 
gitgitgadget
