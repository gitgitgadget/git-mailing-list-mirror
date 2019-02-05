Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477D71F453
	for <e@80x24.org>; Tue,  5 Feb 2019 23:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfBEX3X (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 18:29:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41590 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfBEX3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 18:29:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so5582274wrs.8
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 15:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WgKF1sjIGfj2rOUnQwlnMyK+7Se4byrREO3cD65Ds5k=;
        b=UlOaW6Niz3D9BvckdpMj56D/ggwgAiyLGNkfuCrjV9i8ibpMV5mqrk/fmvo/KePTCm
         yqRkHQ/Q5UUNgEj9qL/B8+YNWsfRaOL23NQEIKAJ/TcX9q+68npQnDc6Nguc2x/sP/gE
         0JioAxeUOyV1SsTf8h2b4j9XgEI0eUfznAiXX+7LceETKZpnqrRW8jQhcDyypqWXd5/Q
         wEgGDzBsOKtIg2U2KIeMmdE5UbWTrWHUqxM9RarROel5S1IUBPg5zIa35dGy2pof8UFK
         XnJp5ElVB/hjVp2SMvf1PQLH4bUS51hnPcpt59UJ2UylEDKIZxp1zOwzkPIpXaT4pwsW
         l5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WgKF1sjIGfj2rOUnQwlnMyK+7Se4byrREO3cD65Ds5k=;
        b=j3cD1t4f8LHHuW0dDA07c7ydIwgPm7RymZPn76xarq+zIjoeJVrohoH+HyOiZ7mEHi
         J6yZXbP2CuK2j4SP4Ttq7DKgVxoCPFgnH3hw//Gno2bKZFdAB0CpocsziCEawtpFszm3
         dRuKgCPY38TUqYH7YG5XzwtcCg2pGzUqO7CRgPyzOdcJYHYIsLDfcsYKsyji3qaKwxv1
         PKHmzYqwuQ1O8000IB6eV+G1S5n8FkbmsOGRrgCbsZ5YF3CLrp0lY4Wn8Jmceer+alGb
         fsNFYh1AN5Y3i2UH1AbwB7sAkCRSl5/zOlIIh8etrsagipx8hqZaF0d+UkT6EpK0cqYq
         WWRA==
X-Gm-Message-State: AHQUAuYQxnoSJ+iT/8C8ASQfCuWfjIgFatSuLD8uS3XAS5Gbd1MknIN9
        2T1zDXRKwTW2cKMoalJL6F7UL9TD
X-Google-Smtp-Source: AHgI3IatQ3J4kkIZj7UjNkhZSfjKH9K94GzEn37misU2R2n6jxJVEI4B3lTJQFeCDTMcaoQ0GxiliQ==
X-Received: by 2002:a5d:47d1:: with SMTP id l17mr5412470wrs.319.1549409360798;
        Tue, 05 Feb 2019 15:29:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x10sm4875430wmi.17.2019.02.05.15.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 15:29:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
References: <20181116084427.GA31493@sigill.intra.peff.net>
        <20181116084725.GA31603@sigill.intra.peff.net>
Date:   Tue, 05 Feb 2019 15:29:18 -0800
In-Reply-To: <20181116084725.GA31603@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 16 Nov 2018 03:47:25 -0500")
Message-ID: <xmqq5ztxstkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> After making initial contact with an http server, we have to decide if
> the server supports smart-http, and if so, which version. Our rules are
> a bit inconsistent:
> ...
>
>  - we now predicate the smart/dumb decision entirely on the presence of
>    the correct content-type
>
>  - we do a real pkt-line parse before deciding how to proceed (and die
>    if it isn't valid)
>
>  - use skip_prefix() for comparing service strings, instead of
>    constructing expected output in a strbuf; this avoids dealing with
>    memory cleanup
>
> Note that this _is_ tightening what the client will allow. It's all
> according to the spec, but it's possible that other implementations
> might violate these. However, violating these particular rules seems
> like an odd choice for a server to make.
>
> [1] Documentation/technical/http-protocol.txt, l. 166-167
> [2] Documentation/technical/protocol-v2.txt, l. 63-64
> [3] Documentation/technical/http-protocol.txt, l. 247
>
> Helped-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote-curl.c | 93 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 34 deletions(-)

It turns out that this has interactions with 01f9ec64 ("Use
packet_reader instead of packet_read_line", 2018-12-29) on the
ms/packet-err-check branch.  Can we get this rebased on top of
a more recent 'master'?

Thanks.
