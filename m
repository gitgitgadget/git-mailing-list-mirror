Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA5C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8F12076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tiECyaqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHKS0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHKS0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:26:06 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470BBC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:26:06 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so10190544qtp.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PTaI9YEG0Y19W14iG+pIVY0d6oq2tq5cwfVajXanOfM=;
        b=tiECyaqDZ6XQ9INpWS8jIe9C6bhCOxSb0xTY7ZYBnhEUHVatEeKKQ9eMIe2+xOilmj
         2ghKreZ0p3jf4HobDwTcfpSYQyhLtKcVsES+r0b61+ZKjlWjnkofk96eQ2F+cVK3Eirp
         IrEcghgC5R53PIZqNm7ceSCR4WWzMXrOYapAq8kfSb2q8afeZNLHLbnr4PEbNQtMhOkJ
         4LBm6elX2Bm6YcYEzmHhdVdGwXjHUjNN5mIcliIEBcY2S87+Zz+s911eopfqi0JJfzjP
         6k95uNCdCn9wWpAnq+cIoBt7bOF08Fg6oMNkvBRj2EFaiyz/FoL7S7qFWXzjUYIEgro3
         T2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PTaI9YEG0Y19W14iG+pIVY0d6oq2tq5cwfVajXanOfM=;
        b=SWFfUk62Q6L6qzoGhaIb7qiXBmq5B0Q2MaoeWLdwDcX+JRvud7Hb2ieikCm3+Ns42U
         7FbwD7YJMikoKHCr+VHsXzw6XAry7RKt06n9SDPXixSJxAebvtipaUpL/rDvP4nz9UJj
         tZTMIOANWe+QTDS6ZBMdllQEiirJ8KA6NYZMkt1WSjHb66eBA19FSFKeBXd+XLzujs79
         8WyUu6h1mI/EJklGLMesiVcVE6RRBlghJA83pzyxXG8oa1wD12YJQFAdSHrZhnZO33Js
         XNmW7C/QEvcxWAslSAwe9PXigCLO/B+fHf+XKPhd1bz5nYgbtdSF5k0RTWXwiCBbNZjA
         vokw==
X-Gm-Message-State: AOAM533t7Eyxz2XG6F7BCbN7WwJPlj/Wku5nlra5kZZV+l+7yeK9HwqY
        LTRJTGiQE1pvZY1JkrRHTmzM/Q==
X-Google-Smtp-Source: ABdhPJzi4XMr44tzDJ0WlOPQZ+nOvuwjfe3tKYTm1hrfsJ5+nJr41vtTOnxJeiRJKxxKczU4D98qpw==
X-Received: by 2002:ac8:490d:: with SMTP id e13mr2419201qtq.198.1597170365470;
        Tue, 11 Aug 2020 11:26:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id 22sm16694195qkg.24.2020.08.11.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:26:04 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:26:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: remove superfluous sigchain_pop() call
Message-ID: <20200811182603.GB33504@syl.lan>
References: <29ac165c-8458-9bb1-7e59-e7c2c68a9f2a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29ac165c-8458-9bb1-7e59-e7c2c68a9f2a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 07:15:03PM +0200, René Scharfe wrote:
> 2997178ee6 (upload-pack: split check_unreachable() in two, prep for
> get_reachable_list(), 2016-06-12) moved most code of has_unreachable()
> into the new function do_reachable_revlist().  The latter takes care to
> ignore SIGPIPE during its operations, and restores the original signal
> handler before returning.
>
> However, a sigchain_pop(SIGPIPE) call remained in the error handling
> code of has_unreachable(), which does nothing because the stack is
> empty after do_reachable_revlist() cleaned up after itself.  Remove it.

Thanks for noticing. Your analysis seems correct to me after a quick
inspection of the code, so this has my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  upload-pack.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index d087113d23e..1b068da0d26 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -731,7 +731,6 @@ static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
>  	return 0;
>
>  error:
> -	sigchain_pop(SIGPIPE);
>  	if (cmd.out >= 0)
>  		close(cmd.out);
>  	return 1;
> --
> 2.28.0

Thanks,
Taylor
