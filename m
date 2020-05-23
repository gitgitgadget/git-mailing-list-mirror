Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5BC433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CB620870
	for <git@archiver.kernel.org>; Sat, 23 May 2020 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4tn5ti8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgEWPwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgEWPwG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 11:52:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98489C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 08:52:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so5611597ply.11
        for <git@vger.kernel.org>; Sat, 23 May 2020 08:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NmIwbJEL7oSHOnpv337DxuimiPW9hfdny1xG/mQTdmE=;
        b=M4tn5ti8grcdVzQTDRGlKq+MwrOsbSecRd8H8ghHE7wt/tioB44rN73T+QXZ4/dUob
         WJtu8seWixhUL+ggXthvLZ2u8i4SvorgeewL0Jug5Mf99Jrg6PpC5JNoG928r4r4MBDQ
         8ySXYMXROUdSjR9E1hAlDFN7JidOucxyJIfrykhpuHZll372uzSThDeRtxSW3kZuB15P
         ztbwT1tsAupJHBvpjeZpNTbIS8XHI1BnSwgzr08c+40jS/psM6PgJLLJz95yP74zl/hh
         Vq0RlNPHfjm2CNuprMP5iyR8jk+BpuRdMcnEh/gYsCU6jYRhRmtjz7XgE2ezQZ42uDWZ
         otIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NmIwbJEL7oSHOnpv337DxuimiPW9hfdny1xG/mQTdmE=;
        b=C9CZ/P1ESAe2nKrfjx3SglgUdl+/Qiv2YU8dPDGMrUFjVsb3o13nMqvc7Qidq9cpq4
         E5UjddADIppnKMkmtUQ14gCXgmLdb3/ugaAPwII5MgmD+9c0CWgbp16QdfccLP/XI+/r
         SSnFVK407zLP4M0kWvbjB/U0fkDea9w2LCoZsXBTdy1LpIVvu1ekuhRpFymQjCUV4Kww
         cWtcgz/oT7CgyWam/2o2FAK0qcLip3hhjGTB9ftCPkFLT1aN9tT6UljqaOMGPaLT5MKO
         5DQatCl/IhQF/yUEizGWfS9dYgA+/ZiaKs7O765Xka6pTLoXZsO34mxoQrqshDu0R9uR
         i0RA==
X-Gm-Message-State: AOAM53058UArylxvX62LI/cyerfFC94jsCsa37bdo9bDa/JAaC2vESDK
        X+0guOTxZcBzd2e47foIxNI=
X-Google-Smtp-Source: ABdhPJykE7kzE5vM8dxdnNZeLV3dQldK/HkunMgYSk8wwhNpipLtLcFKABrdhpCqC8wtvGzS7NLwSg==
X-Received: by 2002:a17:90a:890b:: with SMTP id u11mr555056pjn.233.1590249125714;
        Sat, 23 May 2020 08:52:05 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id z20sm8464510pgv.52.2020.05.23.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 08:52:05 -0700 (PDT)
Date:   Sat, 23 May 2020 22:52:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
Message-ID: <20200523155203.GA10163@danh.dev>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <20200521101455.63484-5-phillip.wood123@gmail.com>
 <20200523123025.GA20683@danh.dev>
 <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 2020-05-23 16:43:39+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> > On 2020-05-21 11:14:54+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> > > +# Checking for +0000 in author time is enough since default
> > > +# timezone is UTC, but the timezone used while committing
> > > +# sets to +0530.
> > > +test_expect_success '--ignore-date works with apply backend' '
> > > +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
> > > +	git rebase --apply --ignore-date HEAD^ &&
> > > +	git log -1 --pretty="format:%ai" >authortime &&
> > 
> > Those --pretty="format:%ai" won't print the newline character in my
> > test environment.
> > It looks like it won't print the newline if stdout isn't a tty.
> > 
> > 	git log -1 --pretty=%ai
> > 
> > doesn't have that issue.
> > 
> > I think there're some grep out there considers file doesn't end with
> > newline as non-text files.
> 
> Yes it would be better to print the newline, thanks
>
> Junio - are you happy to fix this up (assuming there are no other issues) or
> do you want a re-roll?

There're 11 invocation of git-log with "--pretty=format",
in 2/5 and 4/5

I think it's worth to have a re-roll to avoid mistake.

-- 
Danh
