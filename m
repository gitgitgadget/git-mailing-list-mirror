Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C355FC43219
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 08:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E6B60EBB
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 08:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJWI3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhJWI3X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 04:29:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91075C061764
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 01:27:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p16so89261lfa.2
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YPoAg80sw/RFUx7/8RWZpAR9GOdJzpxC8RtfEQPuD8E=;
        b=VfJbdqSpyaWAbuxIOfoxZ9WFSaRzYop/p4kcZLcMJDrJyAu7iS+6sYbcGG+6L/cylc
         +dAgmTVRgSRqn6cFNWRkzAkIU2QNialr2mt71EdoOhZ+Ie5AHfx6yegEDDg9mvt0u5rJ
         Rd2R7B8yZ0qxN8Ymlmcerxs7RLd5+09tp3vkLpxZKb4C0Dc8ZHd4BhC5f8stxAJ2WqhC
         HsFhjMOJjimOpPp+nXPn0dIivRx/rtZXUkp35qOhyM4VaBKilb7IUWUWb5B6tyKC+BoE
         4XIsEH6mS5+qqEp9iqJm3fhXCo6DHRwM7j4M4TW/gm+i6QtxQP0G1fLLZBGtnLsqf3eI
         K/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=YPoAg80sw/RFUx7/8RWZpAR9GOdJzpxC8RtfEQPuD8E=;
        b=m4sP6kDWHFxGnrCX+++5sxnlLJQJsfXKdd3fK9IFwebR0hRsRBZ4mHNIdafpVnARIC
         UDJgtpEH/3FE/dr3+u/8cjopvLtTjFyiNAMFJWypVDYEF55T3KOI8bWPJJl+7+J1n4ZC
         Rgk6lWUf+xdsaVBGhmeTRK6OCCJ1MW6NcbP1XDGitCpvKAE/0gk7tOABSSp+0ucOR/Vl
         MO9f0VkX/Ff27bC+PytCnNBgCGcKgBPTUoga5DpCjQ3tCO//lhh0EY2LhARsw0hK284T
         H8g6EOWeCHt9mt3YWs1cV1sNFKSGTlJH9HhNQ5GrO39Pl+ebUU4wEULztQa60exXTsUt
         HJxQ==
X-Gm-Message-State: AOAM532F3INtO1giQkXhRkLTgVhzB6LzbA6smYUFuYsf06pZoNbOd85U
        nm9ShaW/7q9y0rKoixunarUH1HX8RcY=
X-Google-Smtp-Source: ABdhPJwkPqnw+gR1Di8Nhips2HY1vv8J0+hKuFLdpM0GtWz/hUsgpcXsV0OnPigxLpkTUJBWYAxtRQ==
X-Received: by 2002:a05:6512:12c9:: with SMTP id p9mr4748772lfg.236.1634977623000;
        Sat, 23 Oct 2021 01:27:03 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 15sm965351lfy.86.2021.10.23.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 01:27:02 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     martin <test2@mfriebe.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
        <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
        <211022.86v91pjfn7.gmgdl@evledraar.gmail.com>
        <dc5dcc43-34d0-f4a8-93fa-6875c98e74a5@mfriebe.de>
Date:   Sat, 23 Oct 2021 11:27:00 +0300
In-Reply-To: <dc5dcc43-34d0-f4a8-93fa-6875c98e74a5@mfriebe.de> (martin's
        message of "Fri, 22 Oct 2021 17:30:26 +0200")
Message-ID: <875ytokuy3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin <test2@mfriebe.de> writes:

> On 22/10/2021 16:24, Ævar Arnfjörð Bjarmason wrote:

[...]

>>> If 2 letters could be used, then -c could be given twice for "create copy"
>>> -c  => create
>>> -c -c  => create copy
>>> -cc  => create copy
>> Hrm, that's interesting. But probably better to have a long-option.
> Well, both: Long and short. But long is --copy or --create-copy.
> The issue is finding a short option. -cc imho is still short.

No -cc or --cc, please! -cc is not single option, it's -c -c in a line,
and you will then have hard time to even describe -c.

--cc would be a point of confusion as well, e.g., see "git log --cc".

BTW, is it frequent enough operation to even demand something shorter
than --copy?

Thanks,
-- Sergey Organov
