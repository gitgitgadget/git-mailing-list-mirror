Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E8AC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbiEaRjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiEaRjA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:39:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811162BE5
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:38:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so13483837plh.1
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RhAsFGibtqRI0b4uJWA0Rxkvj705lZhgdz8Bl3zqM2M=;
        b=eLweM3cvnqBQr9ZodOqOEIX7SETbmq5G17vbcCXLiDSwXziUqC4tEygloCE/x42uMb
         9r3K+m/CaYw2KLplmi+T8+WvU7eFRg1bvMHzOhc+VNbLQF2Mwfu6mZ3ZfRcf1SJK7q8N
         XUou3Bqes7w2i2DIlUG4JThz1sax2aaD7l5d+/aAyWXbPSIyDNT/UMXds45iRZ1f/Vb/
         //DoXh2hH5evUf6pwfXxsdQNq6pI458us5nLZX99+k0Dftv8FF9e3C4TIP2NIBIXUPJD
         IIyhK+DylsagidD2KBs+XuLKthqBV06Uh44qo6L1ECGtN58XqeJ5CLfM+duzgva4uL9h
         tDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=RhAsFGibtqRI0b4uJWA0Rxkvj705lZhgdz8Bl3zqM2M=;
        b=O6Hd4LMsHI3dXognLUmpaDpI7hQx4x/GwUPoq/xDpbf13LXyFYNxuf27po/l6lv5Om
         nLihhvZ5A+eWEtdhKcbJFnq9OZugn0Q4qy6ehU9EgPRmwD22tSIb5eE3lwGBFrT0fsg0
         VfPHf22uyxq+L1ViPXg/KjmRmYhxgZzIoRQ3aLF8siW0iDl/IUzuCU5g5C8yyS7bZ6ow
         p6oIT1oWkDZp/3hbCpV/sJVXMcd8SqmATIKrcJkjY6eQRfKbWeH4Rco00nKZFaluLucX
         pF08XGdXa3oLjWm4YNOWx/nSMlayklvBHNbIrOg1xYE/bEcHWO8v8im99Oe0wRquYUAT
         JU2A==
X-Gm-Message-State: AOAM532mFnj2ndQqVSQSO3YUjIeUME6UpWDE130Hbvj1ewRIWtSLa14F
        qTT8fZoJkcFzRMSwgwHr94ftlK6pF9cm5w==
X-Google-Smtp-Source: ABdhPJxpDen2lnIfAyAGFtdQH5q5ikS0BvQMiRQTvBMk4/NatKCWAK4+evSqBbOz165/f0Lo2CKG2Q==
X-Received: by 2002:a17:902:da8e:b0:164:537:d910 with SMTP id j14-20020a170902da8e00b001640537d910mr4354454plx.75.1654018738529;
        Tue, 31 May 2022 10:38:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:42f:67e0:2ed2:1f46])
        by smtp.gmail.com with ESMTPSA id z3-20020a17090a8b8300b001e2afd35791sm2213675pjn.18.2022.05.31.10.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:38:57 -0700 (PDT)
Date:   Tue, 31 May 2022 10:38:52 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 4/6] parse-options.c: use optbug() instead of BUG()
 "opts" check
Message-ID: <YpZSrNM/bZ3i6Yvu@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
 <patch-v2-4.6-47d384d0ae5-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-4.6-47d384d0ae5-20220531T164806Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.31 18:58, Ævar Arnfjörð Bjarmason wrote:
> Change the assertions added in bf3ff338a25 (parse-options: stop
> abusing 'callback' for lowlevel callbacks, 2019-01-27) to use optbug()
> instead of BUG(). At this point we're looping over individual options,
> so if we encounter any issues we'd like to report the offending option.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  parse-options.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 78b46ae9698..243016ae30f 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -473,21 +473,30 @@ static void parse_options_check(const struct option *opts)
>  				optbug(opts, "should not accept an argument");
>  			break;
>  		case OPTION_CALLBACK:
> -			if (!opts->callback && !opts->ll_callback)
> -				BUG("OPTION_CALLBACK needs one callback");
> -			if (opts->callback && opts->ll_callback)
> -				BUG("OPTION_CALLBACK can't have two callbacks");
> +			if (!opts->callback && !opts->ll_callback) {
> +				optbug(opts, "OPTION_CALLBACK needs one callback");
> +				break;
> +			}
> +			if (opts->callback && opts->ll_callback) {
> +				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
> +				break;
> +			}
>  			break;
>  		case OPTION_LOWLEVEL_CALLBACK:
> -			if (!opts->ll_callback)
> -				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
> -			if (opts->callback)
> -				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
> +			if (!opts->ll_callback) {
> +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
> +				break;
> +			}
> +			if (opts->callback) {
> +				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
> +				break;
> +			}
>  			break;

A minor point, but I'm not sure I understand why we're adding breaks for
the two cases above. In the OPTION_CALLBACK case, the if conditions are
mutually exclusive and are followed by an unconditional break, so adding
additional breaks seems unnecessary. For the OPTION_LOWLEVEL_CALLBACK
case, the conditions are not mutually exclusive, but isn't this exactly
the issue that optbug() is intended to address? I.e., wouldn't the
caller want to see both optbug()s if both are relevant?

>  		case OPTION_ALIAS:
> -			BUG("OPT_ALIAS() should not remain at this point. "
> -			    "Are you using parse_options_step() directly?\n"
> -			    "That case is not supported yet.");
> +			optbug(opts, "OPT_ALIAS() should not remain at this point. "
> +			       "Are you using parse_options_step() directly?\n"
> +			       "That case is not supported yet.");
> +			break;
>  		default:
>  			; /* ok. (usually accepts an argument) */
>  		}
> -- 
> 2.36.1.1100.g16130010d07
> 
