Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6D8C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E91D613F8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFJNxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:53:32 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46795 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhFJNx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:53:27 -0400
Received: by mail-oi1-f174.google.com with SMTP id c13so2149890oib.13
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LMTUfQKbGfK8YzhD/0x5gndMssS4cjg++KFbf33NyoQ=;
        b=KsdVZlHKDv0tpttAZg4WpqmSWJQmNSku4hZYI0LwUxzE3lI/Sux+wzyGnAiAAaM4Go
         B9ezsm0+A7yNi5dsVWr/IIhQFzS1asElgRRAGlQgOAlXPkFqo3GakIXb/r33SKMx82t3
         ZvihIhDPry3NOPzIayf8JYHDqY/qKqfHJX/AfQtssJgxZxPPRS2EkeddRBg78L2sEfUh
         42bKxMjx/wt0P2cnHt2mDEyGi4MXoP6lBcvbJfEGSW2WEbcsOQKp4hwyfWlOvPURRTdI
         Nja6M2cGNhESiihue2kwzu3IpXZWaG8PLkqLo3v5xA0+9rEQ6xYsQKb8m8AppUYm7w7k
         bIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LMTUfQKbGfK8YzhD/0x5gndMssS4cjg++KFbf33NyoQ=;
        b=rpee9FYekDNw1r4zvNBtUyE6Wyu6M5q71oVZCEAUIaPyjhzXBrB8V/gjiRrp+i27Au
         jxSrzvxOE0X0so8XWjyLQK3VFUP1a9Moz6d+hRhj16WlHDOp3KzXPwrb5BPsIYarJzmK
         8PQB9U13fCBcDP4ZDHidfJ3pLpvKMZ0mw3jjbFGwSZ+py5WWPP/2dnws9j14NFDTvpSm
         Cn+PqH+1H9ST9cxo4ydPBMUP3mR2o2p0gPPtx5PChSw7ZZuEDr0aEADIFEfJmezgn0jW
         ZH0F8KB4z2FJBVxURz9TpelnblBVLJuSPsGGhBtU6QZoUj/z/vfL9FC7xgLfO577irn6
         oAgQ==
X-Gm-Message-State: AOAM532GouO6DjcVMKIh5jeUTTo7ZZyjQOil1DwvS7xyECiE/1JtwgUX
        9bnaI1pXHhIytylsES3DC5E=
X-Google-Smtp-Source: ABdhPJzcpy6FxBrf1LUvu1RUWEGjuRsqRTz1tYTSu7YNY/VE/zCkLVdw3QLMzhjxRpfP2HmFs1nL1w==
X-Received: by 2002:a05:6808:1511:: with SMTP id u17mr1665387oiw.53.1623333030595;
        Thu, 10 Jun 2021 06:50:30 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 62sm546791oof.11.2021.06.10.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 06:50:30 -0700 (PDT)
Date:   Thu, 10 Jun 2021 08:50:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c218a4e47e9_b25b1208ef@natae.notmuch>
In-Reply-To: <cc8bbc34-1048-0e7b-c783-33f556843a3f@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-7-felipe.contreras@gmail.com>
 <cc8bbc34-1048-0e7b-c783-33f556843a3f@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: simplify style assignments
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 09/06/2021 20:28, Felipe Contreras wrote:
> 
> I don't find the commit message explains this change very well
> 
> > There is little value in checking that git_xmerge_style isn't 0 before
> > changing it's default value.
> 
> I think the check is actually that git_xmerge_style isn't -1.

Actually I meant "< 0", but yeah, that's mainly to check the -1 case.

> Why is there little value in the check?

It's explained in the very next sentence.

> > Most of the time it isn't 0 anyway, so just assign the value directly.
> 
> Why to the times when it is zero (or -1) not matter?

When it's 0 it's a no-op, and now it can't be -1.

By default structures are zeroed in git, so the defaults of integers
are 0, and in the case of xmparam_t.style that is no exception.

These are all the same:

	static xmparam_t xmp;

	static xmparam_t xmp;
	xmp.style = 0;

	static xmparam_t xmp;
	if (1)
		xmp.style = 0;

But of course as it's explained most of the time that's not what
happens, what happens is:

  if (1)
    xml.style = 1;

Perhaps this is clearer:

  There is little value in checking that git_xmerge_style isn't < 0
  before changing its value to xmp.style. If it's 0 then assigning 0 to
  xmp.style is a no-op, and if it's 1 (as it usually is), we are going
  to assign the value anyway.

  The only exception is when git_xmerge_style is -1, but there is no
  value in having that as default, so we just don't, and set the default
  to 0.

Cheers.

-- 
Felipe Contreras
