Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE161F404
	for <e@80x24.org>; Mon, 12 Mar 2018 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeCLWBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 18:01:10 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38930 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCLWBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 18:01:09 -0400
Received: by mail-wm0-f47.google.com with SMTP id i3so18999371wmi.4
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3h+6PauneQoqmItAGigDHKEg7VxpXY1tIOCFaXDkces=;
        b=YNvW0J1Y6AP4fPICwcFnhpXbyRTsumvDdx+O6N07O8lbB/8PzrO80mRs/gWS86XTcs
         lzvoTr2XbxIBNv9EaRcMnVpG9SkMfh8iVApsGgKz2AIjit2sK5C70Ge2/Zti1UdzK9dW
         M2Vu/TEf0PcQa1VTrisfvdn0J+G7xgmtdZpDSrWGOeM0dQilpd5RTRaYJFJU6D+Q277R
         r4ltAT7n5Md5XW0KSDWnK9jj0sP7nSGDjQTSFR7QoEZ3jrC+2sqYB+Wbic4m8NJaaWD2
         suTKc+fUPzzn0DSf1d0cQHo92UqNHAIUEtwWLvrZB040J6Xje612ONi8LFOFP/aOOZ1b
         lYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3h+6PauneQoqmItAGigDHKEg7VxpXY1tIOCFaXDkces=;
        b=K4Ge1atCrQYKIm4i9FHXJmInxkG+tk5kLNw/xvX/g50eSHARwK4fr1Z1a8QHaQGYZU
         HStTM0jaoBxlEZh/EeHeu/giB2GpSjACCVvjBqddK43bth3V0u7CxAUVUjSLJsAvjZln
         xRCLzY101Pi7U79BYEYNx3MZsWtSMc723H5zScixmCeAtDRfiT0QkHum2KZaKYW5LFDR
         6Wl1j0v8wcfZSZ2WC8aqOQFPHLcecNpRjVEFEDY2bnv3zyf0uTJg7rNp6a2nUA3DAS8b
         Y0749FatoZUG5tSBZonlyOGqmYCnKYMDixSJYdaqDxP+HE0XNiEDeKAZaS/h41Zz3X1f
         4uHw==
X-Gm-Message-State: AElRT7HaHbEk5fNj2YNZ9QDqnA1xbOcp9LraPrw2pGNcKTa9a30PIyFV
        uswA/mf9NIJ+5chJ93VeXRw=
X-Google-Smtp-Source: AG47ELsvCXd0HEVl1r7karC6KN+L1kRmoIpRSwSpqUMHgkJBw7OlZVRVoyu+mdSTHk4L2cPpwV6r4g==
X-Received: by 10.28.239.8 with SMTP id n8mr7305163wmh.120.1520892068627;
        Mon, 12 Mar 2018 15:01:08 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id j42sm8631178wre.55.2018.03.12.15.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 15:01:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to "repack -ad"
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-4-pclouds@gmail.com>
        <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com>
        <xmqqd10f20k6.fsf@gitster-ct.c.googlers.com>
        <87bmftqg1n.fsf@evledraar.gmail.com>
        <CAPc5daUcA8MVKH515gvDzUXBThq=8+EXouOQ2zxZGmp5YH5nfw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAPc5daUcA8MVKH515gvDzUXBThq=8+EXouOQ2zxZGmp5YH5nfw@mail.gmail.com>
Date:   Mon, 12 Mar 2018 23:01:05 +0100
Message-ID: <877eqhq7ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 12 2018, Junio C. Hamano jotted:

> On Mon, Mar 12, 2018 at 11:56 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> As someone who expects to use this (although hopefully in slightly
>> modified form), it's very useful if we can keep the useful semantics in
>> gc.* config values without needing some external job finding repos and
>> creating *.keep files to get custom behavior.
>>
>> E.g. I have the use-case of wanting to set this on servers that I know
>> are going to be used for cloning some big repos in user's ~ directory
>> manually, so if I can set something sensible in /etc/gitconfig that's
>> great, but it sucks a lot more to need to write some cronjob that goes
>> hunting for repos in those ~ directories and tweaks *.keep files.
>
> Yeah, but that is exactly what I suggested, no? That is, if you don't do any
> specific marking to describe _which_ ones need to be kept, this new thing
> would kick in and pick the largest one and repack all others. If you choose
> to want more control, on the other hand, you can mark those packs you
> would want to keep, and this mechanism will not kick in to countermand
> your explicit settings done via those .keep files.

Yes, this configurable mechanism as it stands only needs /etc/gitconfig.

What I was pointing out in this mail is that we really should get the
advanced use-cases right as well (see my
87a7vdqegi.fsf@evledraar.gmail.com for details) via the config, because
it's a pain to cross the chasm between setting config centrally on the
one hand, and needing to track down .git's in arbitrary locations on the
FS (you may not have cloned them yourself) to set *.keep flags.

Doubly so if the machines in questions are just the laptops of some
developers. It's relatively easy to tell them "we work with git repos,
run this git config commands", not so easy to have them install & keep
up-to-date some arbitrary cronjob that needs to hunt down their repos
and set *.keep flags.
