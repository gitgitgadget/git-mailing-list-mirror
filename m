Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA56C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 05:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E374561042
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 05:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGLFho (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 01:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhGLFho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 01:37:44 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13BCC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 22:34:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so17730043oti.2
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 22:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y0az8bDtQeNQVdAxlbdk6NOJh6bEEga9XjFI/dj9QG0=;
        b=pGa2hO2PHdnAMCI104i89buzPjepqU6rq+o+fQmp9/9T17EYR0qRheSLA1AHhTlXFV
         1L3p2MY3EaM2RSrs6AC9NSBRsca05/FyeVoLcVmB3GsQh49FcgceYfFG6WgmrSCjAPQp
         p+Ua5+cK0RiIquMGf/wumXGO2fTRvz8M8FglgjnbiDVTnVbw81eiT1gGCqZ+f6aUh4Z9
         Gu93+SybuF/XDHdBl1yFQGZ7IIdK4c+aeyyrTfFjCUDJ1x7pdwn8pNtca1fIJOIVn89T
         TXgZJOmL8CEiC75Hlr4+BLVOu5v60r67gdCjP3iuE0DjZ+Dz4Vn3mP/qYTe53eMIaGok
         wWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y0az8bDtQeNQVdAxlbdk6NOJh6bEEga9XjFI/dj9QG0=;
        b=aaM5W5oNw56EEzdS2EZGdkMQYPkBuOHBPcxJhwO48qIryeX1Fy4brmloX1+5cTSjj3
         AsnAqEJ7YuoC3qMXL4d4F9Fj7py4fL7ofvoYflL9gkXonO26JFVKbzQXXbyE4EWjl5xC
         JFJquEP+jkec7dJDAIk+WyldIv/d2y3Q2tjuymkJKX+c+618h++4LLD0Rxo9hcOuc5Lg
         I1wXpaEknkYPcmFUStgckOoqJHGwXY0oYPkqwJqLLhRC3rt7CaTraSYbPC6kubuht04M
         9DnuVBLSmlPddAiSZIkEXQ+BlgaLo8mUdwmqU0OSHSoB+ocFXXj3pR3Ukt9bHDG3TTwx
         Be6Q==
X-Gm-Message-State: AOAM5306kAKj5uUYthVl+bj5VcotXBAGstl2Y2VJ9DTNTvHniEqWvk8U
        Mqz4UEmj16XZvxvLW/xvWQs=
X-Google-Smtp-Source: ABdhPJwSXedxFxQM0T+tUkXlK9Fmru7zFhrIsOXHa71h4JHhS4iVlJ+RPLYURNg/u7vE4Zd8k71x2A==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr39763351oti.307.1626068095110;
        Sun, 11 Jul 2021 22:34:55 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id u23sm2921890ote.4.2021.07.11.22.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 22:34:54 -0700 (PDT)
Date:   Mon, 12 Jul 2021 00:34:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60ebd47d9dc2f_a407e208f1@natae.notmuch>
In-Reply-To: <ef5ca2bf-3a7a-aa9e-40a2-6b1fe04e323e@gmail.com>
References: <20210711170703.651081-1-felipe.contreras@gmail.com>
 <ef5ca2bf-3a7a-aa9e-40a2-6b1fe04e323e@gmail.com>
Subject: Re: [PATCH] test: pull: add test for disabling pull.ff=only
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 12/07/21 00.07, Felipe Contreras wrote:
> > The advice clearly says it should be possible to override pull.ff=only
> > with --rebase:
> > 
> >    You can also pass --rebase, --no-rebase, or --ff-only on the command
> >    line to override the configured default per invocation.
> > 
> > Since the intended behavior of `git pull` is very easily forgotten let's
> > add a test to make sure it isn't.
> > 
> 
> Is pull.ff=only only do fast-forward merge when pulling?

Only when the pull is a merge pull (although there are proposals to
change that).

> > +test_expect_success 'pull allows non-fast-forward with "only" in pull.ff if --rebase' '
> > +	git reset --hard c1 &&
> > +	test_config pull.ff only &&
> > +	git pull --rebase . c3
> > +'
> > +
> 
> Better say 'pull allows non-fast-forward (using --rebase) regardless of 
> pull.ff=only config'

In English parentheses are used for stuff that isn't essential (i.e.
optional).

If you remove what is inside the parenthesis the title loses the most
important part, so I don't think that's an improvement.

Cheers.

-- 
Felipe Contreras
