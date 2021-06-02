Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18941C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 22:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77F1613BF
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhFBWfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBWfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 18:35:54 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05214C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 15:33:56 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so854783ott.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3LlX7QhIDekGvf/JowOELcFUNFlTktvpUAXCL8UarZo=;
        b=s6Shm+97irImyKmrBjzM172HqC29PoH6x4cAqhg57kHPI1Q47MjnNPFahYhye9K81c
         z80PNYzHNsj+XSgY11eXPphb7xWK/DOXh8zdAkBXK4+EaSiPckUi5a375zla7ynOwNUL
         RKJzKTW9Mjozg23u+YbjTTtKTUBWe4Ia6cl2u06TfY0H2DiEAcTNYjWdonWZ5UV4rQYZ
         p2rnkT+KXGt7P61a0UDq6b9zPe3nIhm6sPKGAqRXcCaLrTwlVa0t1aR0jCar+iX1aEjh
         15eUMNg2jFHbhwdxvgGmNIGlAoZA9NJZFenYP2EsPLPt97/QGpGHvgSw8QqPJEAXCTeH
         i5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3LlX7QhIDekGvf/JowOELcFUNFlTktvpUAXCL8UarZo=;
        b=DFoq4DECDUDIeTMOwR0noaOGGH9sDlLbssSKJsaXrzy21uTJ5RSD3SCQ2737FW0uUg
         0GXV9EbXy+pGNsowoDvn8ByxOwfUo/BvX0ZM+pGsAwEWhEu6/3TKUyYvl7Z/YPYuJMte
         8C1Gmc0FvuWZ8mFZiMSfzl38mKXa7oDeETY6DOViJ7rGQP6ydrGWuylfX7hloFNCL183
         zVhKNt27qX+SFvXv6bHVnBW7/7Nt0AgS8aUOHhVP3dG36Kp4D8Mcu8XpKGMhHQCaHjgm
         Wj4J/UfKHIKhKU1s+2HB+TWeoNfQNFWgL0lrPjUeTAdrdqaGndRPqJYNkQoEc7FyO6FG
         Pr1g==
X-Gm-Message-State: AOAM5313Pzw+HBHl8sWgeX3Gywv+lRrHuOh/8ls0MpFLNhcwspwk/i+U
        JfvL/uOac8AjhdRPOfMeRRk=
X-Google-Smtp-Source: ABdhPJxqV0RuPm3uwp0TUF+SO5zJdaGnFGI+PjSkU9qiPlXbm4WlnYYoMRmzRnzcveV9fCjStJt5mQ==
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr27365316otn.97.1622673236306;
        Wed, 02 Jun 2021 15:33:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y14sm267290otq.4.2021.06.02.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 15:33:55 -0700 (PDT)
Date:   Wed, 02 Jun 2021 17:33:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b80752a4c08_16dbed20839@natae.notmuch>
In-Reply-To: <8735tzncr0.fsf@osv.gnss.ru>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87wnrd6wqj.fsf@osv.gnss.ru>
 <60b6c08f75c1c_40442086d@natae.notmuch>
 <87eedktq4x.fsf@osv.gnss.ru>
 <60b7f7e03fc64_16925f208d4@natae.notmuch>
 <8735tzncr0.fsf@osv.gnss.ru>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> > Sergey Organov wrote:

> >> >> [pull]
> >> >> 	rebase = merges
> >> >
> >> > Can you do `git pull --rebase=merges` for a while?
> >> 
> >> I never use 'git pull' for merging, and all the time with rebasing, so
> >> what's the point? I mean, whenever I do 'git pull' I mean 'git pull
> >> --rebase', and whenever I need to merge, I exclusively use'git merge'.
> >
> > So you can remove that configuration.
> 
> Sorry, I can't, see below.
> 
> > And afterwareds set pull.rebase=true so you don't need to specify
> > --rebase.
> 
> I don't get it. What's the point using pull.rebase=true instead of
> pull.rebase=merges? The former is plain total disaster in my opinion as
> it silently breaks history shape.

I think there's some confusion here.

You said you always did `git pull --rebase`, not
`git pull --rebase=merges`.

The equivalent configurations are:

  git pull --rebase		=> pull.rebase=true
  git pull --rebase=merges	=> pull.rebase=merges

If you can't live without the functionality `pull.rebase=merges` gives
you, that means you have to type `git pull --rebase=merges` if you don't
have such configuration.

Cheers.

-- 
Felipe Contreras
