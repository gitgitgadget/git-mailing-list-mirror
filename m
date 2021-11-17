Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA7C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927D061BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 03:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhKQDPR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Nov 2021 22:15:17 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34893 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhKQDPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 22:15:17 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AH3CCMV079694
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Nov 2021 22:12:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Carlo Arenas'" <carenas@gmail.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net> <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net> <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net> <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net> <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com> <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
In-Reply-To: <YZRxOrv9JFt2oeSU@coredump.intra.peff.net>
Subject: RE: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Tue, 16 Nov 2021 22:12:07 -0500
Organization: Nexbridge Inc.
Message-ID: <012201d7db60$ea5e9750$bf1bc5f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHRZsJQSwQVxvA803MGEaqTSKtEHwGUCvbjAr89fOoBugavkgK/mpqhAVhqoPgCDdPdaAHlLlxXAZjWxhirlmnUUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 16, 2021 10:04 PM, Jeff King wrote:
> On Tue, Nov 16, 2021 at 05:50:44PM -0800, Carlo Arenas wrote:
> 
> > for the little amount of random data we need, it might be wiser to
> > fallback to something POSIX like lrand48 which is most likely to be
> > available, but of course your tests that consume lots of random data
> > will need to change.
> 
> Unfortunately that won't help. You have to seed lrand48 with something,
> which usually means pid and/or timestamp. Which are predictable to an
> attacker, which was the start of the whole conversation. You really need
> _some_ source of entropy, and only the OS can provide that.
> 
> > PS. Probably missing context as I don't know what was discussed
> > previously, but indeed making this the libc problem by using mkstemp
> > (plus some compatibility on top), like Peff mentioned seems like a
> > more straightforward "fix"
> 
> It might be nice if it works. I don't recall all of the reasons that led us to
> implement our own mkstemp in the first place. So the first step would
> probably be digging in the history and the archive to find that out, and
> whether it still applies.

mkstemp is more recent than mktemp and not implemented everywhere, sadly, and despite my whining about it. That may be why. It is actually available on recent NonStop platforms, so no real issue. mkstemp does allocate a file descriptor, which can be expensive and not always desired.
--Randall

