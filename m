Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC57C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAA920714
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SrbBuLbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFNNAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 09:00:39 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:43934 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgFNNAi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Jun 2020 09:00:38 -0400
Received: from mxback9o.mail.yandex.net (mxback9o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::23])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 849EF11C154F;
        Sun, 14 Jun 2020 16:00:34 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9o.mail.yandex.net (mxback/Yandex) with ESMTP id Tekch6MqHK-0XD8cFjI;
        Sun, 14 Jun 2020 16:00:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1592139633;
        bh=PxV/sEGFxMsMCzUXKAXQ3ZbevUdU2yi1Vscz/lMCD88=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=SrbBuLbKOtDwQ7nyYfDMr6DBoLaeuQFzYO7+H8VYxKo9VQKmLnN4Rxc/y217zZaF9
         4B3uTLsSSdtOd8IxmC6FY5fqGXF0wn76WYVPJCDDcILQXY5OyUyh+AZWJmw+6DEMce
         4epIN2WmCxD/K0GaLc4Y3l+ArFp7OTeRH0bE4Dto=
Authentication-Results: mxback9o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-e76feb6221c0.qloud-c.yandex.net with HTTP;
        Sun, 14 Jun 2020 16:00:33 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     "Curtin, Eric" <eric.curtin@dell.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <niall.geary@dell.com>,
        "rowlands, scott" <scott.rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
In-Reply-To: <xmqqa716zs7w.fsf@gitster.c.googlers.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
                <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
                <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
                <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com> <xmqqa716zs7w.fsf@gitster.c.googlers.com>
Subject: Re: Collaborative conflict resolution feature request
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sun, 14 Jun 2020 16:00:33 +0300
Message-Id: <30661592138737@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



13.06.2020, 22:22, "Junio C Hamano" <gitster@pobox.com>:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>  My opinion is that it would be nice to have something like git-imerge
>>  integrated into Git.
>
> I am not sure what you mean by "integrated into", but if you are
> talking about somehow reinventing it, I do not think it is a good
> idea at all. "imerge" works quite well already.

No it doesn't. It has performance issues which makes it practically useless
on the large scale repositories because of slow progress even on fastest
machines. See for example 

https://github.com/mhagger/git-imerge/issues/66
https://github.com/mhagger/git-imerge/issues/149

Also, maybe a bit irrelevant, but it was recently removed from Gentoo
because it didn;t work with Python >= 3.7
