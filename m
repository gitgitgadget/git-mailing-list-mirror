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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6BC433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E2E2137B
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 20:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEyPq7QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIFUyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFUyA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 16:54:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504BC061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 13:53:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so13296577wrr.4
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ZTRkqTQF3+JS/ntItFTasH3JW2GU3HhJLBB6AVNIIw=;
        b=BEyPq7QG/1zH3WIEe+fR+qjM5DtZqjlOpXVYEl5eOlpNjz1EobPzr6yG7G4wdO/A8L
         TpnAdGraoK2k1ul/RXltPs3AsOIjytT+Wcbmt+U47Ns1k4VA67CDrC06GAZy9PxKZdTu
         iCwAEbglCLmJKWswhcJjperTsyaKZPprj0A7RGP1Mqid4DfWLo4P0jGqaO7LBGTzl+qe
         j6k+Lrtr0LFGQCDbae93NNkgF8q4Ls48YXdo2dOgCRVolcgg1u3g0Nw0BcVqjCDOjfeL
         /xreJHptqydcuz5tyqW6+DdBduICb3iivYr0AI6sXdh4a83upB/Fa9+4JyhXZeDy0XKx
         yvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ZTRkqTQF3+JS/ntItFTasH3JW2GU3HhJLBB6AVNIIw=;
        b=QmqifpkVZAin4eXZD5WjBAQi0RFnN6wKOFFq5GU2iWclPYWgjWVzocVV7/V5tPGffY
         LPgXg4Svhep8gedbnIQFnU+/Cxz5TVF9PZlkeFvu6RKO8vs24l+RgFitQG1LsjjUks8f
         4AwGPrGUYT1+G9mJpMDLpfLbpXkvjGeBmS1Y6QX7q/XgpGua+eXdZ6YyVOG/VYPBMUj3
         P9KSm9GL8TeMM9UwW+4l6IecV1y0YpLpbdBZUY152S+atVLh/2PWFMzL2t21OWnN4Cq3
         yg9one2NHUeDDAFSBM1DqH76ByeTQPP3a8kXaBmA9jgs3aXTUsqx5s7foeHl1xz+wFbM
         d3Dg==
X-Gm-Message-State: AOAM533DGPwxXABVIvgkwgCXwojYXq4oBZU+HXSxhINJj1zgK0UADPhx
        Zna5SrT8z0F+PVrGUy1qPHdRBptKhU0=
X-Google-Smtp-Source: ABdhPJzOwILPPidPLo1kPgC4VRfh/Wbtk/Uo26Ta07vSw0XeUyxcv+CTKSKWdUOy2eoLL2uAGz9jZQ==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr17874695wrt.84.1599425637640;
        Sun, 06 Sep 2020 13:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 71sm25418932wrm.23.2020.09.06.13.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 13:53:57 -0700 (PDT)
Message-Id: <pull.725.v4.git.1599425636107.gitgitgadget@gmail.com>
In-Reply-To: <pull.725.v3.git.1599425259773.gitgitgadget@gmail.com>
References: <pull.725.v3.git.1599425259773.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Sep 2020 20:53:55 +0000
Subject: [PATCH v4] submodule: suppress checking for file name and ref
 ambiguity for object ids
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>,
        Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

The argv argument of collect_changed_submodules() contains obly object ids
(the objects references of all the refs).

Notify setup_revisions() that the input is not filenames by passing
assume_dashdash, so it can avoid redundant stat for each ref.

Also suppress refname_ambiguity flag to avoid filesystem lookups for
each object. Similar logic can be found in cat-file, pack-objects and more.

This change reduces the time for git fetch in my repo from 25s to 6s.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    submodule: suppress checking for file name and ref ambiguity for object
    ids
    
    The argv argument of collect_changed_submodules() contains obly object
    ids (submodule references).
    
    Notify setup_revisions() that the input is not filenames by passing
    assume_dashdash, so it can avoid redundant stat for each ref.
    
    A better improvement would be to pass oid_array instead of stringified
    argv, but that will require a larger change, which can be done later.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-725%2Forgads%2Fsubmodule-not-filename-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-725/orgads/submodule-not-filename-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/725

Range-diff vs v3:

 1:  128a7244f9 ! 1:  7134a87921 submodule: suppress checking for file name and ref ambiguity for object ids
     @@ Commit message
          Also suppress refname_ambiguity flag to avoid filesystem lookups for
          each object. Similar logic can be found in cat-file, pack-objects and more.
      
     +    This change reduces the time for git fetch in my repo from 25s to 6s.
     +
          Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      
       ## submodule.c ##


 submodule.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 3cbcf40dfc..e48710e423 100644
--- a/submodule.c
+++ b/submodule.c
@@ -840,9 +840,16 @@ static void collect_changed_submodules(struct repository *r,
 {
 	struct rev_info rev;
 	const struct commit *commit;
+	int save_warning;
+	struct setup_revision_opt s_r_opt = {
+		.assume_dashdash = 1,
+	};
 
+	save_warning = warn_on_object_refname_ambiguity;
+	warn_on_object_refname_ambiguity = 0;
 	repo_init_revisions(r, &rev, NULL);
-	setup_revisions(argv->nr, argv->v, &rev, NULL);
+	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
+	warn_on_object_refname_ambiguity = save_warning;
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 

base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
-- 
gitgitgadget
