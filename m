Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FA9C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 10:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGJKGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 06:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJKGL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 06:06:11 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4425EA
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657447553;
        bh=yq8Gu8Op/RzbazV/BlEWDVz4xmiUGOnVM8kzrEBje+E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BO4opeltTrPJSeawRnd6a2lNl0XBbidB24tMvoW1eiZ7Up4TIt9ILkbBkCmEx+Ggr
         i6mfGw7UGLTLr4knORtEiqTvJ26qcrpxHiGKkVToxQaEXXJ49XaqDdIhN4GlvvwSoE
         SO5ofIYW59wbiCsXw8amASbyZMk6NHqJAjxoIXko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1nr2EK1WBd-00Jv6Y; Sun, 10
 Jul 2022 12:05:53 +0200
Message-ID: <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
Date:   Sun, 10 Jul 2022 12:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: [PATCH] cocci: avoid normalization rules for memcpy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
 <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
 <95432eb4-e66a-5c04-9267-f71391fbe277@web.de> <xmqqmtdhsf1z.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqmtdhsf1z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kDHloF/f6r1W0Gr/rilmwtyRI+oNI88Vy6JLWJvcNSwJ7bg/PdV
 NJ69UgqfxaQLloiWZF9f3/LUUe0iQ0HVjJLwfVU4nONnDi+K3wiNU8zsHqwTAMTxvmYnllu
 hrTAkqXgZCG5nqaj6av67pk5G5FDkXRRyHneOo/n+Q0u6WiJNeGh0NtMQDhJJnR8hHLMphB
 NBjXB+v1Rw2NTlPQLSybg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XHEMXp2TCXQ=:jmh+biAG1/K9wtrTuKc3r9
 yVKcRjLqybZfoXfbQFjuThV7nktDlNtBV/lsOkQl4lpn2eJuQP0IK3iiDIlkyuFnr6StL1Q6m
 POsVjxE8l4mfJNAj5kjT3+VLS7LArHmo0alRefpdefM5vwamKnkdHgdFLPc4fKSRo10bhdJ3G
 U1rQQyQbt3KwHP/28hg1I2queyC6l+lB+fzoHLFyVTMxLJGpY8ADFzUo0tDTfq/zMxFNTmhAX
 YtmHGZJJmh1wD0LZZVPbNtqXBMkicgkxhl0Hv6RI/PyWdLqfI44tstza+jND+7B5rMnDQC7mg
 tLBoHMYghNA6NRtBFISXQrkHpp7emInRYW+v3Z6Ra9iBQM4TtG5J1LOZ+qs0y3Uz0xo8u1XPJ
 MlfJ4F0WiAiz3Bmc9nI83USjFusTkO+N/sENefv70034P89NPjnuLNXIGnMaGnIK3NoXRu+8w
 sEx/qMplvgdmwJ9mOMXfyOj5Db4MaTb7SS7i2xbXX/BTmR+nJ0k+CpJ8TDPeILM1fId0Dm6m1
 7GLmeuVysnuIdyq+ClpyriOYwS1M45uy7G3CQPm+wcCCZdaNNzkYt0W1BwwVHQgPYZQbEnSJK
 BBN76Srp+i6Ton/PVxqtQjrXtdihX1p5443GVVIz3wuwufZfmAVBAIkFJKT7dSm58HNndivi0
 znKlpyz1BGXRUHVRy/InmAZ5SScJmtl8aKYA4+UkzFb/2WA6vnZQ2k4SUuh7VQjt3dbjW/IxP
 OdXOSoVmGokTX98fF7GOTTtAlHO4KqVZYFene7XHX7++bU5GOIS+CCcHXVrZGGhHj8NopVvC+
 yMiu7BMv0fnBT6tM+pxQ7glEtZU/HLPsbsfL0POVYn7EQTA//uMEnmN2eHDkiRyptuU1vCqcj
 SyV5yCVy9oejs352/fT2DEm+0sUwYTpUKN4iCh8/3XIqDTck+kXyfjXpYoIXe6SrOYkumVD4H
 iVQbRR2BBTUf57NmUFbj/eHMrNBFGF717FY8Ew4QjGgcTH06gCNrj2eUMVHY6RURXC4KyevyH
 /oiuBsDTXgFzS5QamF7r/wkSmCLlcmT3l5qWuTNOh0yi9ZIOscbq/h8yQnpsyRUXGPYJJUSEe
 2AtO8di/y5orYzpwUaR6XBAXbgoJ0JfrNCd
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the rules for using COPY_ARRAY instead of memcpy with sizeof are
intended to reduce the number of sizeof variants to deal with.  They can
have unintended side effects if only they match, but not the one for the
COPY_ARRAY conversion at the end.

Avoid these side effects by instead using a self-contained rule for each
combination of array and pointer for source and destination which lists
all sizeof variants inline.

This lets "make contrib/coccinelle/array.cocci.patch" take 15% longer on
my machine, but gives peace of mind that no incomplete transformation
will be generated.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --patience for easier reading.

 contrib/coccinelle/array.cocci | 92 +++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 9a4f00cb1b..aa75937950 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -1,60 +1,58 @@
-@@
-expression dst, src, n, E;
-@@
-  memcpy(dst, src, n * sizeof(
=2D- E[...]
-+ *(E)
-  ))
-
-@@
-type T;
-T *ptr;
-T[] arr;
-expression E, n;
-@@
-(
-  memcpy(ptr, E,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(arr, E,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(E, ptr,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(E, arr,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
-)
-
 @@
 type T;
 T *dst_ptr;
 T *src_ptr;
-T[] dst_arr;
-T[] src_arr;
 expression n;
 @@
-(
=2D- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
+- memcpy(dst_ptr, src_ptr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_ptr))
+-                                \| sizeof(*(src_ptr))
+-                                \| sizeof(dst_ptr[...])
+-                                \| sizeof(src_ptr[...])
+-                                \) )
 + COPY_ARRAY(dst_ptr, src_ptr, n)
-|
=2D- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
+
+@@
+type T;
+T *dst_ptr;
+T[] src_arr;
+expression n;
+@@
+- memcpy(dst_ptr, src_arr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_ptr))
+-                                \| sizeof(*(src_arr))
+-                                \| sizeof(dst_ptr[...])
+-                                \| sizeof(src_arr[...])
+-                                \) )
 + COPY_ARRAY(dst_ptr, src_arr, n)
-|
=2D- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
+
+@@
+type T;
+T[] dst_arr;
+T *src_ptr;
+expression n;
+@@
+- memcpy(dst_arr, src_ptr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_arr))
+-                                \| sizeof(*(src_ptr))
+-                                \| sizeof(dst_arr[...])
+-                                \| sizeof(src_ptr[...])
+-                                \) )
 + COPY_ARRAY(dst_arr, src_ptr, n)
-|
=2D- memcpy(dst_arr, src_arr, (n) * sizeof(T))
+
+@@
+type T;
+T[] dst_arr;
+T[] src_arr;
+expression n;
+@@
+- memcpy(dst_arr, src_arr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_arr))
+-                                \| sizeof(*(src_arr))
+-                                \| sizeof(dst_arr[...])
+-                                \| sizeof(src_arr[...])
+-                                \) )
 + COPY_ARRAY(dst_arr, src_arr, n)
-)

 @@
 type T;
=2D-
2.37.0
