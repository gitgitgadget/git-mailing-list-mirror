Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E029C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347101AbiFNP4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350585AbiFNP4f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:56:35 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3382CC98
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655222173;
        bh=FIcg4s36+KfMMEq4nFRzg4mp1mZA67mUBo8TWVki570=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=A00Zs3BnKFILcTmElwvauJwwb3UtVQakYgtDkZBpuaMaadBEQCa423G/BrG4Neya2
         H454SytOTmRNCkPdh76DUsIST2qrAe9KuC0Sqie387Vf5VPVbtiW7HCcHLSk288M8k
         ZP3M85LWv8vLkdlXLUOWX99r+og34Z/5US9hD290=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1oOb3w2K4T-00NTGx; Tue, 14
 Jun 2022 17:56:13 +0200
Message-ID: <c67bd455-c643-43e4-3770-7dd891e57b4e@web.de>
Date:   Tue, 14 Jun 2022 17:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 5/5] archive-tar: use internal gzip by default
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
 <d9e75b24-c351-e226-011d-5a5cc2e1c858@web.de> <xmqqk09k449y.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2206141109270.353@tvgsbejvaqbjf.bet>
 <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
In-Reply-To: <28f6ec2a-1d94-b29a-4bfd-6a9e74c8edbf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mpgqzKuP6zDTa8DMWsWlbPzezs0aOBlbPB9ME5bScEW7oxi1yww
 ndcvHhj3VCH6lT+PhdQFJknit8BKTbWjcmufwPNOrGKgoffuFUBDU5/GhtynVFMsdJcSHJG
 2pfVJ6uyaPSStIEIAsH+kO28HLdqYMJJKFplHhWOqRkfRNIgSWPq8t3SDjfdBKrItOQkNR4
 8IyXcr1Yo93Yd8m05Y7bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EuIGzGNpbpk=:JZ3VsqQ1VizqtpSxKCgSOW
 1mAeB3YEwdktOyg/xjw1Kc/xDEpaKwejVinY0LnAUxb+wIcvxXLMgN0H5jR+x9CxDpVT4bXlI
 aL6V8aiW0/mbnkGtBEH+pa6Ig7r5JElDrVBGSJ3xt9aQjV8ySQCWZBnchYgGloWfjnLkj3kHO
 HKOePwxt27zkcJw2tyf88Q23gwBNxBBpN4Yl2tU/Qus98ZSMpjpkgyDeMmW8zZikraDGksczo
 0e7UAq3rsD6vJUXogrMMdM4p+53r0GMCplqo9S9Z6xf/zZo1G5cggZkK44xZStktXovGocYfQ
 o79L3+QOoxH8bnwS/VpioR3BBU1ZUveKO40qjLonDVj1i+hSt1f4Kv47XPcpaf9kyj8aNhCuF
 iOHJTtsPtc+35qwztwCC68WT5B3TwjCM5oRt1pJoIeWnq30IGrcj9VKqn67c/2QszCknsryQe
 FOD0mXM9GsQV0TH9LskBs32Vavfok68BDhTdSlWldNGWjTjB75uFFUdCi4DZZzarPbX+HWfyQ
 Q+S/vFrUhy/xXP7LokFRtbz0RDhs77Jh719mFvDoydhBejbGHJ68NhHC94BPdj8CsVbZnS0+k
 jBa/QyMalC5RPHSlwViMS2QPJXuZPsIm/NVOaJ9bR0QmS6SRV5w4UzO4GFGgJmTG/XBCKOMKG
 IElEmnfJKC5cmOBYrtJ1kKzSSEPLesx3qehr+Ujtrml06SKC5OhGhW460cSns0x+46L5Kswk1
 mctcUo3m8LmlLbT5UJSUYlgoZZMflyjPingyQyy6E7DRQfUWwvXz3ARjHXSSq/TiZWd9qznex
 aLpL1BuqeIH1w+YtKJJnQPJxyAMJcNFpnVhjJodN6FWIwo9Tb6M/OJF0Pm+pFwfi6hAsjdI7s
 d4e+CFF3xIT/IrUFivS9TxPhI5U08O3dVG7G6CRQU6+saWOeitpr0U0yMi/xlgVVjutffPRLF
 /uybwMbdR6AeCPY69lYrDe68wbfjLNAsOHiQ/Sn5TpLB77hnkMipKiXlpzPVse0y7CxxaseMd
 FDDNyrMwcUjADsLWLSnm4D1utWVXprGQwUsKeg43iKptYYPmijiW7TMtyaVXYnrMqZjdC84Oi
 olcLRj1EqpCEv2AopAVuwoYs5EVAJtL8foH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.22 um 17:47 schrieb Ren=C3=A9 Scharfe:
> Am 14.06.22 um 13:27 schrieb Johannes Schindelin:
>> Hi Junio,
>>
>> On Mon, 13 Jun 2022, Junio C Hamano wrote:
>>
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> -test_expect_success GZIP 'git archive --format=3Dtar.gz' '
>>>> +test_expect_success 'git archive --format=3Dtar.gz' '
>>>>  	git archive --format=3Dtar.gz HEAD >j1.tar.gz &&
>>>>  	test_cmp_bin j.tgz j1.tar.gz
>>>>  '
>>>
>>> Curiously, this breaks for me.  It is understandable if we are not
>>> producing byte-for-byte identical output with internal gzip.
>
> Makes sense in retrospect, there's no reason the output of gzip(1) and
> zlib would have to be the same exactly.  It just happened to be so on my
> platform, so the tests deceptively passed for me.  I think we simply
> have to drop those that try to compare compressed files made by
> different tools -- we can still check if their content can be extracted
> and matches.

I have to take that back, I was confused -- the tests are fine.  There are=
 no
comparisons between gzip-generated and zlib-generated files.  There's just
the gzhead use-after-return error that Dscho discovered.

Ren=C3=A9
