Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065B3C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 21:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B9061430
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 21:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbhDUVGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbhDUVGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 17:06:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A6C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 14:06:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so30686610wrm.1
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G5y6mUb8C+mZ8AyyPb3pPEzHReBPMFUcvgNrpNiTLt0=;
        b=C2yL3/L4GhAM4KiMWmIhMTXG7XzXXcOQxy7OlJNw3AjeaF5rvzaQ7mI2rBuGTwpjmB
         5OZJk3PW2CUW+GIRpzxBQyTS/QH7tTrUBUlP3xmutEkA9pMdgJDMpxRFykR428tFpukb
         gVQh0HML2MzW6m4L89V/FRH8DtORkgYA2q+HIbB30dsUGzdLVFW2weVqSaJun54D7wgM
         4u1n/fy8Nh6cExTVbPeQ3vj0TlA7TPNBI7ylsqsZqXFm/n1BVGSpFtfVq9EmBJBVJ92k
         iKblzXskCA25CtqKIPdrmpUed1Y89QsDH8jxu7FfdcV/hhBRoTESnshc7J5PpyS+/Swg
         /sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G5y6mUb8C+mZ8AyyPb3pPEzHReBPMFUcvgNrpNiTLt0=;
        b=Ehv67tofJttjQ9y4qoMs/QdFjRCEPrM0MPJZFr6x5Er+GNrWP+KqOuJMydEODBVXv+
         TvKtVeAPTVf1TcUNisEstSntzfig3fFmKDhdY5gGoktUsiVICW15P7rchGqLULb9DQdA
         vMfNUHEwQKhjcUSgwhVShxP+04JIpHv/SarHZH6S7kSSous7B+KCr/3CFihZkYTqUDw3
         z14FdbiI/oVC+g9rf2Mqro+5nSVwDVD8aBkdSPLWQhqxiqLYu+0BK0fkG34CFE/yTKAc
         PqUZWB+S9yrd8qfT9mrBMHE0fFau+yBLbeKpjADcmiXI15IuDHvlCWpCrKQLEc/KB1Om
         OUaA==
X-Gm-Message-State: AOAM531De2d9SpLA3BI5dOW5XUAtzvoDfAsDybm0CPcpuJoToxUOKyXR
        b4c9xSqeidc6pMBvKmpdkHyDUlIL/R8=
X-Google-Smtp-Source: ABdhPJxaVcLkQ2/83wAfKTe1siGvEkBx+ibazjoC6JgwHNPJ5Qzgnv0UaCud2kloOm1yak99tfOLTA==
X-Received: by 2002:adf:b301:: with SMTP id j1mr18243wrd.301.1619039176257;
        Wed, 21 Apr 2021 14:06:16 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id m14sm580207wrh.28.2021.04.21.14.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 14:06:15 -0700 (PDT)
Date:   Wed, 21 Apr 2021 23:06:14 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] config: allow overriding of global and system
 configuration
Message-ID: <20210421210614.GB2947267@szeder.dev>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
 <7e7506217e4aac82e3a03013d24e6f885383ecd3.1618835148.git.ps@pks.im>
 <20210421204637.GA2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421204637.GA2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 10:46:37PM +0200, SZEDER Gábor wrote:
> On Mon, Apr 19, 2021 at 02:31:16PM +0200, Patrick Steinhardt wrote:
> > In order to have git run in a fully controlled environment without any
> > misconfiguration, it may be desirable for users or scripts to override
> > global- and system-level configuration files. We already have a way of
> > doing this, which is to unset both HOME and XDG_CONFIG_HOME environment
> > variables and to set `GIT_CONFIG_NOGLOBAL=true`. This is quite kludgy,
> > and unsetting the first two variables likely has an impact on other
> > executables spawned by such a script.
> > 
> > The obvious way to fix this would be to introduce `GIT_CONFIG_NOGLOBAL`
> > as an equivalent to `GIT_CONFIG_NOSYSTEM`. But in the past, it has
> > turned out that this design is inflexible: we cannot test system-level
> > parsing of the git configuration in our test harness because there is no
> > way to change its location, so all tests run with `GIT_CONFIG_NOSYSTEM`
> > set.
> > 
> > Instead of doing the same mistake with `GIT_CONFIG_NOGLOBAL`, introduce
> > two new variables `GIT_CONFIG_GLOBAL` and `GIT_CONFIG_SYSTEM`:
> > 
> >     - If unset, git continues to use the usual locations.
> > 
> >     - If set to a specific path, we skip reading the normal
> >       configuration files and instead take the path. By setting the path
> >       to `/dev/null`, no configuration will be loaded for the respective
> >       level.
> > 
> > This implements the usecase where we want to execute code in a sanitized
> > environment without any potential misconfigurations via `/dev/null`, but
> > is more flexible and allows for more usecases than simply adding
> > `GIT_CONFIG_NOGLOBAL`.
> 
> Something is still not right with this patch series, because:
> 
> > +test_expect_success 'write to overridden global and system config' '
> > +	cat >expect <<EOF &&
> > +[config]
> > +	key = value
> > +EOF
> > +
> > +	GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value &&
> > +	test_cmp expect write-to-global &&
> > +
> > +	GIT_CONFIG_SYSTEM=write-to-system git config --system config.key value &&
> > +	test_cmp expect write-to-system
> > +'
> 
> This test fails on Travis CI's Linux32 job:
> 
>   expecting success of 1300.184 'write to overridden global and system config': 
>   	cat >expect <<EOF &&
>   [config]
>   	key = value
>   EOF
>   	GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value &&
>   	test_cmp expect write-to-global &&
>   	GIT_CONFIG_SYSTEM=write-to-system git config --system config.key value &&
>   	test_cmp expect write-to-system
>   + cat
>   + GIT_CONFIG_GLOBAL=write-to-global git config --global config.key value
>   fatal: unable to access '/root/etc/gitconfig': Permission denied
>   error: last command exited with $?=128
>   not ok 184 - write to overridden global and system config

  https://travis-ci.org/github/git/git/jobs/767898817#L6931

> Yeah, that job has a weird environment with Docker and 'su'
> interacting in a way that ultimately builds Git with 'HOME=/root',
> which in our build system means that 'sysconfdir=/root/etc'.  To
> reproduce at home just run:
> 
>   make prefix=/root && cd t && ./t1300-config.sh -V -x -i

Hrm, that's not the only test that fails, but I only ran it with
'-i'...  but in fact most subsequent tests fail with the same error.

I think the culprit is the previous test case which I too eagerly
snipped from my previous email, so here it is again (copy-pasted,
whitespace-damaged):

> test_expect_success 'override global and system config' '
>         test_when_finished rm -f "$HOME"/.config/git &&
> 
>         cat >"$HOME"/.gitconfig <<-EOF &&
>         [home]
>                 config = true
>         EOF
>         mkdir -p "$HOME"/.config/git &&
>         cat >"$HOME"/.config/git/config <<-EOF &&
>         [xdg]
>                 config = true
>         EOF
>         cat >.git/config <<-EOF &&
>         [local]
>                 config = true
>         EOF
>         cat >custom-global-config <<-EOF &&
>         [global]
>                 config = true
>         EOF
>         cat >custom-system-config <<-EOF &&
>         [system]
>                 config = true
>         EOF
> 
>         cat >expect <<-EOF &&
>         global  xdg.config=true
>         global  home.config=true
>         local   local.config=true
>         EOF
>         git config --show-scope --list >output &&
>         test_cmp expect output &&
> 
>         sane_unset GIT_CONFIG_NOSYSTEM &&

Unsetting GIT_CONFIG_NOSYSTEM like this does affect the environment of
all subsequent tests and their git commands will then try to look at
the system config file.

Putting this 'sane_unset' and the rest of this test case in a subshell
seems to fix the issue.

>         cat >expect <<-EOF &&
>         system  system.config=true
>         global  global.config=true
>         local   local.config=true
>         EOF
>         GIT_CONFIG_SYSTEM=custom-system-config GIT_CONFIG_GLOBAL=custom-global-config \
>                 git config --show-scope --list >output &&
>         test_cmp expect output &&
> 
>         cat >expect <<-EOF &&
>         local   local.config=true
>         EOF
>         GIT_CONFIG_SYSTEM=/dev/null GIT_CONFIG_GLOBAL=/dev/null git config --show-scope --list >output &&
>         test_cmp expect output
> '


