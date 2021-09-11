Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB7DC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8EA61205
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhIKQKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:10:09 -0400
Received: from mout.web.de ([212.227.15.14]:50775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhIKQKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631376527;
        bh=EwD3S4wRxiinSU3TS3SangzVbl1VI5zYRTNuAPxmKcs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eLoKWo2XSUeMJ7MhAwY6/hVKPiAv4+pLmVcVlGHyd1dqRFSMskkRzYylXLruT2q0E
         51/3E1mNH7qAU4CVSU18XhxP2gyr9tErN25dfePID5q8WErtiIRHKfl/Wkgk36tFPr
         jCrTYglhNiQTHyGS87eoLVBKvLrsUIz2xAME1vhE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MKNl8-1mOXKD1NFG-001g3U; Sat, 11 Sep 2021 18:08:47 +0200
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local> <xmqqeeaa6fey.fsf@gitster.g>
 <8d2e0876-9441-9665-ebb1-8cb28902014b@web.de>
 <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8bd13e99-208b-4c22-90e6-28227593e9c4@web.de>
Date:   Sat, 11 Sep 2021 18:08:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YS1EVq2Gz+sPhw3c@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4YvBSWEwN28Dd4ALJrIDigKLGo3n5WISckcL03niQapVW9bnEuI
 q8KrvAdV/EdkIveOslSXJ3bjiIQYbTgo0xJqcGj3dd1+W77V2EdeuHiqbBmz5tckBejtPQ4
 +zkcKhpseQSrLUgmLQiqcUPWK/yYATbLNuScD7UP5uJQURUBe9qOuubuQS/OM86kmMZosIm
 4d1f14iGC9k9zKq1Hkj5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VC4E5PcL2yg=:T3lHkAgYEorzPl86b0dIES
 gCqN2+UKdAUnRiCvEBDtwliGbnPYAURfxbn5WmcvHZVwqTOTnkpItC0ZtFqJ3m/x7YdOGALL3
 C1Na/oxygX/n9xaGNVLdHuS06BANMgj77ud4QytoYi1el8+/ovn4Dt3K7SFJxOp0KK8OlDII4
 72IEAmvsKR8Lq5/hylVHAhzTpyF28CyF0n7YUPVn1/nmUcT+4AqmfIIr0qBHFtmzw8h921j8F
 v6equstmvGPMurt0DYbdSdKbS1LPvON7mNKUdnlnTpyqK4wRObyrXiMeDjHg/tas/zLTWsnt/
 /5kS+Xx8tuo9XcsEEppvxXFx58WBE58W/9zHwHObUZCUgXwhZa19WoXiHjJ3W2tTRscMuzAZ1
 +C3abewfl9+NZETKgPlqoR0Jg1N1kgLExrmH7ebssw4EDo3hgByWAJ/cnsAZVQ59xClEohATB
 efwPi5lMXczFjmHiXqIthTTLc7dZQotZsibq07K3hzIKfeOvJk50Sepwv+gnU+EPMxJczO93c
 FDl1n0Am5JECeo0sBq63QDTSEekWPRK8iRaQR0dMM2oNnrZAYjvo7P9tnqXKOgv7hXtfYGrVx
 sFomaGSVlIKlh7vzo42D53Eczl1BJ0sANcvHxrYsWZt8+SODzgwuVm1r2EuvhyXFqsP5cjT4O
 6QnbeTOtnW0l4wWImHjPpvbE2Jhi8U3YbrveSPbvBChD3s8mKGLHPObCiWKqCQReWDXRCa9TV
 EFEkSHH6mKUszx394PqfrlWovXcm9w2R7fWiErwtlTypKOvCnpAGgqCNA5ZDMO6Bj1eDM3U9w
 KNyl4M810KtiobeOkjS08q7GM4JSMgTk75D6EXFMPvNJTB0UflK/m9Ly/6EfdBFW619QGaGou
 q9pBFhhoGNC+l4XLa3eGdOXfpnyrluntOZSge/cXQhMFHdV5Ef85SR6s8j75ZUzX+DC9Jf1oG
 lxyGs+wQ8xAi34mF5KMoze8tt2PZNB2n65G3/miQyT8RTNiiA+LBTEvIEAW6Yqx/h8BwdZk9F
 6bNCpR05uQQMRKLDW0zy8v55EhZ69eg/l9kpc5EuLpai5pGDlr6G4l3XBc3FFWVKAHYLrXL3f
 oH9xBibeHF3UCM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.08.21 um 22:49 schrieb Jeff King:
> On Mon, Aug 30, 2021 at 08:22:25PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> It however may not be a bad idea to catch these code paths where a
>>> local variable masks 'ignore_case' (and possibly other globals) and
>>> rename these local ones to avoid a mistake like this.
>>
>> The name itself is OK, I think, but using it at global scope is
>> confusing.  -Wshadow can help find such cases, but not this one, as
>> test-hashmap.c doesn't include the global declaration.  Moving the
>> global into a struct to provide a poor man's namespace would fix this
>> for all namesakes, assisted by the compiler.  We'd then access it as
>> the_config.ignore_case or even the_config.core.ignore_case.
>>
>> Moving all config-related variables would be quite noisy, I guess,
>> and probably conflict with lots of in-flight patches, but might be
>> worth it.
>
> Really most of these ought to be in the repository struct anyway, I
> would think. The value of ignore_case comes from core.ignorecase, which
> is going to be repository-specific. We are probably doing the wrong
> thing already by looking at the parent core.ignorecase value when
> operating in an in-process submodule, but nobody noticed because it's
> quite unlikely for a submodule to have a different setting than the
> parent.

Good point.  So fspathcmp() and friends would need a repo parameter. :-|

Ren=C3=A9
