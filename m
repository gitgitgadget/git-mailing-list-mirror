Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389DF20248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDEUR2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:17:28 -0400
Received: from mout.web.de ([217.72.192.78]:37481 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfDEUR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554495443;
        bh=SNFKqlsq2TYUWZ3NylgbhvfJJHXrnXjg+RABbMsowPQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZxUAxRnY2+vCSbD/Pkp0KsO25r7vIbHvA6Ghz/NcYiSLCV4qFSpyDmOEjDJ/IQbDR
         7E9wCSN+rLCoYMOMUPnWB0HW8SbQk8+JV7dcoxBXezN2I9P2oGX7uvXlMISvE5Gcp0
         Eyv8SmtRn6zZs2VW8MY0hKGMpM1SRLDxBsSdis9E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.22] ([79.203.21.163]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrYf-1hJxO23BHp-00RoOd; Fri, 05
 Apr 2019 22:17:23 +0200
Subject: Re: [PATCH 05/12] http: simplify parsing of remote objects/info/packs
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232704.GE21839@sigill.intra.peff.net>
 <83129937-dcd0-f16e-c8aa-97eceec9769a@web.de>
 <20190405181132.GA32401@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <85b12bbd-15a8-09a1-395b-dc1606ab34e7@web.de>
Date:   Fri, 5 Apr 2019 22:17:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405181132.GA32401@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8S1u9ThWG1Z0yzo6IQLQpU29ndosyQNfAaPzVZOTF0ESncoONlN
 NojAbCIB154p1BOgxtwrMdPnpoZ+H7hWRR+KZDiGTnf3Mfe7fX3LJKs//rZkhHGFJ0muIx6
 JhmVokkVsr7iFfVK8YMjaNu2o5iAERWhJseasvcnGPLgmfZrlXnVyY9YAH3gxDqI79bgKeH
 8TctkF3uiZzsNS0C3g64A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H1qX6ehDVDw=:sNfDaiYeSl1QZAb72rTBLr
 WvVB8x//P1AJPjUUmQGKepknCWj3HiMFBNZrt6nw7qHtEmioB55BNUjkReKMmy6mwJhnR/wFK
 yxwSmTWVHq/YQFGQ/UYkCHiNPMdZWDZqB6EOCKGy+xMSSdYh/kPydHWQCr3hBReaH4fh3e8kl
 8FFUali9BzKyAWldhiI+ajNGlFU/4ne9uRLKbePQb3qve2TlhnpzdyyPfMyrktpQ29aPkUoMv
 aNdexpMkg0J27Y0xtR59dIC6adsOXvfgPGXhsfd0C4o83Ype0L0abUI085USMBH8/gxUYxJl7
 aj6VnkoTUBKmTl/soToP2GSHRiGikqzhBTN+ApPlXogPYnChbCW32dHk72L2t+V2Z3PFDyZTn
 D21O18hC3jjQ1eRS0A9gS4P/G4rYsv6YEcEnzOBAxAQAya+lFwECUmfxBEcqnUljSWaf3Ni2N
 U7R0S04P1FTf/DlEWd3cpX2oHKu0zX5lQeFN1dRNYitWtQmDpe2YNtddYpMFRY3wOdLy58XAg
 hEq6hOEgIiq/YJEKt7RovEUIKl0qDeDY0HG348tfpXL4j3xfiXBatB8UqJKNuLJT5TVa+exZf
 9RZPsEXveMbJrUFInu01wvTPEsFbZLLb2G/OPxPDk0QLs4GyJZIefef8/0OQ/2s8a/zYBfebP
 EdHn71aFehtkY9k7ElIgiu/9I761Ij9wDYQSpXfANAPn7s419vCI7+z6HUvxi/bxZNz6dQI25
 AVifcyMSjAHHM9ZDDD4Z0YMYwUkPIiv/d7kxCDLPHMTq93emSoJchOPC53JnGRnEseHRdYiXY
 35cg2X7dDSRwn5AFDc6jha97w9c81ss3De2JTJoDYedkpXCnKtsnjxn+1lHR0ouAlZ1OzhqW0
 M7hJ/u6wQ5A6RT2PXn0t2MS9dQG9mg9eVtZXUshh6aFNWxW0svQM2/FOK6Fn4M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2019 um 20:11 schrieb Jeff King:
> On Fri, Apr 05, 2019 at 12:41:27PM +0200, Ren=C3=A9 Scharfe wrote:
>> Parsing "P" and "pack-" together crosses logical token boundaries,
>> but that I don't mind it here.
>
> Yeah, I was tempted to write:
>
>   if (skip_prefix(data, "P ", &data) &&
>       skip_prefix(data, "pack-", &data) &&
>       ...
>
> but that felt a little silly. I dunno. I guess it is probably not any
> less efficient, because we'd expect skip_prefix() and its loop to get
> inlined here anyway.

Didn't think of inlining.  Clang unrolls the whole comparison (except on
powerpc64), but the other compilers available at the Compiler Explorer
website keep the consecutive calls separate: https://godbolt.org/z/7eTarV

Ren=C3=A9
