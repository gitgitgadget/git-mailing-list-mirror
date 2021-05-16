Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3801C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 07:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FCA61186
	for <git@archiver.kernel.org>; Sun, 16 May 2021 07:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhEPHeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhEPHeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 03:34:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE346C061573
        for <git@vger.kernel.org>; Sun, 16 May 2021 00:32:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so1751822wmn.2
        for <git@vger.kernel.org>; Sun, 16 May 2021 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=+etAJgLthbKZFnW4ulE9Hn4vEiZJenkCjw/9qZdBpRo=;
        b=a4dN5XQAKL4eei72MZBy42KHc5xE7p0L0ta9+ma+mTJR+OEEPgo5XE/tzEs1N756O4
         QikI+UcSc7r+hL1UXpY6tWu0Rck2EpsnkjRcFMORjSup2RS2nyT+gwqpKaz872SchEeC
         q+9uQ0RyS+nSB/roFim3b09R0JICuoCt3F8YwEJBfqbX3C2kSG1kfGD1hszuiqC0ABPR
         liDyHZW7hiKcOrejs9mz8CX9M6ifmiZ92DqeXMhS5yPpoR/bwJs9T8zL9Yna/NQjcgkf
         R4qIjpmRs/SkyiH6MvMY+1YfNMspDECplU1sqetCwOqXVGYd0+UAGrkdVKkkKIhDpS7D
         bU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+etAJgLthbKZFnW4ulE9Hn4vEiZJenkCjw/9qZdBpRo=;
        b=fSh3YMR4TiNn+zmyici6H+qjZsA/7ynwy7I8s8xYn7CEQRXW8zOyuqjigLFR95kAwm
         bHL8qSsgPzuDsRMuqs1f4nehLZZ35BCwaJOteQTMmbaIqxVfnPmxR8WR9dVT4luv3K7s
         4vnSbcwhDMPPqIm13sDPuM7iMAmPLo8M5ISxZw2UnZwDivUfPhGpkAhD/B4vTCT3UfAe
         WUS8zOjdyBytjvajmQ71sPKI0unzRcsModCHJHZirq4AzrjRzTFOo+lsvZtfgWTtxpno
         VMaMSNv0xkReCB5BUKQL9LrTfOQjSyMsKXf33Q6UHkBBlRkRqy6V8ado6Pm4Acum9u0G
         SkRg==
X-Gm-Message-State: AOAM530K3xgCzh3IH8J2diqRjoSM1V742pkrA87nUvhxd1PuuypIKN69
        GyR3Ql25nOHS2/nWUPbKAbebkp2xpGE=
X-Google-Smtp-Source: ABdhPJzlRMcO2DevmaQEwJDMnJtWp0QG87AhBD9MeowIwa7sKWX/JpvvNl23dbx4gWaFALkgmKvztg==
X-Received: by 2002:a7b:c016:: with SMTP id c22mr17404916wmb.96.1621150367723;
        Sun, 16 May 2021 00:32:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm10477428wru.73.2021.05.16.00.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:32:47 -0700 (PDT)
Message-Id: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
From:   "Anders =?UTF-8?Q?H=C3=B6ckersten?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 16 May 2021 07:32:45 +0000
Subject: [PATCH] describe-doc: clarify default length of abbreviation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Anders =?UTF-8?Q?H=C3=B6ckersten?= <anders@hockersten.se>,
        =?UTF-8?q?Anders=20H=C3=B6ckersten?= <anders@hockersten.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Anders=20H=C3=B6ckersten?= <anders@hockersten.se>

Clarify the default length used for the abbreviated form used for
commits in git describe.

The behavior was modified in Git 2.11.0, but the documentation was not
updated to clarify the new behavior.

Signed-off-by: Anders Höckersten <anders@hockersten.se>
---
    describe-doc: clarify default length of abbreviation
    
    Clarify the default length used for the abbreviated form used for
    commits in git describe.
    
    The behavior was modified in Git 2.11.0, but the documentation was not
    updated to clarify the new behavior.
    
    Signed-off-by: Anders Höckersten anders@hockersten.se

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1026%2Fahockersten%2Fdescribe-doc-abbreviation-clarification-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1026/ahockersten/describe-doc-abbreviation-clarification-v1
Pull-Request: https://github.com/git/git/pull/1026

 Documentation/git-describe.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a88f6ae2c6e7..f3f41cfac496 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -63,10 +63,11 @@ OPTIONS
 	Automatically implies --tags.
 
 --abbrev=<n>::
-	Instead of using the default 7 hexadecimal digits as the
-	abbreviated object name, use <n> digits, or as many digits
-	as needed to form a unique object name.  An <n> of 0
-	will suppress long format, only showing the closest tag.
+	Instead of using the default number of hexadecimal digits (which
+	will vary according to the size of the repository with a default of 
+	7) of the abbreviated object name, use <n> digits, or as many digits
+	as needed to form a unique object name.  An <n> of 0 will suppress 
+	long format, only showing the closest tag.
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
@@ -139,8 +140,11 @@ at the end.
 
 The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + unambiguous abbreviation for the tip commit
-of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
+The hash suffix is "-g" + an unambigous abbreviation for the tip commit
+of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The 
+length of the abbreviation scales as the repository grows, using the 
+approximate number of objects in the repository and a bit of math 
+around the birthday paradox, and defaults to a minimum of 7.
 The "g" prefix stands for "git" and is used to allow describing the version of
 a software depending on the SCM the software is managed with. This is useful
 in an environment where people may use different SCMs.

base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
-- 
gitgitgadget
