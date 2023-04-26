Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E091FC77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbjDZOcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbjDZOcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 10:32:10 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2F768C
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 07:32:02 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Q61XW2KsTz1s94n;
        Wed, 26 Apr 2023 16:31:54 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Q61XV1XRmz1qqlS;
        Wed, 26 Apr 2023 16:31:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ev_gTfnYC2zK; Wed, 26 Apr 2023 16:31:53 +0200 (CEST)
X-Auth-Info: wO26TTLIs83Tlwk86T0JaexMXNaRpC6S2adiccpS8h/ecRqy+N/dDIH2VcXPoCVp
Received: from igel.home (aftr-82-135-86-255.dynamic.mnet-online.de [82.135.86.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 26 Apr 2023 16:31:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id F3E102C1535; Wed, 26 Apr 2023 16:31:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
In-Reply-To: <a6ce9393-331c-3ee0-648b-182614a7d275@gmail.com> (Phillip Wood's
        message of "Wed, 26 Apr 2023 15:06:16 +0100")
References: <20230425055244.GA4014505@coredump.intra.peff.net>
        <20230425055458.GC4015649@coredump.intra.peff.net>
        <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
        <xmqqttx43q08.fsf@gitster.g>
        <a6ce9393-331c-3ee0-648b-182614a7d275@gmail.com>
X-Yow:  Th' MIND is the Pizza Palace of th' SOUL
Date:   Wed, 26 Apr 2023 16:31:52 +0200
Message-ID: <87mt2u3eav.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 26 2023, Phillip Wood wrote:

> On 25/04/2023 17:06, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> This probably doesn't matter in practice but we define our own
>>> isspace() that does not treat '\v' and '\f' as whitespace. However
>>> parse_timestamp() (which is just strtoumax()) uses the standard
>>> library's isspace() which does treat those characters as whitespace
>>> and is locale dependent. This means we can potentially stop at a
>>> character that parse_timestamp() treats as whitespace and if there are
>>> no digits after it we'll still walk past the end of the line. Using
>>> Rene's suggestion of testing the character with isdigit() would fix
>>> that. It would also avoid parsing negative timestamps as positive
>>> numbers 
>
>>> and reject any timestamps that begin with a locale dependent
>>> digit.
>
> Sorry, that bit is not correct, I've since checked the C standard and I
> think strtoul() and friends expect ascii digits (isdigit() and isxdigit()
> are also locale independent unlike isspace(), isalpha() etc.)

The standard says:

    In other than the "C" locale, additional locale-specific subject
    sequence forms may be accepted.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
