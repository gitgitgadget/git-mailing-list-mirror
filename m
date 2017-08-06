Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA4F1F991
	for <e@80x24.org>; Sun,  6 Aug 2017 20:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdHFU2m convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 6 Aug 2017 16:28:42 -0400
Received: from 2.mo176.mail-out.ovh.net ([46.105.35.152]:37473 "EHLO
        2.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdHFU2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 16:28:41 -0400
X-Greylist: delayed 2390 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Aug 2017 16:28:41 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id F301765CB3;
        Sun,  6 Aug 2017 21:12:16 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 6 Aug
 2017 21:12:16 +0200
Subject: Re: [RFC] imap-send: escape backslash in password
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     Andreas Schwab <schwab@linux-m68k.org>, <git@vger.kernel.org>
References: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
 <xmqqbmnvtain.fsf@gitster.mtv.corp.google.com>
 <87bmnvktee.fsf@linux-m68k.org>
 <20170804202255.3oia7ivsoa6vu4me@sigill.intra.peff.net>
 <xmqq3797t4kq.fsf@gitster.mtv.corp.google.com>
 <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <feae203b-222c-4430-8af2-aae76c7e0bb0@morey-chaisemartin.com>
Date:   Sun, 6 Aug 2017 21:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <20170804212231.pl3uipcsujflcuha@sigill.intra.peff.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX13.indiv2.local (172.16.2.13) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 7642890043887445981
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrjeelgddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Le 04/08/2017 à 23:22, Jeff King a écrit :
> On Fri, Aug 04, 2017 at 02:18:13PM -0700, Junio C Hamano wrote:
>
>>> I also think it might be reasonable to scrap all of this ad-hoc imap
>>> code in favor of curl, which already gets these cases right. We already
>>> have a curl-backed implementation. I think we just left the old code out
>>> of conservatism. But it seems somewhat buggy and unmaintained, and I
>>> wonder if we aren't better off to simply encourage people to install
>>> curl.
>> That is a very attractive direction to go in, especially in the mid
>> to longer term.  Perhaps we declare that the ad-hoc hardcoded imap
>> is deprecated in the next cycle and drop the support by the end of
>> this year?
> That is fine by me. AFAIK, we already build the curl support by default
> when a sufficiently-advanced version of curl is available. So if there
> were feature-parity problems hopefully somebody would have reported it.
>
> I think the deprecation here can be relatively fast because we're not
> actually dropping support for any feature. We're just requiring that
> they install curl to get the same functionality (which might be
> inconvenient, but it's a heck of a lot less inconvenient than "there's
> no way to do what you want anymore").
>
> -Peff

There is at least one difference right now:
When using --curl, the username/password are loaded from the gitconfig file only.
When using the legacy imap interface, it goes through credential_fill which prompts for a password.

I don't think everyone is ready to store his email account password in a gitconfig file (I know I'm not).
I don't see why it couldn't be fixed. I'll give it a try tomorrow.

Also it probably make sense to have at least one release where --curl is the default. Until your mail I had no idea this option existed so I never tried it out.
Making it the default will make sure almost everyone is using it and that there is feature-parity.

But I agree it's probably safer and cleaner to let curl handle everything and drop the legacy stuff once it fully works.

Nicolas

