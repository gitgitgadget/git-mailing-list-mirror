Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F9FC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238CD206D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1xud1Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgERLqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgERLqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 07:46:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA2C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 04:46:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so4693592pgm.1
        for <git@vger.kernel.org>; Mon, 18 May 2020 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=gu4/oVAtePmWfQGPfyQRrBRw6xQp2uIAF9ddgHKZQGo=;
        b=g1xud1Zu7Plce2Hca41rdQGSMIBDvDe/lb9ejwIEA1PjOhHLi44W+t2KYs89qc7ofF
         OUf29DgoZDP3M3QYEpQ6ArTEJDWEO7S3z1vLvI9Bk9kIad8RaEfxC19YzrmRSooCV6Fz
         QktD0t5AfGoE4irsjM8GK803SgJjDtVO3HYA51DXLW49uFF1pJlQO2oMQQI9vo9Dhw5t
         tdqla8w3c/6lWwW/slK9ZNL3QBRCU33tnHwKsPzW+GdPOt/CrC25plhXXPmbSTreUG3h
         DxYZnikRcMNv7VkPTXLs8IyzE1hHjc/5Es0N/TIU62uskWENSUYW0vCdxdyueoLrX+Dd
         OLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=gu4/oVAtePmWfQGPfyQRrBRw6xQp2uIAF9ddgHKZQGo=;
        b=ODqoPYJ0p4vJiqirtsVI4RtLBuAo5PoO3Szw148UivL8GVy8v/ndv7OM6MiXGl+R/8
         EUkv6rx+MJhcicGNA8aRq4R9qIzfN7heoHqY+fVjpcDLi0ip9Plw3B4E8JDHc6sojDVX
         fcQ14pVOKq7s7NmwQeEMO4+RWVPfMhy0mMo/tW3UxhhjLaRUCTzuX8m9bFcFTrmQk+GP
         hQQMlT0u3052MttwhjallK/fgYbnTdYK6bNt8nCo3r9frUyPoGZMgXEkRbp1LEqjwTwB
         yxKgGnoNU5f7HO6zRVrqfd9F45W82NXtsaQNbN73Ni2VPE67I+mg5DhYjYug6PhqGniQ
         q1Ig==
X-Gm-Message-State: AOAM530qWhQPf1Uc++bPukJfgFPM648S0whSwMswq0zwq1HLtBxfeZkw
        Sra6jTDtqbdrv4nyIXFlf3HFRh0xkL4=
X-Google-Smtp-Source: ABdhPJy9OHexwvPSRl1BqU+UM3daH6bleEKc3o3DeGrln0ntGFLwR73FzFcUN0KTv7sK0JSf5u9gOg==
X-Received: by 2002:a62:780c:: with SMTP id t12mr5721579pfc.235.1589802398105;
        Mon, 18 May 2020 04:46:38 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id n10sm6367535pfd.192.2020.05.18.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 04:46:37 -0700 (PDT)
Date:   Mon, 18 May 2020 17:16:30 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     laurent@spkdev.net
Cc:     congdanhqx@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518114630.GA30622@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518094021.GA2069@spk-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Laurent,

I have not worked in this part of Git before, please pardon my
ignorance. I went through the conversations held in this thread
Here are my inferences:

> The `diff.relative` boolean option set to `true` show only changes on
> the current directory and show relative pathnames to the current
> directory.

> Teach --no-relative to override earlier --relative

I think the message can be written better, maybe something like:

    The `diff.relative` boolean option set to `true` shows only changes
    in the current directory/value specified by the `path` argument of
    the `relative` option and shows pathnames relative to the
    aforementioned directory.

    Teach `--no-relative` to override the earlier `--relative`

> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -105,6 +105,10 @@ diff.mnemonicPrefix::
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
> 
> +diff.relative::
> +	If set to 'true', 'git diff' does not show changes outside of the directory
> +	and show pathnames relative to the current directory.

In the second last line, it would be better to write is as:

    ... does not show changes outside of the current directory/the path
    provided as the argument in `relative`?

Even my version of the above line seems very crude and innaccurate, but
I think that we should take into account the `path` passed down to us
by the `--relative[=<path>]` option.

Moving on, what I wondered was that maybe making it a `true/false`
option would be better? Something like:

    git diff --relative=false //override the diff.relative setting
    git diff --relative=true <path> //works like the usual `relative`

And by the usual, I mean :
    git diff --relative[=<path>]

What do you think? I think it would be better than adding a new option.

Also, if I am not mistaken:

> @@ -5195,8 +5202,7 @@ static int diff_opt_relative(const struct option *opt,
>  {
>  	struct diff_options *options = opt->value;
> 
> -	BUG_ON_OPT_NEG(unset);
> -	options->flags.relative_name = 1;
> +	options->flags.relative_name = !unset;

This is the overriding part right?

BTW you mention the `no-relative` setting which will override the
`relative` option. I am not able to see where exactly is the occurence
of the `no-relative` option in the code? What I mean is that I am not
able to observe where exactly does the C code identify a `no-relative`
option from the command line input? Did I miss something out here?

All nits aside, it looks like a very good concept to me. Nice work! :)

Regards,
Shourya Shukla
