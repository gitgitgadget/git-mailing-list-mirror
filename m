Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFDC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 11:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhLTL7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 06:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLTL7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 06:59:49 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE5C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 03:59:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w16so8802364edc.11
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 03:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6uHBtYrWpt8IpGfV5W0O1L/osA7srYNQ78u30Dl/B8s=;
        b=nWF9sBJfGG9id8Ids93g5moq+v48dIeJbgbpdEymc4cvo/+l1PraB2DYlqUo+9RIoi
         zCgR3yf74qBa8QtnC2CCBRielNxDYg7cL82JZl8Cxa3HMMEZnbcoHWrGPBK57A0zTadX
         UrQT6QduIl96d5jyneRE10l6vC+X62MgoCKSoRqyppikExPhJkffCdfiuCFm3KqfcGtV
         Pxt85H91iuefRoqQKo52iF7Q3jkxKD7G4z2oPWO0DqUSM8A7KH7fjwpf4vuVIQ6p1hJj
         tqDMx0BWwEC39+JCciGIfrLnNoXM2aqWPZSY18mdTRboq3IfmxUnulyPs16LxrW723ZX
         sfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6uHBtYrWpt8IpGfV5W0O1L/osA7srYNQ78u30Dl/B8s=;
        b=cCjUtuhtqDKG2i2QgJYxRARXG25dLtkaIhFh7Dks/zJrIYJ8HbfwnlCld0fSst5CpS
         1qG6hZPVZVfBbNBnRQkble90ZA7ric/KwoQUsBckqW+f8rImT+GXgttxNdPhGhf5LamA
         H/HvMSlk6FfbZI5DR934ymyIVl7mVfD5Cdo6gVvGNBHsoqHjpCi8AnxBdEoy5ZEy5yi4
         cg4ygAr3Llh4rmJTGbD64uJglGFMzHMWqcQzULANMpHTGAZLsC7H6OpWkUUijmkHr8ZV
         ElPzatmu9xYKoX+adfJh7iaisCM1bGbG0jGRuO4sHeNkOYuvXemF/IOCrs62WLU213hi
         dXYQ==
X-Gm-Message-State: AOAM531bTL2j8IE7iYIGZIIHuAOs1ehXpQZObAaGhXkC94nULBffw1Ps
        cIJn+Dqb80ceEPMJHzN1HHY=
X-Google-Smtp-Source: ABdhPJxjhIoQcV4bxr65uY6ETESZEZGXxvkjvR/rcSTR0f27jt85oEuJ/1ADC07plV68MZ0xV5gVwQ==
X-Received: by 2002:a05:6402:40c7:: with SMTP id z7mr15435128edb.255.1640001587488;
        Mon, 20 Dec 2021 03:59:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm6902531edd.28.2021.12.20.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:59:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzHKU-000Nlh-H0;
        Mon, 20 Dec 2021 12:59:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] t/perf: do not run tests in user's $SHELL
Date:   Mon, 20 Dec 2021 12:56:58 +0100
References: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <f22f978a-26eb-8fe9-cab4-3fd60df69635@web.de>
Message-ID: <211220.86bl1bwkp9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Ren=C3=A9 Scharfe wrote:

> From: Johannes Altmanninger <aclopte@gmail.com>
>
> The environment variable $SHELL is usually set to the user's
> interactive shell. We never use that shell for build and test scripts
> because it might not be a POSIX shell.
>
> Perf tests are run inside $SHELL via a wrapper defined in
> t/perf/perf-lib.sh. Use $TEST_SHELL_PATH like elsewhere.
>
> Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> Acked-by: Jeff King <peff@peff.net>
> ---
> Original submission:
> https://lore.kernel.org/git/20211007184716.1187677-1-aclopte@gmail.com/

This LGTM & I think it could be picked up as-is.

Just a nit in case af a re-roll. I think it would help to summarize the
history a bit per
https://lore.kernel.org/git/YV+1%2F0b5bN3o6qRG@coredump.intra.peff.net/. I.=
e. something
like:
=20=20=20=20
    In 342e9ef2d9e (Introduce a performance testing framework, 2012-02-17)
    when t/perf was introduced the TEST_SHELL_PATH was not part of
    GIT-BUILD-OPTIONS. That was added later in 3f824e91c84 (t/Makefile:
    introduce TEST_SHELL_PATH, 2017-12-08). We will always have that
    available in perf-lib.sh since test-lib.sh will load it before this code
    is executed.

>  t/perf/perf-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 780a7402d5..407252bac7 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -161,7 +161,7 @@ test_run_perf_ () {
>  	test_cleanup=3D:
>  	test_export_=3D"test_cleanup"
>  	export test_cleanup test_export_
> -	"$GTIME" -f "%E %U %S" -o test_time.$i "$SHELL" -c '
> +	"$GTIME" -f "%E %U %S" -o test_time.$i "$TEST_SHELL_PATH" -c '
>  . '"$TEST_DIRECTORY"/test-lib-functions.sh'
>  test_export () {
>  	test_export_=3D"$test_export_ $*"

