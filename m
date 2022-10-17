Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9A4C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJQSZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJQSZj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 14:25:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106674CFC
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:25:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so19716249wrp.10
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsQaBQWCH4K5y5wbsbT+fJfXqQP0uwTMGykcynxdsN4=;
        b=X3dlxb0BPopUKBP9elKKRwTqKS+gZqlnjDSxiCIIec7XwC5N3xLDMxHE/wuqf3Bq5G
         Jh9xn6MDK0owf8EkIExzR8E0s5f2dpkiwxSykdxAHtRGYtpeJYaxR2+I0rRzg+mChtaK
         2VK4WjCUkcWNhgniOHezVLJZkZ9waMCoQJJcWxDzzmJKi/nWqoitaTmKLhCq8fbSob4c
         wEcxTxBR+u/RaxuAVsc3tZm8uXf5/NV9eUcnei7V1qsYxUuCwMJ70WLfVVQOpn+Zz/wN
         hoZC8oUQzqhBn1OiyO/Zz/AjMWr6/4yNCvX7KAANHz4pElxtLxLWzEh/JdQNWbFYuroA
         0QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsQaBQWCH4K5y5wbsbT+fJfXqQP0uwTMGykcynxdsN4=;
        b=3EKR1FQUxhhoG2eprv1FT/cG43AQ+X8Ss/AU6+mlKQnV48YbScqyxeg+Ebdlga4X7M
         PGiRcOgEwu9J2jxbj4RqYV2DcS8MdKP2n5bgh3RihWIJFBBGyp73KxByRAZ9WgepmLSL
         KPfz13MEHkWVV+fdKhTP/VgI6xkHaOUbQ25ONkItNhPp2YIT1Szt6LLRXbNDK58sflDU
         PsGkM3OZisoPEtP/VUIVk5rJ+6Hh94YX9mLLoCdAn8GLONbWh2zqc/sGOyOr45a8cWFj
         4209rJ25zjVzZIiSZ4nNYkJuxxEXAoPTMrf0CzQdbNxY+g3nr3gjaZvxdAsxChH4wNfB
         Vvbg==
X-Gm-Message-State: ACrzQf1Q9gOqr65wRhV1gE+Q+7D+qDNfuLK+SN2fuJg9Gbl5z7pGz61+
        YqKfSVvXZ2dLwQhQxjX8CcmOlKm8FS0=
X-Google-Smtp-Source: AMsMyM4c2I0oRtMqgfW/MHMk7NaVBupaDi/K5nkyGTXB3tTGsiNanKNS9gaUeFczHc6wyxqUSTcLWA==
X-Received: by 2002:a5d:6d86:0:b0:22e:4049:441f with SMTP id l6-20020a5d6d86000000b0022e4049441fmr7133166wrs.198.1666031134918;
        Mon, 17 Oct 2022 11:25:34 -0700 (PDT)
Received: from smtpclient.apple (2a02-a444-ebbe-1-31d1-65b8-8bfb-fce9.fixed6.kpn.net. [2a02:a444:ebbe:1:31d1:65b8:8bfb:fce9])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b4fe03c881sm16962847wmq.48.2022.10.17.11.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:25:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: git gc error with git 2.37.2? (Introduced in 5a5ea141e7)
From:   Paul Wagland <pwagland@gmail.com>
In-Reply-To: <Y02T9ssqqwX3mfRj@coredump.intra.peff.net>
Date:   Mon, 17 Oct 2022 20:25:33 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3C065146-04F5-4946-B38B-8F1DD44AC10E@gmail.com>
References: <ebb035c1-d313-4f8e-b850-a6e11eeb374bn@googlegroups.com>
 <2C46C994-6023-4C69-92DF-73291A6AF94D@gmail.com>
 <Y02T9ssqqwX3mfRj@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

> I'd expect that the resolve-undo extension would eventually be dropped
> once a merge is finished, but I'm not very familiar with that code. Is
> the repository in question mid-merge, or does it happen all the time?
>=20
> If there are no changes you need to keep in the index or working tree,
> I expect that a workaround would be:
>=20
>  rm -f .git/index
>  git reset
>  git update-index --refresh
>=20
> to rewrite the index from scratch. Then the problem should not recur, =
as
> you'd be using a version with 5a5ea141e7 from here on out.

Thanks! This did the trick for me! I suspect that the problem happened =
at some point in the past, when I was doing a git merge and git gc =
concurrently. A whole whack of stuff required recovering at that point =
in time, and it all appeared to work with the old version. But probably =
something was still left in the index that referred to, indirectly, =
1d0f34d1c.

My problem is now solved, I=E2=80=99ll also feed this back to git-users. =
Thanks!

Cheers,
Paul=
