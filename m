Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46011C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EA5217F4
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6mDnSBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgBEQpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:45:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43995 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBEQpc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 11:45:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so2964419ljm.10
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 08:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r6XzkQKFzEn24D+iVq6s2kKn3nSFqJnRiVzsAXHeCQI=;
        b=S6mDnSBLuYYodyHJAzIjwvh9Kr5OfhxUxrca6NgWjDKmbB9f+sRUUL15AFcw0adRdL
         Yn+fohsRMUwZskCq7rl8ZtEVOQwM3Ixk02otoNREKt6p2QjBs5lc/F+mHM5HR8u1D+RW
         v00aKfrRT/xLZoEqLxrMz7SR8sZ6X9AF1pfSUjwyZGEmxRTn5DpIda+/CN1f44zDWqhY
         sDp00gyREVyPiaRWPP7ICUbNa4ww7udY8jl/IjFEC8mGUx/gbJb3F3mLxU+e7cYzHpzO
         X8OyyNIzxf0c5mYAPwigZgZdts7YEwEet0rNryJZNYIckJ2c8fFuIduTVfmkjv+JRDVk
         I6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r6XzkQKFzEn24D+iVq6s2kKn3nSFqJnRiVzsAXHeCQI=;
        b=JcIgf0r+v+H/RDe9I/uRVE0I/d+QaLFqXH5zJY5fksXshEcSx3bSjm0h3s2rftGHCg
         sOKXTgO12mBIylLY33gl0H5i0mRqLD2pxZh3Qq7c35lVYnvNA9+IbTF2aP8f5JvI/Ufb
         umLrSCJy1gZb1HS8BugPzZ1W3e5UpjhrhR0k3Nmt8fBAn+jkY9k6FvNqxly2EF79Nsho
         PGKP74zig0pYsEsXIhnK2QI9nsX/WxCCqwXadeY9+CLZLnQenqmQp4jTBlRqFK2+HC6w
         1rDVuzVFr0YA4LI5RGUyRXtdAcQX2TJC4+7ZAyj7ZuWOaIcNWV+wsmiiOo6Ji7QPwUyN
         KdBQ==
X-Gm-Message-State: APjAAAUscDVT6CNFMgA7/UvJLadW9YGIcun4NXs/0cMM2IXTRHShxHW9
        gCjF5nKgmeebWjKMVJdUlaU=
X-Google-Smtp-Source: APXvYqxxv3Hz6c6tY+MMxWQlPdid39HLlColjAI175OpVg2SW3KamdIt+wlQGrK19jsIhvyUHdMjSw==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr21334651lji.247.1580921130633;
        Wed, 05 Feb 2020 08:45:30 -0800 (PST)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id n3sm4725lfk.61.2020.02.05.08.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 08:45:29 -0800 (PST)
Subject: Re: [PATCH 01/10] name-rev: rewrite create_or_update_name()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <f8b7102a-ecab-1980-c129-ad00f3467655@gmail.com>
Date:   Wed, 5 Feb 2020 17:45:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

On 2020-02-04 22:14, René Scharfe wrote:
> This code was moved straight out of name_rev(). As such, we inherited
> the "goto" to jump from an if into an else-if. We also inherited the
> fact that "nothing to do -- return NULL" is handled last.
>
> Rewrite the function to first handle the "nothing to do" case. Then we
> can handle the conditional allocation early before going on to populate
> the struct. No need for goto-ing.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> Original submission:
> https://lore.kernel.org/git/20190922081846.14452-1-martin.agren@gmail.com/

Judging by this sign-off, link to Martin's email, and shortlog from the cover letter ...

> Martin Ågren (1):
>   name-rev: rewrite create_or_update_name()

... it seems that "From: Martin Ågren <martin.agren@gmail.com>" is missing.
