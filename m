Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356F91F954
	for <e@80x24.org>; Wed, 22 Aug 2018 23:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeHWCn2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 22:43:28 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37917 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeHWCn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 22:43:28 -0400
Received: by mail-lj1-f175.google.com with SMTP id p6-v6so2698037ljc.5
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=P/FvT1jz/75SaZsxR33G8f69dkHPNTUIRFuU+4ITCV0=;
        b=msL9xXW2COgDl40O8XpewEPtsHX+Jiu+dptlEo7vGoME22KyZzFq8ect3JNgEVPQM3
         zI+vrMSLHqTRE26SRpG7mENUS2g3BjTqIYe29a5xEWydWA78xqdTEWh47FMmhEzorMY+
         3u5ubxrEphl2OPoEHmbxvsMrjmHtOEVpoZ5yWeLPRvoW3EvPVlwkvcHMFxPeEQn1gI1E
         v0b7ODtcGULAdGyzntnbZePurDSb497jgpoL6+fTNjGEFBgbWVfv7RzWcmfh6q7lRUri
         mRH5qbwQtWNONYkUZzfSgym4/fCD2Ww9PCDjkWdmLWvBrg8kmQYniuVy2PtTiztS55fT
         gKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P/FvT1jz/75SaZsxR33G8f69dkHPNTUIRFuU+4ITCV0=;
        b=FBd96Zvp6fCtIoFiFGYxCTxipEpn3KHKaMMZcjp2LnQmjm41eLFLvpqn5p0dCKEBem
         evFrFCgIqHoZDZQKhj938pFfxe0QQIZnq4nSjSB6v6FC7HS93yX9uw4COQOB/7dA7U5l
         kS4lUHicZ3DIFeVax8USGF2SFGuw9cAK/xFMPcdXhZfDq6QWhbQIX6z9HWtJENE1uPoQ
         byfuJIdDSQS7YE5CFSX3MXyU9rI013/rsTAugHEEb3NTugm6xA7GvcTe81psQxJccYpQ
         tQt1Bs7SdGlBOivRTaAOMhuYSQbEAd1GlU782GaqakTIXaWCHzuNw5I+TzSYLkdos8GH
         P3/Q==
X-Gm-Message-State: AOUpUlEqnUYfygqlj67GATQRHbW5o4vgasZkvrqCdecVW4Fkf90lpPeR
        NFp4Kmsp1WmggllaElQpPMoQgnoXtTDw6LBO6Y36cp8F
X-Google-Smtp-Source: AA+uWPw4Z2bhHMW/fARqzMkbJvVNjdxSyRx3wiTzDsUNVtIF5Klyyx21DMGzeSBqbTc1xesDeh0W6Y3WjNlTiPLiAYQ=
X-Received: by 2002:a2e:610a:: with SMTP id v10-v6mr37098420ljb.39.1534979796925;
 Wed, 22 Aug 2018 16:16:36 -0700 (PDT)
MIME-Version: 1.0
From:   Gregory Oschwald <oschwald@gmail.com>
Date:   Wed, 22 Aug 2018 16:16:00 -0700
Message-ID: <CAFKzd1qaMU=K6uc62xL0DUyZOWxY79Qakaog2dzBjiNrmq0ydg@mail.gmail.com>
Subject: $GIT_DIR is no longer set when pre-commit hooks are called
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of the release of 2.18.0, $GIT_DIR is no longer set before calling
pre-commit hooks. This change was introduced in "set_work_tree: use
chdir_notify" (8500e0de) and is still present in master.

I reviewed the discussion when this change was initially submitted,
and I don't think this behavior change was intentional.

I have several hooks that were broken like this, and from a quick
Google search, using $GIT_DIR without setting a default does seem
pretty common in hooks.

Greg
