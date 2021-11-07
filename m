Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAB2C433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 23:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F2B6125F
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 23:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhKGXaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 18:30:20 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33326 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbhKGXaT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 18:30:19 -0500
Received: by mail-ed1-f47.google.com with SMTP id m14so54656825edd.0
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 15:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYUbhybqzegKg0IZaLzt5ki8BfayLZt2LqoQ+PgjB9Y=;
        b=5B1yr8cA3Yo5E1+LFASNwQajEkVq1xY+clWCywUbSBc4CSSMLY2iEXwobona3qQv3t
         XCcf11EwoWIcVqDPavlir1E/cm0udNWTRNQQL6itsEECtxowkcLlixQGjum1s0vT96+W
         tzLcvRrJ5XUBNIp0reGmJf7OIe24cenEcODKJdhQYcOEljEOnFIkL1/Mp4R4vhSPUlNi
         ue1X/8OrUQog81lMFGct8sTkAf1bZmVO1gVjXdqrSBOvsF/V1gvoDMeygZ0kdd015VzL
         wALs8674XjW9cxWX96gkGDQJUKtFPUMq+P1jUsM5B4duEi1MuCu7m0UIXpodzqQ/Q4Yz
         e3VA==
X-Gm-Message-State: AOAM531DX2MEYP4AgGGSOc8EoUZ9O97JB2l2VkIjlvBwX6JP3hB+dgOg
        /n9EjAv76MxdX0BCZmHvRdCYnioIBWS0bJyex3U=
X-Google-Smtp-Source: ABdhPJw8MASTNw7qPBGQcMvv0R2uQFe+/r+GdV2Bs9BLVJ533Kh+Qmwa/PGgg0ISqB4HPijxGmi6jPMtBY7WjoO3S7Y=
X-Received: by 2002:a05:6402:1254:: with SMTP id l20mr59944782edw.55.1636327655389;
 Sun, 07 Nov 2021 15:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20211107225525.431138-1-sandals@crustytoothpaste.net> <20211107225525.431138-2-sandals@crustytoothpaste.net>
In-Reply-To: <20211107225525.431138-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Nov 2021 18:27:24 -0500
Message-ID: <CAPig+cT5bU3K9aUk=Y6YAOJjAmDvOWitYD_jtgHap_BYs2mPgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gitfaq: add documentation on proxies
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 7, 2021 at 5:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Many corporate environments and local systems have proxies in use.  Note
> the situations in which proxies can be used and how to configure them.
> At the same time, note what standards a proxy must follow to work with
> Git.  Explicitly call out certain classes that are known to routinely
> have problems reported various places online, including in the Git for
> Windows issue tracker and on Stack Overflow, and recommend against the
> use of such software.

A couple minor comments; may not be worth a reroll or discussion...

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> +[[proxy]]
> +Can I use a proxy with Git?::
> +       Yes, Git supports the use of proxies.  Git honors the standard `http_proxy`,
> +       `https_proxy`, and `no_proxy` environment variables commonly used on Unix, and
> +       it also can be configured with `http.proxy` and similar options for HTTPS (see
> +       linkgit:git-config[1]).  The `http.proxy` and related options can be
> +       customized on a per-URL pattern basis.  In addition, Git can in theory
> +       function normally with transparent proxies that exist on the network.
> ++
> +For SSH, Git can support a proxy using `core.gitproxy`. Commonly used tools
> +include `netcat` and `socat`.  However, they must be configured not to exit when
> +seeing EOF on standard input, which usually means that `netcat` will require
> +`-q` and `socat` will require a timeout with something like `-t 10`.

I've seen this come up on the mailing list a couple times recently,
though I haven't really followed along and don't use Git through an
SSH proxy, thus I did have to go do some reading to understand what
this is talking about. Perhaps people searching out this FAQ entry
will already have sufficient context to understand what this is
saying, so maybe no additional context is needed here. However, I was
wondering if it might make sense for this to give a bit of reason
explaining _why_ these tools need to be configured to not exit
immediately upon EOF. As it stands now, this solution is a black box;
it will work but people won't understand why. Perhaps that doesn't
matter since most people consulting a FAQ like this probably just want
to get the thing working and don't care about the underlying details.
Then again, if the underlying reason is made more readily apparent,
maybe this knowledge can become more widespread.

> +Note that in all cases, for Git to work properly, the proxy must be completely
> +transparent.  The proxy cannot modify, tamper with, change, or buffer the
> +connection in any way, or Git will almost certainly fail to work.  Note that

"modify, tamper with, change" sounds like it came from the Department
of Redundancy Department. I like the sound of "tamper with" since the
image it conveys feels quite suitable here. Perhaps this could be
simplified to:

   The proxy cannot tamper with or buffer the...

> +many proxies, including many TLS middleboxes, Windows antivirus and firewall
> +programs other than Windows Defender and Windows Firewall, and filtering proxies
> +fail to meet this standard, and as a result end up breaking Git.  Because of the
> +many reports of problems, we recommend against the use of these classes of
> +software and devices.
