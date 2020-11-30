Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3CAC63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E7C2063A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 19:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wU54Q4JL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgK3TyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgK3TyG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 14:54:06 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83905C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 11:53:26 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v1so246719pjr.2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z3mmFIKRAgRWjwPjyDEy5Dx6I+aRpBuqVYSfrciTdDY=;
        b=wU54Q4JL0No6ErNgIk1AY91NOvjNZgOxNekrkxgHcQAPWMpg+/FwMXZMW5pTS4v3BI
         mnXmO2zpdZrryYnE7hiYuSrXpT6ekU2ZoBs3zdsr/a6OqpX+alKz4MysUJjPZBn1eV0m
         Z/rgBlNBdFuOGvHEyTGB+DmNt6QWwIexC7dJOYHi42YaKysTR64FbMR4MwGFLzd+vPEJ
         mv6szpPjsxlyC2ELX/Zo2ETjdVf2EFE3z2LXzAWtAjtirtso5GQGmJJR1fW11WQdUGEj
         cvBzq7lcQZmFQQwH7kdjV53fxGBVVhZYrKIZJ5+4mxMYfr4tDOvXj2peSqnFZEkkr8Ct
         GKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z3mmFIKRAgRWjwPjyDEy5Dx6I+aRpBuqVYSfrciTdDY=;
        b=itxnZX3uaD45GebRlC2KESd22BPtiuCBAPGgitTEOEDtAo8nYvL8kgwqMPU67Y56D2
         4vlDbEx6x9l+O2A2beNixTtXKtK5Aeczk0dI7pD/tZZcU2lju7RxzK4ql1lcz8bhYfGF
         hcQWLh5rTUza6+z1FQAdk/3fdJTcEviD3KnamGzl1Wri0FBzXTO0o7hCsuwb4G2cE0+i
         HeT0P9zqWoTa8TagLYpMet3og+kq+rkLDyiN6bl3zhicvWIR8rW2XL6evY8XLJL8XcOD
         u2vja3dgMaQCbIL5eu1oHKQTwe4W54g++Yi+YVEnjBPkSWkdOMOmbeSjsTS1iFBKwQOW
         sQVg==
X-Gm-Message-State: AOAM530gthUh+KJM36wbWTvwxt6Wv3aBrzsdt2oCrUzDTm4lQzZv8X6a
        uikxTtXPWK+PDCa4NMKgCgHPoq67DLztMnLY
X-Google-Smtp-Source: ABdhPJwtOdlUDAWnF4k+ByREq/JWzmQkpBXtWjIfdGJSYpxPrdwc8fNp531nfr+Yu5ZaE7BiBmQ31g==
X-Received: by 2002:a17:902:b70d:b029:da:5196:1181 with SMTP id d13-20020a170902b70db02900da51961181mr15559522pls.81.1606766006080;
        Mon, 30 Nov 2020 11:53:26 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 21sm17680747pfw.105.2020.11.30.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:53:25 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:53:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack: disregard invalid pack lockfiles
Message-ID: <X8VNszeQKJPfZ+Ht@nand.local>
References: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 08:27:15PM +0100, René Scharfe wrote:
> index_pack_lockfile() can return NULL if it doesn't like the contents it
> reads from the file descriptor passed to it.  unlink(2) is declared to
> not accept NULL pointers (at least with glibc).  Undefined Behavior
> Sanitizer together with Address Sanitizer detects a case where a NULL
> lockfile name is passed to unlink(2) by transport_unlock_pack() in t1060
> (make SANITIZE=address,undefined; cd t; ./t1060-object-corruption.sh).

Which test in t1060? I tried to reproduce this myself, but couldn't seem
to coax out a failure. (Initially I thought that my ccache wasn't
letting me recompile with the SANITIZE options, but running 'ccache
clear' and then trying again left the test still passing).

> Reinstate the NULL check to avoid undefined behavior, but put it right
> at the source, so that the number of items in the string_list reflects
> the number of valid lockfiles.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  fetch-pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index b10c432315..4625926cf0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -915,8 +915,9 @@ static int get_pack(struct fetch_pack_args *args,
>  	if (start_command(&cmd))
>  		die(_("fetch-pack: unable to fork off %s"), cmd_name);
>  	if (do_keep && pack_lockfiles) {
> -		string_list_append_nodup(pack_lockfiles,
> -					 index_pack_lockfile(cmd.out));
> +		char *pack_lockfile = index_pack_lockfile(cmd.out);
> +		if (pack_lockfile)
> +			string_list_append_nodup(pack_lockfiles, pack_lockfile);

Makes sense.

Thanks,
Taylor
