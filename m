Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01914ECAAD5
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 20:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiH1UFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 16:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH1UFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 16:05:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0E71403A
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 13:05:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y127so6367001pfy.5
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=XzztR83C69gsbMcxvf6BNugdDhlnB6kYS/BkJcj61TM=;
        b=BnshgGIhi0mtaG6B4iBhY9Hwb/BT8K/6+WtZ/JeUsf4EQ8EpMyf55s/HhTj9YkKs1e
         TOhP8MTEAL7JuEVUFF+aBMeDt78Vs1NW5V4iKip87cGM/0M9nLcjjQjDM+5mvhMiXXDE
         AAy8dpGgoHhsKDwvdxwPA0Mh/LkowQ6IqVa8kXdOW8xz+7AuXxxofV/0CH/r0Wui9JUH
         4TxkQJOsdXX+2V+fgXm38mvuy9lO9LuUCHOqmlFP3SRApxJZcdmqd5n5YU3Yf27DHk95
         kRH6bLiuOMg0/MiulI6btxknYUtAztO1gcnHDqz97UVaudjHHqX9CqRaRYv3w71ECxwg
         RbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=XzztR83C69gsbMcxvf6BNugdDhlnB6kYS/BkJcj61TM=;
        b=rOXrDZ3ctiSCllTXhgkV5te3xtL+09P4JWumaz2mcJOqAnkRwe45FQJocWIyyOO76u
         ZwhB5CsxwYk17LvzQ81hxDMTVsDq+zAkErVaNh12fJrAGZqgiAgLEyGIdPGghVy7Cq5s
         zAtHxS65hw/wgkBmE7yYVrkwMWJdC5+adueeAZV+mCe3wuZDOio5WYAO11hR8Ak1HIZt
         TU1xypOh4NiWDpDZiVKScANsCRy2ZMB2rEZlBH+T7sJNrYf+7tAGgLXhydeKNR9PXZ+W
         qcwEFXzKebwsMmBZTJ1qE7BGvNoLwihMeAqDWL3GnMITm8MbRP9Yh5uLjtFPeQmaf96I
         eQgw==
X-Gm-Message-State: ACgBeo0rB4jBYCEasiupl+hgq1ON2lwvDHcUkTbONdX+WOrAylqQlktN
        PXjPhXu6aAu/bwn+0dBxqTg=
X-Google-Smtp-Source: AA6agR5x7z1tdzdMwC42prnkIS2Trase150uCWpsFmfD4HcCUx7iYXha/u8w8AFnsVv4cKCaZH1fmA==
X-Received: by 2002:a63:c00c:0:b0:42b:80a3:28a0 with SMTP id h12-20020a63c00c000000b0042b80a328a0mr9214115pgg.311.1661717147574;
        Sun, 28 Aug 2022 13:05:47 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b0016dcbdf9492sm5786971pln.92.2022.08.28.13.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:05:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
Date:   Sun, 28 Aug 2022 13:05:46 -0700
In-Reply-To: <pull.1339.git.1661663879.gitgitgadget@gmail.com> (Eric Sunshine
        via GitGitGadget's message of "Sun, 28 Aug 2022 05:17:56 +0000")
Message-ID: <xmqq35dgt9ph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Eric Sunshine (3):
>   t4301: account for behavior differences between sed implementations
>   t4031: fix broken &&-chains and add missing loop termination
>   t4301: emit blank line in more idiomatic fashion
>
>  t/t4301-merge-tree-write-tree.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

The second one is off by 270.
