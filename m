Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F7C2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8602A2072C
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aevSJAT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgAAMEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 07:04:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38131 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAMEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 07:04:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id w1so16283827ljh.5
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 04:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TrhrvT3eeotQLOcLdyWCL6IE8JmZ2OTn9w21bQZ+wSY=;
        b=aevSJAT/MhQZR4OyXiZR1IoETOBAG4h7s4EyykGE8ziZnhe7E9VpGP+vUvPQdcWzzb
         jsiH7bnLiptmOESRiHalAPhVFjI87I9c7JWYvcwAJPbEjl2C6Xum8D85qonhWyFZ5o+d
         pIT8grzzOdlLk0G0cBc+Woh3399VnLHdMtNIBAk1o97uDYWZR7dS5ffxmISKk3uCHeZ5
         EqtfpVciq/oZ5Y004IB9q4AAlP7kPFgMcKs2bGp+DtfNC6slP71yjN4CaUvTqxkaoYa/
         X9j4coxR71R4vbRVpzz7359TfYKGiOXMK93ajt0CHpMMTAf7lChgwfQyHBlgOqvJ6HK8
         cXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=TrhrvT3eeotQLOcLdyWCL6IE8JmZ2OTn9w21bQZ+wSY=;
        b=hKA25Wu3qMlDVehHA/u1KvTh3kpmEPw0waYKqaG40ZVICU+jGtrnDKagsdb+/wDh1T
         LZUK1ArV55PamLUl6EqY6EeAOLs05VtCzStPIb2KHmPX/7xHAv4iXDr8vPHvOMKAscCe
         6bHijJfSF1qhyWuIs0Sg30PNDzVip4RD3dx8jMFCODUHDR917Myhw1lxADRHQ09VLyPm
         pohh+GMd1bRQhQRGYLT49zO3wHvXQ62/dgd6s1jomIurJfI8l7SzgFRrGiVq0D3D2TM9
         FEA3rQrjdcSUGojfhpjyw78xjoRl2V6/QjywB3eV2KFdxAGHro9nl/v+McIWBfcZHqgS
         Nrbg==
X-Gm-Message-State: APjAAAUiZ+1gURmnUSVxPlZugmz8GlyDaM408Fs1tjC95ANleLieuLBC
        tMRublDG3G8ZoKn1GwwQtL4=
X-Google-Smtp-Source: APXvYqyMjBmPLm5z4w3Gts8dJOl1F+MLswu1TDs2ZEbYKzdamtdANY8m9TJbdgwyTOVGHYK/8dyfVg==
X-Received: by 2002:a2e:2283:: with SMTP id i125mr46080048lji.244.1577880284242;
        Wed, 01 Jan 2020 04:04:44 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id b1sm24703696ljp.72.2020.01.01.04.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 04:04:43 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <CAP8UFD1mOEUngLofTZ2hjsTooR49FktfWHWJGzQ9Y-a=oB-mZw@mail.gmail.com>
        <20191222093857.GB3449072@coredump.intra.peff.net>
Date:   Wed, 01 Jan 2020 13:04:39 +0100
In-Reply-To: <20191222093857.GB3449072@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 22 Dec 2019 04:38:57 -0500")
Message-ID: <865zhv4c2w.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Dec 22, 2019 at 10:26:20AM +0100, Christian Couder wrote:
>
>> I have a question though. Are the performance gains only available
>> with `git log -- path` or are they already available for example when
>> doing a partial clone and/or a sparse checkout?
>
> From my quick look at the code, anything that feeds a pathspec to a
> revision traversal would be helped. I'm not sure if it would help for
> partial/sparse traversals, though. There we actually need to know which
> blobs correspond to the paths in question, not just whether any
> particular commit touched them.
>
> I also took a brief look at adding support to the custom blame-tree
> implementation we use at GitHub, and got about a 6x speedup.

Is there any chance of upstreaming the blame-tree algorithm, perhaps as
a separate mode for git-blame (invoked with `git blame <directory>`?
Or is the algorithm too GitHub-specific?

Best,
--=20
Jakub Nar=C4=99bski
