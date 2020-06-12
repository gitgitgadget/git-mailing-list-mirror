Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCDC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C5A20801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIdjPDsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFLMuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLMuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:50:14 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D817C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 05:50:14 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id w20so3172670uaa.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=RhGloVDHtOwo+Eql2Ttmzt5s7SgTKZTY4j1KmDpgwGk=;
        b=AIdjPDsF3MC6T8zzzeR5uH0cRHeVwkL1+7epwg2XATiXmoiFlavhlLqGjuupDnNXVF
         FYUcT774p5Kd76OMMAM1ZCfW2lgQEx932YGNhG/jdbQs11fVG5fU+03422PBKl3XPRNf
         tpm7rLjaU0HA8PkIoS5ONFLxup8VC37wc8EdrHpa+632i5IGarRRwdYmNhSmfX26ATo4
         YMNnvDWizyO5GNqvczbj8X9nkTFD/9V15TRi2HustgYdauJGpcE4ZBebw3SXBuibIE6u
         AgJxnQwHtYx5zr0jOOSrsTUQmf6sulVSBLjTv+ODvYqNUz7ht8o+pNjDCNkevJ58qkFo
         t/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=RhGloVDHtOwo+Eql2Ttmzt5s7SgTKZTY4j1KmDpgwGk=;
        b=MdyFEFss16EIoT4HRTEnWNRTJZZWlTlwicAYWe44J18BSJewdrI6N7YbNdCQu0OK8i
         uD/Yevm/BbFIZh/tGcohdUaQTqr81K0C+46E8TtSguPbr3Yw5iMWnbqvJU8yQIqYWSlG
         SxrYDidwrsZ9LKsKiX0bTcIwEkR0T691uJefp1UlxBGs4qEShYr3rcmhDw0Mnub7ChqF
         YNPPmIO8NGa+h8HXJSOfj0awafk9ok6FU6sOLdfcD+/02vnPdzaKoTEhVxvspyyqHUGF
         RiF7lwTs5zUgIwZsiHZJA5e7qCnsPZ1Pmc9eKErB8f7UZs6uwDrcssmlehq6XlxSCZOG
         Fp7w==
X-Gm-Message-State: AOAM531tKxQQDX174ScEjrIrVmYBAT8J0RwQjTGePLa9DUvdmmoPZLw/
        ABYfpRAGzw/Ch4rwfMkuDNs=
X-Google-Smtp-Source: ABdhPJxVhEAXhKFaphOL25e687/D1GdUJit2L1YsLzvu2igD0v75VyMJugSSEXvioZH8H4m6hSV8Bw==
X-Received: by 2002:ab0:2308:: with SMTP id a8mr9920372uao.88.1591966212783;
        Fri, 12 Jun 2020 05:50:12 -0700 (PDT)
Received: from localhost (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id m73sm935375vke.11.2020.06.12.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 05:50:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
In-Reply-To: <nycvar.QRO.7.76.6.2006121401420.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Jun 2020 14:03:22 +0200 (CEST)")
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121401420.56@tvgsbejvaqbjf.bet>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Fri, 12 Jun 2020 05:50:11 -0700
Message-ID: <xmqq36704fek.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Subject: [PATCH] fast-export: do anonymize the primary branch name
>
> I like this approach a lot. Do you want me to integrate it into this patch
> series, or rather have it as a stand-alone patch?

I do not see any need for an off-series preparation step.  Without
configurable primary branch, keeping 'master' as 'master' used in
the current code is an OK way to anonymize refs and still keep the
primary line of development in the output identifyable.  The "ref0"
trick becomes necessary only when we introduce configurable primary;
even though it would not hurt to switch to the "ref0" approach to
anonymize-but-still-the-primary-is-identifiable early, it just is
not necessary to do so.

I'd say that we should take <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
with two changes,

 - see if the "refname" matches the fully
   spelled primary branch name by asking repo_main_branch_name(repo,
   0), instead of comparing with "refs/heads/master", and

 - if matches return "refs/heads/ref0" instead of "ref0".

and replace your [PATCH 8/9] (or whichever the counterpart patch is
in the rerolled series) with it.

Thanks.
