Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BAFC433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D2C64FBE
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 17:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhCFRlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 12:41:37 -0500
Received: from mout.web.de ([212.227.15.4]:45625 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCFRlX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 12:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615052467;
        bh=BSt9kObAXmL9Xl2NReIfRDj4Ld/kNWSFln7ezRxZXFQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QdH0t5TDmlwOUIqh9fPFg3bfe5J9T/N/TXvzS6/G50iIVrsHy1S+0CSIOUkn2Ry22
         nkbOUdiHppqXeA3Zu3TlamjbcT8ZcofkLAT67vN1Bt2uCdZx6pgJo5XP4V6MRwRK2s
         MfR5/5nmIL9mdEqoOLf2w/Vr9075mlp5r4Hk4pE8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M1aE3-1lJxZR3rkh-003D9w; Sat, 06 Mar 2021 18:41:06 +0100
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
 <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
 <87ft18tcog.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <c654c7f8-bcdd-ab58-cddb-a1005a9b8914@web.de>
Date:   Sat, 6 Mar 2021 18:41:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87ft18tcog.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zAiqphqlQSnDs6VqEap31G6Bf9GoTiS9MQlAaaR9QzyybQUOvFz
 Rrv5oIiMqZCqNhFCsdqya1zYT+nMm1mLI7EFCecB6zod5S0vgF3Of2klF0CvNBdflokRwEB
 WowjBVhcnB6mQ1w0BK20gOUpgWTzgwpWKo/4ua2dIOpZgOCHfFh9iCJ3PpEjRLQF89gkldx
 LWb2Bp/uZWV9GQLeQiuJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b0G+0aDe090=:5UbWmuZkXOLqE5iSmHSbjJ
 nZPV3zzC3Nv415N+2xY3NqpkdBoalgbfpwPA77SDVuNMFiwrkZ1hwq9bVoIjPooaVLzekUJj8
 QBMbLMya8cALfomDAZpU5UPQXaUEbDJiLUFFJyIY8+BZIpckHTucZwzbpc4ayNKC7yQgOTl6A
 BPhFLDx/MHlOc0zImEQF/Yx+lnqoo4zhT1qZ0rpF4uaQ2dP3OCZQA+9iq/MIg9NQSCFzUyr1a
 G3WsSW8bWQgYNDtA9wZsKeeDP6FK3kZ80kAgYeiXUwV7QZrG6Z7LTUDHsn33ZLofNQCLxBHv1
 FLMTFvowDArY/MRwfHGKKiRwbTa6Sau8CtnNASKlqU6MuzSkqrGtB+4I0TOBIguxwSlFgjz0J
 x3ci/rPiAjfJZ8S+OXqKKX4pxCapjEZPnXCH25M9Jam3mlfweiJjnuDDMzG14qCgsdWZlMAkE
 aQ/444slCwvo1mAcIBSEAnqCxr9SghUIMfBNkbLbU0nEfS/bQ9TYolSGLnVxHD6bu2/KGqdYF
 q+JAkC0Xfo8+TLSFlOYYNDkVOM4uibfu+IX3g81t4A+hseB+100H+w/Wwh8+o9e5LLEBRNQwl
 uSpJr3UxjHGSoFEIn+7YixMUAMqSO11FhhwiT9ZXpxT8yxdALt7v8hthmlnPRQ/CnFyrBNtH5
 4JF+N3VaS1jn/+DgPm863EfoL94sMWCGsLggcfCXQ6IJPejSaebAUDLOqGbsFJ7ahxoVZO8No
 HXw5Yc2JouMGHcup1X5R4xu6poCMhIwhergwWXyzHjmLwFRoDmBRw2SOkGHVRBcn+yHTUMfi/
 TRTuKY5+AnFbsxpC/Fhk4RiEHGbkdbFFeoor7vNuTPySBuls9HjGYg77JC4Yroc1A+9we8hRQ
 wv/ozi5HseraGQ94BLmQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.21 um 18:27 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Do these sorts of rules really benefit that much from the type
> v.s. expression? If yes we'll obviously need to support it, but if (and
> I haven't looked closely) we can equally rewrite them with "expression"
> (or it would be good enough) we could be quite a bit faster by
> default...

Type information is essential for many (most?) semantic patches.
Untyped replacements could be done more easily using sed or similar.

Ren=C3=A9
