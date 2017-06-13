Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B14220282
	for <e@80x24.org>; Tue, 13 Jun 2017 10:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbdFMKbO (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 06:31:14 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:43524 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbdFMKbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 06:31:13 -0400
Received: from a1i15.kph.uni-mainz.de (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 466CE34071C;
        Tue, 13 Jun 2017 10:31:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <22847.48875.297447.531147@a1i15.kph.uni-mainz.de>
Date:   Tue, 13 Jun 2017 12:31:07 +0200
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
In-Reply-To: <c7532160-53eb-a0c5-94e6-483aadf0cfc5@web.de>
References: <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
        <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
        <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
        <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
        <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
        <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
        <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
        <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
        <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
        <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net>
        <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
        <c7532160-53eb-a0c5-94e6-483aadf0cfc5@web.de>
X-Mailer: VM 8.2.0b under 24.3.1 (x86_64-pc-linux-gnu)
From:   Ulrich Mueller <ulm@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>>> On Tue, 13 Jun 2017, René Scharfe wrote:

> Am 12.06.2017 um 21:02 schrieb Ævar Arnfjörð Bjarmason:
>> Which gives me a pretty good idea of where the people who are making
>> my colleges / collaborators who are making commits all over the world
>> are located, for the purposes of reinforcing the abstract numeric
>> mapping with a best-guess at what the location might be, or at least
>> something that's close to the actual location.

> Half the time this would be off by a zone in areas that use daylight
> saving time, or you'd need to determine when DST starts and ends, but
> since that depends on the exact time zone it will be tricky.

And sometimes it would be impossible since DST rules differ between
hemispheres. For example, there is Europe/Berlin vs Africa/Windhoek,
or America/Halifax vs America/Santiago.

> You could use military time zones, which are nice and easy to convert:
> Alpha (UTC+1) to Mike (UTC+12) (Juliet is skipped), November (UTC-1) to 
> Yankee (UTC-12), and Zulu time zone (UTC+0).  Downside: Most civilians
> don't use them. :)

Yeah, that would ensure complete confusion. :) You'd have "Quebec"
for -0400 whereas the city of Quebec is in zone -0500. Similar for
"Lima" denoting +1100.

> Also there are no names for zones that have an offset of a fraction
> of an hour.

There are also zones like Pacific/Tongatapu which have +1300 (and +1400
in summer).

All in all I think that Jeff's suggestion makes most sense: Expand %Z
to the timezone name for the -local case, when the name is readily
available. Otherwise, expand it to the empty string.

Ulrich
