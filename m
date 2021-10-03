Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9788CC433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B6561A78
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 08:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhJCIKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 04:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhJCIKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 04:10:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEB6C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 01:08:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v18so51040427edc.11
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 01:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uOk+94ffysqLGuyknoKTsuFVj30JholUFdUloFUen7c=;
        b=WHFhZpXICK/JlkDvInKXB4TSNHvT0NcN3+0I5scHn3aNbSFdnuFC7/mrtEGzNYMXoA
         NdQoTWlmibt8ylCg+Jg2KUrJEwuRCnGwHLOyEFfJerA5LoE7NoS8miZcu7vtnow1sh+a
         kXgKXYaywMZ2LwWXiw6X73sjBSZOuNkuK+qazzpG/VEnA8E/Z8JV9rvlLppma+ezSHAX
         wwKg5AnqPmp1tCrPhcbB5ntv2IBBx1bH1vtQhhsT6KwHPjk4f60VFF8oKXRisNrqF/Gv
         6h1lW/Dlb/PaHFmBDjBz1pyCNcII9NJdHGIj41hFB6z5hEEbOvtDOHOLn3rSMLUGjYmL
         VbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uOk+94ffysqLGuyknoKTsuFVj30JholUFdUloFUen7c=;
        b=UWbHUJUfOU1pjS9SEW9VL8sazGkk1fcEkXs0oI5zwts2pErk6khD3y5VDWF8mTU9TM
         KFiEAe3VT8pXSjPXhLhC5kDJXz+kEKXkBsxwDANSXEGrhWXUZlPVwB8AU8Ke8tPtgu5h
         MftvKXNZJPgXnu8vnFtMNpKt2G7S4hWDi0xnFt7mevw2pHTqO/QxvFMTkXg9zk731dc7
         5InlEq8t6G0IJldluA0TXu6Yws+z/9LzEkAYJiY5C+booxWVxDMgszMyicz3kzMfqii5
         iB+o0yf1JavAqAKcTvbQB38XAMTLBr0AvSAzdd+KCGKmk1XfGEgGNkkcUpQEULPxUF7e
         RwMg==
X-Gm-Message-State: AOAM530n8996y7IrEZeYlMH6vCFsMcr8h93ksgSD7puV+1G36Rrc+m+e
        LZWQmGb/0mCTHXy0eKnl3q8=
X-Google-Smtp-Source: ABdhPJyU4sOWttIs8j1aiHjA08pu88kNimtgKD/+cS/+HOCneAaAETjOR7cal5Z/8BsaO3ggyDGb9Q==
X-Received: by 2002:a05:6402:21eb:: with SMTP id ce11mr9365205edb.153.1633248503626;
        Sun, 03 Oct 2021 01:08:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm1sm4970954ejb.38.2021.10.03.01.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 01:08:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] p5311: handle spaces in wc(1) output
Date:   Sun, 03 Oct 2021 10:04:30 +0200
References: <a682e2c8-fecc-906e-0ff6-93de2b311d14@web.de>
 <YVk8SeuDIWwsrdO0@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVk8SeuDIWwsrdO0@nand.local>
Message-ID: <87wnmuo7ii.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 03 2021, Taylor Blau wrote:

> On Sat, Oct 02, 2021 at 10:33:18PM +0200, Ren=C3=A9 Scharfe wrote:
>> Some implementations of wc(1) align their output with leading spaces,
>> even when just a single number is requested, e.g. with "wc -c".  p5311
>> runs all tests successfully on such a platform, but fails to aggregate
>> their results and reports:
>
> This makes sense, and makes me think that wc's platform-specific
> implementations are too tricky to use when we are being picky about
> leading spaces.
>
> In other words, I think that your fix is absolutely correct, but I
> wonder if test_size should be friendlier in what it accepts, and to
> chomp off any leading space. So perhaps something like the below would
> work without any modification to p5311.
>
> --- 8< ---
>
> Subject: [PATCH] t/perf/aggregate.perl: tolerate leading spaces
>
> When using `test_size` with `wc -c`, users on certain platforms can run
> into issues when `wc` emits leading space characters in its output,
> which confuses get_times.
>
> Callers could switch to use test_file_size instead of `wc -c` (the
> former never prints leading space characters, so will always work with
> test_size regardless of platform), but this is an easy enough spot to
> miss that we should teach get_times to be more tolerant of the input it
> accepts.
>
> Teach get_times to do just that by stripping any leading space
> characters.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/perf/aggregate.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 82c0df4553..575d2000cc 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -17,8 +17,8 @@ sub get_times {
>  		my $rt =3D ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
>  		return ($rt, $4, $5);
>  	# size
> -	} elsif ($line =3D~ /^\d+$/) {
> -		return $&;
> +	} elsif ($line =3D~ /^\s*(\d+)$/) {
> +		return $1;
>  	} else {
>  		die "bad input line: $line";
>  	}

This approach seems like a bit of plastering over the real problem. It's
fine to use the output of "wc -l" or "wc -c" in the context of the
shell's whitespace handling. That's why in various places we do:

    test $(wc -l <$file>) =3D 1

Or similar, but *don't* put that $() in double-quotes. I.e. we're
relying on the shell's whitespace semantics.

So isn't it better to just pass this through the shell's own handling
before emitting the data, something like this POC:

    $ stripspace() { var=3D$1; echo $@; }; x=3D$(stripspace "  hi" "  there=
 "); echo "\"$x\""
    "hi there"

Of course fixing it up after that in Perl will work just as well, so I
guess this is just an asthetic preference for having the shell handle
the shell's output issues with what's guaranteed to be shell-portable
solutions... :)
