Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0731F453
	for <e@80x24.org>; Sun, 10 Feb 2019 19:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBJTfk (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 14:35:40 -0500
Received: from avasout05.plus.net ([84.93.230.250]:42458 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJTfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 14:35:40 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id sut8gt1A3WlgNsut9gdMhr; Sun, 10 Feb 2019 19:35:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Q7j8Hb+a c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=bt8Zh30PAAAA:8 a=21RtsbEhRLMN7burtiUA:9
 a=Viu2rLIDVocO9VEU:21 a=TaIK05l04qhWtQY-:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: Confusion about the PACK format
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Florian Steenbuck <steenbuckflorian@gmail.com>, git@vger.kernel.org
References: <CAA4q8U5JD1tA0KH1nxAhN1AuqYeB-Y5UGqXzichx-ZCipDKsgQ@mail.gmail.com>
 <e9a8ae8d-6f4a-5595-0287-80bf31923abf@ramsayjones.plus.com>
Message-ID: <a0e1ad5b-8d6b-7fa0-54f3-dc0b4b275533@ramsayjones.plus.com>
Date:   Sun, 10 Feb 2019 19:35:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e9a8ae8d-6f4a-5595-0287-80bf31923abf@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGuOeE1DAeF7z1er1kgdge4VyEVlhYoE88k0TH1IMlfrfTxvJ7QDfZLIyQMyIpm1AyiE2sDePBlyLKppXnPNXCiq9RZVQZK1xwZ8dsx2hLNNOaK1p+9y
 z++qRU9bdHGVXX4MVsL2POX7TO70Wk5KlcK9R4ug1pTTOZuGcanL5q5vJnJN775wxcv1iXM1mBLQKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/02/2019 19:05, Ramsay Jones wrote:
> 
> 
> On 10/02/2019 16:02, Florian Steenbuck wrote:
>> Hello to all,
>>
>> I try to understand the git protocol only on the server site. So I
>> start without reading any docs and which turns to be fine until I got
>> to the PACK format (pretty early failure I know).
>>
>> I have read this documentation:
>> https://raw.githubusercontent.com/git/git/c4df23f7927d8d00e666a3c8d1b3375f1dc8a3c1/Documentation/technical/pack-format.txt
>>
>> But their are some confusion about this text.
>>
>> The basic header is no problem, but somehow I got stuck while try to
>> read the length and type of the objects, which are ints that can be
>> resolved with 3-bits and 4-bits. The question is where and how ?
>>
> 
> Hmm, the 'type and length' encoding could be described more clearly!
> Hopefully, just on this issue, the following could help:
> 
> In my git.git repo, which is fully packed, I have a single pack file, with
> 
>   $ git count-objects -v
>   count: 0
>   size: 0
>   in-pack: 270277
>   packs: 1
>   size-pack: 101929
>   prune-packable: 0
>   garbage: 0
>   size-garbage: 0
>   $ 
> 
> ... 270277 objects in it. The beginning of the file looks like:
> 
>   $ xxd .git/objects/pack/pack-d554e6d8335601c2525b40487faf36493094ab50.pack | head
>   00000000: 5041 434b 0000 0002 0004 1fc5 9d13 789c  PACK..........x.
>   00000010: 9d8f cd6a c330 1084 ef7a 8a3d 171a b4ab  ...j.0...z.=....
>   00000020: 9525 8750 0abd 945c f304 ab95 5cfb 602b  .%.P...\....\.`+
>   00000030: b84a 7fde 3e2a 943e 406f c3f0 cd30 d3f6  .J..>*.>@o...0..
>   00000040: 5260 741a 5025 92e2 1458 917c c294 a3c3  R`t.P%...X.|....
>   00000050: 4803 e521 395f c2d8 4d73 95bd 6c0d 82f5  H..!9_..Ms..l...
>   00000060: 6172 310f 0529 7a2f d6a7 40c5 d9a0 d185  ar1..)z/..@.....
>   00000070: 622d 8789 9cb8 3f1e 5132 6366 4de4 8531  b-....?.Q2cfM..1
>   00000080: 114a 70ec 9447 2f5a 526f e29c 3847 23b7  .Jp..G/ZRo..8G#.
>   00000090: 36d7 1dce b76d a9f0 02af b2ca 56e1 f4b6  6....m......V...
>   $ 
> 
> You can see the header, which consists of 3 32-bit values, where the
> packfile signature is the '5041 434b', then the version number which
> is '0000 0002', followed by the number of objects '0004 1fc5' which
> is 270277. Next comes the first 'object entry', which starts '9d13'.
> 
> Now, the 'n-byte type and length' is a variable length encoding of
> the object type and length. The number of bytes used to encode this
> data is content dependant. If the top bit of a byte is set, then we
> need to process the next byte, otherwise we are done. So, looking
> at the first 'object entry' byte (at offset 12) '9d', we take the
> top nibble, remove the top bit, and shift right 4 bits to get the
> object type. ie. (0x9d >> 4) & 7 which gives an object type of 1
> (which is a commit object). The lower nibble of the first byte
> contains the first (or only) 4 bits of the size, here (0x9d & 15)
> which is 0xd. Given that the top bit of this byte is set, we now
> process the next byte. After the first byte, each byte contains 7
> bits of the size field which is combined with the value from the
> previous byte by shifting and adding (first by 4 bits, then 11, 18,
> 25 etc.). So, in this case we have (0x13 << 4) + 0xd = 317.

Sorry, to be clear, I should have said, "mask off the top bit,
shift and add", so:

  ((0x13 & 0x7f) << 4) + 0xd = 317

ATB,
Ramsay Jones

> 
> The compressed data follows, '789c' ...
> 
> We can use git-verify-pack to confirm the details here:
> 
>   $ git verify-pack -v .git/objects/pack/pack-d554e6d8335601c2525b40487faf36493094ab50.idx | head -n 1
>   878e2cd30e1656909c5073043d32fe9d02204daa commit 317 216 12
>   $ 
>  
> So the object 878e2cd30e, at offset 12 in the file, is a commit object
> with size 317 (which has an in-pack size of 216).
> 
> Hope this helps.
> 
> ATB,
> Ramsay Jones
> 
> 
