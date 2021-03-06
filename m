Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2937FC433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB5464FDD
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 12:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCFMn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 07:43:59 -0500
Received: from mout.web.de ([212.227.15.14]:59213 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhCFMn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 07:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615034620;
        bh=CGfeI+DPEMq7Poah7qk3hVOqzBw5ZvHoyWlobtMdJhk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=mgyoGoKGVs4RjfkivrzkN5xIjdApMO0Q4CqBHn/mPYJY9QFScptO38UIRh3Chy212
         aqejGigF3c0Wmu9M14F63wWlVQWkdmH0Sg8xRfOMY9a97RD6ookYIzWZYstich2I0x
         5LGI6pO9i1OdkUcO31/nAd/SS5eYblTmkYmzZ92Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M8kAH-1lMd0k3vPt-004rxz; Sat, 06 Mar 2021 13:43:39 +0100
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
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
Message-ID: <ea384531-24e2-6124-0f7f-9cab4a9ca75f@web.de>
Date:   Sat, 6 Mar 2021 13:43:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <0742554d-7d3e-3f92-57d6-1339e5ce1450@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FV/PyeKjrRJqBk/pMmJhv/PX1C8BIPYP8tJ7nxlNGb31zM8rZZw
 Hj788Ojf4qjnQRhrTpZKXgQMd5oSSxYjQj+Qk4SR1MGexzX+cOEUTDmWpB+vhnLDAJ5lTxp
 utpnGjT/hAnOynWVYSSk8ZUolhDJ8sAeAle9ORU/25TVgnnjed7X6EQsNFdtGU+UyAKj9GZ
 xiVwX2bYv3DEPfIJA4Fgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rSOVdePH8c=:tEK1d+XVUyO92WsKj3sspM
 iMmbIHYhMO/cGGoCJp1zTg5ao2+MCgNMdz+tXPiU0F2/osZzxBmmnPQfbytR/cyUKHYdiN53u
 zqN3D/3v6apU5oEMlmIT0HfxPcFdwD4KxRLjPlZqOHBhoBLgnR5l3WWIcIKqg7gbAir9O7S1o
 qMNivSVoBudzWNQrh9TYIXynnxjwMBOcRKMQAUIC6QBabe5vZrtY7QtvJGnIHX39h9NxC/9tC
 1rJfKC+Bl+AXQgRaU+2LC+9crGP17WFW7GS124fvt1GPRYhgcFbxnGi9CUqFSaQbX8BnH2/IH
 mfj+9oK2bVQH19Pd9ENTR6efTbJSHfnhy5t6xMamXFn4oB8dJldY/VvtOXQcppDy65GU7qXz5
 7DAbLNpgeZbUXQ7s4PYvD/nvixQgCdoWaDCtZoOT8jAMHC0RTui2i2/GbYRr4TqK/aXX2Rbeb
 Vqj4Nc6HW0enHQ+5XrEVBkv5e5Ps2QOmp6WJuCA06o/vmdvsfiFDpYBmQioKx5FnR4/t/reIN
 kQwk0vWVyflo0noz1CMTyDDajOS1hwFBkiGPXchaDpPGCcuHSm7SdSgBeVOfZJWtPqiVjW31D
 NXZFqEy1fXO0v3rDVoYuOZOurhllcXB7IZV7BhcwG+FG5Sp7a4MYCdRZYkQTDYTLLHNmkZGDu
 NutosKeUUVE/AlLjfBoUvLGmIiiZ/uc17NT/JUnYrJPFOnVd2FbHnX3fBcwg2GXGhpCqKJ91g
 NTrC+XEqgUCWfWEWJqINzUL0mw+Od77IzkcnVQG8fnOnTlr3gb/7tQjdt0NaRbCWEZEzW0Mu1
 dPvh6wdt/+sD7ZDOX2fCLr9NIU5kRSOXU+ZPJeNUryW+Qt4D+OshFkpV6nOw/jNrXKiLlb74K
 e5NK9rvD0Dy/SnQhgjGg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.21 um 12:26 schrieb Ren=C3=A9 Scharfe.:
> Subject: [PATCH] fix xcalloc() argument order
>
> Pass the number of elements first and ther size second, as expected by
> xcalloc().  Provide a semantic patch, which was actually used to
> generate the rest of this patch.
>
> The semantic patch would generate flip-flop diffs if both arguments are
> equivalent sizeofs.
  ^^^^^^^^^^
Actually the sizeofs don't have to be equivalent for the flip-flop to
occur, so that word should be removed.

> We don't have such a case, and it's hard to imagine
> the usefulness of such an allocation.  If it ever occurs then we could
> deal with it by duplicating the rule in the semantic patch to make it
> cancel itself out, or we could change the code to use CALLOC_ARRAY.

> diff --git a/contrib/coccinelle/xcalloc.cocci b/contrib/coccinelle/xcall=
oc.cocci
> new file mode 100644
> index 0000000000..c291011607
> --- /dev/null
> +++ b/contrib/coccinelle/xcalloc.cocci
> @@ -0,0 +1,10 @@
> +@@
> +type T;
> +T *ptr;
> +expression n;
> +@@
> +  xcalloc(
> ++ n,
> +  \( sizeof(T) \| sizeof(*ptr) \)
> +- , n
> +  )
