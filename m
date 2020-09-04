Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99434C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6269620722
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trIjztP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgIDOxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgIDOxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B6C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 07:53:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so6319973wme.5
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YOtND77EXCqFSpX8AMYHQSe/UI6T2qmHsVxOfOJ7udY=;
        b=trIjztP3n0cGsA7FBAGrp9rnw0QUkDf2CvQQYfcz29zeRgznL4bZHznGz/Fa0NNkZM
         j3pZULKmxPddfV5ipMl1rInv4GL1vVWtqJ+6n2DAXwB3dmVEPL/GbZMr4hKgdy2w855W
         BHHmTE+0NzVM9+bYxYYf0rtws35uQH50l3J4OIDsP3QvFyOCwRHvD6cmZKSXBtHjzxYM
         vuGv8PpU0UdEFm7TTPMdv0bT2ZximM4PloThhFCWfN19e2eLu1eZT1tbzzulu4SNPWfx
         vXza+mKKp1pPKwUPMYbrsiWq6D6OJZVo/3NhcuqtVq45Ypw9H4IuZ28o4jR5TTpzbPK7
         d5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YOtND77EXCqFSpX8AMYHQSe/UI6T2qmHsVxOfOJ7udY=;
        b=PgZ5+ubRseyN2SFBtwmf4RemjwYwRIGWRq9IiqRlFCk3H3LO/SdRe4zeZUtBTRqr2c
         MYi5tx+iJRQpE+pXFJv2PA/6CeK802Qva9MApRpyQjxR4DVZt1aiSWMUmKgZwMYEKv92
         jyfg6vcspowKKIU6ZtR+kO3zHJ6fyKeloiQf/qO6NkYUPJC9DjVMBweFTJQI6XN5hEco
         hiDiTSW2NccQ57cmVyO7DomPg2ov9bcVtTFL3VM1j9gwYlumrVwqKQwjQpjaL5BPQMuR
         krxYY+KBdIWNVAhBxiew7SDeDzPI7qyRC27YLR31QzHqetZp6SofqrGvE2vI+5Xku5N1
         fxyA==
X-Gm-Message-State: AOAM530fbeLa4ra3KOl6vLtC0eLZ2yHVrhB9S55NhSDeSAR3kTJ7cRIV
        64dq2NRBGxk2GeQU7lYNupO4unCfe5A=
X-Google-Smtp-Source: ABdhPJxeg5sDir/xyyDf+LPvkky4UgmIIOtYjDLk5Uv4/PgOGBZUsCK3dF/q5EIknQ1Iqx/W+lmy2A==
X-Received: by 2002:a1c:234b:: with SMTP id j72mr8108165wmj.153.1599231198058;
        Fri, 04 Sep 2020 07:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q192sm13249940wme.13.2020.09.04.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:53:17 -0700 (PDT)
Message-Id: <pull.725.git.1599231196975.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 14:53:16 +0000
Subject: [PATCH] submodule: suppress checking for file name ambiguity for
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
(submodule references).

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-725%2Forgads%2Fsubmodule-not-filename-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-725/orgads/submodule-not-filename-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/725

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
