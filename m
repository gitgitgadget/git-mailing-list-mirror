Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A892C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AD720724
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgLWXzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgLWXzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:55:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82710C061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:55:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 11so332650pfu.4
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bFXlx1RiUHhweI15PdyL1ieAAneShrtWIC2xZMp2w+Q=;
        b=W00QLaklWg/YWlGjb2xe5OHnTMqNpFUmwVxOjw3ycU6Q+whr+hhGdiGxOZ7HIn/Lnf
         wTjeZt7azXvZ3qb42RFHO06K6YrhcUQqidl6nHr3rL88D0cf1EWEdX0w5sMzRAkPeUS0
         gEkGduTU2lHeWUY4d7ZDhDuD1ZLZ0WxBkSvrwSm0YJyAYyiP6T7+UOtreDRaLnv2Jtrc
         QCDrQiPRXZ+fg3KjDOE0CnI2jvzzEc9oy+Znn+SnqkBIWFkMq1NAYHwJHmD+dN+FLFou
         VsR3IYw85paIzXw/9SchVj4A4nODV8VSmrFKZxSKpJdvI9/pjkcJn6Mv5apVTjD2pmU2
         SNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bFXlx1RiUHhweI15PdyL1ieAAneShrtWIC2xZMp2w+Q=;
        b=pVLK4lG4c67pRTCkpKbDgOWMNPPHnbKMkseFEh3CWUq7+b7zbE0Exyt7DW6N+sfUe7
         EfHg8nCWdC6VfmVAZ+7TA3elWogIQGmKNjBNK4JvVsyhYzb4t9ZqnY9hZEpCV9SQHP2q
         aDf/7YvMTNcN4tG1EFyRJ5fIMQaO4REs0SMaC6DRcvvwG1ev9rQv6rlnedgOboPmwT37
         a6x9XPtKbA8qWXVvH/9Fe6HgIJvGo6yOtP16twcEUWMV+N7qKYNR9fh3FuHh5b+E+PEa
         gw+e/MhzBwDvmlaJWos424/AzAb8JWBYiOHUmjYYON9gISv2o1EDyKW4C1VbVYTzjL0N
         1lPw==
X-Gm-Message-State: AOAM531mPNMoQ9+xhNvJZrsWWmunPdNgmS6eZge6Jzibk41/eWT0zNNt
        3nbJl1ONrxCe0YjZkQbbENY=
X-Google-Smtp-Source: ABdhPJyikwk/r4eYx2maTUHN6YN0wghVnPGtLt9Jx+IIUJLFco1l9kbyFhEt0olh0vHIMl9Barp03A==
X-Received: by 2002:a63:2b42:: with SMTP id r63mr26026547pgr.316.1608767701947;
        Wed, 23 Dec 2020 15:55:01 -0800 (PST)
Received: from localhost ([2402:800:63a8:c764:b10d:95e8:e1a5:df80])
        by smtp.gmail.com with ESMTPSA id q15sm13078092pgk.11.2020.12.23.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 15:55:01 -0800 (PST)
Date:   Thu, 24 Dec 2020 06:54:59 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4lyaWNv?= Rolim <erico.erc@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] In git-log, --name-status flag overrides the --patch flag
Message-ID: <X+PY0/yTwrXjVRvb@danh.dev>
References: <CAFDeuWOit1vKUT38Uvbj2wAsb5CBo59p2h=SE6FGNb6XGOGG-w@mail.gmail.com>
 <X+CgJCj7/tadldUg@danh.dev>
 <xmqq5z4vm0vt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5z4vm0vt.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-12-21 11:09:58-0800, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > On 2020-12-20 01:23:05-0300, Érico Rolim <erico.erc@gmail.com> wrote:
> >> Hi!
> >> 
> >> When using the command
> >> 
> >>   git log --patch --name-status
> >> 
> >> It seems the name-status flag somehow overrides the patch flag, by which I mean
> >> that I get the same output as simply running
> >> 
> >>   git log --name-status
> >> 
> >> It would be nice for the combination of these two flags to work, as it would
> >> allow one to view both a summary of changed files as well as the changes
> >> themselves, at the same time.
> >
> > I'm not arguing if this your expectation is make sense or not,
> > however, the Documentation says something about "Show only"...
> 
> Perhaps the documentation would need to be clarified?

Honestly, I think documentation is fine, "Show only"... should mean
only.

>
> I suspect
> this is not very useful combination [*1*] and if this were years
> ago, I would suggest making the command line error out, instead of
> silently ignore one and keep the other one in effect.

Although, I don't have strong opinion on this combination,
I would say yes, and we should error out for other combination like
--name-status --patch too. And Érico, in a reply to me, said he would
prefer seeing an error instead of silencely discard one option.
I'll look into the implementation in this weekend.

> 
> 
> [Footnote]
> 
> *1* "--patch --stat --summmary" was designed as the standard "both a
>     summary as well as the changes".

-- 
Danh
