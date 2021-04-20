Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C64C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB36141C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhDTXLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTXLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:11:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E9C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:10:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s20so4693265plr.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zK7ADla7opPnKJjT7v/YaXXcbAVHNberBoyWD3s/cC4=;
        b=a5KgtgVJDHKh+ap71j+xQ4l0PtvwL4+ey8obh/QXFhciuRD3+HwS3TekRxI7KDM5tW
         Y/vhTCsssaxfqtkijxTdd/CtHs7eHQOFw1AflIOSz1fd+W1apl/qhyU2MskhZeO1AyGM
         Zp34YZRZAMG73/miqNN+dskUHhspfBGeGQ5ySMFB82iPIzdGKxKxQuMDpal6uk+4atiN
         W3YlsVg0AhbuXGjyfn7tcP3R1RgwZyIphSBzbndThA4aRUL7MsIhpSo+D7pNu2dICL39
         zGLhUzBGRfgx4iFZsxNI4lZHbImGDD3ZNbMoSAvhqFtPvM6IB2h9zmjvxNnW44A7gfgA
         fV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zK7ADla7opPnKJjT7v/YaXXcbAVHNberBoyWD3s/cC4=;
        b=SH9IE7QvvgveZKddpYAJ9ZkLUHer2cFghCZM1JiMfnXN4MDp1GNLAyDOk6CRVgC6u2
         Fc/+40bHoP+W43+iPq8FyafbotbKtRqzlC1X05FHeOeIBaUZtKfsDYhe2vTKFOielx0v
         Uhaem759AHMykt0aNCm8p8We38UmhM159fIGdz9a9D2Pca9BMocrhUhI6O0Um8zamB14
         DaC0bk3l1UyYJoGINpPG1IJGXbI3R0av+0Zm0iKX9EavD7g9AgXVOOIKpA5QZv5JnQ4z
         JzRVuH4MlAZvoJJwCBmEy9LIKm0whGaj0simEs3rbjfwxsLkWzz5wXM16q7FtCopos5F
         WzHw==
X-Gm-Message-State: AOAM532a0ZUxirW6QGxTupzoSdrcTbEvq6qGOADq9jAf9iC4Wgr2AWur
        UnMIsw2hCP1+0Zaon8B1wFkz+JaPscJdvA==
X-Google-Smtp-Source: ABdhPJy79sYdWMoCezr7yjl+rwtzcQPir5sIXcp122NNsObQ644vc/67+XECQX4W1f4Cr9d6NDvTzg==
X-Received: by 2002:a17:903:244:b029:ec:9666:9fc6 with SMTP id j4-20020a1709030244b02900ec96669fc6mr17851683plh.63.1618960255878;
        Tue, 20 Apr 2021 16:10:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:828e:a107:e159:3343])
        by smtp.gmail.com with ESMTPSA id j7sm90037pfd.129.2021.04.20.16.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 16:10:55 -0700 (PDT)
Date:   Tue, 20 Apr 2021 16:10:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, albertcui@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: RFC/Discussion - Submodule UX Improvements
Message-ID: <YH9feTykPhimIA13@google.com>
References: <YHofmWcIAidkvJiD@google.com>
 <CAP8UFD0Ct8NofMdds=w0k1-jjX638L6QJQEJWVxqJ6ZPSoJUjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0Ct8NofMdds=w0k1-jjX638L6QJQEJWVxqJ6ZPSoJUjg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 18, 2021 at 07:22:07AM +0200, Christian Couder wrote:
> 
> Hi Emily,
> 
> On Sat, Apr 17, 2021 at 1:39 AM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > Hi folks,
> >
> > As hinted by a couple recent patches, I'm planning on some pretty big submodule
> > work over the next 6 months or so - and Ævar pointed out to me in
> > https://lore.kernel.org/git/87v98p17im.fsf@evledraar.gmail.com that I probably
> > should share some of those plans ahead of time. :) So attached is a lightly
> > modified version of the doc that we've been working on internally at Google,
> > focusing on what we think would be an ideal submodule workflow.
> 
> Thanks for sharing this doc! My main concern with this is that we are
> likely to have a GSoC student working soon on finishing to port `git
> submodule` to C code. And I wonder how that would interact with your
> work.

I discussed this a little with Jonathan N and Albert and we think it
probably won't matter too much. If anything, I expect mostly we would
touch the submodule--helper, and not the 'git submodule' builtin. But
just in case - it would be useful if any GSoC student were publishing
their code to a feature branch (on a fork, maybe) so that I could keep
an eye out for possible conflicts that way. Or, at very least, CCing me
and Jonathan N on patches :)

 - Emily
