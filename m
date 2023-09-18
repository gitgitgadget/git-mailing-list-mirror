Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C810C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 09:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjIRJy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbjIRJxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 05:53:55 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642DCC8
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1695030800; x=1695635600; i=l.s.r@web.de;
 bh=Wg4cCgR4h+pgQT7lDbhzknobeaaB0sCCP6ViGrcAPIo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HjEg6b9qoCXIWyNZZ/OtD/BgMUIFlF7XOThnuDTT100UHnPdlrKVB2jZDqSOlhh1l+9IlNtbOCa
 eVPiUgQa0OBVX3y3J0vpXr+fv9EH3q0QcblExCCGL0s0MAXvZFffZzpG0q3AyYQFjGChUQEW3C58Q
 xFVaD3XFnQAb38ulxyOwN5FNuuvoKzaVu6bSEpkwL7GFXPH+h1wd6R6v/xg9VbvIvCvi2CEg6rKj0
 zffwvN+wLdy/o+lk20ymh7POYDf876wjwrxqXnPxQNN8UkxqbTCKCqkSNJ8GmCl9+4LEFnmm1k34H
 FzMbL1QF7jXTwtcqrPNuED8x/mfpkne2rEkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVad4-1r9lzA27YS-00RXcn; Mon, 18
 Sep 2023 11:53:20 +0200
Message-ID: <2349e897-9e0d-4341-86fc-9da117a1eb48@web.de>
Date:   Mon, 18 Sep 2023 11:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <ZP4NrVeqMtFTLEuf@nand.local> <xmqq7cowv7pm.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7cowv7pm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jqiStS6nwL3YuVsHM+fP7jIWgCB6uBCMOQHw/weBKZRgSHJ8Pzf
 TKje4Q+Q19XQ6cKHThXgyHN+FLxGPUUAi8mJt49fL2gXxUCnWYyCdFvh15agbyskbThr0J1
 Yz4qWk+NCSUMpN8ZSFg2KHBL45W02WDBdmLU1ldMezQ3esFc4mj33MsrxZBzwgn6L63vyyj
 8HIPIL4zf+8knebve0zzg==
UI-OutboundReport: notjunk:1;M01:P0://a324rZmYc=;r3OYGSl2Hy4Dsz1euD+xOAa1j9c
 G7R7OlzNfyGNqyZCeDxSwizKtQ5Fxoz+y0UMqX3J5Bnm/MyHmX39w9zBfEYoSQOaCcuVc8AY7
 juIDuIyRHIPjpcRMlAm8UJ5MFTUNW+K3L6QzLiGO58BdACzA+oDxzDSG8hQmx5VDurIfhqVQG
 T9dvu/cfVMTQr/PdfSCit5OBPm4kQk35CuaxbCnOahEcM2MPzBwgZxCxhVOf+Z3rkjUE9pqGG
 b9BSyNEMUqbWHDeuUV8AF4yldbLZKskCPJmTk6o7psPwOoEw5ovGhl1lzQJ8ypRtYDBxyQ9bJ
 FVoYN+BwalEwNewPVBlXJz0aNwMcc1SWhDGnif43GKcuG22J1ScaVz6FGvymEUqc9InVqSOrG
 3HYW4llEcavk9cyDHPcW4ixeXZwCpRZKMhcxSbBvrfQn1RVOg2OojHloI7gn93uhuRmNB4iGB
 YJzB1ZQepRWCNEmFR2UiGvsaDhj+thGdQ0ZQ3SNG5791vw5RkPH4OhA9afbFNdbGxONywpzE6
 fhkpA2EsM1NdBg1KIUx1NNIRd8J+hm5zxJhYJr8YWnsq2Jdgx110J/BB7VOg6f3sGsxYiwae/
 W4bHYAQdvz57zbIfcUPcgHLps4pR9vG20to7CIfiYF0nxFIWbT+ncFvidOwuMM8VXd69hPezK
 V7i7NAg992RUgVCaRdyquWgOhG/on15PDRvWvjDSPcvQNXohjf/KcSUOMhi0lsREQL+YLvih1
 rnJtPcySPXvIBsPEUCqg9rFWtGV9QuKp078k11M5MNoLGnLJDuOxItMh5dwCD3DiznEOGtFth
 yycTbaJ79KmaMefExJV1BJQgO2yYXEgLLtLQaRe1PsA4s2dE8/vj00644qzVdgUjcZqc0Othe
 MKpFRwjaA0JyCSNy7lw3WfzHdGfj4f2PDyzCgBKuv8BwqM/e1Tuc3BCYcTciCjdjU0Ktk/t7+
 J8gIkg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.23 um 21:19 schrieb Junio C Hamano:
> Taylor Blau <me@ttaylorr.com> writes:
>
>> callback, something like:
>>
>>     struct option {
>>         /* ... */
>>         union {
>>             void *value;
>>             int *value_int;
>>             /* etc ... */
>>         } u;
>>         enum option_type t;
>>     };
>>
>> where option_type has some value corresponding to "void *", another for
>> "int *", and so on.
>
> Yup, that does cross my mind, even though I would have used
>
> 	union {
> 		void *void_ptr;
> 		int *int_ptr;
> 	} value;
>
> or something without a rather meaningless 'u'.

OK, but I neglected to ask what we would get out of throwing different
types into the same bin.  It complicates type safety by making it
impossible for the parser to distinguish the used type.  This will
become relevant once all int options are converted and value_int can be
made mandatory for them.  A named union also requires changing all
users.

It reduces the memory footprint, but only slightly.  Saving a few bytes
for objects with less than a hundred instances total doesn't seem worth
the downsides.

Ren=C3=A9

