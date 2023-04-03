Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74155C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 16:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjDCQ3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjDCQ3W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 12:29:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F031721
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 09:29:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so31151732pjz.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539361;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g08Kv26XU0P++/Nlb0ZN7ddk8DCklTeSLdYsTAgxYLo=;
        b=N5X+BMMt1X6JlR3u2kWTmCDBRSXE9KUH41W1XzhJvHdmsV22SfYXMiJBNsVOKLWuPb
         g3Cyn9n3Ir4WHWjq0gqJU8a6Vm/8tyAnaUj1BXi+LjKFKvP3IBeBEkyN3Ail8HA6MvhC
         Mge4R++bgRD5IJ/nPgXyFlBrySdnJnVVtVNnd0ISp6SJGf5HltP5SMyT7wKLQgG2KEh9
         kP7YyH/jAozSFLyBOhmAw2YUjdLFwgMMvqD/PU8+Ril46qfu+1fBaQ7mNC8w7Sq4E0fu
         QE8Vj4ZJnNsq4V0NH7PDCEkPge+4iiPZ1wVgVO/2wEo8dK3oSUQsSCPZzrE7b9k2dkJY
         RxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539361;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g08Kv26XU0P++/Nlb0ZN7ddk8DCklTeSLdYsTAgxYLo=;
        b=WArm5ORDAFApBzBQaLek8hyAnMVXLKePgLG+X2+QHm6zxIj06rkCQHueiOwfrojx0p
         cc/vrRPH16nxbNZFdp7LJuUWxVhDAL3fXiKRey1jlp67rR9SiHIxfBD1I3PWOzRBCu2M
         4GsyqlPf+R0AnurVRjnvFu/4G6URh3OKeuvU/1moOZx1zrbB7WdQvf8UBVFbWXVvNuBc
         AznaLKz686npd6WclDxuK+dmFUvStUi4OhLQVNZHU/qIyBLsJVKVfL3ug64Bxilrofe6
         XgjYUB7pc+NlP0HPdo4R2CQoIyPb7NADrp4elgJ3EgEXaIGdQn2M0Ytp57V/FgFKSSy5
         E0Gw==
X-Gm-Message-State: AAQBX9fYET1ncI9WHuSRA6Bj28Lcy/T3W5P4kghnCbqW/Vuue38EJPqs
        DaOxPtOLNJMyXrBRjsG4M8Y=
X-Google-Smtp-Source: AKy350ZlqwKPIeYPdomcBv7ThQV1fhJmPwLdZD5pl/+BpxO3PJAiKOaAoxxbsvYXgbl5Pmt7R2Uuvw==
X-Received: by 2002:a17:902:ecc4:b0:1a1:c9f7:cec5 with SMTP id a4-20020a170902ecc400b001a1c9f7cec5mr47199837plh.2.1680539360702;
        Mon, 03 Apr 2023 09:29:20 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902ce0a00b0019a70a42b0asm6928988plg.169.2023.04.03.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:29:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>
Subject: Re: regex compilation error with --color-words
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
        <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
        <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
        <c4728fac-bea9-3794-077e-c978d99f46bf@web.de>
Date:   Mon, 03 Apr 2023 09:29:20 -0700
In-Reply-To: <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 2 Apr 2023 11:44:30 +0200")
Message-ID: <xmqq5yad7wv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Actually we can drop the "|[\xc0-\xff][\x80-\xbf]+" part in that case
> because the "[^[:space:]]" suffices.  And we probably need to do that at
> runtime because it depends on the locale.  The rather elaborate patch
> below does that.  It leaks the truncated word_regex, which isn't that
> bad because it's done only once per run, but certainly untidy.

Small ugliness like what we see below is fine in a technology
demonostration.

> I suspect/hope this can be done simpler and cleaner after refactoring
> the userdiff code to allow for runtime assembly of regular expressions.

Do we expect "does the regcomp(3) and regexec(3) correctly match a
non-space multi-byte UTF-8 sequence as expected?" to be the only
choices, do we expect we will choose from only two, and do we expect
that the differences between the MB version and fallback version to
be the same "OR_MULTI_BYTE_CHAR may be omitted"?  For now I think
it would be reasonable to answer yes to all three.

How are .is_builtin and .has_multi_byte_char_fallback bits expected
to be used?  For what kind of files do we expect them to be set
differently?

In the simplest case, I would imagine that we could do this

 	...
 	const char *word_regex;
+	const char *word_regex_wo_mb;
 	const char *textconv;
 	...

in the definition of "struct userdifif_driver", use

 #define PATTERNS(lang, rx, wrx) { \
 	...
 	.word_regex = wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+	.word_regex_wo_mb = wrx "|[^[:space:]]", \
 }

and similar for IPATTERN, and make a non-NULL .word.regex_wo_mb
serve as the .has_multi_byte_char_fallback bit to trigger "does our
regex engine do a good job for multi-byte?"

Thanks.

> diff --git a/userdiff.c b/userdiff.c
> index 09203fbc35..aa2cd150ba 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -9,6 +9,8 @@ static struct userdiff_driver *drivers;
>  static int ndrivers;
>  static int drivers_alloc;
>
> +#define OR_MULTI_BYTE_CHAR "|[\xc0-\xff][\x80-\xbf]+"
> +
>  #define PATTERNS(lang, rx, wrx) { \
>  	.name = lang, \
>  	.binary = -1, \
> @@ -16,7 +18,9 @@ static int drivers_alloc;
>  		.pattern = rx, \
>  		.cflags = REG_EXTENDED, \
>  	}, \
> -	.word_regex = wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
> +	.word_regex = wrx "|[^[:space:]]" OR_MULTI_BYTE_CHAR, \
> +	.is_builtin = 1, \
> +	.has_multi_byte_char_fallback = 1, \
>  }
>  #define IPATTERN(lang, rx, wrx) { \
>  	.name = lang, \
> @@ -25,7 +29,9 @@ static int drivers_alloc;
>  		.pattern = rx, \
>  		.cflags = REG_EXTENDED | REG_ICASE, \
>  	}, \
> -	.word_regex = wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
> +	.word_regex = wrx "|[^[:space:]]" OR_MULTI_BYTE_CHAR, \
> +	.is_builtin = 1, \
> +	.has_multi_byte_char_fallback = 1, \
>  }
>
>  /*
> @@ -330,6 +336,25 @@ static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
>  	return 0;
>  }
>
> +static int regexec_support_multi_byte_chars(void)
> +{
> +	static const char not_space[] = "[^[:space:]]";
> +	static const char utf8_multi_byte_char[] = "\xc2\xa3";
> +	regex_t re;
> +	regmatch_t match;
> +	static int result = -1;
> +
> +	if (result != -1)
> +		return result;
> +	if (regcomp(&re, not_space, REG_EXTENDED))
> +		BUG("invalid regular expression: %s", not_space);
> +	result = !regexec(&re, utf8_multi_byte_char, 1, &match, 0) &&
> +		match.rm_so == 0 &&
> +		match.rm_eo == strlen(utf8_multi_byte_char);
> +	regfree(&re);
> +	return result;
> +}
> +
>  static struct userdiff_driver *userdiff_find_by_namelen(const char *name, size_t len)
>  {
>  	struct find_by_namelen_data udcbdata = {
> @@ -337,6 +362,15 @@ static struct userdiff_driver *userdiff_find_by_namelen(const char *name, size_t
>  		.len = len,
>  	};
>  	for_each_userdiff_driver(userdiff_find_by_namelen_cb, &udcbdata);
> +	if (udcbdata.driver &&
> +	    udcbdata.driver->is_builtin &&
> +	    udcbdata.driver->has_multi_byte_char_fallback &&
> +	    regexec_support_multi_byte_chars()) {
> +		const char *word_regex = udcbdata.driver->word_regex;
> +		udcbdata.driver->word_regex = xmemdupz(word_regex,
> +			strlen(word_regex) - strlen(OR_MULTI_BYTE_CHAR));
> +		udcbdata.driver->has_multi_byte_char_fallback = 0;
> +	}
>  	return udcbdata.driver;
>  }
>
> diff --git a/userdiff.h b/userdiff.h
> index 24419db697..83f5863d58 100644
> --- a/userdiff.h
> +++ b/userdiff.h
> @@ -21,6 +21,8 @@ struct userdiff_driver {
>  	const char *textconv;
>  	struct notes_cache *textconv_cache;
>  	int textconv_want_cache;
> +	int is_builtin;
> +	int has_multi_byte_char_fallback;
>  };
>  enum userdiff_driver_type {
>  	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
> --
> 2.40.0
