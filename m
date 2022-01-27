Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D30C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 22:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241304AbiA0WDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiA0WDy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 17:03:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74191C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:54 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so7187099wrg.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 14:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=E5OrqNFNYpLquEcVdqlBjv7h4W77sq3dsAtFcMKvunM=;
        b=MOYCGFx1TNYekRXqd6IF9IviJFt2eqZak1lyG58GLN6R3MtwHdpegt0wZDwLM/nQ/6
         CxCxME2iyjDg2Wm3FcUSf4EuYmI2Ejs0tmP93MzO4MJaOU9wM5BpuoyTacvE165JplJQ
         CrTkSIi4QSlxpTPBVkkGdLLCY7iT6Pm0N5ErE3OtIC+h7OuhrssOf18NFHsMx4UI8RI/
         AhIYQ1bu48VCOrK0qHpH37WI0g8VpDOiAk+nAfEcNLqUwm8w/uMgKomXAj+Eog3E+JX/
         MY9ZabMebwNDnoOHydzv7+mGzMJ1d5ciynglQ0jovVHbK5yLwe0TtcUBqY6U6+QtNyW2
         jZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E5OrqNFNYpLquEcVdqlBjv7h4W77sq3dsAtFcMKvunM=;
        b=FH3o/6E46zEK+VW/kI3aJWX0pEdm8dfsMjvTrJCWhz2uBLIZysJ/aaTq1oX5PppOJd
         DA1wnl+ReiSjqvw5YhqsrA5T3V4njX7YpTm+iypN9/CONCaMSMwJIfAAdWds72yJos9A
         gl1t2Y/EbAG6Du2v8+Fc4qKrqsI0QGW77li/dTcjvzGd+LPzITALVIZ4+G35XSEdnflF
         WSVGUYfG0lHZOGxxb1GdA+l3slrRwSeNZKuyrhotmopJPvYiUrypsYAnBmBBdSxDb1zy
         yR90oxi7fkAmxh1sd9s9re+94WM+7UE3Kmjxwz6J9f+0DI36A9KORY0eeqzDsYR8/oVD
         N2Pw==
X-Gm-Message-State: AOAM533RHsmVeQtm9vph8oJOWt0+JPyZnXDRN/0jnAG47Xkvrc9VwEyu
        WdqHlQ627wJ9VkCsJokXlxHlVVkaulk=
X-Google-Smtp-Source: ABdhPJzv/4gK8WDxpu4TibKbv36LGV3JdonEHKna8viT55w6cXfPgEYz6em8YxWX9ayROUNlQN2PfQ==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr4630300wrr.341.1643321032845;
        Thu, 27 Jan 2022 14:03:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm395982wmq.43.2022.01.27.14.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 14:03:52 -0800 (PST)
Message-Id: <pull.1133.git.1643321031.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 22:03:47 +0000
Subject: [PATCH 0/4] Really retire git-legacy-stash.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After proving out git stash for a very long time as a shell script, we
eventually converted it to a proper built-in, leaving an escape hatch in
place to call the scripted version.

After another very long time, we removed that escape hatch, leaving behind a
warning.

Now, almost two years later, let's remove even that warning (and a couple of
tidbits that we inadvertently left in the code base).

Johannes Schindelin (4):
  git-sh-setup: remove remnant bits referring to `git-legacy-stash`
  add: remove support for `git-legacy-stash`
  Remove documentation for `stash.useBuiltin`
  stash: stop warning about the obsolete `stash.useBuiltin` config
    setting

 Documentation/config/stash.txt |  7 -------
 builtin/add.c                  | 14 --------------
 builtin/stash.c                | 10 ----------
 git-sh-setup.sh                |  1 -
 t/t3903-stash.sh               | 15 ---------------
 5 files changed, 47 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1133%2Fdscho%2Freally-retire-legacy-stash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1133/dscho/really-retire-legacy-stash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1133
-- 
gitgitgadget
