Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C1C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B022250E
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E46dG0kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgHETpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgHETpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 15:45:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176E0C061757
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 12:38:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l64so36001387qkb.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GOob7ntvB+vVU5V80T7wPFORxBd/lDfx26GUzrgSh8=;
        b=E46dG0kSXP4QsemFow001PJu717O6tjRU8F8fF8EQreEq6/Bbb/S3QYjG2RfkUO14c
         hXgSNQyrA9lB/jcojCCOBrdOX5sVXSPsno6AWSDciG7FOauT+j0gej1VgPX03wGCFekV
         B8DBB3EN+bMNAirprUEVHu2/0uQdxid6FcSnbj9EpMW75iSjkIpOFu3NvHbSM4B0R7Dj
         cNh0dSmk6tXrB7UonXrUtLsdqE68P6e4OZ+3/DknXzVCtOnJQsubZJDOWbWKYwbYk9cE
         qAef656Pl9e+85XX1ibo8Xz8C/n9mJu4ka9PVUM3b2fd7HOUBrU8SVnTVXr4Zz0jx8UL
         Jkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GOob7ntvB+vVU5V80T7wPFORxBd/lDfx26GUzrgSh8=;
        b=uUm0Ek7XdKKE70O2NzW39U9kBHwcIrze1LkOS3exv65sJcRkQPVBQVjQNCKGkTB2tL
         EmMznjvDe9mIgUqvRCLCzpX5EEjb4iO5PHoo6CJkq7RM85Ct/YS0fGIo3sE0H2rf9rk7
         PHNnXgPR9iWVhwaq1gU5waBR1uPf/DQk5q+gtJFUjDDseQzd757ImYVlDfUKNZvIejoK
         CR0H7nt02/fy5ulpDIyLoR9KffmkEyDqODcloETfgTRvLJqDqC6cemr0K1/OIWgFuDdr
         UdJ8yGvTxBpLb/32eMxMsjnS4FjK6D6tYao8ZsE5IySSLBG/BqSgPVADSRRWnMXO80bK
         zyLw==
X-Gm-Message-State: AOAM532Rpk0YZPcCwuz8GUbhmzqbMcsfurp61mAzDI3IoGSMcJG6qw/O
        pcbi9OCIEAWIk9AmOFIk+fM=
X-Google-Smtp-Source: ABdhPJy2r5xphn9XjfFKwiDxzUfDJtR19ciGCTY9lvmxsXzQWAjPN54rMMY6lhdAG3Vw8DZ3cB9RRQ==
X-Received: by 2002:a37:4f07:: with SMTP id d7mr5318168qkb.144.1596656279196;
        Wed, 05 Aug 2020 12:37:59 -0700 (PDT)
Received: from generichostname ([2607:9880:4028:16:8d08:d938:7804:129d])
        by smtp.gmail.com with ESMTPSA id h144sm2482416qke.83.2020.08.05.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 12:37:58 -0700 (PDT)
Date:   Wed, 5 Aug 2020 15:37:55 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] t7401: modernize style
Message-ID: <20200805193755.GA2650@generichostname>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-2-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805174921.16000-2-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Wed, Aug 05, 2020 at 11:19:18PM +0530, Shourya Shukla wrote:
> The tests in 't7401-submodule-summary.sh' were written a long time ago
> and have some violations with respect to our CodingGuidelines such as
> incorrect spacing in usages of the redirection operator and absence
> of line feed between statements in case of the '|' (pipe) operator.

I'm not aware of anywhere in CodingGuidelines that says you can't have
the pipe operator on a single line. I assume you're referring to the
part that reads

	If a command sequence joined with && or || or | spans multiple
	lines, put each command on a separate line and put && and || and
	| operators at the end of each line, rather than the start.

Note that says "If a command sequence [...] spans multiple lines", which
doesn't apply in our case.

> Update it to match the CodingGuidelines.
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 9bc841d085..4439fb7c17 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -16,12 +16,13 @@ add_file () {
>  	owd=$(pwd)
>  	cd "$sm"
>  	for name; do
> -		echo "$name" > "$name" &&
> +		echo "$name" >"$name" &&
>  		git add "$name" &&
>  		test_tick &&
>  		git commit -m "Add $name"
>  	done >/dev/null
> -	git rev-parse --verify HEAD | cut -c1-7
> +	git rev-parse --verify HEAD |
> +	cut -c1-7

For the reason above, I disagree with this change as-is. However, one
useful thing that you can do here is breaking the pipe up entirely. We
want to avoid is having a git command in the upstream of a pipe. This is
because the return code of a pipe comes from the last command executed
so if the rev-parse fails, its return code is swallowed and we have no
way of knowing.

You could break the pipe up by storing the output of the rev-parse in an
intermediate file and then have cut read from that file.
