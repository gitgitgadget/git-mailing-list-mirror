Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537641F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeBWWRV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:17:21 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:52066 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeBWWRT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:17:19 -0500
Received: by mail-wm0-f52.google.com with SMTP id h21so7259990wmd.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aplvSdVZf4CtvLy7XZQKICjwyicWpDeJFA4hU36nVGw=;
        b=nmY3IQVp5XwpfUjPYFZ8zVFLMYxsITdXGRJYwHAdrdSTILkTjXwWZmENI8/P6ZVwEd
         rmv2mhFz2Od6vdA+tGA6sRgbJZhetIOMSHJoFGJnYN+311MTgY8kQeHdQ5uH8MoiRijZ
         sMtjXTo9sAbc8PIqFvqvZEfEpIkrJOEihadb0aE9v9FIuc+Pu7je0S57kj7bhVJ6eL0r
         Cf4LC3PIXRtBR4mNjkdLIG5RXiza0H4zPGFIKgRipI4bblYxOvbNk+TLpxc8+uMw1AcB
         qbxVR9rwr7JOkF1mnlAQHAgU5BEzRVgiQ9DNqfr/8HeFcswIrsKn/VH5JS10V4obLbbK
         2NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aplvSdVZf4CtvLy7XZQKICjwyicWpDeJFA4hU36nVGw=;
        b=bSh69M5DCH1r6gvMMySAdWyc1uS6Gh0OH1r4DrPCGFCLVMJ/5SPbVLXnu9vG8MzIr3
         rCKHpEiOPTgBjtEXtmOBGZK32xhiZ+EDkKmN3qLM/H0kL1mXJIMAuAUBfH21YGalpKr5
         t6tgJu7NM27JYvLNFsCxTf9ncTpZpBkiutFVKMdBkILczn3YEDGXZ5yXDKkdRaVnMySd
         wTFvKELTyQHM/H7QauErMK5VH1cVJSpqz9fw/nL39IJ/9qvFqpa9/kOSS35ulaIJgURs
         fG9AtsexC3yicJxhuO95fpI8Te0FNaLoS5Ey8unrDHQU09MBIu0IDxHLqYKowVk2zlzv
         F8zQ==
X-Gm-Message-State: APf1xPAkOwcAeYlNMxGXMR8kS7IHv4fYSVHs2rKA5X3IgywXwvU5gP0w
        TOVf7LD3EeZ2BfCq5uPpGag=
X-Google-Smtp-Source: AH8x226KMC1lN+4xKzaZE89v9Rwj5GiOcIshZ5NGXSVfvIAbOYSTNgHLoiqvCgMOD11t84aSletd2A==
X-Received: by 10.28.186.66 with SMTP id k63mr2650299wmf.156.1519424238319;
        Fri, 23 Feb 2018 14:17:18 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 74sm3420669wmf.38.2018.02.23.14.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 14:17:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] strbuf_read_file(): preserve errno across close() call
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
        <20180223064952.GB19791@sigill.intra.peff.net>
        <20180223070053.GC19791@sigill.intra.peff.net>
        <f134c6bf-c147-4201-1217-b59bfb9f2288@web.de>
Date:   Fri, 23 Feb 2018 14:17:17 -0800
In-Reply-To: <f134c6bf-c147-4201-1217-b59bfb9f2288@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 23 Feb 2018 22:00:24 +0100")
Message-ID: <xmqqk1v3s64y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> +#define IGNORE_ERROR(expr) do { int e_ = errno; expr; errno = e_; } while (0)

The macro certainly is a cute idea, but ...

> @@ -391,7 +393,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>  
>  		if (got < 0) {
>  			if (oldalloc == 0)
> -				strbuf_release(sb);
> +				IGNORE_ERROR(strbuf_release(sb));
>  			else
>  				strbuf_setlen(sb, oldlen);
>  			return -1;

... ideally, I would imagine that we wish we could write this hunk
to something that expands to:

		if (got < 0) {
			do {
                                int e_ = errno;
                                if (oldalloc == 0)
                                        strbuf_release(sb);
                                else
                                        strbuf_setlen(sb, oldlen);
                                errno = e_;
			} while (0);
			return -1;

no?  That is (1) we do not want to rely too much on knowing that
strbuf_setlen() is very thin and does not touch errno, and hence (2)
we want to mark not just a single expr but a block as "we know we
got an error and errno from that error is more precious than what we
do in this block to clean thihngs up".

Of course, a pair of macros

	#define IGNORE_ERROR_BEGIN do { int e_ = errno
	#define IGNORE_ERROR_END errno = e_; } while (0)

is probably the only way to do so in C, and that is already too ugly
to live, so we cannot achieve the ideal.

So I dunno..

> @@ -617,9 +619,11 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
>  	if (fd < 0)
>  		return -1;
>  	len = strbuf_read(sb, fd, hint);
> -	close(fd);
> -	if (len < 0)
> +	if (len < 0) {
> +		IGNORE_ERROR(close(fd));
>  		return -1;
> +	}
> +	close(fd);
>  
>  	return len;
>  }
