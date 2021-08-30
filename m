Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52105C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9460F5B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhH3U7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhH3U7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:59:00 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757CBC06175F
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:58:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q3so21803996iot.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PjlTUdThyyLN8JV45G5SFX4e1+t0XDwdNPYn5KYOqqA=;
        b=JeUdZiqVtL5XenviPGZuXpAlp5w4V/R4GS72LzBFCMdc28PRZ2JPviOPAcBBqNZJwc
         ZmWbWll58NbHHPDezuEPaPZVmoJuG2bUInf5/kxIjb0BqiZppbsNiSDslri57Ro9Xb5p
         p7yuvX5uALtL8DOzI5oWJW7YRXSWI6tHLTYgPclP/qej6EEvZhBfgt6CY7viC9uc3iRw
         i/uBgzFucQnNbRmTDGWMPJZ7lMKzk2q6UIH7geKdo4kgqUbQ4yGWTa9oUGEkzj4WB5OM
         JpbEIB0MhYVGr9fLYC+6ynKr0t1/6A5R+8C8wFNNKUXDqXjdmykY3qUzjn/OOt/8h5Mz
         srow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PjlTUdThyyLN8JV45G5SFX4e1+t0XDwdNPYn5KYOqqA=;
        b=Huko+C2uuspso6gkp8bBDAtK0IUz4PVgqC03rEk6RaThMOuVz5KXmqcF7ylh5qRDct
         tmP61eJVYfEuLaBsxbmlH30vvmkMihfx6mJs77xh7PDjd2xw+LmK6RYeWKIS9B6qLecI
         0FsOzhGDYq5S9CxncO5+YAjoPSFGwXsVnKDpAhgwAx7bgXHpwHilu7XASc7sQvzmkCE2
         wLJ7JwhPCjXkeDZ3YC99vLs7HHSAg77IpB0CmIsjCOvXsycOZOFfBNy7n1dVU4ZWVXhJ
         /dS+quoQvRYbT+cDGbLM9InGxVdbo78Rc8kF1Ji24IW4xCPbhvv632VWU8vhACcug+Xr
         w3lg==
X-Gm-Message-State: AOAM531DQFJnqqeUDQiHMtZ891Uapt/i8HwZxDsqustW/9Jrn3D8C6wd
        jPrSN37/cVb3R/bimS/ZcrA0fQ==
X-Google-Smtp-Source: ABdhPJxGf0nIRy5ORYBj5SnX7Fdqxz6lME2iMKn/FKxyOs+7ikHrSN76yeDgylayca28HxoyrjA4Jw==
X-Received: by 2002:a6b:e318:: with SMTP id u24mr19589051ioc.137.1630357085952;
        Mon, 30 Aug 2021 13:58:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14sm9456896iod.18.2021.08.30.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:58:05 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:58:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/4] test-ref-store: tweaks to for-each-reflog-ent format
Message-ID: <YS1GXNoPgjIjO3B7@nand.local>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
 <xmqqpmtu3bbn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmtu3bbn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 01:51:56PM -0700, Junio C Hamano wrote:
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Follow the reflog format more closely, so it can be used for comparing
> > reflogs in tests without using inspecting files under .git/logs/
>
> I find the above written in clear language that conveys what it
> wants to say unclearly X-<.

I agree; there is unfortunately more than meets the eye for this patch,
so untangling it all took me a little while.

> [...]
> Is that what is going on?  Or is it "even within a single backend,
> sometimes we get message with terminating LF and sometimes without"?

Is exactly what I was wondering about in [1]. And...

> Shouldn't we be instead making sure that the callback functions get
> the msg argument in a consistent way, whether it is with or without
> terminating LF, instead of forcing the callers to cope with the
> differences like this each_reflog() function does in this patch?

...that is a much more sensible resolution than what I saw in this
patch. (At the very least, strchr is confusing since we don't expect LF
characters anywhere in the reflog message, and this is really dealing
with how the callback is invoked, not the actual bytes-on-disk).

I would probably prefer that the callback be standardized to either
always or never give a trailing LF.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YS0+MHk3svGr7d4n@nand.local/
