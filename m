Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519BEC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB6C60F6F
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhIKUqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:46:35 -0400
Received: from mout.web.de ([212.227.15.14]:38983 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhIKUqe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631393115;
        bh=V8Z87ogxKEpbEaom2JYSqymcVvGQuM7ka6SB7qDyddg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=IMRSLAXIIJA/Ephbqg6+ID/0B1rAvnSsrunOQj34tC2jhDGbEgaYETX24FLRh0JTv
         hDankjUf7+Lw7M9FGU84veemK0DvDpWtcdnempHuXiyTxpIIwTO8xfrV62HQmfussF
         g6Niv1AWbC2Hlf1U9OXVs6W7WJ4ahJEdDwKGEP38=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MX0q4-1mSXVf3cKS-00VyVH; Sat, 11 Sep 2021 22:45:15 +0200
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Message-ID: <14d4f3d0-b94f-974e-0c65-bddc54d89cca@web.de>
Date:   Sat, 11 Sep 2021 22:45:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sEDdq7BRVfP3Y4gxByG1LBOzxz5Gz18JJeOgW5/HGsKsLbyDn2h
 qVBiQToVN8vOf8/hs6Ev2LcQTAEPpmT2J3n4dnnamqSyKqi4wZ/2/QvPFMB74otn2fdvIho
 4z7U8PQp1qpo4Yprkrz/hqL+hOa24PLMJu+oq2IXTV6rbwc2CSbLN/FKAgAVRWFakg+kvfo
 sVKxEusFYX1KLhwQOOCug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xF29GUPwHyQ=:jJDn2TS+yM/+mH6FtQxKqr
 NUDoOf8Ro7CtXCtVvJk4U28B3rkVejN+2TV4SBe5n2OfXlfqspAwgMAiGT+FKQCHEQKFP+QDc
 bD4DkEg939QxTtyPsQbcEnuCtS+52XC6r9UctSc8jmx6OJ05YIJoX3R1FMW13HiITuBvUJOon
 VN72RsTPqmr3mYMcOlWhaxsWN0vARACPp4hvj4saSUpp83vDnDmhCGOs4vZ1a8kbEfnYMbC3y
 la4PuTspKOokYtGd7yuD7b6nUwJQOf9FABjt8v0o0QrOBNkLb94iuC+TtFNp8/sm/VMMBHHYs
 xvq92GW2EX8zWuJMn176Bnm9vAD76FjHyg1T0Oxudj991HBM9PyB+5SldR026ZQ88IQiQHke1
 WsuIKtkxgOrYr+vJLQF2ApobqlS9mAuJI3lNJ04EfO+6dWqLh5EcWCPYQCi6OiVy2NPvPXXBQ
 fV4maCIuMOEonAZWwjdyUkRqZtbXgRZOKemJyg/ta++8L4bPs9nomtn8n0kmbYtGvrMjFd1vJ
 04shH5gyGNJeaCG0Hs73LFAv5NgLUYUtjpHi6+5DSqETkvYXhs5F3VjCxfflRMKwyR26B6rC1
 DlBm2c8EvGhz1ZGPbcBH4b6cGdLZpjplDVXEOgKclzEv0bZhB0+sSae3IKDgHjJzzKtLzo3Ah
 o32JMxibLkB7CF7gbuNHE90JVcrfuPDAvG+eyYd3QGFsLPLVEkq33p7yAGKtjEyeIdmvJhYRj
 NBVE5fxhejcUcWHupFfkwROSiJ6G6ETEn4yHwfO0yzTjyoBLRUoi3r1/wDcbJRY7dKkDL9uS7
 +J3G3mLKee5fFuk/Bt5WKzEx5HgaOwGQn5D2fB9iTJ0a3/DR27t87W5HcaPtUTix+q/tL6e/9
 dKWGwseFI0IiSK6oz8SCFJt7cuDyrxM9Dp7SZv6cBtcG+jWEN+ZIcY3jpeAoYQBwkithaaXH0
 VmNtAeF0xic+1Je74hEw4x/OzHAA5y/XYUx8RmaW7YAXykT7W5VCeuYSGP+e3592T5/ZJ29Jm
 zeRaw/kar9G1nNn+ofOxklr9VBf1/5lh363nlLnjHdW27Og2lasXxXTNIieosW1cyg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.21 um 22:31 schrieb Ren=C3=A9 Scharfe:
> Replace the custom hash array for remembering corrupt pack entries with
> an oidset.  This shortens and simplifies the code.
>
> Changes since v1:
> - inline oidset_size()
> - inline nth_midxed_pack_entry() early
> - use oidset_size() to avoid a function call if no bad objects exist

- forgot to add "v2" to the subject of patches 1, 2, 3 :-/

Ren=C3=A9
