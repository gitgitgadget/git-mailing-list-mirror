Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438A3C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163CC61406
	for <git@archiver.kernel.org>; Mon, 24 May 2021 16:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEXQl7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 24 May 2021 12:41:59 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39720 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhEXQl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 12:41:58 -0400
Received: by mail-ed1-f48.google.com with SMTP id h16so32699174edr.6
        for <git@vger.kernel.org>; Mon, 24 May 2021 09:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jE9kQPvuLNAc+0S+yZb8IxR/DUvUqtTyi8Os1ZG9KYI=;
        b=EXOvEDnqgFB4vpdT0WdA2B46ZCtCXrPNvBYh1ylYIyxNuImEX3CJC7YJ02SJGHdNVM
         IwDJnFafNUUd4SrQkK6olNZpwD44qqBFpwuPIi4sF6E+EoUFVdrzOb9O0DQbzGHAREnf
         Ktda8ODyOXQ1IPN9DkvhmRKXjro3+WUltXNDSTVaymA5AXA1ZmZA85zb6Wfc65aa4Lj5
         SX/7mWPQM/uvpO4w/zwyxpLeZxw5+3pddeYl9LIG4zL5cP+/Gpw8os4N+FX+LhvlR+sG
         ZjY9wQIO1tbdrtKV3XRZhOGLD09b+EIu4axa1hgywTt++evHrCAlIMjXbBMHa28ZRILs
         wiRQ==
X-Gm-Message-State: AOAM533AoQQHHggIOVq/a0Hx/uB+d6wbgZUITB5wI5/bQe/dImCAtsf2
        +qfxXRuIKfOyhqT89elSQmKmV+0IW1/9iW6ieGGEgzcXCKG2/w==
X-Google-Smtp-Source: ABdhPJxfOju9PES+uv/YLQmgiuLY4FgNQM6pFYZw85U8Ywe7TzE8WzrTmXVRWcUb4ZOdTwY0+baTYUFp9Eh8tZhOP3M=
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr26471144edr.181.1621874399684;
 Mon, 24 May 2021 09:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210520221359.75615-1-lenaic@lhuard.fr> <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-5-lenaic@lhuard.fr> <87r1hwo3e3.fsf@evledraar.gmail.com>
In-Reply-To: <87r1hwo3e3.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 24 May 2021 12:39:48 -0400
Message-ID: <CAPig+cQSbHM1ph+hg2dkR3fBoxF2pxAh+xYe8to4yGfXOpMLMA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] maintenance: add support for systemd timers on Linux
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 6:03 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, May 24 2021, Lénaïc Huard wrote:
> > +test_expect_success 'start and stop Linux/systemd maintenance' '
> > +     write_script print-args <<-\EOF &&
> > +     printf "%s\n" "$*" >>args
> > +     EOF
> > +
> > +     XDG_CONFIG_HOME="$PWD" &&
> > +     export XDG_CONFIG_HOME &&
> > +     rm -f args &&
>
> If you're going to care about cleanup here, and personally I wouldn't,
> just call that "args" by the name "expect" instead (as is convention)
> and clobber it every time...
>
> Anyway, a better way to do the cleanup is:
>
>     test_when_finished "rm args" &&
>     echo this is the first time you write the file >args
>     [the rest of the test code]
>
> Then you don't need to re-rm it.

A few comments:

This is following an already-established pattern in this test script,
so it would be unfortunate and out of place to change only these
newly-added tests, thus it's probably better to follow the existing
idiom as is done here. If someone wants to rework all this, it can be
done later script-wide and need not be part of this series nor done by
Lénaïc.

The name `args` is reflective of what is being captured here;
specifically, it captures the arguments passed to the system-specific
scheduler command. It's also the name used by all the other tests, so
it's probably fine as-is.

The git-maintenance command is invoked multiple times in a single test
and `args` needs to be removed before each invocation since its
content is accumulated via `>>` within the `print-args` script, which
is necessary since that script may be run multiple times by a single
git-maintenance command. So, `rm -f args` is not mere cleanup here;
it's an integral part of the test, thus test_when_finished() would be
incorrect.
