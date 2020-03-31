Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A2C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DDC20838
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 21:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qi4h1sPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbgCaVsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:48:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39212 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgCaVsy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 17:48:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id k18so3894245pll.6
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b8o1LTwRsCpP3PZ0MnzB4VvOQdPvtE9cPvd5pIPm8Os=;
        b=qi4h1sPEl5gxzH5mvFpCOED4HKJBI6Wyp+Z3x366gaUI16td+RbxA8TvqqAg2wEB3S
         yYd6XNWN17nCKHJJjswVkIt7dTnp0Zh7ujG9ZblsOsxRwwiv51nd/SyXSXsIGolb1xSG
         WuDWW3EkYKlXvXISfshQzO8/SkPEuqtuvkHZZtzYm3UGKRK70RLewpmIgCSFqOtvSle2
         zFmKrJh6Z2E9tPohHduLEui8q1nMLoXbCbSvr7Miar83qUUpTlA3qXmGA35DqZnYqfMY
         HJVGg+k742DrTC/Dl1Z9ELAGlnNIbvgchNsVqaAXEa5i9BI0uQvWBj47j0AHOI1A9e0H
         dL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b8o1LTwRsCpP3PZ0MnzB4VvOQdPvtE9cPvd5pIPm8Os=;
        b=iLfBiE/pB8HKR6se6NlLuUD50X+0U/oZ9Tgpx3uz3C7J1c/psWrw5MwFuL3q0oBmIf
         JMZy5fdQj042RFdIJrW/RHs/kBilPNSd6m39bgS01zAcG10XFpHIj4mWxy5D9nrz2hce
         C3KoO6c/IdHIYckXNhDv+Zgrrw26panqznE4lcATScjusxyIBbmakiS5WwifMMSQBCVh
         NAlxq7qUsZudy0ZEQupfxWub3rNrzGm+0jgPgeYQKWd8vaT+K45n3nvTafoVZmBT18gM
         2qC2rvJT0NaM3k93lSnuInDn7E4sQxl5ySNOw1bXZw7/sIIemXqNj8nQRVdvxBiGopq2
         Umog==
X-Gm-Message-State: AGi0PubW1SYUhYZ6CcHc76oaFwjlilXs6d/c0TeQ4Xz5aHA3yzsbBS5+
        wAAZaKt1PUMmjardlInOzJI6DQ==
X-Google-Smtp-Source: APiQypL3xMoq2iuePXwCKalRctehCQlhva1ApnFm6IfgzTM+3AuBIvjPi1VTCHPN7pKsyfO6flV4Kw==
X-Received: by 2002:a17:90a:e649:: with SMTP id ep9mr979350pjb.161.1585691332897;
        Tue, 31 Mar 2020 14:48:52 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i7sm5853pgk.15.2020.03.31.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:48:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:48:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, =?utf-8?B?5aSp5Yeg?= <muzimuzhi@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Dongcan Jiang <dongcan.jiang@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1] pull: remove --update-head-ok from documentation
Message-ID: <20200331214851.GB95875@syl.local>
References: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
 <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
 <c94f8c43-625c-8e99-fa04-aafb0c7cdd78@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c94f8c43-625c-8e99-fa04-aafb0c7cdd78@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

This patch (and the other one attached to this thread) both look good.
However, the numbering on this patch is a little weird, (2/1? 3/1?). Is
there a third patch missing, and/or are your subject lines mangled?

Please share if there is more, or if I should be interpreting this
series differently. Otherwise this patch makes sense.

On Sat, Mar 28, 2020 at 03:48:33PM +0100, René Scharfe wrote:
> 'git pull' implicitly passes --update-head-ok to 'git fetch', but
> doesn't itself accept that option from users.  That makes sense, as it
> wouldn't work without the possibility to update HEAD.  Remove the option
> from the command's documentation to match its actual behavior.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  Documentation/fetch-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 00d03ec8c3..05709f67a1 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -204,7 +204,6 @@ ifndef::git-pull[]
>  	recursion (such as settings in linkgit:gitmodules[5] and
>  	linkgit:git-config[1]) override this option, as does
>  	specifying --[no-]recurse-submodules directly.
> -endif::git-pull[]
>
>  -u::
>  --update-head-ok::
> @@ -214,6 +213,7 @@ endif::git-pull[]
>  	to communicate with 'git fetch', and unless you are
>  	implementing your own Porcelain you are not supposed to
>  	use it.
> +endif::git-pull[]
>
>  --upload-pack <upload-pack>::
>  	When given, and the repository to fetch from is handled
> --
> 2.26.0

Thanks,
Taylor
