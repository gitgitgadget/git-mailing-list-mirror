Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E14C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A91360EAF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhHWUHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:07:46 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:50454 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhHWUHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:07:45 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:16f:faad:4075:735b:619a:fb95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id CB5844E61E4;
        Mon, 23 Aug 2021 22:06:26 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1629749189; bh=hEzYbksvSMd6LFZK8kiYdwyt1Xzk46kTlo0JxQNoPsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=7PNIj/Ay6Jlo6/LnSjNE0uKV71zUVPNVflfO0VM1UhOB9Rkb0c+eMO4tKHZUTeWpz
         eBURMlFX6cf3JMDgCv9oZnb7mEmCt/YxkS1+Sw+7WpwRqSJQX37nA2rwYq7oOFIT6n
         GtPcaSR17KcQH8G41uHuIXUS7pFqwDffu/disX4Y=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
Date:   Mon, 23 Aug 2021 22:06:15 +0200
Message-ID: <3218082.ccbTtk1zYS@coruscant.lhuard.fr>
In-Reply-To: <87h7h75hzz.fsf@evledraar.gmail.com>
References: <20210612165043.165579-1-lenaic@lhuard.fr> <20210702142556.99864-3-lenaic@lhuard.fr> <87h7h75hzz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Sorry to come back after such a long time. I just resumed working on that=20
series and would have a question about a review comment.

Le mardi 6 juillet 2021, 21:56:38 CEST =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on a =C3=A9crit :
> On Fri, Jul 02 2021, L=C3=A9na=C3=AFc Huard wrote:

> > +#ifdef __APPLE__
> > +	return 1;
> > +#else
> > +	return 0;
> > +#endif
> > +}
>=20
>=20
> I see this is partially a pre-existing thing in the file, but we have an
> __APPLE__ already in cache.h. Perhaps define a iLAUNCHCTL_AVAILABLE
> there. See e.g. 62e5ee81a39 (read-cache.c: remove #ifdef NO_PTHREADS,
> 2018-11-03).

Is the suggestion to replace

+#ifdef __APPLE__
+	return 1;
+#else
+	return 0;
+#endif
+}

by

+ return IS_LAUNCHCTL_AVAILABLE;

and to add

#ifdef __APPLE__
#define IS_LAUNCHCTL_AVAILABLE 1
#else
#define IS_LAUNCHCTL_AVAILABLE 0
#endif

somewhere else like at the top of builtin/gc.c ?

Also, do we agree this shouldn=E2=80=99t be defined in cache.h=E2=80=AF? I=
=E2=80=99m a little bit=20
confused.

Kind regards,
L=C3=A9na=C3=AFc.




