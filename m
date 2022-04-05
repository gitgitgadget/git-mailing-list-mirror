Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4EBC4167D
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 05:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445845AbiDFFGH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 6 Apr 2022 01:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453990AbiDFBRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 21:17:03 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068B4FC62
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 16:09:43 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 235N9XD5086589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Apr 2022 19:09:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com> <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com> <034701d84875$030bfb40$0923f1c0$@nexbridge.com> <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan> <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan> <035b01d84899$3cdc5b20$b6951160$@nexbridge.com> <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan> <Ykv5dCEv/gl7aHMq@camp.crustytoothpaste.net> <CAPUEspjAiXKz00VgP16RRA+ZKYpG0QjpU4XxwJXYnZm+MQwwqg@mail.gmail.com>
In-Reply-To: <CAPUEspjAiXKz00VgP16RRA+ZKYpG0QjpU4XxwJXYnZm+MQwwqg@mail.gmail.com>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Date:   Tue, 5 Apr 2022 19:09:28 -0400
Organization: Nexbridge Inc.
Message-ID: <03f101d84942$36be25d0$a43a7170$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE87yXqDmaysdJkpyH6/spM26GbOgJ005kMAt5RIzwA5EjRSgHvWmbNAtNurRQBhZlANgH7TbPpAYaJAh2tmJgRkA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 5, 2022 6:48 PM, Carlo Arenas wrote:
>To: brian m. carlson <sandals@crustytoothpaste.net>; Carlo Marcelo Arenas Belón
><carenas@gmail.com>; rsbecker@nexbridge.com; Junio C Hamano
><gitster@pobox.com>; Git Mailing List <git@vger.kernel.org>; git-
>packagers@googlegroups.com
>Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
>
>On Tue, Apr 5, 2022 at 1:10 AM brian m. carlson <sandals@crustytoothpaste.net>
>wrote:
>> I didn't consider the case that we had NO_OPENSSL=1 because it seems a
>> bit bizarre to say, "No, I don't want OpenSSL—oh, wait, I do want
>> OpenSSL!"
>
>NO_OPENSSL is definitely strange, for example in macOS it means: do not link with
>openssl if it comes from homebrew or macports, but maybe use the one that
>comes with the system, which happens to be based on openssl anyway (based on
>libressl, boringssl, or even a really old version of openssl, depending on which
>version of the OS you got).
>
>Either way, the choice of using the openssl function this requires could work with
>any of those if provided with the right linker settings, but it doesn't seem worth
>the trouble to do, especially not for rc0.
>
>> This patch also didn't seem necessary for me on Linux when I tested,
>> but of course it might be necessary on some systems, so if it fixes
>> things, I'm in favour.
>
>Not sure if the required changes got somehow dropped in one of the rebases
>after your tests, but it definitely didn't work for me when tested on Linux (using
>debian stable or sid) and I can't see how it would work unless the crypto library is
>pulled in some other way, and even in that case the lack of the header should
>break, at least with DEVELOPER=1.

I had to be explicit and override the LDFLAGS to include -lcrypto and -lssl at least for git-daemon with the wrapper.c patch. Testing is still going - currently at t5531 on the ia64 NonStop variant without problems. I deliberately picked the more finicky of the two systems since x86 uses a slightly simpler OpenSSL with the x86 hardware randomizer.

