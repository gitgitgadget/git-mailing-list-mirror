Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEEC3DA7D
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjAAMcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 07:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjAAMcX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 07:32:23 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC202708
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672576331; bh=S1B+xy+4V5G6uGheGZrSbnwrOd3qvJJx/LVS+7HKRzQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dtoqd4Y9a9XiUsBuZ1A7eCTA22vyRGigpIAIWTriViKPr911sW6erUCXCzh1V2Qw/
         KSMOvC/zntvO/s1qwEnEgQajY6qGVyWZHqm/IZYdoEM/kn/kaWSr9Ew8P8YGB+qPmU
         AlnBlE7ANMWFWbk5EedZhqnP44spIrhWAYGknnPSSFNgyY+CgaVQvzs0T0LYy9YAd6
         cS+xbOTJIa92H/Q2M5pDxB6qrKm97DutJpdnJIp+YT7GceQobLWkbXkuam7s3iOr/u
         SSP8cYd6mbrQpc9jv0JqFBVlPHBYq/yCynpwK4VuIbkP6tkngoCBG+8Jq+VLlU5a1l
         YqGtJWh5ZGtaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtguh-1oxzYi3CZz-00usYE; Sun, 01
 Jan 2023 13:32:11 +0100
Message-ID: <269d85de-1448-0198-8251-9af898fedc67@web.de>
Date:   Sun, 1 Jan 2023 13:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
 <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de> <xmqq8rinhs7t.fsf@gitster.g>
 <xmqqsfguhplc.fsf@gitster.g> <220515b3-3924-c8d2-ff20-7017caa7dead@web.de>
 <bf4e6798-c687-270d-1344-37bacb403e13@web.de> <xmqqzgb2fo8g.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqzgb2fo8g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kp2PYyyB4dLoCRz8nMgbzuYB7ae/ct3gk2A3IOFPuFv5WhV7/CR
 xUzuudzlf6FCqckVYRcEHxSE+FG7MtFWprFcZrLz5MZ1irGrN0+suhQUCXVeUH4CcIuiI7k
 F2D500xZr4F034J+V8MXtsV6HK80+IQCdxYoh42OW2rzaU+7vlBb7j0h6utFgvvDGH2mO4j
 m7zY+O0Pkz7neeAsSWklg==
UI-OutboundReport: notjunk:1;M01:P0:8WjbjkHxznk=;5HrkIMbEVytKytc27hsu9DjU84c
 etVT96HCkcDoXdTyz4s7rhYLHR2TQfEdv7a1/IUO02ffizCRZXASOYBy8oP4wml0z/G2wBxLv
 AOGQGCH8vS8x2CEULaS2eGLeZzJZ+1Zg9jXQWHsiKLzlpDCsjavnKxZl7tB9Q46Smp7Y39SN5
 GPoo108gLRRCtZ6KmsugmRAG+EsGJ1HdhOjAMa0dB7mAFlEmhnssOf2h9ppBpNADJb5kLF82I
 M9fwaMtfJtiVF5DY08kPb58HjvK02BxUpehPz5kDd49Wzr3O12mvVeTyxtA1wzfZTXpR6j1Zv
 8roE2AoZP3uuGfxrTx3lOiKilp64UXGwPFvFyF7VaRD/YBkXFyDfJoL+bpdjE5ebK+r7wKawj
 eUCMuHhF9blt8Z3noxwap/LRuQfHAlwUKozzIH07bZapr2Hkm9Lm+zEJLqpNiPx554HMukYkq
 wJoAmMzBlAmaJyvWd8LIhTNq9QNNMm6x2gR+1U/OlHWgt4YuyTh/ooyI2m46DTmHPjf1jnAn2
 mlk1JyDiaZzxR1l+43htfD6FK/NFCu+f7uMxSqbEgjzWNG3gnaWrcKLS08WhJX0x/epj2Tjzx
 yVGheA6lyULz1tF8lNVnEtf26kZTEMPaR2bA52wba2rwSYWNRo2lYK9ELf7ywDhVgkKt5JfGp
 nMm8Ezt+3qIGPzuVsfadyYLysh+5/vJwes9HbmWkXz6ehUo7gMjUj9UYf06g3L5+cfeICmxIj
 FUuwSiOrnKkNBntsp4R+thRgrTNbAC/WOarfHkM2GMBYvyXuD034jL0Fvu+x3yakrB67X7J6P
 yrxLULm8glN/96nmoRFUTOinfszdXTn4Zdidle6L0/h0PUcUeRuhBPXIkD+HFTZ7AYqZFItkY
 kx/7b6I2pBRPA7nAxDCXGm9+3yXR00uRnnFUo0EjhpVC1/0+bgSwOWhVc/dGAmu0ZP86r2/H4
 haK1Bg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.23 um 13:11 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> On second thought, what do we gain by using __builtin_types_compatible_=
p
>> here?  Does it catch cases that the assignment check plus the element
>> size check wouldn't?
>
> I was reacting to this part of an earlier message in the thread:
>
> Presumably we cannot catch
>
> 	int *ip;
> 	unsigned *up;
>
> 	(0 ? (*(ip) =3D *(up), 0) : 0);
> 	(0 ? (*(up) =3D *(ip), 0) : 0);
>
> with the approach?
>
> i.e. *ip and *up are of the same size.  Would the assignment check
> trigger?

Ah, right, __builtin_types_compatible_p returns 0 in this case and an
assignment is silently allowed.

Ren=C3=A9
