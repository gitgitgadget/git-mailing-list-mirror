Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A0C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 01:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3368920721
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 01:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtSHcuFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbgDBBJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:09:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46317 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbgDBBJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 21:09:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so914426pff.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 18:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x84W7UV+8j8f+3wYbncgjHM8fXaeFui7GIXuDxH5y/I=;
        b=LtSHcuFlSFyhKLdZYGx2d0qv+W10AaOVT5og7HvZbzod3g4EYVvenMezr+RBxbUNTq
         Qa+BbbOjkNdKzdnZzFN0Q5n7TR0utr7JpI4FT5AllHuiHOYfKg+jIMBUrS1d2xng4E5h
         45Ny8LjVikGqDnveLfFtt1vP6EZZVj+IXqZXa3nWLMdqyPN9V0nQjJ9Z9oIrc7x6Rp8+
         Pq7ZXpSX6V4vrTX90jvDrAdTqIKobvbE3dGKz/RlzB4HBHkfQDVhI+jDxexSBMU5Z5oU
         8y2qS7E0M181Yi9sMFgUeci1TTgi5ylfw02iE9XDiySM50VbmmEScGR9XF99SWr9vmfH
         p31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x84W7UV+8j8f+3wYbncgjHM8fXaeFui7GIXuDxH5y/I=;
        b=ejitgSlZSd6RvZnuX9E5yulEkQvYxKb4L3FHXX3HC8KgGq8LUBFc0TAvSa+K2pl/kv
         HAn7HwnAXnGMeVqHLLT27ntE7ajqQtAdYCW/LB1RDfDcXyq4I11uALlpbP0d4FjKHRZL
         iO1b6F3D6JcbweoGGKVAMoHoSKbo2+QkEcTw0udEUQdkADWd5lGwDG4m8Q92hJ3na52/
         fwtOYspL2ctuc8kTfbldBDdIdxq4KB93JfoC5PL+vcmJTARpLLxb8ew7eSsHHlMZwTHe
         BsFs/e96p8a2cTv3Bt9Mj0hEdWl6Dvzor4gRq0f1ukMfJQl9veGpmGawe87R0ohwgqgo
         WMIQ==
X-Gm-Message-State: AGi0PubUQTVJvwkZmiU0vljgWvw+wFymfwOJSlNAdC6Uheu4oBkUpZ0t
        Yha31L/rKaS+OVuqkKOeZOE=
X-Google-Smtp-Source: APiQypKDqnKo5++I1RHSvmHVTiSjdnndCNNXljSAP7cWdlmIBFi8s63w9QDzdVZkL55gwdACH4/JDg==
X-Received: by 2002:a63:1053:: with SMTP id 19mr1032486pgq.60.1585789795476;
        Wed, 01 Apr 2020 18:09:55 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id f8sm1259411pgc.75.2020.04.01.18.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 18:09:54 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:09:52 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dominic Chen <d.c.ddcc@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase.c: teach --no-gpg-sign to git-rebase
Message-ID: <20200402010952.GB2764@danh.dev>
References: <81aea443-6978-93d7-c5d3-98dd731a1fd8@gmail.com>
 <20200331064456.GA15850@danh.dev>
 <xmqqv9mj5c9o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9mj5c9o.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-01 10:47:15-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Two points.  
> 
>  - There must be already an entry for '--gpg-sign'.  It would make
>    more sense to make this addtion a part of its description.
> 
>  - The --no-<option> form is not just to override a configured
>    default, but also to coumtermand an option given earlier on the
>    command line.  In other words "rebase -S --no-gpg-sign" without
>    any commit.gpgSign should work just fine.

That paragraph was copy-pasted from git-commit documentation.
I think it would need a clean up there, too.

And, mention of --no-gpg-sign in am, cherry-pick, revert,
merge-option.

While writing this, I've checked (again) all commands mentioned
--gpg-sign. To my surprise, "revert" (despite shares most of code with
"cherry-pick") doesn't honour --no-gpg-sign, either.

I'll teach "--no-gpg-sign" too revert and update all documentation for
this.

> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 27a07d4e78..a8cc5cfe0c 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1593,6 +1593,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  
> >  	options.allow_empty_message = 1;
> >  	git_config(rebase_config, &options);
> > +	// options.gpg_sign_opt will be either "-S" or NULL
> > +	// It'll be freed later, hence, no skip-prefix
> 
> Don't use //- comments.
>
> > +	gpg_sign = options.gpg_sign_opt ? "" : NULL;
> 
> We've read configured commit.gpgSign in options.gpg_sign_opt; it is
> either a freeable "-S" or NULL depending on its value.  We initialize
> the local gpg_sign variable to either an unfreeable "" or NULL here.
> 
> Let's see how that local variable is later used here.  We know it is
> given as the target variable to OPTION_STRING, which will overwrite
> with the value given from the command line, so "" that is unfreeable
> avoids an unnecessary leak.
> 
>  - If we did not have --gpg-sign, or --no-gpg-sign, then the local
>    variable gpg_sign will stay to be either "" or NULL after
>    parse_options() returns.
> 
>  - If we had --gpg-sign or --no-gpg-sign, we will have the value
>    given from the last one of them on the command line in gpg_sign
>    after parse_options() returns.
> 
> 
> 
> > @@ -1823,10 +1826,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  	if (options.empty != EMPTY_UNSPECIFIED)
> >  		imply_merge(&options, "--empty");
> >  
> > -	if (gpg_sign) {
> > -		free(options.gpg_sign_opt);
> > +	free(options.gpg_sign_opt);
> > +	if (gpg_sign)
> >  		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
> > -	}
> > +	else
> > +		options.gpg_sign_opt = NULL;
> 
> Now we _always_ override options.gpg_sign_opt based on the value in
> the local gpg_sign variable, so the *ONLY* time options.gpg_sign_opt
> is used is immediately after git_config() returns to decide what
> value to assign to gpg_sign we saw above.  I *think* it would be
> much clearer to FREE_AND_NULL options.gpg_sign_out immediately after
> we initialize gpg_sign above, instead of freeing it here.

Make sense,

> Then you do not need the elese clause here, either.
> 
> This is a total tangent, but do we ever call cmd_rebase__interactive()
> these days?  It does not seem to do the config thing, and assigns the
> string taken from the command line to opts.gpg_sign_opt, which means
> that it is an error to free the field in any codepath that can be
> reached from there.

cmd_rebase__interactive go through different code path, and it doesn't
run into above line

> I suspect that after removing "rebase --preserve-merges", there is
> nobody that calls "git rebase--interactive", and at that point the
> function will be dead-code and can safely be removed.

I've grep-ed the code and it's look like only "rebase -p" call
cmd_rebase__interactive,

I've drafted a test, and "rebase -p" indeeds doesn't honour
"--no-gpg-sign",

Consider the deprecation of "--preserve-merges" is more than a year,
I think I'll mark that test as broken instead of trying to fix it.

-- 
Danh
