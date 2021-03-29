Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B9C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 03:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474D061874
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 03:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC2DRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 23:17:42 -0400
Received: from mx.99rst.org ([52.22.122.190]:51246 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhC2DRj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 23:17:39 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id 540FB43CC9;
        Mon, 29 Mar 2021 03:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616987856;
        bh=SZgbzpwTqA5+p2lrcwG3zIrlZ/qwIYG1TI25iv8EPeY=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=xKj2JN/zF7iDDehDNGEnC4FlpuY21NAFiIBDc+dwnBqYngiult6QMTmr5ImSMxldG
         mlx6cI2GaVxoQlpTZreCXyP106Cr++lpBV4HRTCTrOTGAFqjOj7vCOiemLMVgsJg3w
         OUERsS9+13WQVgvaTbGkUGnPORnabiZcDS2PMcTXuAvEVPIhMrILKJf2c3ypctpZcx
         AhTRftTbI0JQ3c5dbPN4jYGIzvR8+WvSDeCMbK9nUcyh9s+SgBTI4NpIoLL7Dl4HO2
         vuL8mzyW0oJWpTA60w741UWix1DparkJufMs2pFwXV3sz7sgTKmm3Rn4modohHfkLv
         6aEFWR+hjvvHw==
Received: by mail.kodaksys.org with HTTP;
        Mon, 29 Mar 2021 03:17:36 -0000
Message-ID: <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
In-Reply-To: <20210329014744.GA2813@dcvr>
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
    <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
    <20210329014744.GA2813@dcvr>
Date:   Mon, 29 Mar 2021 03:17:36 -0000
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     "Eric Wong" <e@80x24.org>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIg==?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
User-Agent: SquirrelMail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> Gitweb extracts content from the Git log and makes it accessible
>> over HTTP. As a result, e-mail addresses found in commits are
>> exposed to web crawlers and they may not respect robots.txt.
>> This can result in unsolicited messages.
>
>> Introduce an 'email-privacy' feature which redacts e-mail addresses
>> from the generated HTML content
>
> A general reply to the topic: have you considered munging
> addresses in a way that is still human readable, but obviously
> obfuscated?
>
> On some other project, I settled on HTML "&#8226;" as a replacement
> for '.' for admins who enable that option.  The $USER@$NO_DOT
> remains as-is for easy identification+recognition of hosts.
>
Thanks for the suggestion.

People have been trying to hinder address harvesting for a while now.
Replacing '@' with "at", the dot with "dot", adding spaces, etc.
was pretty common at some point. May still be.
I would expect crawlers to have caught up and this includes
all sorts of character encodings and unicode look-alike substitutions.

At the end of the day we are looking for something that's easy for humans
to read but hard for scripts to parse as an e-mail address.
(And that scripts cannot learn through an additional regex)
I'm not aware of anything like that. (I know CAPTCHAs, etc.)

> I also considered Unicode homographs which can look identical
> to replacement characters, too; but rejected that idea since
> it would cause grief for legitimate users who would not notice
> the homograph when pasting into their mail client.
>
> Anyways, here's the list of candidates I tried:
>
> homograph∂80x24.org
> homograph@80x24ͺorg
> homograph@80x24·org
> homograph@80x24•org
> homograph＠80x24.org
> homograph﹫80x24.org
>
> https://en.wikipedia.org/wiki/Ano_Teleia#Similar_symbols
> https://en.wikipedia.org/wiki/Enclosed_A
>
> homographⒶ80x24.org
> homograph@80x24 org
> homograph@80x24․org
> homograph@80x24ꓸorg
>


