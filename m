Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7382BC77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 04:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFDEiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFDEiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 00:38:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F181ED
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 21:38:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6532671ccc7so2351070b3a.2
        for <git@vger.kernel.org>; Sat, 03 Jun 2023 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685853485; x=1688445485;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwjGEzf6yNe4U+Q+IaZz93/av3nEbq2bm1mFOAFt88E=;
        b=NGeQb+M/WJyOgbcltEGldzM9yK6IgHVC+1o19IyHoyc5dR/UrsqG83XBORB1y1okmI
         ArWlmAepyviTMs+8tt1kDT4EA+JtiU3wAvpGG3BKziLBI2MYzeKnMwhJxoEeHAeGUkP6
         DAV+sXbQl7DSJXSMGG6XKvAVaGto+OoBP6AFZQ+8GyqVXioJ3lOcEjPlE058x5HAGxmc
         wlw4yNyELAvLGmIRVfF5e1TwvAExg6V84ouXNm+zNmSz7aCwdWZFm5S1srrButnfar4d
         3r2i3+T3HmGN9d7R5rT5rc9nB5solald/xWZhroiVO4dGRofjMZGD3oTFFoG0638LyWv
         ZzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685853485; x=1688445485;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwjGEzf6yNe4U+Q+IaZz93/av3nEbq2bm1mFOAFt88E=;
        b=gmdvULFrgI+iUweI7S8iSFprfCgQ+Z9cqyEi0FEKjcz3OVd23RFmGXpww4eqsH0z/m
         Rf5lfqTUqnvgfrCIA7VwwwnXN/Dj8Tzld3zn/Dh/5WhsMpB3DH8g0DQPs1p1Jm3w86jh
         D9ffcdEsVNMVxEYOzgtW+nvrBz9WYGnWA/IipVZ3EV126+Y5gUOS/5tX3f95m3xVa5qP
         57KjbzVORzwHMVp/QO+TVldYGC67r8gLLj+Z1EAdaF9rK65cfuVDDymBdgXLZL19q7Zg
         c/qo/LHqdEzwv/Geg5SWap1KT+dAT4ELw/47uW18fjyoDIS+g7XUEnALpR2sFFymzDlJ
         13+w==
X-Gm-Message-State: AC+VfDw9gvN3Pms5RBEG26cy4ZANin1kxqI3ZwiDLEZhMKKWrPmmcT2Q
        3/S89XNo5iAo6y0aI3r5gsI=
X-Google-Smtp-Source: ACHHUZ7nTd0OgtrEIWALag87CMcb6xDKQ4CQMEC5bkKt2jO+H2nX4RVUwfQGvyaPcfTcEsxLQCWXPw==
X-Received: by 2002:a05:6a20:3d95:b0:115:83f:fce1 with SMTP id s21-20020a056a203d9500b00115083ffce1mr801500pzi.5.1685853484862;
        Sat, 03 Jun 2023 21:38:04 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id y2-20020a62b502000000b0064c98c87384sm3079829pfe.44.2023.06.03.21.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 21:38:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fedor Bocharov <fedor.bocharov@jetbrains.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the
 index
References: <2B864C9E-9693-49F2-AE50-CB56DE872AB9@jetbrains.com>
Date:   Sun, 04 Jun 2023 13:38:04 +0900
In-Reply-To: <2B864C9E-9693-49F2-AE50-CB56DE872AB9@jetbrains.com> (Fedor
        Bocharov's message of "Sat, 3 Jun 2023 20:18:23 +0200")
Message-ID: <xmqqbkhv6dw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fedor Bocharov <fedor.bocharov@jetbrains.com> writes:

> Anything else you want to add:
> I have this options set in the config:
> core.fsmonitor=true
> core.splitindex=true
> ...
> feature: fsmonitor--daemon
> uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Mon Apr 24 20:52:24 PDT 2023; root:xnu-8796.121.2~5/RELEASE_ARM64_T6000 arm64

I wonder if this is similar to what the topic that includes 3704fed5
(split-index & fsmonitor: demonstrate a bug, 2023-03-26) [*] addressed.

The fix appeared in Git 2.41-rc0 and above.


[References]

* https://lore.kernel.org/git/pull.1497.v2.git.1679870743.gitgitgadget@gmail.com/
