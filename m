Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541F01FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbdEICut (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:50:49 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36811 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbdEICur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:50:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id 64so20673781pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rK/NzT6KtCrVj7ND0MGi39EMiCH5D8HBgVYdOccMyEo=;
        b=HsV6EESp4+U/SRtFafCmkQhO5FTrwAFdiuKJffDTebF2A6G8hnkExU2wGM1YkdlI3R
         ZPZfhZs9yCD8+slqYM7ZuSdCCRnb5cTpPgeFQpQcXaGHe+McYm3Jn4X3/JWtfDdc7Zeg
         +F0doygI2J/H1dCXsG6Jcly6ykM+JyDlHggEraRSnVbIv2TVlaG/f8FXrIBsPnfUgdYa
         korKqtX4HheMIbLXG6T/iCKIPgCqx+bWcfeUED63nQKZKbv9hccNfbTrk6d4NcJ1Eauw
         cgEKXbvjOziklYdCN1YMhXUrfbNsls2R83X43UbWa45lTO6SR0HqTxX90ILLCZjOdyqC
         z8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rK/NzT6KtCrVj7ND0MGi39EMiCH5D8HBgVYdOccMyEo=;
        b=OuLo8hlDVhQ+j9Vq9l5vulY8/hGo3hwtx0x9R9k1DZwGu6xwyGF9RRArkOLrNwL+Gn
         fcMyD+OxeRAnPcrp6a3lqNYbDVoehU2PHZv0+KIQ3ldGYJEasXa39/QEvN13C2V8GMDF
         8GlXj3IPD1qL8K0FzjrfQrCSMlt1YybDplVxXJGcgWXURrgpHc20Bkb0RAoAWGm58S9n
         j5tUnlA+J2un2X/lVEVkWMoS8l0Qjtl9nHun8qiPBEXSTLaJYloNZuCRHC//RjzvdDlR
         OZpmsWe4Evh+54mdu7XR/jpMyPQkQx8ako57KMIyReXrdmoV2uw/FGWOqRmT47NbsL8w
         pKUw==
X-Gm-Message-State: AODbwcARn5liHnW95KTmv7Nk8I1YQEY5Z4CDyc5Azei3QJd6LWJqbZMs
        uly7CRAJjB6gsQ==
X-Received: by 10.98.9.92 with SMTP id e89mr1629486pfd.177.1494298246596;
        Mon, 08 May 2017 19:50:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id o29sm19211265pgc.27.2017.05.08.19.50.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:50:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: git-clone --config order & fetching extra refs during initial clone
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
        <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
        <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
        <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
        <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
        <20170315170829.7gp44typsyrlw6kg@sigill.intra.peff.net>
        <CAM0VKjnjMEThuMvLEQByxWvxVvdzMSVsFKKstKLMweEx5UwTcg@mail.gmail.com>
        <20170503202224.arjszzbruxjgpkt5@sigill.intra.peff.net>
        <xmqq4lwu7r0s.fsf@gitster.mtv.corp.google.com>
        <20170509021028.fr5mc76kcbpnn4zs@sigill.intra.peff.net>
        <20170509022621.ku6pozb2zdeltz6o@sigill.intra.peff.net>
Date:   Tue, 09 May 2017 11:50:45 +0900
In-Reply-To: <20170509022621.ku6pozb2zdeltz6o@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 8 May 2017 22:26:21 -0400")
Message-ID: <xmqqy3u64ube.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, it's not too bad, because we can pick up things like
> option_origin from the globals. Here it is for reference. The nice thing
> about it (IMHO) is that it makes the lifetimes of the helper variables
> much more shorter and more clear.
>
> But I'm OK with any of Gábor's original, my earlier squash, or this one.
>
> (Also, as a side note, the free(refspec) in the context at the bottom
> seems like it probably ought to be free_refspec() in the original and
> free_refspecs() after this change, but I didn't investigate).

I'll tentatively queue this on top of the original and wait for
Gábor to say something, then ;-) as I do agree that this one looks
reasonable.

Thanks.
