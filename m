Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7D2C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EF622268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQC6rRvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKBTTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKBTTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:19:00 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64404C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 11:19:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s9so15896994wro.8
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/D7KMNpcVQ+qvSFHSuHg+i+G344+Yaxgy5ZQRTCTa1M=;
        b=bQC6rRvkQ5+4aTLfbF24s/6oRKvP6XLhFDQGaN3GZLSBr3ER+ZZJe6Mis4MKHzQyYj
         y1PiEpLthAMBFfE3TIz/D05Tkw0NIunjzL/Bpjy+EShFTmXhFWHChwZCHtBj9ko0M6l8
         wni+rEZE6Mdz1Q0UI4Ov9uxjJYU2pn/yBsy6KzWsZlFQl/vs8DllSQng9uMlNfnl/D5z
         ocLSu6UWYhGSjRX84/TKKrGspjIvJDxALu3yPrxnyEUHWrK6Witn7EDhvlDlkeB5nF3P
         3DMtGCTeDIixmcWC9qJtubjiryWMrw5Y+evg37ODN60XaLsDPnL/LVKUAcmGQJ0SKxVo
         Zkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/D7KMNpcVQ+qvSFHSuHg+i+G344+Yaxgy5ZQRTCTa1M=;
        b=GQGuQvDiHjkn6khykJ46HASw3GsfAaXZzXBDT/Zhs6np0DCducdTPU1yf2QpcIbGs/
         IyM3iV7keJk/KCgqj1ChTPHnKpmSqENv9rI/0DjRfq2Y+ocLB8KSH9ftV11J2zxkbuE8
         NjtfRAPT48ovJINP4FDpz3Mqv9ozLHd2K9owcE7TigCHb21LT2+vdLkmPwjtyRitx42O
         6k3/Rco4hA+Ka4AjWnsiPVQOdhYvpe1UpfSGLVUwEJrG/C3gnKAokX7nhrUbHpF3zDOv
         SXF93WBlBEHYBGcUW8EmzUSgNd9WPbeMaV1ntkCyfowlZTNiA+67Idqe5a5gzwf3dq84
         jDxg==
X-Gm-Message-State: AOAM531vluRR1WJm4j+GCdhShgP4KgKXBJCwxivzUGI2QcnyXJifu/sV
        +cS7zH+ytQcciQYzlrEJtI7ndcZUiYQWVeBKEtMA+ZJvotA=
X-Google-Smtp-Source: ABdhPJybNu/YR3/0YQg8+Sc5cCDUZplh07F9jqQwyUAY0DK9RRoUhruv3ifnXn0T0csyIl0To6TmAbeLJ+EPVIBBUKw=
X-Received: by 2002:adf:de91:: with SMTP id w17mr21513841wrl.84.1604344739132;
 Mon, 02 Nov 2020 11:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com> <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com> <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com> <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de> <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeelh7y23.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 2 Nov 2020 13:18:48 -0600
Message-ID: <CAMP44s1N+U79+sZ-smMrtePnE6_ottAB2uTQb-fdctc0ibZB_A@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 11:16 AM Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > On zsh the situation is different; zsh by default has a git completion
> > (/usr/share/zsh/functions/Completion/Unix/_git), and some might argue
> > it's more complete than git's zsh completion,
>
> How is that completion script developed, maintained and distributed?

By the maintainers of Zsh.

> By "by default" I believe you mean that it gets installed when you
> install zsh automatically.  Is the situation different on macOS land
> (which I can believe, unfortunately)?

I don't believe it's different.

> Another question (this is for Felipe).  Is
>
>   https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast
>
> the one that comes with zsh by default, or is it something else
> (perhaps it is the go-to version for those who are not satisfied
> with the version that comes with zsh by default???)?

It's for the people who are not satisfied with the default Zsh
version, which are a lot.

-- 
Felipe Contreras
