Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308EC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 04:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944B660F6B
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 04:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHaEQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 00:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhHaEQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 00:16:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264DEC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 21:15:36 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z2so18678910iln.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBIZcWTRLzc/0njvL9YGvDumleaAWDLCwEfcAILHR6I=;
        b=bYWdSzPiT2TbKi5X+QPLvjUKDakEcNcS1frHahKNm6QVA1/DUGorlZnEfkfoSIVhnX
         5fL81XuOxNQCmijQtpQQV/dEuj2oUi4ZNFG+8VOjlIcEcecIJsoLacbpcYtFwcpGd06O
         Wd5epZ4Y7nkWKZbx/nAm1ncaOKYQ6P126w1rr6kNaIhbxuzVfn12AafFJA4Y50e9wvDW
         FtMNJTTx8vKnsfPBgwF/LtFeUIU4YUsAUDY7SXprrocfNUasvIVf3Jdmw8Cn4QR4ziAC
         Wnvo/TED3QmrWVvnPZpGZIDwfBiWhbeH79rLPYHNElNoAMGBYxjiVa2viIXyOP4pHXTU
         Nw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBIZcWTRLzc/0njvL9YGvDumleaAWDLCwEfcAILHR6I=;
        b=pf1R/AISx0lpBnRcxuRhKVHkPTg+tURfvlBqG2AYPHeeyqxUfvneTkRzBJOoVh2w9P
         7uEEx9ei1FWaWwFTzrl4FJFgmFye9KQSCxdZ8ST3jZgub0Pm/sFPZ1E1eGhPYNEkjfBs
         W4BzazL1Bg3xc2mzHjLU3dC6jkVRaLDsWnwe0g2ft7gzhtIFbkOVzc+bIlpI5BMZB8Xo
         Ky7FgZARJJAHXytj06hfKcees1lnlDGagbq0u3rC8IZD2ZTOT2ONQsqD4X64lWLjmzKp
         m/NTonwLDnUkJmFfeKGrZO3P2swG6rGJHzV0ZSWavxTZsyzzXZQ2d89XSAlULnwKzeBH
         xYmQ==
X-Gm-Message-State: AOAM530nAyL+xYnP9yTS3l+yWoCLPSgB+NC2ZIp1LG0+lHTd40JXOovM
        TmCAYEyUsrqbWspVBI/Wd2/VfR69fG9NKRCzncOKFQatrthE1IJ/
X-Google-Smtp-Source: ABdhPJzkFm03Ay2m62sV46nFHH7PA81ToMJLVZ2OuLCCslfMUbHWKawothroGbwZE+G6g2wRxcrl5sRWiJ/MpIZZrvE=
X-Received: by 2002:a05:6e02:ed1:: with SMTP id i17mr19201318ilk.272.1630383335308;
 Mon, 30 Aug 2021 21:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
 <20210823160455.32397-1-chenan.xxw@alibaba-inc.com> <CANYiYbEL2T897jMZFg_F-AgomrEj3EcEC2ZTyBZMB550k_PPbQ@mail.gmail.com>
In-Reply-To: <CANYiYbEL2T897jMZFg_F-AgomrEj3EcEC2ZTyBZMB550k_PPbQ@mail.gmail.com>
From:   Xiaowen Xia <haoyurenzhuxia@gmail.com>
Date:   Tue, 31 Aug 2021 12:15:22 +0800
Message-ID: <CAHLXgnaS9yocd+OV=uCi+Udd419RTy+=-o7cjD79LyZR5MbpYw@mail.gmail.com>
Subject: Re: [PATCH v2] http: add http.maxReceiveSpeed to limit receiving
 speed of "git-receive-pack"
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Xia XiaoWen <chenan.xxw@alibaba-inc.com>,
        Jeff King <peff@peff.net>, Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for Jiang Xin's reply, it's very helpful.

But I carefully considered the purpose of this patch this week. As
Jeff King and Randall said, speed-limiting should be the function of
the operating system or the switch/router, and I agree with it. Users
may not need to limit the speed for `git-receive-pack` in most cases.
On the other side, for the ssh protocol, there is no way to limiting
speed in git. Please ignore this patch In general.
