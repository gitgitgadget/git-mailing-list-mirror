Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B589211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 22:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfAFW7O (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 17:59:14 -0500
Received: from mout.web.de ([217.72.192.78]:34385 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfAFW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 17:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546815539;
        bh=n2rDVsifwk/Luls8OzuIUk6+3yELVzxhnGzDgFXrX9s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fyqvK0SpWv7Rawe7+DKmF0SOrcl2Wmhj1XLSnzqWAvFE68U1HpV+Luh/MPjhyky7k
         TUnlyGrBZ3NDCmUEIj5kcVDj7oSPrZUZ6w9IvlhYZA6mk10hNIz63T+TTcxK0iuKGe
         QV4dbtkDDYa0bzKVov++FLnNPRyBs2/rlGO/pRH4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVcZf-1gnp6K3FDr-00Z0Ba; Sun, 06
 Jan 2019 23:58:59 +0100
Subject: Re: [PATCH 3/3] object-store: use one oid_array per subdirectory for
 loose cache
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <c8dd851f-0a18-848f-8e58-cc0ee5f8e705@web.de>
 <87imz1ed25.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <949fb568-295f-de4a-dc87-bc721e8aea29@web.de>
Date:   Sun, 6 Jan 2019 23:58:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87imz1ed25.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X08wBHOZLrbrA9h8bRuswIb1V0PInv4b4ZeYhATD/C+EYMIEYkU
 P7omG2eTXZE2mlzl6+Wr/KDhHPFZMwY41wa8vZTXUUhWfzyFpfyvGihybrcyhvlKuqq8W1B
 0CM3nthLoNgJXPacNVQwZTiH/Uzy5jcfjgT1haHdSdP1800fT/qRz4QCUAERWmhMvYHFT1U
 MOf9jif8iO8VNnJ7VYGhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l9ul9WMjT/E=:lEJJjzKIIXle+XHc/NIWRW
 ANcyAVUaq79T3I5P/AD0IdlEHSLDA7+keAOjag9IaBV3U5Kr1rHHIyHbVTfbDB5eARkee5w9l
 aX7/6RqaIoJrkJIi+KjwscktBOFQXFtokCB7hvTk/klRFtM/1W+sXvvdMqZjSGBPgCQVS9Dic
 OZgDZ2p7RZ8PB+GyoDB8sCBphKy2fWKe6pNms7y2/3UlObBoFqqMz0oc8Ac4Er+nwzxK6QyXc
 5r/Yp/QuVKAPYCgUSxlKRyfRxKCNr6KzAjGg+fXsrG0F3cLd0zY5pcxiQEcad02Af3X2VKHoF
 DqL87sqk7t1Ks2flcONQwZgu/rIunzxy/HwxSXNWHgH3ZNZvxiPt4yrPi0a3T2Q3DeAeUEPFq
 mvVVNdq5Eee4v6Vy03mRaytanDU0yhPE35nCD2iVO3YlYyFbplvo36OQtp0z9EjbalNrMK0Vm
 tAXPzKdR3h7+yLJSkq0pUDy0iw+rIHQexYdMrMJxtGlIJCrwV5KB6jm45PBBbdA7TI+WjmjuX
 5g6U+urfVu5tCuUIdTyGA1fNFBQ3LZ+5cKPVxak/NVqhRqrPb808B1dPXvdkOJelOIQe4YIPi
 5CPapS0fdBHiBb+xfUzat35Mg5J2+5PRvUt1GgZM2mXz5PbIi2NBuKTLQKma0q/KcZ5szWy39
 ERfmOd0zSqt03haBqbCriqHlMGGoObhtow8dDnsbwGBhXR6VimLbSaYsSmKKRlhmlaX5ZkLJW
 SSf5vY2Ycv30cPSfA22M8moE0G2kPfodB+Z81tcJc5iMBT3B/W/MbR5YM/zR/63OX3nc7quZ/
 R9iDy3CeMUeBXWMeV6a1t1ErdJyVQpxIEEf1gZgPXBcbX7tk57DTvlFVkOlAm4mlV+FBjOxTk
 5ZlbDiYfI8Rt9m9yw8mUzN4sjHBeKq6SVgMYljg1GuLHhlDXvv18YgCL7rjCCu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.01.2019 um 21:38 schrieb Ævar Arnfjörð Bjarmason:
>> $ git count-objects
>> 26733 objects, 68808 kilobytes
>>
>> Test                        HEAD^             HEAD
>> --------------------------------------------------------------------
>> 4205.1: log with %H         0.51(0.47+0.04)   0.51(0.49+0.02) +0.0%
>> 4205.2: log with %h         0.84(0.82+0.02)   0.60(0.57+0.03) -28.6%
>> 4205.3: log with %T         0.53(0.49+0.04)   0.52(0.48+0.03) -1.9%
>> 4205.4: log with %t         0.84(0.80+0.04)   0.60(0.59+0.01) -28.6%
>> 4205.5: log with %P         0.52(0.48+0.03)   0.51(0.50+0.01) -1.9%
>> 4205.6: log with %p         0.85(0.78+0.06)   0.61(0.56+0.05) -28.2%
>> 4205.7: log with %h-%h-%h   0.96(0.92+0.03)   0.69(0.64+0.04) -28.1%
> 
> Can you elaborate on the test setup required to get to the point where
> you got these numbers for subsequent comparison, i.e. how you generated
> the approx 100 objects per dir, what OS/version & storage type etc.

I happened to have that many loose objects lying around.  Numbers are
for Debian Testing on a Hyper-V VM on Windows 10 1893 on an SSD.

You could fake object directory entries with something like this:

    for d in .git/objects/??
    do
        for i in $(seq 0 9)
        do
            >"$d/0000000000000000000000000000000000000$i"
        done
    done

René
