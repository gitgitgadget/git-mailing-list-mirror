Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82FC3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A187246A8
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="KG/lyKO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgB1Vqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:46:54 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:37817 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbgB1Vqy (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Feb 2020 16:46:54 -0500
Received: from mxback8q.mail.yandex.net (mxback8q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:b38f:32ec])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 532AF60315;
        Sat, 29 Feb 2020 00:46:51 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback8q.mail.yandex.net (mxback/Yandex) with ESMTP id 5IuxVJyahX-koIGn3xp;
        Sat, 29 Feb 2020 00:46:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1582926410;
        bh=L4Cn2YtvIAxiNkFPnEQVdF0qcVhyrHLZc2iddqf22Os=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=KG/lyKO+2J2MoeUjpJmFikA06qJt2kYBdN8Rn4fhI/Y6OsvDtsnQr0ecF/LZkDYEX
         vOkTW/s0sDVqi7bCPJwAyqdCp8LyRQWwTNlSoPCGiz2yX0OKCBR28W8dPjC9ZZxT+j
         ZWaKrJxiZYby3Gxpx2NO7LRTpsi+x3feJT/lt/6c=
Authentication-Results: mxback8q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-fadba9086fdf.qloud-c.yandex.net with HTTP;
        Sat, 29 Feb 2020 00:46:50 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Git <git@vger.kernel.org>
In-Reply-To: <CAHd499B3HbXPo+O3u3qA-SfJ_dV=z2k5v09mVHtbjXGkAaNBvQ@mail.gmail.com>
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
         <CABPp-BGrwNf9p6Ayu=A4CF9ydww8tQfvzFqFO1rNm-QG55yG6w@mail.gmail.com>
         <xmqq8skmeabd.fsf@gitster-ct.c.googlers.com> <1320071582924243@iva6-ab1cb434301d.qloud-c.yandex.net> <CAHd499B3HbXPo+O3u3qA-SfJ_dV=z2k5v09mVHtbjXGkAaNBvQ@mail.gmail.com>
Subject: Re: Why does `pull.rebase` default to `false`?
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 29 Feb 2020 00:46:50 +0300
Message-Id: <1200001582926410@vla1-fadba9086fdf.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



29.02.2020, 00:23, "Robert Dailey" <rcdailey.lists@gmail.com>:
> On Fri, Feb 28, 2020 at 3:10 PM Konstantin Tokarev <annulen@yandex.ru> wrote:
>>  In reality, newbies often end up doing chaotic merges caused by pull
>>  instead of learning about rebase and branches. IMO, it would be better
>>  to have pull.ff=only as a default.
>
> You and Junio make a really good point. After reading the responses, I
> definitely could reword my problem statement. The problem is that, for
> newbie git users (the majority of people I work with), they just do
> `git pull` which always does a merge. Myself (and many others) in
> simple workflows don't like it when newbies do merges on a pull.

And if default behavior would suddenly be switched to pull.rebase=true, newbie
who was doing these merges all the way may end up in a really nasty situation 
when doing pull: rebasing local master which may already contain a few local
merges not present in origin/master, resulting in complete change of recent history
shape and possibly some involving a few bad conflicts. Changing default to
pull.ff=only seems to be less likely to wreak havoc.

>
> So the problem statement is: Prevent newbies from doing a merge commit
> on pull. Whether its a rebase or not is beside the point. I think
> making it --ff-only would solve the issue nicely. It forces them to
> make their intention explicit: Ether do a merge pull, or a rebase
> pull. But you are forcing them to pick (and ultimately get educated).

-- 
Regards,
Konstantin

