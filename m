Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB6C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiLGGnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiLGGni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:43:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4391A9
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:43:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f9so15437224pgf.7
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 22:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkAY5gwFMxB6F7Xoj1J5lDg6J1jpzo8CC8AKNrAf8Qk=;
        b=Y2tXaaPFuE8+zmuVLG/NOyQwooE1SK5EcUSORClaE+LoixZtQDsiBlES3klEmcwSbP
         nhabeS8iRVmnrO9Yr+4VeNwIrb8STQZtc5hT165yBsGTISk+sWcF34P2kZ4LZs3HR5sx
         jR8SjXG93YRs7xcH1rQBVpVhN7xbIQryvlkDcv/8bzdvxInxZ1tBkrFD86GOe9VhrziK
         xC1x1rXAlUStyYfV1DqiTsfeulCnkQgithiZZdAhfOfoKtKyw74AAgj5rL2AcTytz7d4
         cqvBMJjv4YvW/pV1BM1wmUFT3kIbsTZVLanbTsgCvDnO6Zn3JVNhUkS4H6LvScqPwseC
         /ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkAY5gwFMxB6F7Xoj1J5lDg6J1jpzo8CC8AKNrAf8Qk=;
        b=ADFGIoTziiheL6ZXUHLNjJh+5m4qMW3B5DByNSZs9znexq+m4IX3RJ+wOWJ3BKy99j
         Oozs9qpX0immDMit+9KI0WYpv/o+N0CN9fzNwjZcy+5GEE/TVPl4gAtkte4SRu9RsLgy
         gq/YBE1wyPq5zhmHdfYKJY17o45AFtWcH7ggd5UNvW281HMI348jQMggw0SSKkTlDSgz
         ezeK5bCywkfYNb6qhr6YnyHhh/y4wnCDWOU12RgyuIyUNmfhLOpFhYYDt3jPRgUhUgKz
         L6B3fjZFfcqBM3HzNbAu2CfnZkLg0NPmFlz73raioalABcKmde3VL0ZdpaTL8oIOjK15
         kIUg==
X-Gm-Message-State: ANoB5pn9drEXC+CjkUp9ZEgqpeunf4tUro6fEtbpZzwD4qfRIlu/+Hs8
        irdnVKys6XJfOvHRJUZbM4M6ZE31Gpf0gQ==
X-Google-Smtp-Source: AA0mqf6fuDv1ywr9rzts+oG+CZaR6zWiE43RXA36/bonhKq5ngS9L0BWrtWGzAZruJ6TCtZW+1gvuQ==
X-Received: by 2002:a63:ed0b:0:b0:477:9319:eb4f with SMTP id d11-20020a63ed0b000000b004779319eb4fmr65482500pgi.257.1670395417202;
        Tue, 06 Dec 2022 22:43:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a930e00b00219463262desm438930pjo.39.2022.12.06.22.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:43:36 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] object-file: don't exit early if skipping loose
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1670373420.git.jonathantanmy@google.com>
        <9ad34a1dce977044066de0bfa6e25977215e8dc9.1670373420.git.jonathantanmy@google.com>
        <xmqqy1rk6mqa.fsf@gitster.g>
        <Y5AvPjTjKPxq7vG8@coredump.intra.peff.net>
Date:   Wed, 07 Dec 2022 15:43:36 +0900
In-Reply-To: <Y5AvPjTjKPxq7vG8@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 7 Dec 2022 01:14:22 -0500")
Message-ID: <xmqqy1rj67dz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered who those callers might be, too, because it is such a weird
> thing for a caller to want to care about (usually we try to abstract the
> object database).

Exactly.

> It looks like the only user went away in 97b2fa08b6 (fetch-pack: drop
> custom loose object cache, 2018-11-12).

Nice, very nice.

> So I think we just want to drop it:
>
> diff --git a/object-file.c b/object-file.c
> index 26290554bb..cf724bc19b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1575,9 +1575,6 @@ static int do_oid_object_info_extended(struct repository *r,
>  		if (find_pack_entry(r, real, &e))
>  			break;
>  
> -		if (flags & OBJECT_INFO_IGNORE_LOOSE)
> -			return -1;
> -
>  		/* Most likely it's a loose object. */
>  		if (!loose_object_info(r, real, oi, flags))
>  			return 0;
> diff --git a/object-store.h b/object-store.h
> index 1be57abaf1..371629c1e1 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -434,8 +434,6 @@ struct object_info {
>  #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
>  /* Do not retry packed storage after checking packed and loose storage */
>  #define OBJECT_INFO_QUICK 8
> -/* Do not check loose object */
> -#define OBJECT_INFO_IGNORE_LOOSE 16
>  /*
>   * Do not attempt to fetch the object if missing (even if fetch_is_missing is
>   * nonzero).

This would make Jonathan's change a lot transparent and intuitive if
it is based on it, I would think.

Thanks for digging.
