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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C5C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 20:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B9F20C09
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU+QEbZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgIFUro (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFUro (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 16:47:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DBBC061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 13:47:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so2038265wmi.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D2CgynsmOxuZo9Cx0RZfX5K6XmQHeiL6hJEJUzh+0w8=;
        b=WU+QEbZWxMuvOgfMmCDJ03VwszCTrJIun71RssDribhs06FVZsX5IOCejdLXSRWXF8
         R3kRdAKYcdMUJrmYAhkbqp19Q0XjzeakiPNKeqQXA3XWkfzOsUKbKG1Tt9NtUXVMjGvk
         ZvrfQfSiLY+iL4LZlijlffac0q7tVEfU28qWUx8TpWdNW7ncwTYJdnTIS8Wfiyv23KGw
         ucrqxaSQ/9lCv0OdvSnsGlnfI+sB/H0QgoTvjeS+5tG35p+9i2lzt3Jg9aBQvrtP+ch9
         tGA23/5UNrHmszn9yP1Joc7c+P2pRtDOaDhY4DlAS17j0gfAZrGekldmgAsd7cIDKWBE
         bKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D2CgynsmOxuZo9Cx0RZfX5K6XmQHeiL6hJEJUzh+0w8=;
        b=OJh1B68v5LxVbmW3xGzXTFqWXt/IlC5xfC+EeaYSNBFliE5xyNZb1/gJ9I75g0rFWu
         Q5bzrh3Iiku5XxwOFWaK3GdwPNAk3jYfe1ITwhfw8oXNFAHJPp3Id9VrwEM6DKYvS/us
         QFsg5jeksKC0CCtE+zxlZVPXrEzNILCEYIAxvkiHssHbIuj52ylFVGw5FH8frR8Ek96/
         ujGlOpdpMf6sm/qLDN2rNWCOBA4c9KdFolmWdfKjwT3SKusb3b8GWKJQBeitgcvLTprl
         LdX5noyJmNjBbObePauSviAhTD4GW0UoemIvh+5kUJjJA0/wHwBb+Dlm1O0njiaweDDm
         SBvw==
X-Gm-Message-State: AOAM532Tw8UUB4qHS00c/g/HvArIf9fSOpR2iu2dW2MWNZaim9jrRXGR
        bAdsMg8RIrJ7pJCjTx1H65VSGSGrYl8=
X-Google-Smtp-Source: ABdhPJzcnrYmQMcaE9gtCa5vTbn6/po1BWvG3JNs/nRCqoZ1VvAGx+sXkBJAbYj70aW/8kD+zLth6Q==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr17929679wmj.33.1599425261095;
        Sun, 06 Sep 2020 13:47:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 128sm23449537wmz.43.2020.09.06.13.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 13:47:40 -0700 (PDT)
Message-Id: <pull.725.v3.git.1599425259773.gitgitgadget@gmail.com>
In-Reply-To: <pull.725.v2.git.1599370473141.gitgitgadget@gmail.com>
References: <pull.725.v2.git.1599370473141.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Sep 2020 20:47:39 +0000
Subject: [PATCH v3] submodule: suppress checking for file name and ref
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-725%2Forgads%2Fsubmodule-not-filename-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-725/orgads/submodule-not-filename-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/725

Range-diff vs v2:

 1:  501ce90e9a ! 1:  128a7244f9 submodule: suppress checking for file name ambiguity for object ids
     @@ Metadata
      Author: Orgad Shaneh <orgads@gmail.com>
      
       ## Commit message ##
     -    submodule: suppress checking for file name ambiguity for object ids
     +    submodule: suppress checking for file name and ref ambiguity for object ids
      
          The argv argument of collect_changed_submodules() contains obly object ids
          (the objects references of all the refs).
     @@ Commit message
          Notify setup_revisions() that the input is not filenames by passing
          assume_dashdash, so it can avoid redundant stat for each ref.
      
     -    A better improvement would be to pass oid_array instead of stringified argv,
     -    but that will require a larger change, which can be done later.
     +    Also suppress refname_ambiguity flag to avoid filesystem lookups for
     +    each object. Similar logic can be found in cat-file, pack-objects and more.
      
          Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      
     @@ submodule.c: static void collect_changed_submodules(struct repository *r,
       {
       	struct rev_info rev;
       	const struct commit *commit;
     ++	int save_warning;
      +	struct setup_revision_opt s_r_opt = {
      +		.assume_dashdash = 1,
      +	};
       
     ++	save_warning = warn_on_object_refname_ambiguity;
     ++	warn_on_object_refname_ambiguity = 0;
       	repo_init_revisions(r, &rev, NULL);
      -	setup_revisions(argv->nr, argv->v, &rev, NULL);
      +	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
     ++	warn_on_object_refname_ambiguity = save_warning;
       	if (prepare_revision_walk(&rev))
       		die(_("revision walk setup failed"));
       


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
