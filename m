Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A2DC636C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 03:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6AE6127C
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 03:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhGPDF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 23:05:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CADC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 20:03:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so5939985wmf.5
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 20:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fbCk6P7rogwFQqM47fRFJfJZl0HIkGiHj0W+qTw+E/Q=;
        b=mt9NpXrRG7NLNoYo+Wd/MeuMohufykiAZgBNOarro4b1eJznZdlrOQC/Yv5FV8c9/F
         iQkXeq0bz62Y2M4eaGMB8SPtlDhK66aaavgQVqCNL2jjHEpivjA/EQOe8Ll3JWFULXWt
         o5+JbaGHvL7IvJiHKT0pnrVWhzMxcBzwkzUaEW/WdslnEIQw/jIq+1iGBwWF3sVLWiUD
         td1liFpERU5oc2TVyyExgl+a7JDzbRQoY5ycxmgA7dqyXJSWcRyCdq2d5nlDdqZ3zgiN
         VB1MnOhsfbTM0bAXHKFlk4/d6D4WN5xXXMGCa5zPJ3ws78aa6cFp6NZuT86smwZxTMRG
         k2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fbCk6P7rogwFQqM47fRFJfJZl0HIkGiHj0W+qTw+E/Q=;
        b=Ag1oMvuYiZ19B3U3RcJ0ilu2ObOroMlyuO4HrJS/2zP94ZpCDUySVxJnijiegAH3Kp
         3FEL75b4v18fObhD/0nfB3Wo+au1nBvsh6ccVmdAov7wX5SM4gDMV5k5HHMrddETS9Pa
         h9X4/ktqEBUfRuXOAq5ydkC6pWatA+q4dxnnuEEv6ZdrmO8ogq4FdsX7y7T9MLrm/BzL
         YNC8I8Fmr9/BUe8P4OSwI7+tU6fSsJjF2uWyN2vQKesYedwfv8xNctAKkNawCD8ABYMI
         IBRxU/ybPTBaXNo010JM/E6Go8sE9A3MUNB80UZD4djJuBynXm6R2PTpDb+3YnAL9xK7
         QXnQ==
X-Gm-Message-State: AOAM533a6XzzqyK/8S7W1H7YcUZugyEFqnNuc/JLFeG+tZWR4vv8VdGN
        rvdz5nKbjh80ew22Jntko1pdVD0S9oE=
X-Google-Smtp-Source: ABdhPJxJcG/m1fWOdWeHePfpe9JLdBXxJmH7Q/UrYNLhmBuu2f+D5k36GH7uRQY2lt/bA5m5qa4mIA==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr13954995wmj.128.1626404579205;
        Thu, 15 Jul 2021 20:02:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm8506887wrh.16.2021.07.15.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:02:58 -0700 (PDT)
Message-Id: <pull.997.git.1626404577534.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 03:02:57 +0000
Subject: [PATCH] doc: clarify description of 'submodule.recurse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The doc for 'submodule.recurse' starts with "Specifies if commands
recurse into submodles by default". This is not exactly true of all
commands that have a '--recurse-submodules' option. For example, 'git
pull --recurse-submodules' does not run 'git pull' in each submodule,
but rather runs 'git submodule update --recursive' so that the submodule
working trees after the pull matches the commits recorded in the
superproject.

Clarify that by just saying that it enables '--recurse-submodules'.

Note that the way this setting interacts with 'fetch.recurseSubmodules'
and 'push.recurseSubmodules', which can have other values than true or
false, is already documented since 4da9e99e6e (doc: be more precise on
(fetch|push).recurseSubmodules, 2020-04-06).

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    doc: clarify description of 'submodule.recurse'
    
    The current wording confused at least one user [1], so let's clarify
    that.
    
    [1]
    https://stackoverflow.com/questions/4611512/is-there-a-way-to-make-git-pull-automatically-update-submodules/49427199?noredirect=1#comment119208094_49427199

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-997%2Fphil-blain%2Fsubmodule.recurse-doc-clarify-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-997/phil-blain/submodule.recurse-doc-clarify-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/997

 Documentation/config/submodule.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index d7a63c8c12b..ee454f8126a 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -58,8 +58,9 @@ submodule.active::
 	commands. See linkgit:gitsubmodules[7] for details.
 
 submodule.recurse::
-	Specifies if commands recurse into submodules by default. This
-	applies to all commands that have a `--recurse-submodules` option
+	A boolean indicating if commands should enable the `--recurse-submodules`
+	option by default.
+	Applies to all commands that support this option
 	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
 	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.

base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
-- 
gitgitgadget
