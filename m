Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49865C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiCAA1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiCAA1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:27:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318D4E38C
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d81518795fso114137507b3.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pw7VDnE+Q7RjqtzDf+S09Y6g+alm2MUglH4XXxmKXwc=;
        b=Bd4Cp7sWwumZ0qds1p01vxIOvjmjuHjQK6YGGrxFrzmlbkT6aWrY0R/FnOi2cDmj2K
         b5LOv6ZWKR2obw088RlUHX/5TutqQvFxsRKZp3IwqY3AdcNyId8IWPOLgtXIuXEk3aXS
         H522SdmT9bSmiRLsTVm8CAzc+NLlDnIyP2+K4th1TY3/Y11dJ/c3i+EI3jj8pk3SYFDr
         fJRZEW3wPLwCH7RLq8arh2ISFWTrWLi7sh6QC45mPLlfXQRJI3ERHMHlNo76diEh7UPc
         ouhGtpPTUj9a0jltIGkJlJvHmRgl5KTZizi1A8m89VvPibRLxJGkXezWDJsOqK5foXKW
         ziSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pw7VDnE+Q7RjqtzDf+S09Y6g+alm2MUglH4XXxmKXwc=;
        b=qo1EUKsbQR7WFIRYYHMdHGymMx2mItILJjYTmGrnXKlQx4VSWj93DDRd+gZUCsIu2o
         vH2AoBdA/zMiPhydvUc8JmvidLv3SK2kfCKRXI3eqnbDwKTL2uEV7QjRVMRaZ6MWk3MW
         KZhsZYflDlPqAMJosHEwMUckeGjZU6caKPzaZJgUhx6p80OAOCiASWB5Ky4kuuZOYKsB
         Rm5X2SaS96mfBiLk5dUvi4PDcxx+TVCg+N5AY/K4UFjcEq5J0+ei6UyZjIjgQp74nK59
         o4/u+OxY9yKA7ysr/PVgRLGTNKSLu/rNxWIX0bnqA4Bp1Jy97/A8Xdy4CSxcV8qbtaoH
         HYRw==
X-Gm-Message-State: AOAM531FYi++dFGURRlcsC4WiF9Za+GZ41VtyhFHoXVMWo1IVjXq1EKV
        3wEHjcDaESIJ5GnGFv/BGpTZ+wZhxio9sOcolvLq7O5Nsqy/3K7RlULPJrlTJ5vy40hgtT31mWt
        rpuCkjq3cXRNE0FCGWdXuKAtly1BTKpdfLsj0rl3X/h/5UgreCVPzwXIw+F6r7LS5zuRCxRPuYA
        ==
X-Google-Smtp-Source: ABdhPJzg7bjW5DSu8lLLWjrdAUrTIoe4soBAYjyMgbDH10F5epTuCrPzjIssjrd5iGVGxB7b8GnfF0KGOkuMKQCmxDA=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:3f0e:8f7:9f8d:6e8c])
 (user=emilyshaffer job=sendgmr) by 2002:a0d:e8d2:0:b0:2d6:1743:4023 with SMTP
 id r201-20020a0de8d2000000b002d617434023mr22974428ywe.7.1646094398425; Mon,
 28 Feb 2022 16:26:38 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:26:13 -0800
In-Reply-To: <20220301002613.1459916-1-emilyshaffer@google.com>
Message-Id: <20220301002613.1459916-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com> <20220301002613.1459916-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v8 3/3] rev-parse: short-circuit superproject worktree when
 config unset
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, submodules learned a config
'submodule.hasSuperproject' to indicate whether or not we should attempt
to traverse the filesystem to find their superproject. To help test that
this config was added everywhere it should have been, begin using it to
decide whether to exit early from 'git rev-parse
--show-superproject-working-dir'.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

---

Maybe it's actually better to warn instead of error here? Or maybe it's
best not to say anything, but to set 'submodule.hasSuperproject' after
we successfully find the superproject?

Either way - I ran the test suite with this early exit added and
everything still passed. I made this change hoping to get a little
signal on whether the series achieved its goal, and in that regard I'm
satisfied.
---
 submodule.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/submodule.c b/submodule.c
index 741104af8a..463e7f0c48 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2237,6 +2237,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
 	const char *cwd = xgetcwd();
+	int has_superproject_cfg = 0;
 	int ret = 0;
 	const char *subpath;
 	int code;
@@ -2250,6 +2251,17 @@ int get_superproject_working_tree(struct strbuf *buf)
 		 */
 		return 0;
 
+	if (git_config_get_bool("submodule.hassuperproject", &has_superproject_cfg)
+	    || !has_superproject_cfg) {
+		/*
+		 * If we don't have a superproject, then we're probably not a
+		 * submodule. If this is failing and shouldn't be, investigate
+		 * why the config was never set.
+		 */
+		error(_("Asked to find a superproject, but submodule.hasSuperproject != true"));
+		return 0;
+	}
+
 	if (!strbuf_realpath(&one_up, "../", 0))
 		return 0;
 
-- 
2.35.1.574.g5d30c73bfb-goog

