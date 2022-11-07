Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAEEC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiKGVnb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiKGVna (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:43:30 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A76409
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:43:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u24so19648032edd.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S+RYtSIsMJabcHfZdpOU6Zju35vLS6i8W0mGTwwV6ew=;
        b=Ram3GvBn7lZONMavmX38suRx3Jr/WcSqwS5YUhuvGt7bVycXANxn5jGjiphy+ZWQ6f
         7HktCGVcwZ60CYdQaI0P0ZxBNPsPWhIUudOjERp81Z0nIeV7dpksUn0BBmnmqOgxH2eT
         ztMT2+KNA7jtJ0xlWe/x4y8WejeKtSPFV3Esadj+SRqA/g9b02FK1qsvLolZGGPikLkV
         YEIGC5yAS6k4s/+fiJvtWSieyrAkYnVWEzW1YYZuxr7gkw+R9iXgHSZkRA6XMUcPDNWH
         oM6LMGRuRF88w4MYIbyMJS8Ea4a4W07uilccr5xTFPcWJK9psJ1OxcPGlmXc5oh2a9sV
         eTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+RYtSIsMJabcHfZdpOU6Zju35vLS6i8W0mGTwwV6ew=;
        b=1PPnbY5JDMhf4r+QQBpBdALPmuTcbBrXhdvw1ZiS0ap5ztCelSXyUryGmJIKnz6W5K
         xurTm8+UcCmzJNr+njH7PNf5EnlC88I0bF1NL0ctg6cl9oaKVFod/Fsga8P9kTLIYM3h
         Gm4STa1pq+UerG/LNDQ6OI6mJM5OZaoWrhi06kwku4jOjUW8oadUCUcs7SBNlupQTS/L
         v5x3VKmGzJg74hVYHxqkawO0Q3GD49+SKYDTirYntaucFEwjS4HoQF9IP3vouSdX922x
         +cTMl+EFLZZsaEjx161fCNtaeOk6ar+2J5vP/u/hFlkLae/lKXUKLgP0g5w+FG1uHE7p
         rHpQ==
X-Gm-Message-State: ACrzQf1cdaQl5jpkgUzuwADW7vWMPbjzXOHDLGVQtEnLDXsO5y3zd+c+
        mnHm16emreOlTbcUf1tstzYZPNjhuG49fg==
X-Google-Smtp-Source: AMsMyM4wv0pxWdKQ+U8dDTZfHrag2TB40UWlvGw1ndGGPQ/NLLzkXzd6ICnxkLU3nlshvmKmK6xS7w==
X-Received: by 2002:a05:6402:31f4:b0:461:604d:2607 with SMTP id dy20-20020a05640231f400b00461604d2607mr53682310edb.330.1667857399801;
        Mon, 07 Nov 2022 13:43:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id em3-20020a056402364300b00458824aee80sm4766048edb.38.2022.11.07.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:43:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9tm-000MP4-1p;
        Mon, 07 Nov 2022 22:43:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 05/13] bisect run: keep some of the post-v2.30.0 output
Date:   Mon, 07 Nov 2022 22:40:33 +0100
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <5ba3bafdd48b47320624d0db06f379bc0a4b8d4e.1667667460.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5ba3bafdd48b47320624d0db06f379bc0a4b8d4e.1667667460.git.congdanhqx@gmail.com>
Message-ID: <221107.86k046tp8p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 06 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Preceding commits fixed output and behavior regressions in
> d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
> in C, 2021-09-13), which did not claim to be changing the output of
> "git bisect run".
>
> But some of the output it emitted was subjectively better, so once
> we've asserted that we're back on v2.29.0 behavior, let's change some
> of it back:
>
> - We now quote the arguments again, but omit the first " " when
>   printing the "running" line.
> - Ditto for other cases where we emitted the argument
> - We say "found first bad commit" again, not just "run success"

So, something you refactored here was that there's now a
do_bisect_run(), and:

> -static int do_bisect_run(const char *command, int argc, const char **arg=
v)
> +static int do_bisect_run(const char *command, int argc UNUSED, const cha=
r **argv UNUSED)
>  {
>  	struct child_process cmd =3D CHILD_PROCESS_INIT;
> -	struct strbuf buf =3D STRBUF_INIT;
> +	const char *trimed =3D command;
>=20=20
> -	strbuf_join_argv(&buf, argc, argv, ' ');
> -	printf(_("running %s\n"), buf.buf);
> -	strbuf_release(&buf);
> +	while (*trimed && isspace(*trimed))
> +		trimed++;
> +	printf(_("running %s\n"), trimed);
>  	cmd.use_shell =3D 1;
>  	strvec_push(&cmd.args, command);
>  	return run_command(&cmd);

Instead of trimming with strbuf_ltrim() we're now using this loop, but
in any case, this has had the effect that you're only fixing one of many
of the output changes. We're still adding this leading whitespace to the
other messages we emit.

As note din the preceding commit you've carried here in 03/13 I didn't
have time to come up with tests for those.
