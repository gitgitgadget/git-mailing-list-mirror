Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8251F453
	for <e@80x24.org>; Fri, 19 Oct 2018 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeJSKaZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 06:30:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeJSKaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 06:30:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so7890425wrr.8
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=n7i1gbKsq6MMKaUqUOhcLqOqjhM5tkVESaavhAE0Ylk=;
        b=L6QRtmU0XrwIfOR+eSWAXm/YvxGTM37b1ZRnTjHWRfM4A4umYiu/L+Vj9kCiW7cBmU
         VuTxYxdnDbzNB7Tn6P2TkFdifjRrvbN38Wva755GrPHvogznIEwxWkdOe0us7jrjFYW6
         X52sEsnledjtMIKU5eCHCtQR8K+46JNOhz7XxN5y1lLAasLq+uDCYZ57nIZKObv8XqcO
         niyLrXFXvyhXpn+fnaKet8+dC23Wu6kCpFEKhmqo9hshtbs2kVLbIPAZZO4j90SM90Hs
         Ymlj2imORIUixXewh2c8Yor0rINP3xwl0Z6YPyLReQDy2MizEAMIXTq464sNS78ru5Ox
         A/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=n7i1gbKsq6MMKaUqUOhcLqOqjhM5tkVESaavhAE0Ylk=;
        b=lt3UyOzpTgcNqSr5Xifq0Lgcs79RD2m/NTq/v7QUWXzpjwzDxrNAOvKK0AxXEa/9de
         4iRl4NfbKpqvFQilOt3zmTKNjnbQJrx45f8qBxwnBnQC3GLOTEnMah8+oc5GPLUBOFzR
         MQX4gIQkTwExGeltx+CpcfXTl2hp4M9oRH6L0x4qkK9fcKmBztixVoGdzOT2fTloHZEd
         WePA9ypSAWD4AXNP8Eu82UfRkNdxer0LOKvAu7cxsCb7EpWaknZVoR8TfjZHTCtKy9Xl
         UJ6LsgdJ2FgCejZ8NHgvYo0fJvXLxrgilLOg2rGEBo9Cug6VbR6P6utHM/Zdx648QT65
         IX0w==
X-Gm-Message-State: ABuFfohPl2MSiKKqPpa2GJzyCuQxJiaH/M9vwaxCY420YlqqM2SyhiaE
        Cq5GleOh8iupm7GCh4hfotY=
X-Google-Smtp-Source: ACcGV60QsWOrdtNmW8+PC/2qeEkWp80ylwfYn3W/37obTB3Li00oZxXUSjRbspsU00sMLqfKeWXp/g==
X-Received: by 2002:adf:a387:: with SMTP id l7-v6mr34173605wrb.1.1539915986233;
        Thu, 18 Oct 2018 19:26:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b16-v6sm1483918wrt.43.2018.10.18.19.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 19:26:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] multi-pack-index: avoid dead store for struct progress
References: <20181018185920.22975-1-carenas@gmail.com>
Date:   Fri, 19 Oct 2018 11:26:24 +0900
In-Reply-To: <20181018185920.22975-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 18 Oct 2018 11:59:20 -0700")
Message-ID: <xmqqr2gm3c4v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> it is initialized unconditionally by a call to start_progress
> below.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  midx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index ea2f3ffe2e..4fac0cd08a 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -941,7 +941,7 @@ static void midx_report(const char *fmt, ...)
>  int verify_midx_file(const char *object_dir)
>  {
>  	uint32_t i;
> -	struct progress *progress = NULL;
> +	struct progress *progress;
>  	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
>  	verify_midx_error = 0;

Both changes make sense.  It's kind of surprising that this still
matters, though; I would have expected a compiler would notice.
