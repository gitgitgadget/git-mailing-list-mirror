Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4313C43467
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CC422403
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeW0pb46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgJSVfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733236AbgJSVfW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 17:35:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A292DC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so984616wme.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=FeW0pb46Ntu0He48gfahPc8I8WnTtP5dJoERT1CaWDUc5z06tI3yjodet8gO8htbhP
         DAU6gLHYemBMG2Y5VEk6TzED7CqCoJvNClWtq71OVb4Y15fw8XNd68Witf47zCujHREH
         zMu5a1IxrJD64qjlimy8UrT4z8+5c9jNXDJWcVYl3JtTd3Mr82//Iw7gu4TSjx5kAyi3
         J96+EaWHEwqIB7I4RtnIOHroFhWWWmEcKm+duQaejIjg7OGxjHTQvRcq984kpjPhP3M4
         qmoU294OW/8RHWoG0BJEiN0ts0E1egnLJKPqZ9zW6FmybhQ5+DowzdGcyBp4KGMAEfvJ
         023g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=NvzBBRX4wnYHCpd8SK34GHvIB7hA4BzOHGNzJGO98b3AJN6lEu0vNwUW4OcN80ZLuD
         KLnKlX8DbqCfYP+2paPbQqbM2j5ZpDMN2Nu2YDcXSwYxAZo/B68koZc0JERLhBWTar7B
         1HjXp55iq954ozEKF4Pe8EXCx71/Gb9miITmPsY233wwBtdNWgquitEWKKD2SBrYNgjs
         MxilEkgjHqZLixanGtMCv1/4jewGVsSw1Sje5Fep0FmmwYQZYMZOTOjm/MJcy+1wXoKx
         /EzOfzR7TVMmyDclgjvF+mLwRoqP2H856WYukotEQNh4PSa8UCYAwrrry989A4wmg1gz
         Rbpg==
X-Gm-Message-State: AOAM531kxFKxvCpt9SrxVH+3X0hkQnboDPtSklb60dhLzATlSt6udn/3
        5kvfVturr5BC8QzWVLnOBgYAov38oP8=
X-Google-Smtp-Source: ABdhPJxlMPPt78HIw1rvysv1iStjULZ8dae2r7YtKiOC6Y1xdvtuNaQN/FUH5dfuy+A/Juq/e9+4Pg==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr1243970wma.70.1603143320226;
        Mon, 19 Oct 2020 14:35:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm243203wrr.80.2020.10.19.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:35:19 -0700 (PDT)
Message-Id: <401f696c8156acafd1bf91511fde7ae099ff9052.1603143316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
        <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 21:35:14 +0000
Subject: [PATCH v2 3/4] t/perf/p7519-fsmonitor.sh: warm cache on first git
 status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The first git status would be inflated due to warming of
filesystem cache. This makes the results comparable.

Before
Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         2.52(1.59+1.56)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.18(0.12+0.06)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.36(0.73+0.62)
7519.7: status (fsmonitor=)                                      0.69(0.52+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.28+0.81)
7519.9: status -uall (fsmonitor=)                                1.53(0.93+1.32)

After
Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.06)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.13+0.05)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.34(0.77+0.56)
7519.7: status (fsmonitor=)                                      0.70(0.53+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.32+0.78)
7519.9: status -uall (fsmonitor=)                                1.55(1.01+1.25)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index def7ecdbc7..9313d4a51d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -114,7 +114,8 @@ test_expect_success "setup for fsmonitor" '
 	fi &&
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
-	git update-index --fsmonitor
+	git update-index --fsmonitor &&
+	git status  # Warm caches
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-- 
gitgitgadget

