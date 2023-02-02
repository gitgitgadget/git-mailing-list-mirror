Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254A8C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjBBTdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:33:05 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF767F74F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:33:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2202051pjp.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 11:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SgBHWUe+GMc6IxZjzUeGJD/a+c82BO+UpOOvhI87xw=;
        b=BKsBqRxHgnB8xh2v85NQJ7A+uv2V8IXoSIcf9N1S296wHG7yTXpglhZmPpn0965sve
         Yzk3PLlCQsJ8id2eC5DcQ88llxblgq7+hUJYcVqIgOkVo5BwQsg8sjL19xhEX27mXRye
         W1gA8dNNLPKZO4/dq3/gH1tTqQV7e5O2PPVsfYLZ7yboEH9iLgFWw3J0xCBeAPer4XGc
         jaDKVqjlKRO8QYUxqZ69FxxAk1MDYM1t89NQ8UkrzA/TeopK/b0OAza8eB4/65kwmCBe
         tIZjsTQhFa7O6NYaygpC1FksBQMRnYxWTGsiVfZKldSK4YoZE+yNAXlZMB7+iBrFQkZE
         0+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0SgBHWUe+GMc6IxZjzUeGJD/a+c82BO+UpOOvhI87xw=;
        b=XhIuGkZ1vzNFP5r33g5H5sfjYgyg2QGZNCcx4g4nWchc9xQZZH0cUBVR1sYArk/vvy
         TpdNDfQFvoZ36hWu4PHhPzs2Vgtqg7qHtD0yRiL8IUO4Zsy1RZcSKfd+2s1kyAdUGJl4
         iQCs4zKEiF27FlBAOFnNcnZ3pnb5fsdHTAzb8xGOHL0zRv9+2p4444zHbSeqFqpGozXt
         yyIxewjuy18WGvN8ZAYMUrbotDRicfvUux+TssjheC5hLa909Wl9SnFC7rQkzPuQ6OdQ
         MUHpNuwtMrPqxz0MzNjIdG1+FImMXkvSNG/JsfDU2lkANGyF/Xe/brFqh8FnckPOo4e5
         EvPQ==
X-Gm-Message-State: AO0yUKWKMjAvoe2glWC1m7oEHk+ibPkhgx6cWViIt2gx5rnLb1M5ejya
        4+do0ce+/ywk3w2U7bqI/aI=
X-Google-Smtp-Source: AK7set/kQPzNVCVkeLIuNOC0S0m6O6Y371xO+QGTX2x9est6bV62s7/C5JBxsVgweI4c0AzUEzQzjw==
X-Received: by 2002:a17:90b:4a81:b0:230:2056:b6da with SMTP id lp1-20020a17090b4a8100b002302056b6damr7690839pjb.34.1675366383088;
        Thu, 02 Feb 2023 11:33:03 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a0d0200b002298e0641b6sm3493988pja.27.2023.02.02.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:33:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/6] imap-send: replace auto-probe libcurl with hard
 dependency
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-3.6-354b6a65a78-20230202T093706Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 11:33:02 -0800
In-Reply-To: <patch-v2-3.6-354b6a65a78-20230202T093706Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:44:14
        +0100")
Message-ID: <xmqqk00zuakx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  imap.authMethod::
>  	Specify authenticate method for authentication with IMAP server.
> -	If Git was built with the NO_CURL option, or if your curl version is older
> -	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
> +	If you're running git-imap-send with the `--no-curl`
>  	option, the only supported method is 'CRAM-MD5'. If this is not set
>  	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.

OK.

> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index f7b18515141..202e3e59094 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -44,8 +44,7 @@ OPTIONS
>  
>  --no-curl::
>  	Talk to the IMAP server using git's own IMAP routines instead of
> -	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
> -	set.
> +	using libcurl.

Hmph, let's read on to resolve "when built with NO_OPENSSL, giving
--no-curl now errors out or do something else? do we need to? why?",
which was my knee-jerk reaction.

> diff --git a/INSTALL b/INSTALL
> index d5694f8c470..d9538bbcb45 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -129,13 +129,13 @@ Issues of note:
>  	  itself, e.g. Digest::MD5, File::Spec, File::Temp, Net::Domain,
>  	  Net::SMTP, and Time::HiRes.
>  
> -	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
> -	  you are using libcurl older than 7.34.0.  Otherwise you can use
> -	  NO_OPENSSL without losing git-imap-send.
> +	- git-imap-send needs libcurl 7.34.0 or newer, in addition
> +	  OpenSSL is needed if using the "imap.tunnel" open to tunnel
> +	  over SSL. Define NO_OPENSSL to omit the OpenSSL prerequisite.

"if using the imap.tunnel to open a tunnel over ssl"?
because I think there are some grammo there.

"to omit the OpenSSL prerequisite" -> "if you do not need it"?
because the original sounds like losing prereq without any penalty.

>  	- "libcurl" library is used for fetching and pushing
>  	  repositories over http:// or https://, as well as by
> -	  git-imap-send if the curl version is >= 7.34.0. If you do
> +	  git-imap-send. If you do
>  	  not need that functionality, use NO_CURL to build without
>  	  it.

OK.

> diff --git a/Makefile b/Makefile
> index 45bd6ac9c3e..b08a855198c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -773,7 +773,9 @@ PROGRAMS += $(EXTRA_PROGRAMS)
>  
>  PROGRAM_OBJS += daemon.o
>  PROGRAM_OBJS += http-backend.o
> +ifndef NO_CURL
>  PROGRAM_OBJS += imap-send.o
> +endif

Nice.

> @@ -1592,6 +1593,7 @@ ifdef NO_CURL
>  	REMOTE_CURL_ALIASES =
>  	REMOTE_CURL_NAMES =
>  	EXCLUDED_PROGRAMS += git-http-fetch git-http-push
> +	EXCLUDED_PROGRAMS += git-imap-send

OK.

> @@ -1617,19 +1619,9 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> +	IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)

OK.  That is a natural consequence of losing USE_CURL_FOR_IMAP_SEND
conditional, which is good.

> @@ -2786,7 +2778,7 @@ endif
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
> -git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
> +git-imap-send$X: imap-send.o http.o GIT-LDFLAGS $(GITLIBS)

And this too is a natural consequence of http.o that serves as a
linkage between us and libcURL being always used.  Good.

> diff --git a/imap-send.c b/imap-send.c
> index b7902babd4c..26f8f01e97a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -30,20 +30,10 @@
> ...
> +static int use_curl = 1;

OK.

>  int cmd_main(int argc, const char **argv)
>  {
> @@ -1531,12 +1519,7 @@ int cmd_main(int argc, const char **argv)
>  	if (argc)
>  		usage_with_options(imap_send_usage, imap_send_options);
>  
> -#ifndef USE_CURL_FOR_IMAP_SEND
> -	if (use_curl) {
> -		warning("--curl not supported in this build");
> -		use_curl = 0;
> -	}

Naturally ;-)

> -#elif defined(NO_OPENSSL)
> +#if defined(NO_OPENSSL)
>  	if (!use_curl) {
>  		warning("--no-curl not supported in this build");
>  		use_curl = 1;

In the original, this part reached iff we had USE_CURL_FOR_IMAP_SEND,
so "if we are using curl and do not have openssl, then --no-curl is
rejected and we forced use of curl" was how the original behaved here.

Here, we always link with curl, so the updated code is doing exactly
the same thing.  Good.

But then the documentation change above that puzzled me was there
not because it was needed to match updated behaviour (the behaviour
stayed the same).  So was it meant as a documentation improvement?

> @@ -1580,10 +1563,8 @@ int cmd_main(int argc, const char **argv)
>  	if (server.tunnel)
>  		return append_msgs_to_imap(&server, &all_msgs, total);
>  
> -#ifdef USE_CURL_FOR_IMAP_SEND
>  	if (use_curl)
>  		return curl_append_msgs_to_imap(&server, &all_msgs, total);
> -#endif

Naturally.

>  	return append_msgs_to_imap(&server, &all_msgs, total);
>  }

Looking good.  Thanks.
