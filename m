Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4187C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762ED64F1A
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhCMQKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:10:54 -0500
Received: from mout.web.de ([212.227.15.4]:51283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhCMQKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615651828;
        bh=jRpFD/dZGbc8iNOnw95ZgDHPymE35jPVtMhr6VxkvgU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=K55mXqGfzgDyTc177u7lsWo5zaLoq6x8MCvYX+z5QFy2M5n0j1u3DIqxeAdL3HC8T
         e7MjSNewVPFWi+uPx+UJSUAFH4dBANydTh3w5AeYAs3crw8dza4aeQWS085t+cYm+4
         SjoMB4TJbYthEq06n/r5pZ0oCwW3o+hLIU042BxU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MBTD4-1lTKJ0058Y-00AVlt; Sat, 13 Mar 2021 17:10:28 +0100
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
 <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
 <xmqqim659u57.fsf@gitster.c.googlers.com>
 <0742554d-7d3e-3f92-57d6-1339e5ce1450@web.de>
 <xmqqft16914r.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <778c6cd8-b1c4-2a97-ab09-a926196ab0b0@web.de>
Date:   Sat, 13 Mar 2021 17:10:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqft16914r.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mspEBPogPddTlNdgsvH1ohjizSeXtiyHkFE0BiMjFz7eCpLOowl
 f7CTEpPAcKXwZhwcucya1mMG0fp4dqw3hSco4CVfB/R93JcoZQ2eSd07FH9jUHZ1gW3w/ZX
 b+CAGu6xp/wEHSL6Su6ZVhdnPFmq+hnJ7cXT6SNzXTu0HP8OGVu1tEQY/ZY8cY0y6uiPQus
 TYjkn+MUzGjMMaY+0UQ2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p461jE09itw=:rnc+Q4ClfHlaa04QigjUfB
 O6tj53BWiFUvBXWeOZPx3dhcs/1o6oCJkmWl/g2BjakcEQGzSz6OvK77px/3W1bQrMcXfL8WO
 AeHE3g5nIk+TcTpOc1711jhpdp9YCsqOqTUtl2YNEVU9/CjLINhNjdsCZbSV5cGgDl9sPPYCA
 dJOgFTJ0a/UMfBjW/ux8phA1l/qww56NeWkZ/HOGI/Wo5f2cs8pwD3aTwJQEfgf2YKGEbj1qn
 NTLkgCOCRm6Xha5b4JB04M1n9qnrpssSU9fY53Lt1+TFXSKpyNLRWbJRPFi1bdrDydkkZ7eZW
 8dDP72ohgl3jat6x2srjQZ7nMlJivvUky4oIf8pYjNGFo/BPcdqYiaoyXJFUGf71BxUrF+U04
 8q6pgij+cvvMgFQYGatvM3NojeFATuvYMKcNpdVmgxOMtPHCWHOeDhpVSJ5m0kW0aXu6Su7sG
 tjheWWD5Qf5/wxp7fFZDsmnv8yZW+4FToL2DAcyWFl1FWSmVx4ivI8BVhURhittfnIx0le3l/
 eEZDKrdYVZmkn9ae1CilY3+9hpQq2VdxCfCZy+ONPHvpydefsk6yk6yovZy/OLRBdmgUBkVEx
 epZpBp4KtqTp6z6hLO6PAi4TMq8LyA+2EgLR2BSu5ikw867MS/+MCa8jcKBbZTdU8pDW0Ej8P
 ghlN2e+4Pegp8Yqk71CB6hFUeeRWqsNdcCSOT5ODxxAswfHUBV6fIlLCOXRWGdgQCKP/Vb7qs
 mKKXdowMTictgxQUQr/WQV2Nb/106FNHqx6QLrLmQoswgVi4geVVkhq56/yK0qTIODrLu/l2/
 HfR5Rdc5L5JkXZAvoYRn14YQu1WUINANNBifabvcNaroPha1TNfulr8tT145JGaRUOS4vUWju
 ivkc5KSesXfF5COG+Hpg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.03.21 um 21:09 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>> Anyway, what about this more targeted approach:
>
> It is a targetted approach to solve a different problem from the
> original one.  I like the solution and the resulting code, but I
> also like the solution to the original problem, too ;-)

We can have both. :)  The semantic patch for correcting the argument
order of xcalloc calls allows the one for using CALLOC_ARRAY to be
simplified, as it doesn't have to do that normalization itself.

I can't bring myself to introduce special macros for allocating a
single object.  Let's first make use what we already have.

Ren=C3=A9
