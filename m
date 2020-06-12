Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06DFC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA80B206A4
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urhOsiHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFLPWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFLPWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:22:03 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A7C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:22:02 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id g129so5512705vsc.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1DR9vOK5XteYihvh31EHBJ2TrqHS/jaf9UnjW6rEthI=;
        b=urhOsiHYoXUo+4KgxcD/EHr9TcHHz+mwe6hqzUnCrs75cWGZjiEKR/vMpj732tusKl
         81H9eSq2pnRvf50RvVFmmLUcrqOvOhrsn/axqi+vl0PJ1rPP3jf/MVDpTWTZXxWRYiP4
         cagCire6Gr0DGDvg0qkMDnFcH9E/7uGWdwNWwxiMpDXFBHtXmKafc+u6NL+s6FjHZ34p
         aGbq2Z/TiUVzS6YbheWC37gKAsIe8W5NUvYsaU9nhcMmEmi08WBPo3QE5lRqJAk6Ys4r
         8rv++JSJ9wW1ATKB86lvsx40yLKMVF4sKwGLDKI4b19FAz6Gc35x74KWcTEjGS7bqMza
         ezvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1DR9vOK5XteYihvh31EHBJ2TrqHS/jaf9UnjW6rEthI=;
        b=mTcMpRGPX7aQlqJYCeyNs7qrpD+MsDJHz8n0AOKGalX2qfwusEPCUwMqNehUbZp0AC
         i/KvCtEOYJjW2hzA1TyIYF0a2ov+AV/LYBM91q+GN7l1x06TyMAHAbxTPyWpHGzRbkv/
         CDjSI/6GImPErvYOPHKbf0BRGQx/96uuhb+BinJ5vQ7EWI+e0lLF1ws1e1WlJSTAW+9j
         J+9S4ZDmx1qR25CYsSGdf1HI2NO9Oq5D7kQ+JBlPAgYGud6KnBKx3Fp4UpQao147rIop
         sdsDVOwe62tsol3no6QcXsGajixmsS5HIYro1FuHQt/PN3VsgIwAQRFJkkqhXZHm8oQb
         +ivw==
X-Gm-Message-State: AOAM530hEacqt7C9nS2dL5r4t5IdEFrXuZlsdV9hIUj8w3xWJVhlMIGJ
        6rrGGZpjUck1rGXgmG0ATQtWwqAv
X-Google-Smtp-Source: ABdhPJzi+GLAhRywXJBxJwaJWgdfFlSCdSYQmoGKQ9bdNqI0+KSEB/BCcoNxYbadmBLd4Kq40poj7A==
X-Received: by 2002:a67:542:: with SMTP id 63mr11627931vsf.128.1591975321289;
        Fri, 12 Jun 2020 08:22:01 -0700 (PDT)
Received: from localhost (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id l14sm1000892vkl.47.2020.06.12.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:22:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2006121518160.56@tvgsbejvaqbjf.bet>
        <xmqqtuzg2twq.fsf@gitster.c.googlers.com>
Date:   Fri, 12 Jun 2020 08:22:00 -0700
In-Reply-To: <xmqqtuzg2twq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 12 Jun 2020 08:19:49 -0700")
Message-ID: <xmqqpna42tt3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As I said already, I personally do not think that this needs to be a
> preparatory patch to anonymize 'master' that cannot be configured to
> something else into 'ref0'.  This will become necessary when we make
> the primary branch configurable, so I think it is easier to replace
> the counterpart to your [PATCH 8/9] in the original series with it
> in the v2 series.

Ah, I forgot to say, if you think it is easier to manage the main
set of patches for the topic to eject as much preparatory changes as
possible, I do not at all mind treating this as one of the
preparatory step and queue it separately, making the main series
depend on it.  I just wanted to say that it is not necessary, even
though it does not hurt.



> Regarding the update to the comment before this "special case", I
> would suggest to explain "why" not just "what".
>
> Thanks.
