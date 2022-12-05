Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC10C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 10:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLEKnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 05:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiLEKnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 05:43:39 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFADF5E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670237009; bh=xiFdAGi4vNiqWW+1gEVcV85wlRQd0zUdhFv8wAIJlZM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jx5FVSIB+febkQ4kFknaQex2tmbC81tBMPdgYvgq/po1fYrFNj2X7CGDsbhdYX3N0
         9Wqkmui1ezstGf1d1MpoX3P8/VaAyicvYye6XAgyJmwQRTHIO/JWD+3thKZdJPFRld
         BhfOm14FfutwBtY7JrcdFjs7Ld3vjz84Jr1bjQVgtCXVBF/bQwiVQHXKdj4OCCLn6v
         ATtuYpNtwT7z8Wc9EmaFiOZsUgWEjAOrm6oNNeeS43F62solt7MtzT3lhRoi2uGCLW
         axwvVmzaejTIk5pQmIVl/nZ+0AWFKL6ZJcK1i/kKWpi/w3UrOIx8X1lnnzVKULu7I+
         9njd/YJ759ZDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZjb-1oPEE818d3-00cnlg; Mon, 05
 Dec 2022 11:43:29 +0100
Message-ID: <26ed832d-fb97-c0ef-3848-f58ea574a23f@web.de>
Date:   Mon, 5 Dec 2022 11:43:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de> <xmqqo7sisllv.fsf@gitster.g>
 <569714f6-a913-5f7f-855a-b303adbde3ee@web.de> <xmqqwn76p55v.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwn76p55v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fGGfxIc5LUjaGx7ghMEWZsttKx/V3w8jNdj4KUna7NkuQzg12Kx
 Lw5gUVMVFdOktsqcqgOhn5HtGG//VjxzhuDOJaU+vj/brQNYTKgP4oalhFYYUwhNnRmtcZ0
 NoXx3UwJ/wmnI7Y7YXJuKXsL9JeT3ZIeCTs26XLMzqCC2yJb0QtWAttTzoMaaKNK/oWG4Gg
 xfNRhVBvQOHELakZO0dTA==
UI-OutboundReport: notjunk:1;M01:P0:SAgAcYlK50E=;J87Axk/BGTkbNS5beW7owdPsEkT
 E3QAKo5NTg27h2K1CvtDGCnOQP35N6566yOnGxo/YrhUEJkXhM2yER9OU8MSIjuW5zTKqJoRk
 +nME7boiSC1f+5Ga7z76P2BvH6gJvOYLGGALWlfP5eZfyUZieWwJAlZPjt4pcG6iWETuoLBXG
 ZJjbmNxLTgB6CX3HNAGTSSNfHMdmAc9CquaX9YQznYcWoHZ4F/eTMIen/CJb3KAdNCCcHsIUN
 34vXX95G0+YZ4ZAB8lDB4ATSl81BAAIkoDIb93o7w965msu5si997ABDIf+qEuju9J212R0/Y
 8gr4wB1ihAiW0V1pYv8HMbCNmWkmBA7alG1xQEt7ZBJq0Q0l7SVsTp3L289hRrh4Gj1LKfLLF
 p1fBNqd6+4uYxOJf79hXcPvhi2gQfQCAhI/WWQ8gnxR8uCA9X5uFL4ePbHgAYe+Mcrk3J0Hcc
 JwjagPjnv2T0ies+eHPkzpyOCRdm2EbHf/X4aYI3l7BjuoiQMINNmgXytSEoLiDsu0D7pcW4y
 TjPU2YNdsY0R/fJqjuCX3fbszjLX/CvAm7+ZGxuZi3o4k1VMvmNh/y8lzFgYwwE0v2U3UbqBf
 UxzpDyLUWKAf1WTVy918X3ONZ4fnuZYGx0Fz7xwCMnZbYgFRL+DcMjzLfelvA4gGWZoGArqGM
 LqCxU+T4iz+7OUA1FA9cGY7DeizXcgBC0BQMEvJga0IjC+3HPJE2T+MkXozbdeHvwLW88GB3E
 4hJUVVagHrOjq8vleVMvqseQ71xlvxsi61MkPATEc8byYzQsiDFHTX+f6UM80cyJutSOYf97R
 vZgWLVv+gWyWYUt06tsLd/KSjC4oaD8CdL2bBqK5Fnb5biRcIQFpRjYAKtWicMBFMS51pFVqb
 Zcl+p8dbfn8dVlE14y1eFxqKgH8Ti4xJnUzJTgerKnaThryainyWivEywKrg9p7YCpvhNb3ib
 IWViGIqh4U9I4Ik2M/+5/x9+2zo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.22 um 10:32 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Depends on the meaning of "fixed".  If it stops removing CRs then this
>> line is unaffected -- .crlf-orig-$branch.txt contains no CRs.
>
> OK, that "fix" was what I was worried about and if there is no
> problem with the input we use, that is good ;-)
>
>> If it
>> starts adding CRs then we'd have a problem with all grep invocations,
>> which was addressed by 4d715ac05c (Windows: a test_cmp that is agnostic
>> to random LF <> CRLF conversions, 2013-10-26).
>
> Yeah, but I thought that the unspoken motivation behind recent
> changes are so that we do not have to rely on "the differences
> between CRLF and LF do not matter" version of test_cmp?

The patch currently enables the removal of mingw_test_cmp; its commit
message mentions it in passing ("[...] especially since this is the only
test that needs it.").  If grep (or bash) would be "fixed" to add CRs
then we'd have to deal with that damage e.g. by keeping mingw_test_cmp.

Ren=C3=A9
