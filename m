Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7368EC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449692077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0V8+4an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDAEUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:20:25 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:36626 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDAEUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:20:25 -0400
Received: by mail-qt1-f176.google.com with SMTP id m33so20591259qtb.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jR6Z/LXBwzfQetZGOUMa2kavY1Apo0jBS5QCGksgZfk=;
        b=p0V8+4anP2DvDDTakiBO/zero4mc9SAX+dLanKnuFykIKfphSuAqyXULao2CVgiCm7
         xfaHwQSM0692PrBgi0Lgd/A08uk/ZJGrVeDPqZiKTRhMofpXCbV7gYzroFidOMX4lzdj
         jvtwvTKNlLp3Xi1zSPG+rmuudKDwQJYNMLijB0C0HA7zOvLtiL4AjdPQx9ZjvAADGmKL
         7SrV8Ezougda4PPt/o0Z/JFxZULH/Hw4Z557wHuV3Ub6DI2SdLnQ4JTNzmJjNxM6WlXt
         C7UHHPIQHbTpaXTH5HajnagYCeWNwyYCZ20xu/JOg7RS5Ejr2p0PIhwaayAVCYaYir4p
         lVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jR6Z/LXBwzfQetZGOUMa2kavY1Apo0jBS5QCGksgZfk=;
        b=kSQ4PqI2hLGfE1wTmChGXGYnuG7V2lqr8YJkutIgxe3seju/S0wtNL5gRHIb8fYwu9
         Ckrsc1We5QuerucgUfUybhp41dE84Ecztmf0iTIsZ/OZT9Cp3SSHaAfEsiyo21kJIVU3
         3YQUWnzUAT1Nh+G3KZb67hmgxKlAHQ+9gT75MU94ZVWErHNWEgKf8QVLaGaI4iuyj0fe
         rw+tvLEpQnWQ0kclPuz5nG54GYx3QkjZSGRCuJ3BMYLSSP+4HOsCP6zxjsHMLrdqZ8VZ
         XwThd5VnSuZQT+ZcU2TUS/no6qExLcC0y1lWlrEC0dcL2qOJwE+9jie3IYeQnPcEQEYq
         4LxQ==
X-Gm-Message-State: ANhLgQ3Lw+TajQfXUFGIIWMlTZxF7RZC7Ar8GRW3YAJCDOc+f6KvfH0O
        nrYCq+iYX16l5Ri5KEB1YBg=
X-Google-Smtp-Source: ADFU+vsNHrO/sW8tTtgBknfYvWTR2E0ONE9DP1QMTwxpMy9torG08vS79BoA5yWeLIVc2sviVoWUEA==
X-Received: by 2002:ac8:17ab:: with SMTP id o40mr8545569qtj.308.1585714824255;
        Tue, 31 Mar 2020 21:20:24 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id r34sm708453qtk.89.2020.03.31.21.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:20:23 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:20:21 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     _RuRo_ =?utf-8?B?KNCQ0L3QtNGA0LXQuSDQodGC0L7RhtC60LjQuSk=?= 
        <ruro.ruro@ya.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git pull -- error: nothing to do
Message-ID: <20200401042021.GA780945@generichostname>
References: <8017591585671131@myt3-605d5ea4bc20.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8017591585671131@myt3-605d5ea4bc20.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrey,

On Tue, Mar 31, 2020 at 07:15:13PM +0300, _RuRo_ (Андрей Стоцкий) wrote:
> After updating git from `v2.25.1` to `v2.26.0`, I've noticed that performing `git pull` on an up-to-date repository now results in a non-zero exit code and `error: nothing to do` on stderr.
> With version 2.25.1, `git pull` used to finish with exit code 0 and `Current branch master is up to date.` on stdout.
> 
> The current (`v2.26.0`) behaviour only happens with the following config options:
> ```
> [pull]
>     rebase = true
> [rebase]
>     autoSquash = true
>     abbreviateCommands = true
> ```
> If any 1 of the 3 config options is not set, there is no error.
> 
> I think, this is a bug since many scripts and utilities rely on the exit code of `git pull` and the current behaviour causes false errors.

I believe that this bug has been reported already. Can you see if these
patches fix your problem:
https://lore.kernel.org/git/20200330124236.6716-1-alban.gruin@gmail.com/

-Denton

> -- 
> Andrey Stotskiy,
> ruro.ruro@ya.ru
