Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E00C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 14:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DEE611CA
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 14:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFEOeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFEOd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 10:33:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A2C061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 07:32:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n24so1229548lji.2
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WoHNCSV3TFuGDrvJ4yUNQfWaTHZIVVAkVbwN5dcn4Ns=;
        b=CsfXP8fHUzus0i39ibgKqCdm+p7fSxe46BQMeTTGCseHtQbaXQgqPZOWDf+4GnMDjC
         IYkp11qPuQBlRnqtNQLhX7gDFwDmb7ScV1f72o6zwJ+I+P5+N79K5bwttNVaXKlGvbZv
         3vJvET7ZLlqbBHdCs91X4iEE9w8RgRRN4OTyJ3sp1gb7F7o++Ch0FE8iNCfmoFKzaNjF
         vop6OUt+Ede3VbnczTDNZUey62j2zIwMs2TUiJFMFz4Pm2izmTdZEbDql8WDw2anRHRG
         bEj7XDWxP3HVOK1ZLj5dfCxPSqA4lCCpbYD7mgt0QpW17J/89G6U3Mq7Ok9y0TWPVFC7
         JEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoHNCSV3TFuGDrvJ4yUNQfWaTHZIVVAkVbwN5dcn4Ns=;
        b=HFY0f/GzbeiWwOFwcJZ32JwvfZNTpo3Be8yZPkW9LtrFFnFN6fKfRDKAydA3XMz1io
         svBUDzfObcVMSdgvgKKYY7B8o5ow9zkOrSvewCIamI/UzWJZFBT6GYkYtu4R2GIxKnsM
         ink0rpzmwjUo0xf7rXGyccNDjL6Gtv6UfRjf41rXT3sn9C8koxCmuYujw2BsOmbFPASJ
         +bnve+0jMBAAFLGja53WCiIO3tZerHSd/sPaATdOQ1a1JYXSzx2mlXiBg3b1nWVZ6/tT
         2LEs4H3C669Z6aACFlEk+x7hhP6XjJ9VLfKLZivcAdONZV+1x0bu2foPKEiT9KiUIDlB
         FpVA==
X-Gm-Message-State: AOAM532vrsEpk4Gyu/mwvcPIqJ92uap0vCcp2ybXuoJY8m2p879Sgt30
        zVXKXyNwLDD8bLL36wySxnH0Kh2RUtg0i8o+bq+zUA==
X-Google-Smtp-Source: ABdhPJxh7HgXWD3dZvsSTmljX4/dQ3YSDYuYtGebgm2YDFQGX0nQ7kNiVlWA7OD9aJ9247Uh59TCKfBBcwTOnYXVSkU=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr7510981ljg.248.1622903529404;
 Sat, 05 Jun 2021 07:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
In-Reply-To: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 5 Jun 2021 11:31:58 -0300
Message-ID: <CAHd-oW7f0rfRaTyvJJMt7uNiLS4F9c=D3oKYc5v+unzxPPxjCw@mail.gmail.com>
Subject: Re: [PATCH] parallel-checkout: use grep -c to count workers in tests
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 5, 2021 at 9:27 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
> reporting the following error:
>
>    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name

That's interesting. It seems that dash is trying to use wc's output
(in this case "0") as a local variable name which, of course, is not
valid.

This reply [1] to this bug report [2] mentions that dash expands a
local assignment like the following:

    x=3D"1 2 3"
    local y=3D$x ---expands-to---> local y=3D1 2 3

So, in this case, dash thinks we are trying to declare three local
variables, y, 2, and 3, which is an error. In bash, the above commands
would result in $y getting the value "1 2 3", even though we didn't
quote $x in the assignment. (BTW, the reply mentions that quoting the
right side of the assignment should make this work in dash as well.)

I wonder if that's what's happening here. Maybe "wc -l" is outputting
a space before the number, and that makes dash parse this line as
something like `local workers=3D"" 0=3D"" `? If that's really the case (I
can't confirm because the bug seems to have been fixed in the dash
version I have), maybe we could mention that in the commit message.

[1]: https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097/comments/6
[2]: https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097

> This seems to be caused by a bug in dash, which doesn't like the pipe
> into wc for some reason.  We can work around it and make the test
> slightly shorter and faster by having grep do the counting, though, so
> let's do that.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Reduced test case for underlying dash issue:
>
>    $ dash -c 'foo () { local bar=3D$(echo baz | wc); }; foo'
>    dash: 1: local: 1: bad variable name
>
>
> The pipe is not even required to trigger the issue:
>
>    $ dash -c 'foo () { local bar=3D$(wc /dev/null); }; foo'
>    dash: 1: local: 0: bad variable name
>
> Turning wc into a function calms the shell:
>
>    $ dash -c 'foo () { local bar=3D$(echo baz | wc); }; wc () { :; }; foo=
'
>
> Setting a global variable also works fine:
>
>    $ dash -c 'foo () { bar=3D$(echo baz | wc); }; foo'
>
>  t/lib-parallel-checkout.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index 21f5759732..145276eb4c 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -27,7 +27,7 @@ test_checkout_workers () {
>         rm -f "$trace_file" &&
>         GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
>
> -       local workers=3D$(grep "child_start\[..*\] git checkout--worker" =
"$trace_file" | wc -l) &&
> +       local workers=3D$(grep -c "child_start\[..*\] git checkout--worke=
r" <"$trace_file") &&

Nice, and the result is both cleaner and more efficient :) Just one
minor nit: I think we could drop the redirection as grep can take the
file name as an argument.

>         test $workers -eq $expected_workers &&
>         rm "$trace_file"
>  } 8>&2 2>&4
> --
> 2.31.1
