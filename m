Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC955C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 07:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977C3613DE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 07:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCHFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 03:05:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD6C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 00:03:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a11so6948389ejf.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1I/46Hp64bGsf9RI8N0SoRZWjt1tyepN5ijb7rBys7g=;
        b=qLxPRklcVevRy+L1mQJP3Ocy2WHJ0HVd7lbUIvEhTqMNVxWhwRFlNdQRwl5WGAY8FP
         v70wcaI4hT8tEFmVfhktUGpaoM43V7Z5yiEWn/GnVeqwkYWNDLT34CeuKEOenxhy/+jF
         rI7XJJuvjqkda3TyD8u2NUm0Wdc2ovQfavrpaZ4kHzBT4lnIgtuXqvALG1d3I2uyVjp7
         maahoKvs1UWJRRinRiDKA/1q1vUQsmFJbrB1/6fWweCI6cujvcsbgCJq9+DKezuIsFoI
         y8KcXrwq3QnhO12DB7Pz08MdjjGpNCcBvRYdZN7vXa3V6Qo9ROwdktkIYqjTTNFsOsxD
         C3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1I/46Hp64bGsf9RI8N0SoRZWjt1tyepN5ijb7rBys7g=;
        b=DoKvFdhNEtqQKZb4a/CdZg1AaRIVykdcDXC03IFb9BfkPKU0oJhhmfWT72oMTC7DnK
         rbUt3/dYiDgAf3+543UGPXW5QZK6wBvKbwsnzsqe7W/Bk5I9+Vnk2u+np15/1dDLhZoG
         H+8JLtnG3Hwh3cD9gB2fQ9+RZodWVwuXhcrImsGG+uGKwtBCbE+Lji35/tt4X01d8Zi7
         Wesq2v9XHrnFxpJWbeZ6isq7h43oh9ZHJBUnx19ruDku/eMNYql8PIkkquns0u4O+3Dl
         bvd/5Eps7Qz98lC7TmHL4RH6vz7apRikiGniIXPRbI/6W64r7ZquBQMpVK0fXPeEpXUj
         mUvQ==
X-Gm-Message-State: AOAM531CSnMG+7ZcnoyX96kTGSu+kPUXtwN3m7cu7aMu1SRdBgrqCSZs
        FvdrEwzEaKDdGq2Cr3Vg28k=
X-Google-Smtp-Source: ABdhPJxWb3nrh1sEGcv+v3RvgA+XNkhIvaXGktTTsrR3t9HvZ5jDl25z56GrjLelW82L/vUzE14lTA==
X-Received: by 2002:a17:906:d85:: with SMTP id m5mr23667080eji.55.1622703812550;
        Thu, 03 Jun 2021 00:03:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s10sm1092893ejf.54.2021.06.03.00.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 00:03:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
Date:   Thu, 03 Jun 2021 09:02:49 +0200
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210602001132.459705-1-rybak.a.v@gmail.com>
Message-ID: <87k0nb77lq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, Andrei Rybak wrote:

> Config variables feature.experimental and feature.manyFiles are grouped
> together under "feature.*".  However, this is not easily visible when
> scanning the help page of git-config.
>
> Indent the descriptions of individual feature.* config variables to help
> the reader distinguish this group of variables.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  Documentation/config/feature.txt | 40 +++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
> index cdecd04e5b..2c4dee170b 100644
> --- a/Documentation/config/feature.txt
> +++ b/Documentation/config/feature.txt
> @@ -3,24 +3,26 @@ feature.*::
>  	a group of other config settings. These groups are created by the Git
>  	developer community as recommended defaults and are subject to change.
>  	In particular, new config options may be added with different defaults.
> -
> -feature.experimental::
> -	Enable config options that are new to Git, and are being considered for
> -	future defaults. Config settings included here may be added or removed
> -	with each release, including minor version updates. These settings may
> -	have unintended interactions since they are so new. Please enable this
> -	setting if you are interested in providing feedback on experimental
> -	features. The new default values are:
>  +
> -* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
> -skipping more commits at a time, reducing the number of round trips.
> +--
> +	feature.experimental::
> +		Enable config options that are new to Git, and are being considered for
> +		future defaults. Config settings included here may be added or removed
> +		with each release, including minor version updates. These settings may
> +		have unintended interactions since they are so new. Please enable this
> +		setting if you are interested in providing feedback on experimental
> +		features. The new default values are:
> +	+
> +	* `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
> +	skipping more commits at a time, reducing the number of round trips.
>  
> -feature.manyFiles::
> -	Enable config options that optimize for repos with many files in the
> -	working directory. With many files, commands such as `git status` and
> -	`git checkout` may be slow and these new defaults improve performance:
> -+
> -* `index.version=4` enables path-prefix compression in the index.
> -+
> -* `core.untrackedCache=true` enables the untracked cache. This setting assumes
> -that mtime is working on your machine.
> +	feature.manyFiles::
> +		Enable config options that optimize for repos with many files in the
> +		working directory. With many files, commands such as `git status` and
> +		`git checkout` may be slow and these new defaults improve performance:
> +	+
> +	* `index.version=4` enables path-prefix compression in the index.
> +	+
> +	* `core.untrackedCache=true` enables the untracked cache. This setting assumes
> +	that mtime is working on your machine.
> +--

I don't know if/how this helps readability, but this breaks the
feature.* generation of these variables in config-list.h, see
generate-configlist.sh.

So if you make this change you need to fix that script as well.
