Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C1DC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3795F61185
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhFPLqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhFPLqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 07:46:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0FC06175F
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 04:44:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ho18so3383341ejc.8
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dzg7qphj7Cu1BymKYoFxAcZbc52v+6azJYkFTvGED00=;
        b=W3/5HHGwFLsQeEZB5FY8zG4zixtnQrtwfBrLRM+Qw/bDTiTJrFiXMt94qeVfhHAc64
         Lzx5kKWgpXxz7yOl/N1Inp+HkwxDxpOAJxprdi0uN3sMwVdLCJ8mI0noVM1d+OZ6qWd5
         w4zMP4sIbQXszwP9Hk6VlFIUJGFUcHETc4va1FOxCTKQ1F89iJlyYKlE77HEQr/iwqPE
         c3itNZ8KCA52BYR3CSHEWJea/72sRfxiBMs1hK2NDCu2BGD58igjewbKnr0XG2f1xmCR
         g/5n9q3qV0MF2M/RKkXpoQrSi4op/i+91uywI3F43/3cgfMdUzIS6UbzAm6hbL3nmDRC
         ZK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dzg7qphj7Cu1BymKYoFxAcZbc52v+6azJYkFTvGED00=;
        b=aPGsSl5iLVxrvSE+5fUCxI11F2jQ2dihyJz/tpWATrGoqLmY6dw697jXXveAP0cE0j
         J3V4xDuyf/HsZF8ari2m+jVPCfm0q2Jv5ljBUxnmhzrvHdN80wKSotSsBFDGwd21ZL9j
         ZmZ+SNdUuTdtbOllMSla3VX9+GI3KgTwvUFSJ5n9/4Xqu+mBwQVnt4uNm0ZI5godHRq2
         krBP7YKRzQP61cIENE3hnsOrKk/Cf69l1icCZW2r5eBGPEgZISmoaOPU5RK0oQ6j3vP5
         u3R5JN694BjcMYG5IAhr7KX8yjG6WKU4MAlvXSkWNdWXMJrm87w+49c4WUrgyLnbdBRG
         JVog==
X-Gm-Message-State: AOAM5306Q6TAa9C6XR4dQuEyDA60NzVwuQCyBcz/mxavZNNU+HfnRL61
        W1NcgHFWBRph4tcZ0M0O64g=
X-Google-Smtp-Source: ABdhPJxQHKCZKtz0vrlNg82A9GmchFWTl1s6LFxA+kL7JekFn8oCjKi585ow5hUoiA3076DU/5SEmg==
X-Received: by 2002:a17:907:1c9e:: with SMTP id nb30mr4910511ejc.0.1623843877599;
        Wed, 16 Jun 2021 04:44:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bx17sm1271461ejc.94.2021.06.16.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:44:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Date:   Wed, 16 Jun 2021 13:38:55 +0200
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
 <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net> <xmqqeed2p3jx.fsf@gitster.g>
 <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
Message-ID: <87k0muxcd7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Jeff King wrote:

> On Wed, Jun 16, 2021 at 06:22:10PM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > ... Still, I kind of like the "set -f" version because it doesn't need
>> > the extra directory which could cause problems with "ls-files -o", etc,
>> > as you mentioned. You could also create the empty directory on the fly,
>> > though if "set -f" works portably, that seems less complicated to me.
>>=20
>> FWIW, I share that.
>
> Here it is with some cosmetic cleanups and a commit message. I don't
> mean to preempt further discussion if =C3=86var prefers another route, bu=
t I
> want to make sure we didn't stall out.

I mildly prefer mine as noted in
https://lore.kernel.org/git/87pmwmxd6f.fsf@evledraar.gmail.com/; but I'd
mainly prefer just to fix the immediate breakage on master, so whatever
variant of reverting, taking yours or mine Junio prefers I'm fine with.

Just inline comments on the patch:

> @@ -732,14 +732,24 @@ match_pattern_list () {
>  	arg=3D"$1"
>  	shift
>  	test -z "$*" && return 1
> -	for pattern_
> -	do
> -		case "$arg" in
> -		$pattern_)
> -			return 0
> -		esac
> -	done
> -	return 1
> +	# We need to use "$*" to get field-splitting, but we want to
> +	# disable globbing, since we are matching against an arbitrary
> +	# $arg, not what's in the filesystem. Using "set -f" accomplishes
> +	# that, but we must do it in a subshell to avoid impacting the
> +	# rest of the script. The exit value of the subshell becomes
> +	# the function's return value.
> +	(
> +		set -f
> +		for pattern_ in $*
> +		do
> +			case "$arg" in
> +			$pattern_)
> +				exit 0
> +				;;
> +			esac
> +		done
> +		exit 1
> +	)
>  }

Why not just start with a ret=3D1, set ret=3D0 if we have a match and break
from the loop, and then do a "set +f" afterwards? I.e. is there an
actual need for the subshell here.

I'm mildly paranoid about a new "set -<flag>" in the codebase for vague
fears of portability (as noted in my linked message), but whatever shell
supports "set -<flag>" surely supports the inverse with "set +<flag>",
no?
