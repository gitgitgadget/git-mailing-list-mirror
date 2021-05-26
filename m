Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA0C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A39F61157
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhEZXvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhEZXvn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:51:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41862C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:50:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v22so3317650oic.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+GYZ+gW+dNY512LfeY0e+TU/4l9MG2GFl+rFliIjnk=;
        b=p5WWXnCFf+UJScOW5I7u2Spu5dOQR4fmHARViGL8qbEkxdNQZhpI/Y+m610fiJXbEz
         lO8oDeH4v51g4wWeszKBYpd6CMldxFa3M/ebhq9EmcCtTaUtuSvId6OL0kKQlizvkrxH
         8W+qUAcbP8cJS0ktK8G/w4Tg5SMxX8iLX2pLOG7QrO/QhadsKGt53Vn89hg/d8tddUE6
         chwbknm4jlnf5Ye3d5VAct0Fgq8+pIgSRPCGHH7i2RNODDNARw/yGPQyHfmkY8qJy5nR
         Ow15W2Z9b27Qzwo62DSV5u8BGTj5BNpLCz1X/PooNiOho6OYyPfB76TRKvL/0CyxmvAI
         LTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+GYZ+gW+dNY512LfeY0e+TU/4l9MG2GFl+rFliIjnk=;
        b=G5e1eSiy2UXb+HPZXDu+C6ETFNZqTtxVWiBuwgCG3d3po6NbLDAn3c/6Qhvco3SKLI
         tEBG0NKCA8m6FiSjlIpTFbriuWGZPcskLUaQ3bs1huzlcPPT2XOblz3Naz2lambPeakG
         VleuN8rV3jqntgOEy7Uo/c88IsKzx6lvVDkAlUMSp3p/Ae/nqkXj3ZigYLizo2uNYDYk
         o/Z/7k74W0hB2ISfs60Y50kpDX9dBK55Uj7HNiCvJQAIp8IYa4YAvAiGAsAmgqwuqfuJ
         fJ765lgr+d4iuaybqzZpUvyvW133uZrW1uuTphTUM2vZPh2RPkeSi7xOxMc0ymdCerBT
         n2Bg==
X-Gm-Message-State: AOAM531pp/CBaXJqvlZcB1jOVKDUwIrHV3J0VZ+4agHr+tGSxUe3s4ko
        LvNbE4TnkwjQtlNLldBVjnUxF35ExIEy2JlQSH2ioGzr98s=
X-Google-Smtp-Source: ABdhPJylOL/cr4qhFkg8bl0kscHvvaFLxcc6cv7f5bAUa2sNgfKCkCm7LyG0avcos7fxlGhvAkpD+ShFTS9Zw0bqQps=
X-Received: by 2002:aca:3e06:: with SMTP id l6mr474787oia.147.1622073009530;
 Wed, 26 May 2021 16:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210512040926.GN12700@kitsune.suse.cz> <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz> <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz> <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz> <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz> <CAFLLRpJeU3BFKmsGgFoKQRLCw-uGRRH1Ob7PZBHUEQu_Pqshgw@mail.gmail.com>
 <20210513094818.GH8544@kitsune.suse.cz>
In-Reply-To: <20210513094818.GH8544@kitsune.suse.cz>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Wed, 26 May 2021 18:49:58 -0500
Message-ID: <CAD2i4DDY1z1ZNigRfVog1205hKBk+U5KfinzXCk-2mkaYy4cjQ@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Robert Coup <robert.coup@koordinates.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 04:48, Michal Such=C3=A1nek <msuchanek@suse.de> wrot=
e:
> Yet Felipe insists that 'impact' is somehow generally bad word to use or
> that it should be abolished solely because he finds it bad and nobody
> objected to the alternative wording.
>
> Opinions on use of 'impact' differ both among the participants of this
> discussion and authorities like authors well-known dictionaries.
>
> It looks like this is generally matter of stylistic preferences and
> opinions. That is even if there is some slight stylistic preference for
> not using the word 'impact' it is very hard to prove such and then it is
> very hard to request change based only on writing style preferences.

The argument is not that it is generally a bad word to use, but that
it is generally bad to use words when they don't mean what one thinks
they mean, especially when all evidence says otherwise.

All major dictionaries define "impact" as "a strong effect" or "to
affect strongly". This is not style, but semantics. In the same way
that "per se" being used to mean "necessarily" is not a style issue,
using "impact" to mean "an effect" or "to affect" is not a style
issue.

As has been stated already, the clear and substantial argument for
this change is that it reduces the confusion that arises from
improperly using the word "impact" in the instances without any loss
or compromise in meaning. That is a clear win.
