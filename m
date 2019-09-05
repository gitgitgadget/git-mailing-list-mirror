Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7201F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbfIETjz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:39:55 -0400
Received: from mout.web.de ([212.227.15.4]:55679 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388174AbfIETjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567712379;
        bh=L+TxzkJfMSmzirk7dIn3ie3u1ek2qo/GittT8wkILT0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ViWZKZQsFl1gpadf3Y8/p84mPA0j6nUdzOPZ5ypeZlin4uYepwJSzuKJZ67PehLIL
         4j2YMhzvRUuXep04O3pth+Ob39djfPtarey7WLtzdcfgL/RPutndbyAJNkxyuIK3/v
         7a0qic6ItKRQrl2/VOMjBuVJ6x79Dg4lc3Tb97jY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwU2B-1iDzgi0VQt-018HVo; Thu, 05
 Sep 2019 21:39:39 +0200
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stephan Beyer <s-beyer@gmx.net>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
 <20190905175304.GA23663@sigill.intra.peff.net>
 <b4f53049-ff50-8143-1653-d321cce6421c@web.de>
 <xmqqr24upmtm.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8d90d803-8a4b-2656-550d-ccee5156b643@web.de>
Date:   Thu, 5 Sep 2019 21:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr24upmtm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dHAyfVz7p2VNKf/dkYDn6bkkjckI4LapsPpcG2aQh0QI7bz/6cx
 cdDfwWk5SzT1s+x9HZSCPbtJjBQ/wiEgXREpPf2bpx5KMcKCm+pOaNv5E/7cIeuTS8wW2XK
 x0fxe82KSoa5whtESBJPWIQWW4gX6PcRK5E/PcnTdZQcpLa1T8slVIDpMBYGvMWeEmDmN8E
 hyfRzDo+cEWF7w09BpOUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLSnAwJJ2UI=:SCOYiiGcHahf5/WysNSaL3
 SOObtYIbA9usGE6c4JTrRKQ1Q3R6pJLWLt/dp+BWtct4jnrS1FoeE8/CkAViL91WLq5KgNHlq
 FWupAAFC4JK3GhUiBfUiT4fW/NVdoqKQhEewrl6XG9AKy1WrGkGeO4yy1Q+Z3iiMG1zsbEyKG
 0t3jxOr4v0X3B5eRZqfhVShCIVsT9zV4cXJQlXpvKPrxq4MNqfRV3T6RcxBStGz2dPBiYekK4
 zvdMkGrqrhqkc6/rWKBcApURpLnq0r3vWVwI97DI3TgTE2l1zQ0Dm52nNMoVlmLiIO00cF4xa
 iKtuF+KgKO7s/cyeKxiYT+lcdvUZtNILeLTBjji8z7HWzfCw3sffZRACB0lEyav+d1IHORFSx
 ORuaevfZFe6EvtAZzKnq8GPT115izTQISSitLGE5ab0TrQ3y03ivH81NgFdicKLnHt29dzkrQ
 g8EUEuaw7LbK0c858BUbiFMpqoC9UhHNJjlH8tn1w95XcN6AX3YzLUwWU49wjZaACnkewFxp7
 rB69cAJ/oCENgfHHFs6CGYdYBmt3rHH+yRG6ubHYsHU09ULpzCm62qu9OhouTM5/urjwHSStC
 dpx2h3u8hJdEkHP7FM40V/z/yRg9k4xqXs7gUSnHevpMdZJKp2hH69cTL0SidPhXzXN5TQgy+
 SdGQqpQen9cQGo/mlEfhYl6seTNJluUepbchvnYdN1H16Ep3eyYpcOcT1Vd00tfLInURFYwzR
 jKbd5wdbzea/pj2lJe2cEy3Ev8km6Q8+dw/H2IMfk7yUqIHCAkLQwvK7svkdrnpq1gkrjxGry
 zRoTTGmBZZIo7iNGoNGAAr+8NzuhI3auoyyc12BbKVCkLhq04OJBvhSxoSo21vGROLDYP9NsY
 KyxWUvr/VMXrSZru0RwVKZOH/EW/XwE5jD/DG4yCYiB0eSXWVn3IwqCSTxCn2JgIC7sp8PUPK
 dFOlAudjb1FYq/286jMWTn4mqDV6Igh1xE6xIIo7tJg/yuVAr2XkL5xMxAYP/0b4MtVnhDVcq
 OtYFgQOZ+QP+GSzMMzyXcUbkounOx+JA2T5b/S/TN/9gd61uNFJb/3JFKo4d5EXmk5Q7UkxDs
 soRRvmkKP2YceUf+PalEF1n45IkdQt33MFysZgqDoD6475faQ4OoSmdt7YYbKrb4dvBMK4vQd
 xtY2nLfzXaPTUcl6yiEFTFTbDlV2YRqQn4fD1juog5Lz2il5ekqHUVmwSVgZDr/zLLKl8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.19 um 21:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 05.09.19 um 19:53 schrieb Jeff King:
>>>>> int cmd__read_cache(int argc, const char **argv)
>>>>> {
>>>>> -       int i, cnt =3D 1, namelen;
>>>>> +       int i, cnt =3D 1, namelen =3D 0;
>>>
>>> I actually saw this one the other day, because it triggered for me whe=
n
>>> compiling with SANITIZE=3Daddress. AFAICT it's a false positive. "name=
" is
>>> always NULL unless skip_prefix() returns true, in which case we always
>>> set "namelen". And we only look at "namelen" if "name" is non-NULL.
>>>
>>> This one doesn't even require LTO, because skip_prefix() is an inline
>>> function. I'm not sure why the compiler gets confused here.
>>
>> Yes, that's curious.
>>
>>> I don't mind
>>> initializing namelen to 0 to silence it, though (we already set name t=
o
>>> NULL, so this would just match).
>>
>> Pushing the strlen() call into the loop and getting rid of namelen shou=
ld
>> work as well -- and I'd be surprised if this had a measurable performan=
ce
>> impact.
>
> Yeah, we are making strlen() call on a constant "name" in a loop
> over argv[].  I do not think it matters in this case, either.

The loop count is either 1 or argv[1] interpreted as a number, i.e. it cou=
ld
be very high.  Its body consists of an index load and writing a number to =
a
file, though -- a strlen() call on the name of that file should go unnotic=
ed
amid that activity.  (I didn't measure it, though.)

Ren=C3=A9

