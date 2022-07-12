Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9764C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 01:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiGLBw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLBw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 21:52:56 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF772AC5D
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 18:52:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c86fe1dddso67155027b3.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F68Cu/DPmi87wCl6QsAvOyZq2mkjQyxYqLcQwefhOsw=;
        b=qGC1pmmH1rsHlEI3xk/+Fy4derbgE/TCqm6yguxgJAlJzmO3APnI2O2aQMZJwz4I4l
         ZzXPVf0MGg73adSe2VwLYSlfZoqtGv+TUuMAffbCpnpOXp5LzsfdoWfRdusb4FX7hFeE
         v1h+SalxfRnleqVqHL3S1fd54SNFIM83fQDpXF/709FssBYxvboU7PSjL9WV6bfvsLNX
         /138iRyW9wha0h748mVU8T5+62HjqHZokC9dOM5R7K/EZI+Zs5mINNw4ymS7KabZFgWR
         72hZJPE9ZB4Y90iKaASLZv0CMOP6rk5G4V8rBheY2UEJwqiua3RwT++c/i12jLb3vnG7
         j54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F68Cu/DPmi87wCl6QsAvOyZq2mkjQyxYqLcQwefhOsw=;
        b=zfyrm4+39hEmH1gVU9/E0H1Gj1/tqmkGiFYKB0/Zkr1oK2qPN0xaVG/1msMqlRw5fH
         cpqJl0bSE8n0bDxFF3UhJ1fmIufEiR1pvS3J4mxy9c2rpIO0TW45ZPIcqze7Z6cvDjV/
         tj5UGrR+7IJQP8kUtmX+zv5w8hDDj+7YuoTBRKoknc8p+OcH2bUCWdTppEavhJA+2LuO
         IFzmnV/23Gq5FS+C2IoAgrkAg4pS0zeyaKAXpyP1dnRsuwUpFaq5u2Q62XYZaLB4VgJW
         HUoTEDNoIkGuVK83mYy5L17XQ+sXzNQIWG0nXGaUnGuYBG0Ot/OgMn2BlaG+3rb/FdS6
         +pBQ==
X-Gm-Message-State: AJIora/mBkIu4gfQRLb26DCvGgylZful1Nzj85M1cTxzi3TbBNIe1U20
        InoJ11hyhlhu4Qneun/eOeT6iqrWXxzw7EyOtxq2pQ==
X-Google-Smtp-Source: AGRyM1t1+77W7t/lm0S/8Zp7TAf2myKDDV1eEO3E4lzEKs/G0VO7TZ7f9zZNKrMBlY7S4ZBQzPoSfZ0kCOs2GU2obdY=
X-Received: by 2002:a0d:f445:0:b0:31d:4f2c:a0b0 with SMTP id
 d66-20020a0df445000000b0031d4f2ca0b0mr15428847ywf.73.1657590774196; Mon, 11
 Jul 2022 18:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656381667.git.hanxin.hx@bytedance.com> <cover.1656593279.git.hanxin.hx@bytedance.com>
 <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
 <165736941632.704481.18414237954289110814.git@grubix.eu> <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
 <xmqqk08jo147.fsf@gitster.g>
In-Reply-To: <xmqqk08jo147.fsf@gitster.g>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Tue, 12 Jul 2022 09:52:42 +0800
Message-ID: <CAKgqsWVD2108f0PyJGp6mVKp2cGd_V_MiiQO3SAPm+LEHcb2mA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael J Gruber <git@grubix.eu>,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 4:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> 512 is probably OK in CI in an isolated environment but is too low on a
> >> typical "What you mean I'm not working? I'm waiting for the test run!"
> >> developper workstation.
> >>
> >> Conversely, which number would be too high to catch what the test is
> >> supposed to catch? Does it incur a big performance penalty to go as high
> >> as possible?
> >
> > This bit me, too. It works if I run it standalone:
> >
> >   $ ./t5330-no-lazy-fetch-with-commit-graph.sh
> >   ok 1 - setup: prepare a repository with a commit
> >   ok 2 - setup: prepare a repository with commit-graph contains the commit
> >   ok 3 - setup: change the alternates to what without the commit
> >   ok 4 - fetch any commit from promisor with the usage of the commit graph
> >   # passed all 4 test(s)
> >
> > but it fails when I run the whole test suite with "prove -j32". Or even
> > easier, just run it under "--stress":
>
> Understandable.  I am usually on a datacentre VM without graphical
> UI so the process count there is much lower than on a typical
> developer workstation.
>
> I wonder if we can just run the test without any limit?  If in an
> unattended CI situation, hopefully they will kick the job out due to
> quota, and on a developer workstation, there may be processes killed
> left and right, but that is only when the "infinite respawning" bug
> reappears.
>

The tricky thing about using ulimit is that it's tied to the entire development
station. I have tried to run the test without any limit [1], it did finally be
canceled after 6 hours.

Remove the "ulimit", once the infinite loop reappears, this test seems like a
bomb to developers that quickly consumes all resources? While "1024"
works fine with "--stress" , there are reasons to wonder if it's enough, or
maybe we can take a value like 10240 that we wouldn't normally reach?

1. https://github.com/chiyutianyi/git/runs/6962635320

Thanks
-Han Xin
