Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB4FC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 21:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F2C20774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 21:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="PGQL1snN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMVQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 17:16:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B0C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 14:16:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so8773925ioe.9
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=78OOnGfYptbmBDngDBNjYYwINkgdvLftiU1Ql/30EIw=;
        b=PGQL1snNhprHFyh7TcmRPEcy24xiWNBh6g/XuCVC6gvOujn5W0UFNBM/Mp6LQlUTmF
         W1Dds6JWzEvves7zuHZ7a4Dd7/jjhDy15mFadlWpjhmleEaAaM4ls2lrubCrDn28OFKs
         e+4t2ZGEChk3AJLTcgfmKMgZvoPbwyDK91eyLwMY9gUHEKpuemuSLgL0aWSS3JTsugKS
         k/8wmQRNSuUH4idT0SEcAOKE/Dq8I103bIRuKO+sSAX7AXvFCr3oatmS6WIO20nF16yT
         bmL+C6VzlfVvT2LD4UZYRyfmuLYK2EzAfuCD3hgAoueKfRmtAdf6WmrkhP7DD6uyra88
         1WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=78OOnGfYptbmBDngDBNjYYwINkgdvLftiU1Ql/30EIw=;
        b=hbGy3N6H1OZJF4I1QwAEIhnemb/S0Ef9sOSFv66UAevtY/48r09zLomu1ooPkt8W1A
         C/vTC5khu2xb7E+JlTI/+c5OWpBK64xtMe6TefjtLJOhF6+pmE66A8mW0hx+Ix++6R/Z
         AhE4KQvhIimReupYz/1KlPA3Uic5oMbnMPciMsga1c4hDe+K5TLIm+MFWJ/bP019rcz8
         vIM5216xf0/Bz8E8qefMhdUsIK4SM89ErPV/mcJZj2JdOomDkFC0eBQo74LSJsPVxsSg
         /pd6Yo8P+s43YZa0abJnrLXmhCla/MnLz4xVhuz7o4Dav7MIHCnOo0kjy+m/6BHfD7OP
         SE6g==
X-Gm-Message-State: AOAM532YeNvK6vDyAwegzcbzvq1I6TSBNZ0UhQNjdANXen9F9twZiL4n
        rArBNMMXuySepzMHFHKcOp1NE6RMo5f+X5f9yEEokCtG
X-Google-Smtp-Source: ABdhPJymHP3MgY12Y02d/SkqqAe9O0bYvir7ho0oPwQlfrKCmOIe+vswXU6yAYdcUNNSX7T3uEBMyAdzG1cb39KeTp0=
X-Received: by 2002:a6b:4e0e:: with SMTP id c14mr6351932iob.8.1597353403462;
 Thu, 13 Aug 2020 14:16:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a302:0:0:0:0:0 with HTTP; Thu, 13 Aug 2020 14:16:42
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <CAGw6cBsctN0-BP6k7p71-edsHR4BxJWai4Qz5m5gi4J6pYh=Kw@mail.gmail.com>
References: <20200623205659.14297-1-mforney@mforney.org> <20200623205659.14297-2-mforney@mforney.org>
 <33de1078-5f19-e76c-2a30-1754494d1e31@gmail.com> <CAGw6cBsctN0-BP6k7p71-edsHR4BxJWai4Qz5m5gi4J6pYh=Kw@mail.gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Thu, 13 Aug 2020 14:16:42 -0700
Message-ID: <CAGw6cBs2O4eLGu=CWNM4G3aL0hjOtxxOuy2wMBadd9o5Wb9iNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: use submodule repository when preparing summary
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-30, Michael Forney <mforney@mforney.org> wrote:
> I attached my best attempt at a test to trigger the error. The
> probability of the test failing correctly (without the fix applied)
> seems to depend on how many commits are present in submodule before
> the first commit in the range of changed commits. This can be
> controlled by adjusting the `seq 1 X` in the for loop. The lowest
> number of commits with which I have been able to reproduce the bug is
> 3, where it occurs around 1% of the time, and if I set it to 200, I
> can reproduce the bug around 99% of the time.
>
> Can the bug fix be applied without a test? If not, hopefully someone
> can volunteer to craft a reliable test (assuming that this is even
> possible).

Still looking for any help with this. It seems pretty clear that this
is a bug (I am not the only one who has hit this), and I'd really like
to see the issue fixed. I gave my best shot at a test, but I don't
think it's acceptable to commit a test that gives a false positive
some percentage of the time.

I see that my patch is still blocked as "Needs tests" in the what's
cooking summary, but I really don't know how to proceed from here.
