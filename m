Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168BEC27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjAVACR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 19:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVACQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 19:02:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D31223663
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 16:02:15 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b12so6641580pgj.6
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 16:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxzpsBkbNLULM5c5TJDd+Xo05j71A/Pf4H1AOHPqxgI=;
        b=HmlSrwKlHtEAZ9m6fw/Yow7SxsK/kAWENEz1AJiJWnMPM55EsRtnknyO/XWohjPpw/
         btHsA+vBd43wxMbFySJCI0yjMB+i0qKDwiGT82jA+15xVhu2rLjeYEX4dHhCyWEMpjjm
         +pm1CNWkJI1T12aj+rqPIM9NDxiqVj6VdjV7QFrtChA9cKKbegHCPCN1H4cIdWHg3/ft
         Okp9RI9d6c1W/+OZEFDsDMo4PR+bZquJgmdupPUPucoRBrk+ElT9wmjSlCv6PoUZY5pv
         udj4dtoHpcekxEh6eIF5t3IuRfiCRixI4jyHQweV1UTcA5z2MN5qJEDjQygKlbg9usyy
         Yucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxzpsBkbNLULM5c5TJDd+Xo05j71A/Pf4H1AOHPqxgI=;
        b=gHMoaCuiJY4lNfkq8ChslOFDmBogEjqxKXChr8UveEfXXQ8GmeI6N7jSUQlBuPKPim
         yL+3C46jAY2SLVXOxL6CPalwepiACMwzQI8LRABuNcm2fxKS1kEVKnRg7OJQMT7nEcGH
         FYVDHuAwNjYX8jboX9BI0lQdtdoBguKXYEhaZhnDjzCzi1pp4ZnXBQJcuOqRBbLTTkS0
         R4Sp3SlPguP7alvRSJyprMecbGOhh3Akd2Mvq04LjK5i9frZ2X5DMqYmjPfldlFPiTL0
         zCh5hFaWMCHPyOh09q8OvKevJvp6I7EUbmkXWKUXd4E5aN5K7vWu907HG+13MmYL0FrS
         xUJA==
X-Gm-Message-State: AFqh2krCt18eLot/Gw/by2dZo84lK6j4nhH8WSddkvbcE9lbh845HeFt
        BefRJKQAojhFwcAH9raVrG+HD5m9Fmw=
X-Google-Smtp-Source: AMrXdXs8Xn67PuFM3plZ07nqwMAh2Y9Iv16jHyYuL4DSz9kP/lLJk1NqxQ9TIqlFO41iLCBcmJy5nw==
X-Received: by 2002:a05:6a00:4519:b0:58d:f047:53b7 with SMTP id cw25-20020a056a00451900b0058df04753b7mr13865046pfb.3.1674345734838;
        Sat, 21 Jan 2023 16:02:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o189-20020a62cdc6000000b0058baa6586f3sm17304566pfg.135.2023.01.21.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 16:02:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
        <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
        <xmqq5yd1za0t.fsf@gitster.g>
        <CABPp-BFakaEqnpW4Xn1rzcOC6oVmcEz+OxBV4dKA_TJZ-xbTvg@mail.gmail.com>
        <xmqqh6wlxjuo.fsf@gitster.g>
        <CABPp-BFLUf7htEMXOLGOTNhUP=K11TfKrXQuC-FO4W6mHsjWQg@mail.gmail.com>
Date:   Sat, 21 Jan 2023 16:02:14 -0800
In-Reply-To: <CABPp-BFLUf7htEMXOLGOTNhUP=K11TfKrXQuC-FO4W6mHsjWQg@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Jan 2023 20:52:05 -0800")
Message-ID: <xmqqilgzwi61.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'd probably go for that, but since in my mind the plan is still to
> deprecate and remove the apply backend as you suggested at [1], I'm
> not particularly motivated to improve/extend options specific to the
> apply backend of rebase.

I still consider that deprecating and removing the "am|format-patch
pipeline" mode is a good longer term goal, but it seems we still
have some features that are only available with the mode and not the
other "sequence of cherry-pick" mode?  We'd need to port that over
to the other backend before we can wean ourselves off of the apply
backend.  Until then, ...


