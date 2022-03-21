Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02CFC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiCUXPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiCUXOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:14:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79737404249
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:03:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so21853111ljr.9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2WJLxrI9QhhjwhJMmMwUFCYR8S1sO0VCfKz+5gpxTg=;
        b=QHbSU3PZYQ577DCuOct0fr1iJvEXbi/pCDvRHvI7Q88WNqaHjBtJZq05zm+H5ol9xY
         PhzqKjtPZ2dQD0l9MW8LptC5XS7+xdZZd0Pky28GoxTZ/PbIqdIuyWqHgrerJaqn41f/
         TKlciO7IpksMW+nHykzYFVCEUyZtJMnuF4I17NQYI63kRXtHfZmF6KjBbZn+KKXS/Mxo
         wwxyondqOaoUzvlGJVUcqJ7ndcaFDSzvoz7UiR8fqVOHgkI/clWxds3kxB/1/25NJK8t
         Y27uVnqgVmedLBXwnYJGvHZBfys6KOX8ytj3htJFwreAV7uqg4fwNWH3BDqU4Noav69z
         a/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2WJLxrI9QhhjwhJMmMwUFCYR8S1sO0VCfKz+5gpxTg=;
        b=XHzGQ/9BaUUABM3NiCzpiXAL8smzl/UEkVcHcxByoGoXAvMuWZEBNI1yL4xB8QInX2
         7E5/PRRKShjBr/yKEEdbD/PMWOedWaOiUfRvY5YX1h9A2+os1WcEiRs+cdTHmGqJgqgH
         wkoc0vMcaKYIrs+Ner4Yj5rWZpb3n4ANfD0/huX2AN+kg0MMMiT159adpGlTL0dYQLYG
         aXg6MK1q3wkMH9dFFlmwpFqYrajYp1JaZ1peKGCOhe3XUP5nqmcOIuGBASbG6j0TBPuv
         kX5itjaDm0eE1cajqPR4jDVChPlXKilhhED6T+wvLaMxvIEzs/y7D1FAK2WBtHpLlXzO
         1B/g==
X-Gm-Message-State: AOAM532S5SYl4IRNFPyI+4qhtAPGO/nD3mheP6bcqf0F9wIRyxlT1Y98
        GaXKmsSnnhF7dMIn1HBlR1L4RGz9aXOGqykLiPw=
X-Google-Smtp-Source: ABdhPJxcUBmrcfVMi3PI3NWQkT4A7r+4GnjATgkJjB5mkij7A/uim4oWY8jwIYo4COXiAFA5uvaeEyAV1GPuQhv4M2Q=
X-Received: by 2002:a05:651c:241:b0:23e:42c1:2e4 with SMTP id
 x1-20020a05651c024100b0023e42c102e4mr17392300ljn.406.1647903752095; Mon, 21
 Mar 2022 16:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <6662e2dae0f5d65c158fba785d186885f9671073.1647760561.git.gitgitgadget@gmail.com>
 <xmqqv8w7yyua.fsf@gitster.g>
In-Reply-To: <xmqqv8w7yyua.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 16:02:20 -0700
Message-ID: <CANQDOdeQP7b1MefkGZKSuFb-kc9F01RPypxaowFwG-A+wyZGog@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] unpack-objects: use the bulk-checkin infrastructure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > The unpack-objects functionality is used by fetch, push, and fast-import
> > to turn the transfered data into object database entries when there are
> > fewer objects than the 'unpacklimit' setting.
> >
> > By enabling bulk-checkin when unpacking objects, we can take advantage
> > of batched fsyncs.
>
> This feels confused in that we dispatch to unpack-objects (instead
> of index-objects) only when the number of loose objects should not
> matter from performance point of view, and bulk-checkin should shine
> from performance point of view only when there are enough objects to
> batch.
>
> Also if we ever add "too many small loose objects is wasteful, let's
> send them into a single 'batch pack'" optimization, it would create
> a funny situation where the caller sends the contents of a small
> incoming packfile to unpack-objects, but the command chooses to
> bunch them all together in a packfile anyway ;-)
>
> So, I dunno.
>

I'd be happy to just drop this patch.  I originally added it to answer Avarab's
question: how does batch mode compare to packfiles? [1] [2].

[1] https://lore.kernel.org/git/87mtp5cwpn.fsf@evledraar.gmail.com/
[2] https://lore.kernel.org/git/pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com/
