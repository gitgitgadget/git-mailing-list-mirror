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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44037C4743E
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BAF6115B
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 20:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEUGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 16:06:11 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35393 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUGL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 16:06:11 -0400
Received: by mail-ed1-f53.google.com with SMTP id ba2so13489629edb.2
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=R+L/H3K5btoFyApVYqkwZkUhLPlD+LtZ1dc8im/CQnY=;
        b=lxvravb95TnZTL3ahYobyIoU04siW+v55+H5PlX143tgOcDt7+SXVPwAVO4K7PjBEt
         cUvK6qK5NfSpiqC2hugZE/eyKqdy/jl/D3e3ITO4Zin1j8nlVIFnTR+qKvRd/AYipmeL
         8KDw6xk5VcVWLKQbnOpiOBnV8DY4Tm0XAWPi1ET5fMqWEjR1INB1RxXX1PMV4g5FLrLD
         B7OoU8TSiErkjN7oXv3zvbdLqo5UdMYRQlhlv3sh772paA2f+fn+YDJFoc1oR4zs8Kds
         PEBo8yYCTWFmF/FyO6c6sZT8tpOGGbWGBONa67Fx/AXBM4dM9I5ooh42m9tmLzbmDKnN
         Scog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=R+L/H3K5btoFyApVYqkwZkUhLPlD+LtZ1dc8im/CQnY=;
        b=PN6exC/QvOLf5FDnoLkBqpCavx/68TeNeDVzC91rZ2hz5AOpRMZI00tQd0IHl1neaE
         6uKA0PoOgAdasys5VS7dDU6BmWPLp6DbX+r4V9E4xKpx+aRzFIPmWjn3iNhQiaWmt4x5
         XrRSkowYogVZzCgELvBU7Ee56R0VhsxuR98BKkOGhV9cirE7KqqKIgYTv0Ue0mTq1CbL
         4zyKqkeSd5EAWg6y8hckv4JiXiBOqrYFrmDjmFhK8xZ6vhW5VSBaMzinvg+5kVVDS/zU
         YU1lxx0ZWNTQZgEPfDCk+Vnd6XPzvq+OvoJaA5Qk7fbZXtjruWUa7jWVbZHaMUublWOu
         d14A==
X-Gm-Message-State: AOAM533FgHlhx1g07l1XJA510EsYnfA+Aoznua6oiXTCY6LyymKhu/QO
        PjMfVV4s0eLkcK9k7XZPjZs=
X-Google-Smtp-Source: ABdhPJzoI4S9ppuBFAY0tc/y4KEzOKCfmTzqNA5GcqPmW9q96NMa02bj/KT621NnZu+pVgnD6DtvEg==
X-Received: by 2002:a05:6402:1d8e:: with SMTP id dk14mr11883384edb.385.1622923402099;
        Sat, 05 Jun 2021 13:03:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o64sm5247733eda.83.2021.06.05.13.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:03:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
Date:   Sat, 05 Jun 2021 21:56:05 +0200
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
Message-ID: <87fsxw5bav.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 05 2021, Ren=C3=A9 Scharfe wrote:

> The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
> reporting the following error:
>
>    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name
>
> That's because wc's output contains leading spaces and this version of
> dash erroneously expands the variable declaration as "local workers=3D 0",
> i.e. it tries to set the "workers" variable to the empty string and also
> declare a variable named "0", which not a valid name.  This is a known
> dash bug (https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097).
>
> Work around it by passing the command output directly to test instead of
> storing it in a variable first.  While at it, let grep count the number
> of lines instead of piping its output to wc, which is a bit shorter and
> more efficient.
>
> Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Changes since v1:
> - Explain the root cause.
> - Get rid of the local variable "workers".
> - Adjust title accordingly.
> - Still use grep -c, though.
> - Remove input redirection.
>
>  t/lib-parallel-checkout.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index 21f5759732..66350d5207 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -27,8 +27,7 @@ test_checkout_workers () {
>  	rm -f "$trace_file" &&
>  	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
>
> -	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$trac=
e_file" | wc -l) &&
> -	test $workers -eq $expected_workers &&
> +	test $(grep -c "child_start\[..*\] git checkout--worker" "$trace_file")=
 -eq $expected_workers &&
>  	rm "$trace_file"
>  } 8>&2 2>&4

I'd find this thing much clearer if the v2 just narrowly focused on
avoiding the "local", and thus demonstrated the non-portable shell
issue, and perhaps with something like:
=09
	diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
	index fd3303552be..aad6f3e2bf1 100755
	--- a/t/check-non-portable-shell.pl
	+++ b/t/check-non-portable-shell.pl
	@@ -48,6 +48,7 @@ sub err {
	 	/\bexport\s+[A-Za-z0-9_]*=3D/ and err '"export FOO=3Dbar" is not portabl=
e (use FOO=3Dbar && export FOO)';
	 	/^\s*([A-Z0-9_]+=3D(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
	 		err '"FOO=3Dbar shell_func" assignment extends beyond "shell_func"';
	+	/\blocal\b \S+=3D\$\(.*?\|\s*\bwc -l\)/ and err 'whitespace handling in =
local=3D$(... | wc -l) differs in some dash versions';
	 	$line =3D '';
	 	# this resets our $. for each file
	 	close ARGV if eof;


The let's do grep -c while we're at it part of this IMO just adds
confusion while skimming future portability issues with --grep=3Ddash or
--grep=3DPOSIX in the future, and looking at the history in v1 it's just
there because in v1 the root cause wasn't fully understood.

If we're doing a general cleanup of that pattern it would seem to be
better to search-replace this with the rest of them in another commit:

    $ git grep '\$\(grep.*\| wc -l' -- t | wc -l
    27
