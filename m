Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F87C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4772075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596056237;
	bh=oeIFPRv8XOvJUT1VqDhGeb+yHVhqWJ3OIEyBo5DTvqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OzNUN8RZ5TC8/EaGUP3o2EXFlhhWqaS9ueH0rFMAR6jUOVlXy4jMPJCdqhG2aQStp
	 USqpuMAvdf36zIWrOMlx5jV2s0G2lQwhs+0sVts/dVEKtpcTDoH0bzU3SxiO6Mz7Is
	 VxsRm5LdqCnO5rQX+UOn3YQFnIibnzfggMRsdVE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG2U5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2U5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:57:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B8C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:57:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so3034393ljc.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktAIduaS1qT3qTb0HaonV5pwoBc4SiIeq3oS3+ccmOY=;
        b=T0NMdSus+R19BT2CR9u1QwkG1jI2tBqvcQY5kceVz/XG27v1D80cfKjx7LH4kaprjQ
         GNdfrFZYgm/aRhZiF/stSbacuCLDNLaG2rzTF37pHeTyvyoOCRwHJwC1F6LSL2+Pe5Bf
         QudvbzA/1OkRqJsnnBU9oy8yBWvrv27BSP7b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktAIduaS1qT3qTb0HaonV5pwoBc4SiIeq3oS3+ccmOY=;
        b=YMxJflLTnA2ZyzT3J6SbsDxFOIYf2lJxPaKs+j65uNuo2OfNz8e6AcyBYKp8Ewtrz6
         ftw5fRsuQYay5xgD4gtVWIwGWMRXDnFbDPD0QjDMsjrsnraJfTtRyVsiylttBjqUmKUr
         VlS/R2FQ1BylTJp2H89MpYY/I0o0nU6zYCGPioaxR2306chhyVLAPiBo7uxDK3BtBqDI
         nM6LPquygPqcYwC1AANE2kosh/kpa0DD5DzyWHvOn3FOMHpjTQROazp9TgNJlFcA4m6Z
         LuvwT1xW5vnQY0Rw4AlptbIsqu/DgdcNHTgkfCTH4I/swgbr4hPicpz0yTo9x3Y1C+Th
         RWiw==
X-Gm-Message-State: AOAM531G7XnoTTP/WUzDKBjHICNJ4BV1a8UNS7PAZq8o7bX07b8ABNmc
        IvVcCVQCkChNY2J2MjdiP+E6KKmBWW0=
X-Google-Smtp-Source: ABdhPJyxlVzIvu7NwXS10tWZzM5z54f2Ryf2bxJVyRzfwePuDMiz4s9/RRiav89sHEvPriXtSWn+IQ==
X-Received: by 2002:a2e:961a:: with SMTP id v26mr74644ljh.467.1596056233401;
        Wed, 29 Jul 2020 13:57:13 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s2sm702264lfs.4.2020.07.29.13.57.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:57:13 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id i19so13781265lfj.8
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 13:57:12 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr26784lfo.31.1596056231391;
 Wed, 29 Jul 2020 13:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <20200729203856.GA519065@google.com> <CAHk-=whYOHQ5T-5ozUG6DCfKUyJ14qPoVWqsyHSjQBK450wigA@mail.gmail.com>
In-Reply-To: <CAHk-=whYOHQ5T-5ozUG6DCfKUyJ14qPoVWqsyHSjQBK450wigA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 13:56:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRn-8S9TcpLJXwf2VP7vrbQAW2W=eyB0D6roYk0OAckg@mail.gmail.com>
Message-ID: <CAHk-=wjRn-8S9TcpLJXwf2VP7vrbQAW2W=eyB0D6roYk0OAckg@mail.gmail.com>
Subject: Re: Avoiding 'master' nomenclature
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 1:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I was annoyed by this because it took me much too long to notice
> that my merge messages are now unnecessarily ugly for the last two
> days, for a _very_ bad reason.

sed s/days/weeks/

I guess that shows how much I look at the boiler-plate.

I try to make my merge messages readable and spend actual effort on
formatting etc, but take all the git-provided stuff for granted.

This violated that trust.

           Linus
