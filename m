Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BC2C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 19:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC1TcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC1TcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 15:32:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC313582
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:32:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7-20020a17090b050700b002404be7920aso12196047pjz.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680031920;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chmIFf9otnf4BVuzj147sTCPlddTiwPoKvD528/XyEM=;
        b=OO13Z90ujPHTuN/xTcbMwjoffy+KoFovTRVJCZD+7bN+4PhPXkvAfoBcKRkrnEZ5e5
         p6IiUGjjbd+bHTMO+Uw3dN9VJAZzEcMcQi13O401j79X11m//Wq4yZCRCKXCEIORrplF
         j5DB0Bw3VYx4rei9TRwAcgB6ntnNa6UJg6w5cSZlC20oY1LhAH89eB2H59wpA8HBswlN
         0m3JPuLaWZRXUqLgmygsNQpdlmoZoOQXAWlQnaSRKaofnXHJAW+XrA+0B2XmMEHt5ci1
         8gvlJDC6gLMXI37a5ezuPWYFbggBZzcPa8R1qW62WHvasCay4suGo1ReTn0J36ARXjSi
         WDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031920;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=chmIFf9otnf4BVuzj147sTCPlddTiwPoKvD528/XyEM=;
        b=UMsrGdP6guxUgPo1cyN3RS3GPWNUd4B+3hR+FvSSa0IVsOQCPSJQYr2GXMT0hn58q7
         VmqenzdkxoUStzyw28pzk9Cj7Ui2c6ewYnFC1SFHoOheOieUTqVbn1/DSAc6nhGDfJbe
         IE1ZfB52/krgvcCxDcsVkLKcJ7yYnerwPCZRcSofMDQblZrDbZDrNpn6pw7N66bbTS6F
         2GjcCAiwlbfKwimzGg03Iz9DH8QEaQdJNLKy1c9qsGxye1k+hNoLnu/L+ansGVNlhjKG
         +BoNhpmVuWiMXtN+BO6O5YpdlGwgbjzWYQvXQL3oZi+u0Pk9xvIPXvQc/j0Q6BgBQg8j
         XlCA==
X-Gm-Message-State: AAQBX9dPvT6ColQT6Dj7EfNzhJx69foiSk2obPSJvSqDhv4Pei0OuCgu
        rqzYuaST0D6UX0vXwMqNZFM=
X-Google-Smtp-Source: AKy350Y59aob1jgAXdefIG93eXZnzHkxMOHzj6A5sX1DRjN5M21GdkAkFJnknMgQXIQ0apLxDOddHA==
X-Received: by 2002:a17:90b:4b04:b0:23d:3386:95e0 with SMTP id lx4-20020a17090b4b0400b0023d338695e0mr16024760pjb.1.1680031920277;
        Tue, 28 Mar 2023 12:32:00 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b0019edcc30d9bsm21612742plb.155.2023.03.28.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:31:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH
 6/6] ls-tree: introduce '--pattern' option
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
        <xmqqtu20qinx.fsf@gitster.g>
        <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
        <xmqqzg7ylye4.fsf@gitster.g>
        <20230328180859.GB18558@coredump.intra.peff.net>
Date:   Tue, 28 Mar 2023 12:31:59 -0700
In-Reply-To: <20230328180859.GB18558@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Mar 2023 14:08:59 -0400")
Message-ID: <xmqqbkkcfz9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So it should be fine to just set TERM=dumb everywhere. What actually
> confuses me is that we try to do so already:
>
>   $ git grep -B1 dumb ci/lib.sh
>   ci/lib.sh-# GitHub Action doesn't set TERM, which is required by tput
>   ci/lib.sh:export TERM=${TERM:-dumb}
>
> Pushing a stripped-down workflow file to just run "echo $TERM" shows
> that it seems to already be set by Actions to "dumb" on ubuntu-latest,
> but is xterm-256color on windows-latest.
>
> So maybe we just want to make the line above unconditionally set $TERM?

I thought that Dscho earlier said xterm-256 is set by mingw when
nothing is set to TERM, which explains why TERM=${TERM:-dumb} is
not good enough to "fix" this one for them.

I am fine with an unconditional assignment for CI.

Thanks.
