Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C6C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiBKUIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:08:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiBKUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:08:40 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D437C55
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:08:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c15so13927989ljf.11
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUuxiwj5L5hH1+DHPt/m3ww+ohpSztkNazFO84YSHMU=;
        b=Op71jzBCdGlZAWMejP7TPGBwjtvCPvLwdZGivWHbVwIH0EPctC0ZoVPt+dASWyRt51
         C5Im8DwNXvb34Mf3Eu3SJqrgs4DEbR6KUmoY3dUhZBTf+EfHUYV5HrDdltq4/SfsDlcR
         IMrOXrcQCNL4I9omwiQ+D/v0xRARSJJYpz1hkpmDtAnw4PZOBsfP44DARmME/424BkY0
         jLx1PdACeO2y4e26T4F6gjhiV6/Tkzi7AkjM6jgUkCaFhw2KJW6lYqNvLXq9qha5QsPk
         UIa0kbdn2czhY40pJ3iGvK6bHPTyXwWHchShTeI4yoN4JnmUlSSOmTiqglvsWYzeAudL
         ASHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUuxiwj5L5hH1+DHPt/m3ww+ohpSztkNazFO84YSHMU=;
        b=o9MZ/WxDI4F27ATHWz8uZt/w5Prk6XXGBMaJXVbEahw0CiifHE1PZp3Li0wLyGVPXb
         Fgp7DWnj3UZ3Ysa9Ehywlo8zIvoaLNkBJvGueqjvUZlWXCA2N7w6xkcgKdOYx2X/HaTZ
         2roxafHoaphTfG+wuLT0NE/a7MUMBxM9lrRDZhLM6fxisl2l8wgyr4Br9dbq4Zegii/U
         oz3sFbOb8jQLkBVWu6ig3pAsyuH/g+iZL277eXv1rUby1gOGPFLncsBDeuHcfeJG/Vak
         60t6EOn9Rv059OvIo4COQScqLg5wNrY8UOuLhScwSJOkpjdcvpRR7fJowCMfSE0Ruhga
         Dg/A==
X-Gm-Message-State: AOAM5325O6YhFPfBpzs6/wiXGABB70f/TnGvsDhF45Wtc/iA7u6x3Xs7
        j8tYJbpY0GRo898FEjv5xJPYPp0Kfx4Hz/o206nkaCyW
X-Google-Smtp-Source: ABdhPJxv0JCaFGMCIrInNvm0+MWj/yveGXPs07WBKj/H1MQ0eT65x3oXGS/s6skCP5Y/Mnexlu1UeoKjB9iJ/kBAXPA=
X-Received: by 2002:a2e:a307:: with SMTP id l7mr1895191lje.363.1644610117337;
 Fri, 11 Feb 2022 12:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
 <20220211163627.598166-4-alexhenrie24@gmail.com> <xmqq1r09clxl.fsf@gitster.g>
 <CAMMLpeTBstt8qo2q6r=YCEi-h-G-EkjY=d7kHKeepzTvz1gmJg@mail.gmail.com> <xmqq5yplb46m.fsf@gitster.g>
In-Reply-To: <xmqq5yplb46m.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 13:08:26 -0700
Message-ID: <CAMMLpeTWvN45jTmoFHBS2+E+wEuBKTAnxXh3+RWzJc0O2rYy2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 12:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > What if we make log.graph=true also require feature.experimental=true?
>
> No.  feature.experimental is to give people an opt-in opportunity
> for features that we are considering to enable by default.
>
> > The log.graph option would really be a useful feature for people who
> > use Git exclusively from the CLI without any external tools. It seems
> > that the main challenge is how to give others time to adjust.
>
> Those who want to see log by default must need to twaek their
> configuration.  Instead of doing "git config log.graph true" and
> breaking tools, they can do "git config alias.mylog 'log --graph'"
> with the same ease, without breaking anything.
>
> So...

Yeah, that's not a bad solution. I actually have `git graph` aliased to
`git log --graph --abbrev-commit --pretty=oneline` for this purpose.
If a lot of people are doing that, maybe a new command should be added
to Git itself. It seems like there's not much demand for that at the
moment though.

-Alex
