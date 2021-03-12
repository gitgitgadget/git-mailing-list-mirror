Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA87C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90DD64FDC
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhCLIva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhCLIvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 03:51:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A38BC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:51:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p7so40501213eju.6
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Lal1JbPKi7ONQQfNdjhpliHXlDoyMxDtrBCc3heZRwI=;
        b=sIse9ht7m+vHJbYUS3FZx8UpxZkePVanQ2n+22ckuxonR3zFGmbtBDl28qOTmzzMw/
         W/SppCR/RoBFBVBxtxqoqdLWlFIKlMGq2YPqC/hqkdZyzBxPAAlRWjj3FHNTWbbdveAm
         7QJ+W/JVZt7hejuWShh89IoR6/rppqAd9k1Tam136h0nosW4L58Su+mSrALiIGHqfeaV
         30OCeMvE/cTVEqVAjgnUpmRQS72dlZ1VmNDzDkqgOEdeJcVQKW2rtKPRy/7PEj2GY79j
         sj2qK4yJa+hP8qp99p7ya42eFWD+Bl+ya+yWbERXCFJMHkr+ufhEHGn9M0v+uUV3ogdd
         74LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Lal1JbPKi7ONQQfNdjhpliHXlDoyMxDtrBCc3heZRwI=;
        b=Vd1uge6h0af4wqyjWRjbEpu80oCHdpjYlWB5l4qIIRPwK0E8R/zfNNeLxxIRaYiHN5
         XogiF6yxnCAZgIc3bn3iNqCCe1FVRzeyIFhD5rwEEujnTSR+J7CO4qUzBAxCHP6+2e3R
         5xGiA1XILYbmUKcvmhqUmRX47RZtIjp96Hu4fEoarkmKaTOBdKvrOCCd04D0Ng5Z2qhe
         IUnj56g9qgmxsR+mqThOfC/PPrW2sL+2pmnPXWehx3496PExuV3CDG0wYAwB/eFBqQIP
         TtLL9NgNKGD+Aql+qIEdCqpY/dWXLt7hVjpHbLVl4wPZt1LRu1BXq/04dFUkbcAmikKx
         s5pA==
X-Gm-Message-State: AOAM533ij9uFzpd+pC4pot2WbXI+Q2W4GrMqqbRFTnmcCqEFwdpxqP4+
        QWWsTsvSa1WJXvjC8HgAKBvcV7ctmV5LPw==
X-Google-Smtp-Source: ABdhPJyJL22IKLI37lIZqyqnSwBxEKLD1o1hSHOkN7vjjnqwiPaPWTygWlpQb3c2homvKoqiU10xpw==
X-Received: by 2002:a17:906:4150:: with SMTP id l16mr7520332ejk.90.1615539059258;
        Fri, 12 Mar 2021 00:50:59 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v8sm818449edc.30.2021.03.12.00.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:50:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/37] parse-options: parse into strvec
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-8-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-8-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 09:50:58 +0100
Message-ID: <87czw4hi19.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 5a60bbfa7f..f79b17e7fc 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -173,6 +173,13 @@ There are some macros to easily define options:
>  	The string argument is stored as an element in `string_list`.
>  	Use of `--no-option` will clear the list of preceding values.
>  
> +`OPT_STRVEC(short, long, &struct strvec, arg_str, description)`::
> +	Introduce an option with a string argument, meant to be specified
> +	multiple times.
> +	The string argument is stored as an element in `strvec`, and later
> +	arguments are added to the same `strvec`.
> +	Use of `--no-option` will clear the list of preceding values.
> +
>  `OPT_INTEGER(short, long, &int_var, description)`::
>  	Introduce an option with integer argument.
>  	The integer is put into `int_var`.
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 4542d4d3f9..c2451dfb1b 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -207,6 +207,22 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
> +{
> +	struct strvec *v = opt->value;
> +
> +	if (unset) {
> +		strvec_clear(v);
> +		return 0;
> +	}
> +
> +	if (!arg)
> +		return -1;
> +
> +	strvec_push(v, arg);
> +	return 0;
> +}
> +
>  int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
>  {
>  	return 0;
> diff --git a/parse-options.h b/parse-options.h
> index ff6506a504..44c4ac08e9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -177,6 +177,9 @@ struct option {
>  #define OPT_STRING_LIST(s, l, v, a, h) \
>  				    { OPTION_CALLBACK, (s), (l), (v), (a), \
>  				      (h), 0, &parse_opt_string_list }
> +#define OPT_STRVEC(s, l, v, a, h) \
> +				    { OPTION_CALLBACK, (s), (l), (v), (a), \
> +				      (h), 0, &parse_opt_strvec }
>  #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
>  				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
>  #define OPT_EXPIRY_DATE(s, l, v, h) \
> @@ -296,6 +299,7 @@ int parse_opt_commits(const struct option *, const char *, int);
>  int parse_opt_commit(const struct option *, const char *, int);
>  int parse_opt_tertiary(const struct option *, const char *, int);
>  int parse_opt_string_list(const struct option *, const char *, int);
> +int parse_opt_strvec(const struct option *, const char *, int);
>  int parse_opt_noop_cb(const struct option *, const char *, int);
>  enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
>  					   const struct option *,

Nice, seems very useful.

But let's add a test in test-parse-options.c like we have for
string_list?
