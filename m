Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505D2C76196
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 00:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDHAWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDHAWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 20:22:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D2F12842
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 17:22:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a273b3b466so253975ad.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680913339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hGGJzfNlmZC2rgMsL0vbIrehgb2/U+HMnwnmWKpXrUs=;
        b=R8U+vjYHk/R0CT8S2zKBaDz2Q0CYVEMgtcRm5SNJ3uSohNQo85RQo/QfowoazTILAF
         tnGbytb/wApLvJ3J2XaA/3HEzRjSNHSreLqpp9hosphJrbljpiWMV/e7UKCk3KuSvHKU
         V1ItitutYGgYL/Hfgjz/+L82MvoXijIyPnUB/Qy/38yUin0VcDGftbvTfpaoiGkHaEnM
         JeDcnB1f9fIuFdlC3+qZmDaWExtoR7ULBH3R54gMJewS/sRFJ22TfT0nTVzPZqHLjjrj
         q4SYWjT/6DqF0AaObQdWHI6VzYTaugtCvauQAJQqo59Yzq036poaRpRQwFTmATdZTL6p
         WOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680913339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGGJzfNlmZC2rgMsL0vbIrehgb2/U+HMnwnmWKpXrUs=;
        b=Jy6r1u9HB2PznPkcg00bXfn2H9fXo9K7qm3Da2zLRSywmDDmL0O0oS7Vj9K9S3tqs0
         W1bgYHItMGfLZtlPI/IbuOoxGZnbJZAXfaztBSfRNuwAsn1Gj9NtLiXaQWqxSpAohBmC
         80qctKvUWABSu9P+gWV8dSUfgGPmh1bTMnMC8lSIwGlP6CHBgwD4XQRVxr5xDOmfqien
         FXAuoaNXCC++TcYxk/71g14ghFlW3mro7vudmO+6GPIqMUCW/tqkTHxBUbg5WN8hCHvY
         mP+DaP/5OVYnmoeYhxlDkkK3vI7Z+XeIRTKGCcu1AzvR0W3G3duKmYEIj5mEVJ9N0y8Z
         jcFg==
X-Gm-Message-State: AAQBX9dLusbAbRQviYtseZfYbcYVrqeLjBaJBlXgvwpc1sItqxELmTEE
        warVMEW0v4W2ynvhrz1hkgxshXCovx5RnFIGPRFzbdoO
X-Google-Smtp-Source: AKy350ZkN8wIjL/0jS7bcdlGpv1D0Et7MILtGgVslnDpGEP22WKEyNjrl7RAAIonJw8zdQj+DFxSiQ==
X-Received: by 2002:a17:902:e993:b0:19a:f15a:5b2f with SMTP id f19-20020a170902e99300b0019af15a5b2fmr38907plb.19.1680913338918;
        Fri, 07 Apr 2023 17:22:18 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:3cbf:c928:3960:94f5])
        by smtp.gmail.com with ESMTPSA id c16-20020a170902b69000b001a0742b0806sm3444984pls.108.2023.04.07.17.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 17:22:18 -0700 (PDT)
Date:   Fri, 7 Apr 2023 17:22:13 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
Message-ID: <ZDCztVHuZoCstNar@google.com>
References: <ZDCWrl4GhgYKYFYG@google.com>
 <xmqqcz4fi7bd.fsf@gitster.g>
 <xmqqy1n3gryw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy1n3gryw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2023 at 05:03:51PM -0700, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do agree with you that "git checkout -h" and "git reset -h" that
> > list
> >
> > 	--recurse-submodules[=<checkout>]
> > 	--recurse-submodules[=<reset>]
> >
> > are being unnecessarily confusing by not saying anything about what
> > these placeholders are to be filled with.  
> >
> > This however is a breaking change....
> 
> With your patch, the callback becomes like this:
> 
> int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
> 						     const char *arg, int unset)
> {
> 	if (unset)
> 		config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
> 	else
> 		config_update_recurse_submodules = RECURSE_SUBMODULES_ON;
> 	return 0;
> }
> 
> but this makes me wonder if it makes it better by turning it around
> 180 degrees and going in the opposite direction.
> 
> With Devil's advocate hat on, what if we declare that *any* option
> that sets a boolean variable can be spelled in any of the following
> ways?
> 
>     [enables "frotz" option]
>     --frotz             # naturally
>     --frotz=yes         # usual synonyms yes/true/1/... are accepted
> 
>     [disables "frotz" option]
>     --no-frotz          # naturally
>     --frotz=no          # usual synonyms no/false/0/... are accepted

I don't have a strong opinion on this, sorry. :)

> 
> It would be just the matter of updating OPT_BOOL()'s implementation.
> 
> Then the patches to builtin/checkout.c and friends would look like:
> 
>  static struct option *add_common_options(struct checkout_opts *opts,
>  					 struct option *prevopts)
>  {
>  	struct option options[] = {
>  		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
> -		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
> -			    "checkout", "control recursive updating of submodules",
> -			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
> +		OPT_BOOL(0, "recurse-submodules", &config_update_recurse_submodules,
> +			N_("control recursive updating of submodules")),
>  		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
> 
> and we no longer need the callback function.

I think we do because config_update_recurse_submodules is static to
submodule.c - that is, builtin/checkout.c and friends don't have access
to set it manually with OPT_BOOL. Using the callback just to set static
state we don't naturally have access to is pretty awful, though, so I'd
be in favor of plumbing it through like other options we might be
passing to the submodule machinery.

If you do feel strongly about it, anybody else is welcome to hijack this
patch and make it so, but I doubt that I will have time to do so. Happening
to have a moment this afternoon was a bit of an accident :( so I hereby
un-lick the cookie.

> 
> We will not break any existing users, and then suddenly people can
> now say
> 
> 	--progress
>         --no-progress
>         --progress=yes
>         --progress=no
> 
> just like --recurse-submodules=yes has silently been allowed all
> these years.
> 
> Hmm?
