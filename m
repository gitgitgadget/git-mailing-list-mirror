Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B30CC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 01:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbiBUBnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 20:43:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiBUBni (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 20:43:38 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3AE32040
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:43:16 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h9so28137738qvm.0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfaH9uFT2Yc3OLDE0xI1lvnoysxePxuysl/6zZ5XTyU=;
        b=qDVJM+5XXe7XUDiSlHH24DkzK21CYSAFXw7yo6JH3ixlRBc8YSAJpGNRBF5meiFPH0
         QAnNy5rsu/cHhxyXy9EiN/UJguSz8iaV5gTbney4LU2+t1PQiIe30qDwi70iosnK95+3
         N2d/zpxprMA1Nop1vjfTQcrkUdSBEIBF1k90x1byavZOPJOiJyWsjqXdooEDTE1tvGX5
         LvBWxFx0qXo2kYCRG7QmQ5rDxnO6JTWXLuUCKUf+s07x6ylNEuT7Rm3Vp9ei5ratNhye
         C1vJaVBNj0qiSEbHibl1rg40/RH0OvP1GPHNHPkHJtKQzPdLhc472+hiBXGMjIXU/W6Z
         F1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfaH9uFT2Yc3OLDE0xI1lvnoysxePxuysl/6zZ5XTyU=;
        b=1es/XcKK0Y4mcEbv1cgAG0lPonAXFB4Z0NvSI2pRYuOEjdLbUNYcrZ6fDUNFasS9We
         4knX3HG4ngbD1U9Wua5Vbco9R2Ettiqh3ElZH4uWjHaIVIIEx4g6WpVDY3yyBOjwFg8v
         S5vzFkOZgiTvV973/I5qlfjlgrXi4bcOkCNgmeM2NASK7DLWqI0zrx4Ifd3abc9CL1mR
         MWWfvrMlTkfGvzW+9UZZDAlw8tA2g0aJ73SBbR4Zq80QnzaRaMxOUgV0dDyT9K5poIos
         XWenX7MYNkdifEG9i0gHHnxLsrrrIu+MAcp6ZgKlExDKZK2A58R4mqNsWDb9GGWn136Y
         E+8g==
X-Gm-Message-State: AOAM530Wpi0ZpbZB5V5wuypU16MH0yqE8Ka2kEvGRs1OIWaEPagmmssC
        Yz3X7PLmlG5/UZqysoGwezj0myZFtIo=
X-Google-Smtp-Source: ABdhPJwWYsqQONB2bXXfzHWg454bUwz6tDpZ+IVPhdXVzs7GoYadNNBdwUZj5fxKhshGpJRf/ES33A==
X-Received: by 2002:ac8:5dd4:0:b0:2db:ac96:9ce6 with SMTP id e20-20020ac85dd4000000b002dbac969ce6mr15996809qtx.103.1645407795812;
        Sun, 20 Feb 2022 17:43:15 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id l1sm7988316qtp.4.2022.02.20.17.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 17:43:15 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Date:   Sun, 20 Feb 2022 20:43:14 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <F49696AE-3A00-4870-A355-A9510468F35D@gmail.com>
In-Reply-To: <Yg/09XYTruPJQVV/@nand.local>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <Yg/09XYTruPJQVV/@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Taylor,

On 18 Feb 2022, at 14:35, Taylor Blau wrote:

> On Fri, Feb 18, 2022 at 06:40:45PM +0000, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> Currently stash shells out to reflog in order to delete refs. In an
>> effort to reduce how much we shell out to a subprocess, libify the
>> functionality that stash needs into reflog.c.
>
> Sounds great. For other reviewers, looking at this with `--color-moved`
> if you have the patches applied locally makes it much easier to see what
> is going on here, which is basically:
>
>   - All of the implementation that used to be in builtin/reflog.c moved
>     to reflog.c.
>
>   - The function signatures and structure declarations moved to
>     reflog.h.
>
>> Add a reflog_delete function that is pretty much the logic in the while
>> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
>> builtin/reflog.c and builtin/stash.c can both call.
>
> As you mentioned, the `reflog_delete()` implementation is indeed new. It
> looks like Ævar reviewed most of it already, so I'll take a look at his
> message before I end up repeating everything he already said ;).
>
> It's worth noting that the subsequent clean-up to rewrite
> cmd_reflog_delete() in terms of your new `reflog_delete()` happens in
> the subsequent commit. If you end up rerolling this series, mentioning
> that here may be worthwhile.
>
> One question that I had which I don't see answered already is what the
> plan is for existing reflog-related functions that live in refs.h.
> Should or will those functions be moved to the new reflog-specific
> header, too?

Thanks for bringing ths up! Maybe this cleanup can be included in a separate
patch series since this one is mainly about getting rid of the shell-out in
stash.c. What do you think?

>
> Thanks,
> Taylor
