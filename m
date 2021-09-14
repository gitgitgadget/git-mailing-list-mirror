Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38AC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6567C6113E
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhINRAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhINRAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:00:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE292C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 09:59:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n24so18014385ion.10
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i7HNuf9jApLIpdWzqmUoygabhNjQrqEezTbh451XiGw=;
        b=l3vQE/5ctjksrbFy0YkkHv3+EhtRQAsKJPBui2Y1WOKiFHRo0JJMAAhaVp+v8Q/M+X
         dm/wUTUpUdnXpx95TUEuH40/NjHbk5otp8XsTr8w24vON6h0sJ9ZpIJ6xvxvQwkSHBl8
         dFcd8SdARJcnyLiSGwMSXPLi1uYmOlO1ojnISEp9RSiaA8EL6SZBNG6jSIIyJxpjGmjY
         YujeuBenOy87Bg6XPUSku8MVvfsfguUpahO3beFN8OlLbqNqq5WFPBLnO+57KQods4bU
         iynX0keSFsOsB/hfCVzxUo3t94eKFSLjC7kG1snU1Mm5sif21aezyowxob5hJN4vE+Ui
         DYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i7HNuf9jApLIpdWzqmUoygabhNjQrqEezTbh451XiGw=;
        b=0RTPK+CwKT/4a+iNIV6VyJS6pcrBjaE00+kXFqn0dbe1XPsPMKV7bFNg1pruSIVuPL
         C2qtZyKIj/zEyWbW6BfoM7Qs11Pl1fyIAVjds4wRPERfRHPd3fCLmCovVnJLYyV+lMYO
         FTG5nFvWgsanpbtWxtTng32mllvoh6PUieuB5hElfi+d+quDJ05GbLU04EceaxAn53JC
         x5O/U9Q+7WuGd7V1Kr9oZ/b1yWVW8ocNA2sEukg05x0tvLNYbb6mG2/6MgNz1u5j+nfL
         zPITZnVHmoArIJh1Sp3ETttiiisHBjD0J8bGxCtq6SvoKSD8hl1TKKSIuqdKnhlkp59x
         dD0A==
X-Gm-Message-State: AOAM5323pSe0/zNsTmf1Q/tDlJpnWgbMAT1bAhW8gq4KVcnkCm/bgmF0
        M5KMrVBOTSTK5eykRgnoGjivekdMb9T/hsq0
X-Google-Smtp-Source: ABdhPJyHQpAwceq5rbgp/uFbba8wU4fQ3BqNpBz+xpx7EvumagoAtS/ugMVn0zh9228ZRQStdf+hEg==
X-Received: by 2002:a6b:8d08:: with SMTP id p8mr14795116iod.150.1631638759246;
        Tue, 14 Sep 2021 09:59:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm6890220ioa.13.2021.09.14.09.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:59:19 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:59:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/9] serve: drop "keys" strvec
Message-ID: <YUDU5gE/AazOus+s@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDAvjteb/JAtyNz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDAvjteb/JAtyNz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:33:18AM -0400, Jeff King wrote:
> We collect the set of capabilities the client sends us in a strvec.
> While this is usually small, there's no limit to the number of
> capabilities the client can send us (e.g., they could just send us
> "agent" pkt-lines over and over, and we'd keep adding them to the list).
>
> Since all code has been converted away from using this list, let's get
> rid of it. This avoids a potential attack where clients waste our
> memory.

...because now we only bother to tell capabilities about information the
client sent as it happened, instead of accumulating an unbounded set of
strings together into a single strvec.

> Note that we do have to replace it with a flag, because some of the
> flush-packet logic checks whether we've seen any valid commands or keys.

Makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  serve.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/serve.c b/serve.c
> index 6bbf54cbbe..baa0a17502 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -239,7 +239,7 @@ static int process_request(void)
>  {
>  	enum request_state state = PROCESS_REQUEST_KEYS;
>  	struct packet_reader reader;
> -	struct strvec keys = STRVEC_INIT;
> +	int seen_capability_or_command = 0;
>  	struct protocol_capability *command = NULL;
>
>  	packet_reader_init(&reader, 0, NULL, 0,
> @@ -263,10 +263,11 @@ static int process_request(void)
>  			/* collect request; a sequence of keys and values */
>  			if (parse_command(reader.line, &command) ||
>  			    receive_client_capability(reader.line))
> -				strvec_push(&keys, reader.line);
> +				seen_capability_or_command = 1;
>  			else
>  				die("unknown capability '%s'", reader.line);
>
> +

Nit; unnecessary whitespace change (but obviously not worth a re-roll on
its own).

>  			/* Consume the peeked line */
>  			packet_reader_read(&reader);
>  			break;
> @@ -275,7 +276,7 @@ static int process_request(void)
>  			 * If no command and no keys were given then the client
>  			 * wanted to terminate the connection.
>  			 */
> -			if (!keys.nr)
> +			if (!seen_capability_or_command)
>  				return 1;
>
>  			/*
> @@ -309,7 +310,6 @@ static int process_request(void)
>
>  	command->command(the_repository, &reader);
>
> -	strvec_clear(&keys);
>  	return 0;
>  }
>
> --
> 2.33.0.887.g5b1f44e68d

The rest of this change looks obviously good to me.

Thanks,
Taylor
