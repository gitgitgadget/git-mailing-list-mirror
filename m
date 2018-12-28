Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A391F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbeL1UKg (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:10:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51473 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbeL1UKg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:10:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so19679205wmj.1
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=geNmNPEvh/GtgZvhOrorZ7PCTRacvDWuooA24Q2uf7Y=;
        b=mVux4w9Pesn5YSOiEzXvzSOpvY1J0R1ajROHMnhICmLKNa0uhHo4u1pSCWNTLJ2JI5
         3q0wl1aEeITS6GEzPak5taGYElwvHWYQ+l+pNP8drHiB20+OfLC+Kicl10TnDWTTp7XU
         HN0sK91LqFOpX/nAVo9wOs+V5tuApOeDOFFU6ivwcz4mFW8D5i1Qv2VUDby5llQJaiL4
         Y0BmcMBn/GSd4oDfjz9x7ZSsXqh9CJlx5FDaLLBon2G79F8e5bRWBmYpBwAgOSe1Lcuk
         zti7fvxo690h3LINLpv2bFIGji7BcUjkQ3fPUqph1GgDI+uBwP201Y0vr77rmFkJBbOd
         HENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=geNmNPEvh/GtgZvhOrorZ7PCTRacvDWuooA24Q2uf7Y=;
        b=m8mDzxd+8iCT1wEzD6olT+ruQC2l0C+gg+6y+3M5o/VmuQAobVFzC5bJ7WH6WFgcuG
         3GntjVdLcGocllpFT6zrTjuUdOUZW/2nDsCxuE630t5uJtJOszJNHT64knXcgVWmCljn
         lVkgJ/n3U6wCAqvJX+gCZCvKNOwOOEVsCQw4YU1V1T+Ehl+RikacQgHE2ZAUbgVFSkS+
         7vwvjf3K/736fhWfQuDthQ20uWbwDjsihmFKe8jgjGENTUdz4aUFQ31YVq1KdZpq44z8
         /5pYdpz+UPvyKdpUbhuCBAilA4rV3YLaWT8b0BKpcA7VzLk8iQQs9yZMKMZxdiIZhK0p
         L9Iw==
X-Gm-Message-State: AA+aEWZNrJxBsUK4i7V2TWmkIYESKypMBfWvqx2pBolzbsLNOjxTZ2LG
        Iq2VRN1qieHuT3PRS30WWfg=
X-Google-Smtp-Source: ALg8bN7ueqWv8pEpCoR4FmI4Pa2nLL+r9WJ+qZDVPIItrp2IUJYnAh4CMUSelB7rsdq9TKbbgkx/Zg==
X-Received: by 2002:a1c:af89:: with SMTP id y131mr24234054wme.105.1546027833939;
        Fri, 28 Dec 2018 12:10:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l37sm62177126wre.69.2018.12.28.12.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:10:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 1/4] transport-helper: use xread instead of read
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
        <20181226230523.16572-2-randall.s.becker@rogers.com>
Date:   Fri, 28 Dec 2018 12:10:32 -0800
In-Reply-To: <20181226230523.16572-2-randall.s.becker@rogers.com> (randall
        s. becker's message of "Wed, 26 Dec 2018 18:05:20 -0500")
Message-ID: <xmqqk1jto1jb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This fix was needed on HPE NonStop NSE and NSX where SSIZE_MAX is less than
> BUFFERSIZE resulting in EINVAL. The call to read in transport-helper.c
> was the only place outside of wrapper.c where it is used instead of xread.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  transport-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index bf225c698f..a290695a12 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1225,7 +1225,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
>  		return 0;	/* No space for more. */
>  
>  	transfer_debug("%s is readable", t->src_name);
> -	bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>  	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>  		errno != EINTR) {
>  		error_errno(_("read(%s) failed"), t->src_name);

As Peff pointed out in the earlier round of the same patch,
replacing read() with xread() here will affect what errno's can be
possible after the function returns.  The checks affected by this
change must also be updated, either in the same patch, or a
follow-up patch in the same series.  Otherwise we _will_ forget to
clean them up.



