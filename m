Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7480AC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336A62076C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 09:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN0pwK6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgJGJyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgJGJyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 05:54:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F0C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 02:54:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ly6so2046489ejb.8
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JDiBBVsq08xU45wZRx174QzJMcWyCZ53edzzUBMbuOw=;
        b=QN0pwK6+CY9pdwJ7vR4jVPHumszjGlV4R22EYYcsLfOWIoO2XrYFexRkvT0hLfFQKj
         2pYzSLz3NAKExVjCbWu18kxgfxGOp9mvFD6bkDIIy/oX3FsUzuzxImiJofvLawbD/gNx
         tUnf7guwMzJmnZ5i1A13OGTcmsrq49k3e2rOlrr18b0U2vRppJZVRUR/QeBhc3e/A7b9
         vf8pVJw0mQJKxauGu/Ps6i3LWvAJOfIzuIlUqITasdroge10btoNRMwm60Lpa1GWplCl
         C0p2C3kXFQz3qL20N7KHzXGGWH0txFUb1XEa0uXqA8N2qt0nsBXySFoITyBO6peGuRyK
         BS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JDiBBVsq08xU45wZRx174QzJMcWyCZ53edzzUBMbuOw=;
        b=be4G+/+YCSSOuLd6Noy7jrRMmYW3ykY/9uzN1ieoj1uqQR8nt/7gsOcFhqVGX1WcB0
         KwgasqobClEVyXpD//531UsOr5F6/U34CUwA8GJbG1dJEAa2of8ef2Tz3/OJ4ryktxCO
         DT9Ei1T1q8BEl4/1Y/+ysNWs8fRAmQe1NInrORbO+PoRClrMfAO5NTc71jKbdj70IN+z
         hqVT6MgwDIa+r25PM4IpSga2IPgLWVyPuR+w9QDTpdIZXSG75eaBcKPYotfm1vwv8xON
         D5vJXozH4PjfQSKQ9Z4UxBbfF2TX22YVE/rkd/9kzt7XNGwlx3KOFidr0M1hMgV7x8c2
         ts3w==
X-Gm-Message-State: AOAM532Qwgy6Ey512oWyK4TKK7wA0UNdKS2qrmYOQ0XYV5MwY1db78iO
        W8FvDkb3g9qrrFcsUH1autMl0H2v3GN/YQ==
X-Google-Smtp-Source: ABdhPJy82N36E5duYDQU93VPsLKPFT4D9hrU0gPgiOxMxeY03pJ8z2KtIVPidU9tPDTufNXI1ZJ58g==
X-Received: by 2002:a17:906:cede:: with SMTP id si30mr2596836ejb.236.1602064446615;
        Wed, 07 Oct 2020 02:54:06 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id i14sm1158930ejp.2.2020.10.07.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 02:54:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.29.0-rc0
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
Date:   Wed, 07 Oct 2020 11:54:04 +0200
Message-ID: <87k0w2gy4j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 06 2020, Junio C Hamano wrote:

> An early preview release Git v2.29.0-rc0 is now available for
> testing at the usual places.  It is comprised of 588 non-merge
> commits since v2.28.0, contributed by 76 people, 22 of which are
> new faces.
> [...]
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (17):
> [...]
>       remote-mediawiki: convert to quoted run_git() invocation
>       remote-mediawiki: annotate unquoted uses of run_git()
>       remote-mediawiki: use "sh" to eliminate unquoted commands

We didn't do a point release for this security fix, but I think we
should still credit it in the same way we've done for security point
releases, e.g. in the notes for v2.7.6 and v2.10.5.

It's still an RCE, and even if we considered it minor due to the
obscurity of the exposed component every little thing we can do to
encourage responsible security research & reporting helps.
