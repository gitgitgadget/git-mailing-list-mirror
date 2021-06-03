Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55CEC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE8613D7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFCKvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 06:51:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6151DC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 03:49:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r198so4780290lff.11
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UIFa7NKW0kg6TLQ9BnHG9sWwYqTngHiq/hklnJr1/jY=;
        b=LiCsFY81X6xUFh0FbsCFjco2EHdFxIhi2lAqineTWKQNm6Rtc56SxpG3dfLuXWdiKK
         nu+StD0hOyp6f69weElDV0OhDNtjddVragwy/hYvMysSeOo33r16W1OipJfNx6+QJETF
         nR7wybtfqLjOhQ69QpLksvU8RGTnLGjHom/DxmpvfHlEAubs5/MQd61F5WrPfT5G3Zd5
         OEWArUwY5GtR65vzvnsZ9HWhm+50CotYaeM+9BChkuyCnO/wTSNCc1swHWtIC8tLXgwr
         FqE89hN0SAyhh8aku+40M/JDN2WNqMGMhFBzAXhuaoge8Ndlh2dI3kgqtqAXIZx01EDh
         DJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UIFa7NKW0kg6TLQ9BnHG9sWwYqTngHiq/hklnJr1/jY=;
        b=GGPZnsEyX++9E5+I76MVf2sM7w1h4iS2kcX54kyr/8vwj2pn78iXJ6hP6GbdNPXj6x
         b0QWUF4rTMyQKuH6wnJzFOMFCSVwMTbn8tS84wiPFJeRyYDEiUcZdkAvlTaIJpq6boSZ
         sYoDvuq1nVHknvrwSkxJrfwmRHU4ev7QB0I6p0hsS3BPQFSBuKQvT+lC8B+YG1iwfMKz
         WGQyucmitJzwRE4XRAH6GXdeXXbjsDU9Llrv82HlqMzmSq3WycEEDa5c5NYwvhsT15Xm
         0icNTkIbJCkilnS/nfEacns7T9mMaf0OlfHhq46dkZ34dzw5JH0WMA9mfdNEZ54KjOLt
         l5Og==
X-Gm-Message-State: AOAM530HgvjuWgvy6tq3UtxuV+6i6TRldAR5EQRYjMoSDVW5hTP4JYBm
        5hkLHwYAsn/skFpw0ZXpyY7CPvqA0+E=
X-Google-Smtp-Source: ABdhPJyk8z7xsS9veOngjj9/nDjRbc7fN6hWyFaie3oNeLIvP8NUEYGdl3j9Vws/inybKXvcbhFSSA==
X-Received: by 2002:a05:6512:3c8:: with SMTP id w8mr25776394lfp.63.1622717394512;
        Thu, 03 Jun 2021 03:49:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u13sm321217ljk.133.2021.06.03.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:49:53 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <YLXl5+ronWhcGh13@danh.dev> <60b61089ba63d_e40ca20894@natae.notmuch>
        <YLcFU+ORZTzAsyBy@danh.dev> <60b70eb930614_4abd208ad@natae.notmuch>
        <87eedj74dr.fsf@evledraar.gmail.com>
        <60b8a98d11d7c_1a0a2d20856@natae.notmuch>
Date:   Thu, 03 Jun 2021 13:49:52 +0300
In-Reply-To: <60b8a98d11d7c_1a0a2d20856@natae.notmuch> (Felipe Contreras's
        message of "Thu, 03 Jun 2021 05:06:05 -0500")
Message-ID: <87im2v1aun.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:


[...]

>
> For example in 3 days of doing this experiment I've typed 'g c'
> countless of times (alias for `commit -v`). I added an alias for `ci`
> instead, since that what other VCSs use, like Mercurial. But I don't
> think `ci` makes sense for commit. It would be better if `co` was
> available, but then checkout needs another alias.

I guess 'ci' historically means "check in", as opposed to 'co' meaning
"check out", probably in RCS.

Thanks,
-- Sergey Organov
