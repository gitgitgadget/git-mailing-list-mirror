Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A5EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGQRM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGQRM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 13:12:57 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DAD131
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689613968; x=1690218768; i=l.s.r@web.de;
 bh=xwyCULG2+ZvMq5kaj5dQrM+ivG7Ye2H982nYg0mQBSs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IixmiQKpqzAhPqZqtc4+urw8yDwZQbhUTmvJv2jWGOt83EcADACmlfz07Y18skeXoebRfMY
 7ryN8LvcMenutfolJSyjsStAoHu7AA3h50Hx3IuNx1xDOkp1Z0ssU+szgw9cvQ4dQ9iSKE9He
 2wT4MGEWBZ26U0SnyDd6QFN4zY28UDhNFgDBjjRmNuF7gcLa6GL1LqOUTL/rzJO6LtU2kSIJ0
 cU9IWfKFzgovg0Yf1+FBhKyzasw+u13+vNqn75miOrHxeE2lzlNjY8/iL4r/MsDIPxRMponGK
 uLG1VnerXXsnpWFBhy50Rm49b5FYYe4Y8yA+cVI0G2oFkoYrS4RQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.224]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeDQZ-1plYWt2wmF-00b6R5; Mon, 17
 Jul 2023 19:12:48 +0200
Message-ID: <183f69ff-8b6b-80a5-4d25-d58d25ae5b5f@web.de>
Date:   Mon, 17 Jul 2023 19:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] t6300: fix setup with GPGSSH but without GPG
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <cbc22750-af93-9274-2ed4-6dfd356568e8@web.de>
 <xmqqwmyyik2o.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwmyyik2o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:guvaKE+tx1Here3UySBwCeqhbyhD8zkHPNFahN/fR5tzlgxOywp
 B/8qiL73RoVEkW2LQcP1FNUo3rno/+4PLKpnIWmZOOVjclXb3r3lPrY7cJ03SeNf8zusHoy
 K1ws9iL/7lY9ULpfPu6FDjsSIIsyLxhZ5ildKswWlHSDtxcpWlLqmAns3EzGneVFz0IVmYT
 av7Lga60v4kdC0cwJtGBA==
UI-OutboundReport: notjunk:1;M01:P0:B72R0Lq0G6o=;qYO+QI4gFZ0tMb6VMWu7BhJm9Lp
 xeYj+0tPoKrlxC22lTtdwiYL/dy+F1J1jwy3cacAP9MjN1fo6VHgX/eZMEQ3qkNrfZjUs/89m
 YT+JYf6ejxRPIJGsqUgBLVj8DMM9BXjzrKvOu+4rp3YxLPg959XjNAm32YeuocgDSstPbVw5J
 UNHntiGzdpabx8Gr4LAjPzI9cvemBvSeyNVmQZ1KTj3HJptzhTSMCyHPT2XyENibO8TntVT8u
 2U/nXGYIG7fkY5Bf5RIuIbCLxRRQlVh9baHvtfTi3aFdvYelYuN785UOB/DJITmudnPMSAIqc
 odre+mghVsL+34nDgeJ51T+wgKlwkhtCpB1l3mFmNbs9YmDAKwYAE3joGyMkYtYSVQaCbLvBy
 xyG/FdZaMpBH7nS15C37J3qZLq0hNUk9Y/h1eRijzaIGXSDHIHxHXuuYc33tfKjm52NTx9dir
 oMOX0lftygUiHY1pbVh+RpnHJovEh+1kbHXg/VsQklmUEaJGHuIWFLsuNa1SIL/ppgjSKHNfl
 sGkt1w3s6HyapGCWmh1dt8YluhY164e4oNsk91XTvt+cGr8ens4a/mIwdGqEHhdmr0oWciUrz
 s4fZKjNSuaUDTyo8cBVMl5i+WNUcAxx/i8SnYXx9r1oa2riK4vxrMkWfox1WRyFcZtOf6BHD2
 IQi9uE2sLIn4qOl1ui8c+5Upk7opN/KNEBOmptCDVfs1UCXnLZEuWldX01gon47+d+U4CltdN
 +PfJv8a8daDibWAsQrpaT2xo9tvlYrgm3mHZbsxNqbO5g00QneejfjxAWi99o5j4qj/rojDRl
 bTkE7Y4Y/TXcQiWFavVSFoYr3RwpgzMgRzf9p8DXDMl2vjQOOiR2MQRSBjbRVOgtFzN4oMOMj
 KsB9b660eH+1a/zoIJ+uouSsdssYQ+zR5PpkPhNZ3SqNQqzZi7HroaTwB9OihDJBRFVpuKqUi
 kxBSQA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.07.23 um 18:22 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> In a test introduced by 26c9c03f0a (ref-filter: add new "signature"
>> atom, 2023-06-04) the file named "file" is added by a setup step that
>> requires GPG and modified by a second setup step that requires GPGSSH.
>> Systems lacking the first prerequisite skip the initial setup step and
>> then "git commit -a" in the second one doesn't find the modified file.
>> Add it explicitly.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  t/t6300-for-each-ref.sh | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Thanks for good eyes.
>
> I guess a box without GPG is not so uncommon, and even such a box
> can reasonably be expected to have SSH on it, so I would believe if
> this was discovered on a real development box, but is that how you
> found this?  Or have you invented a nice test helper that lets you
> pick random set of prerequisites and try permutations of having and
> not having them, or something nice like that?

The test actually did fail on my machine.

Running tests with all possible permutations of prerequisites would be
nice, but sounds very expensive -- there must be billions of them!  But
there are only a few per test script, I imagine.  Collecting all found
prerequisites for each script and providing a way to force-disable them
individually could make testing them all feasible.  Nice idea!

Ren=C3=A9
