Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D1C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiCDNMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiCDNMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:12:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C2159EBC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:11:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so5295500wmj.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=ZSzHxz4jKt+DaOck9pRGEScWhWJkzPHgSDH7V7Tp6Fw=;
        b=Q13kkQa6+iZ3m1l3G8qkpgSkmhJWkoVfzuw50jhSwjDEj29QguA+SVKqXIGPdILs/0
         11qG6RsUEslnk4K3B1qLF/iDaaW717Ty6L3iG6x9NUngUYhBnjOi3+A64CDlNjsRQ6zg
         +SWSZl3j20dON1nOP9heMaCo5Wepz/jy0JB25ZuEv6fbpu3XHToha+wtm4bGEHTIXK2B
         WfhibVBcDWnSdh2icwyPBDqLfohjfek83Z7fnlnnAQAtZZvm8CDIuNujkp2QSiFuCV/Q
         HeZeYvUrbXeZ5Bh3tPxJ6KgIsX3hrNx3U2CuNJG6rQW3XPnXuO9V19bDuWL8Xh3D5maN
         lfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=ZSzHxz4jKt+DaOck9pRGEScWhWJkzPHgSDH7V7Tp6Fw=;
        b=rnOSngqaVCa1X4hUnE/Topat3AV6knnIWW4tj9NOQaa+3KYZcMEHwAhp3fK5PwMBtT
         4hQrCXcNFZZzxsSw1rppEi1Gmtk91Plu3qxSEScv+5fxzDf1dtLy4NYwyPWEWXG3funk
         zaUcQNN315K/h6FQT8cOX0shabWME/Lvyb8PRRx3K/NZK+48aDCfjGp33ELSmEsgdfWg
         rSsZ+m80WZ8W6V0RLcNGVBYnrX7qWgYG0tcBPbz2Gu4VT6y9mgYLytDXa/iNQqVFc0OY
         cUpBcZv+NhVGSJrc51Mf2k0U2zS4TJGebH0nEOEutEpvIIudKCha2Api57ho/RgoK8BS
         4Dkw==
X-Gm-Message-State: AOAM531iCJ4qjCvfuuBapq0T7eZb7E45HiU/4iJUjRuRkyyp2LHRyFQS
        LIQzjZQdqnF6/Z4Q7oBPMxLTFKs4y3E=
X-Google-Smtp-Source: ABdhPJxMSf4MjkLi32Z7rR4nWrb3ZPF2hTg86GMP0oX+NDS0hi+OhAHHRCj4nCG/krQl4Z939R5P9w==
X-Received: by 2002:a05:600c:414a:b0:386:f407:e261 with SMTP id h10-20020a05600c414a00b00386f407e261mr7557948wmm.38.1646399491545;
        Fri, 04 Mar 2022 05:11:31 -0800 (PST)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b001f0494de239sm4634042wrr.21.2022.03.04.05.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:11:31 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/4] builtin add -p: hopefully final readkey fixes
Date:   Fri,  4 Mar 2022 13:11:22 +0000
Message-Id: <20220304131126.8293-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Fix the remaining issues that I'm aware of when using the built in
"add -p" with interactive.singlekey that are stopping it from being
merged to master. The first three patches make sure that we call
tcsetattr() and the same file descriptor that we use for read() and
work around poll() being broken when reading from terminals on
macos. The final patch is more of an improvement rather than a bug fix
(the same issue already exists in the perl version) and could proceed
separately.

Unfortunately these patches conflict with
'cb/save-term-across-editor-invocation' as well as the textual
conflicts there is a semantic conflict as the argument to save_term()
is changed so the code in editor.c will need updating.

These patches are based on 'pw/single-key-interactive'

Phillip Wood (4):
  terminal: use flags for save_term()
  terminal: don't assume stdin is /dev/tty
  terminal: work around macos poll() bug
  terminal: restore settings on SIGTSTP

 compat/terminal.c | 205 +++++++++++++++++++++++++++++++++++++++-------
 compat/terminal.h |   6 +-
 2 files changed, 182 insertions(+), 29 deletions(-)

-- 
2.35.1

