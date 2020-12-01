Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE1C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EAC20770
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alYSWQj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbgLAKIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgLAKIp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 05:08:45 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E866C0613D3
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 02:08:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a16so2940901ejj.5
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 02:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=iLc9JwOSCPXRiTUFSZoX1HZrCGujZlhrMejCp+1oYYQ=;
        b=alYSWQj2pxDxHDNqHBYb1p8IALJeCYCq20kjaEc8Mf92R0+++FQJDq10mTxnrQrh2X
         qWyJe6pLthTR0MhoK69ytTSSm8W/sualXrJgY4k05p8l8f/BEuCyFMlbbaPhrzRvxg6H
         CPb9Qgn1mwn2ZTsEuS2Mq6UbBLlCnF+l0KKXkgu0vrfrd8Pogr+PZICy+IRu+EMgslw3
         01sl7mhwixO/fwwHrxjy3UJtQSshmd2mwW9jJiHEY7wIPE0hWwJFd7SstBGDO7g6DOrf
         Ojz6gzgQvqkW0Dfh7U6r1yOQ9D/GdcdRgG1XznndAyVMb0aX8iu6R5BePJLtnw82zQw3
         gPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=iLc9JwOSCPXRiTUFSZoX1HZrCGujZlhrMejCp+1oYYQ=;
        b=lS4CIX8dWOok8gyCUsE/LqARqdNY6E06B5JHj/EJGGuT85g3AXgrjvEBJSA1slS2NX
         TuWHXF1LYWSsDjqmH/JROAe5sZnEHCxpKOXxmL26gm6hMpPmjTDtPf2bv/bRcwE4gCNE
         HrKX3ya+09AQW6mLF/DKjW7gXlw4cV2hcY+JzVvbr62lBYQVm7ccPAYy/M/uZI59wJyw
         T/T8qsrc/ChlouwY32OzZFhIgjvS7qTmqLXbTCvMgSfy55uQpnO0/CkhOLcP+YGDmPXN
         UFim23bQw4df+0q+nZRoKSBrEtmnqIl0uiNV/5FNSoAhWexsgfxcHPRXPvlkRjXWzzOj
         QjPw==
X-Gm-Message-State: AOAM530aBZHbY6sgpZzTYg+dKMdpD2bkvpsRlYqunrjYnCMwEXaVS5MF
        xvO07upU+aAIxCZ5IO5WXJcsP8YW1OUYSQ==
X-Google-Smtp-Source: ABdhPJx/UGxKSzPOnwtJDyEpoZPrTMJyGU8U5+DncePwA/NLMb+n2ixn4zVclWqZqzbbVFzSV49qrw==
X-Received: by 2002:a17:906:6546:: with SMTP id u6mr2351189ejn.36.1606817283638;
        Tue, 01 Dec 2020 02:08:03 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id cb21sm569585edb.57.2020.12.01.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 02:08:02 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] make "mktag" use fsck_tag()
References: <20201126012854.399-1-avarab@gmail.com>
 <20201126222257.5629-1-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20201126222257.5629-1-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 11:08:01 +0100
Message-ID: <87zh2xvny6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Now a non-RFC. I went for the approach I suggested in
> <87r1ognv4b.fsf@evledraar.gmail.com> of just having fsck_tag() able to
> optionally tell us about its parsed tag/type, thus avoiding any need
> for a custom parser in mktag.c. Hopefully I've addressed the rest of
> the feedback, range-diff below.

Ping @ Jeff & brian: you said you wanted this in one shape or another,
so mind seeing if the v2 looks good to you?:)

Junio didn't pick it up for the "What's Cooking" sent out recently,
hopefully some reviewer ACK/NACK will help move it forward. Thanks!
