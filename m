Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EE6C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 22:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjEGWPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 18:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEGWPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 18:15:36 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA513AD36
        for <git@vger.kernel.org>; Sun,  7 May 2023 15:15:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1928aa70ffbso3282210fac.3
        for <git@vger.kernel.org>; Sun, 07 May 2023 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683497735; x=1686089735;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK7DQuSFLWM3A24KDdnPVl/bPLRqUmMztk765t5QXR4=;
        b=sQcTQdDg41Exk5PcjVPCPN8VUY40SLyLVSHh6Yrjc6hwp/31Rp4/jn464evUD7rASW
         u/1pouSKfY91bAr4QfZ/epbSSseMpvx1VczAMKBgpKSus3tFyrbFRTh9oF2TEH7u2i4i
         7weNYuk3RNjQYtfJG8NuZBkGctGQ7Yduu2cD8fen0PrPTzDZK2fjuVHv1c6cgs0ZlMDV
         lYnKeQtK4RW1+oHoB6ws40vU8tA1jOslakd2FFIGXsz6PcdiyrkP/uS59fKAz6PYO5/1
         D8l32F02hGh2lTzlOGwJnTXGT7bgGNHqL4CXgPVhUikBMVvkhXdSHNFJOHdIaqa2pkJl
         7JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683497735; x=1686089735;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fK7DQuSFLWM3A24KDdnPVl/bPLRqUmMztk765t5QXR4=;
        b=iY0mZVLs2DZUqc9nmLkYZAdd8x5KcTSS/d8Tp2+RVe3j9dVow0aJlhV2H7Gv0ctKGC
         rdtncSko/QVLqEIGvLYg9hz95Ko8Va4jW6RE46v95BayNqkkuPKsGuo6r2Exuq4s7/no
         YGNHzqT4iDLK19ipjAZt82wMaS7EKQsEQ8XId3BBsIQBJCa50w87m+NJigaWxT1KP4J3
         o8v3W0UKAW74OzbeCAMxqf0sRCNcQVqSf7KqnUETs9JV/kYiDQMoSnJg8OtFibQpuITZ
         Ta7yLyjTLAgXXHFEU5iGj8Y/wprM4iSSUIb7NifWWzAUL1h69r+oULDFcUpmAilUYlqP
         91UQ==
X-Gm-Message-State: AC+VfDzScNKheY4Qx61Mpep1xQvJgZSr2o0GLdj/HCU1B6y+ffAA5E4i
        hhFKiEhwE+n1acZqRhlM74c=
X-Google-Smtp-Source: ACHHUZ53HM8pSifcV1OtBRhdfbJieLAZ0mkLb+V9cf55GvmuXvNA2byZE5xqEsSOcKCk84U7iC/VuA==
X-Received: by 2002:a05:6870:b302:b0:18e:2b7e:a849 with SMTP id a2-20020a056870b30200b0018e2b7ea849mr3920617oao.22.1683497735200;
        Sun, 07 May 2023 15:15:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q24-20020a4a3018000000b00524f381f681sm3758814oof.27.2023.05.07.15.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 15:15:34 -0700 (PDT)
Date:   Sun, 07 May 2023 16:15:33 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Adam Johnson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Adam Johnson <me@adamj.eu>
Message-ID: <64582305ee966_4e612948f@chronos.notmuch>
In-Reply-To: <xmqqzg6ibe42.fsf@gitster.g>
References: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com>
 <xmqqzg6ibe42.fsf@gitster.g>
Subject: Re: [PATCH] doc: merge: improve conflict presentation docs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Adam Johnson <me@adamj.eu>
> >
> > Improvements:
> >
> > 1. Remove the sexist example ("Barbie... wants to go shopping")
> 
> "Barbie goes shopping" is a pretty common meme.

And it's not sexist in the least.

Tony Montana likes big guns, and it's not sexist to say that outloud.

Tina can like big guns as well, and Peter can like to go shopping.

The fact that a preference happens to match a stereotype doesn't mean that
saying so constitutes bigotry.

I'm Mexican and I like tacos. There's nothing wrong with somebody saying
"Felipe likes tacos", especially because it's true.

So what if Barbie likes to go shopping? So what if Amanda likes the color pink?

Am I not allowed to like tacos because I'm Mexican?

-- 
Felipe Contreras
