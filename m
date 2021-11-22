Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390F0C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbhKVRTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhKVRTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:19:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE4C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:16:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so80295637edc.6
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ql6UCPt9W41W3Iuim/1cocPwK94HP9dmeljZDd+FSTc=;
        b=ZRYXh/mqYv/6rtm+koNGLVqPRx6X/Oq6Ktg+cg29DyvJbj0LhYuBpSCRTA6n62t5L7
         F6mgkkU6rm0M2DH3daeYs6l7AVGTTAYfJVgNCDDAnP6hcv9N4kPPK0GLLLPsdBLwIXhD
         Y/CC0hDiGjnmFH78k/ToXE97AMJ8lS0VzWfXq48M1pr+WnxLr9Rq4tnzMUvqCVX2EsxD
         8+nebPe6oWTYLKGntnYWnlhiU+ymB1T+Fezgno4AI9NKzMSrvyCenm+t+ffuTPi9dADu
         rmRqAm4jN3bDTJ0HyyiumUpegaXG4tD94TDPLdUU8mEOA2ePFb/8foTIsJtdycmmVHZN
         PDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ql6UCPt9W41W3Iuim/1cocPwK94HP9dmeljZDd+FSTc=;
        b=osR8mvmVDmKgk8ml8KgYdjHuF4rLcBQSLgkjMPpG1koe/9fWt5GoytPLPjiLUhrs+R
         9d73ro2meWOyVuXKBS3Gvjp+zhi4Yi+rhTFiIIU9JibIF6nXW7t2GMtzR55CNjpVY6C6
         rHH0MSXnXcI7aCt6LC+75BnScBTBB6mBg6gPO892z6RBdJxOUFAAVKVzZiDFfv6zs2dk
         0rKtbOO3eeYU/GZJyCycdK19afkuFYyq3Sdpvq99mC1Nr04y/LJWlKNc4pylqLXkrgVq
         zWMVEsT4qPzCaZd/5zfnXBHZ30r/+n6meO1kT+6Ye18tvN96l1Nuz68b1eSyC3xtN5U+
         IZwg==
X-Gm-Message-State: AOAM530tj7ECm81ibI3WxJGqD2b3NxLs0yVITgJqkGwY3JydboN4Zcq1
        LG9G1OCLlyYBhMRM4wUOXrI=
X-Google-Smtp-Source: ABdhPJyZtsJ6R34OBFSAOGXRBk7Pp252z6J4xdTRxV8do/qp8fRrX0uHABuch+DyRFUW6s8KVQSYKA==
X-Received: by 2002:a17:906:9459:: with SMTP id z25mr44414200ejx.331.1637601361126;
        Mon, 22 Nov 2021 09:16:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sc27sm4196058ejc.125.2021.11.22.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:16:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpCvA-0018VM-3d;
        Mon, 22 Nov 2021 18:16:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
Date:   Mon, 22 Nov 2021 18:10:47 +0100
References: <20211120194048.12125-1-ematsumiya@suse.de>
 <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net> <xmqqfsrplz3z.fsf@gitster.g>
 <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
 <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
 <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
Message-ID: <211122.861r38yuun.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Enzo Matsumiya wrote:

> On 11/22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>I think an alternate direction of simply getting rid of "argv" is better
>>in this case, and I've just submitted a topic to do that:
>>https://lore.kernel.org/git/cover-0.5-00000000000-20211122T153605Z-avarab=
@gmail.com/
>
> Well, this is my first interaction with git's source, so I can't say for
> sure, but that solution seems more complete indeed.
>
>>It still leave us with this oddity:
>>
>>    $ ~/g/git/git -c pager.show=3DINVALID_PAGER show  HEAD
>>    error: cannot run INVALID_PAGER: No such file or directory
>>    error: cannot run INVALID_PAGER: No such file or directory
>>
>>But that was the case before that topic (if we hadn't
>>crashed/segfaulted), and with your proposed change here.
>
> Yes, I did find it weird on my initial debugging, but didn't care at
> first.
>
> Now, looking again, it's because git (main command) have a higher
> precedence on pager preference, so it tries to setup/run the pager
> before running subcommands.
>
> An issue I've hit now is, if we don't want to fallback to any other
> setting, this works:
>
> diff --git a/pager.c b/pager.c
> index d93304527d62..b528bbd644b5 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -110,6 +110,14 @@ void setup_pager(void)
>         if (!pager)
>                 return;
>
> +       /*
> +        * There's already a pager set up and running.
> +        * Regardless if it was successful or not, we shouldn't try runni=
ng
> +        * it again.
> +        */
> +       if (pager_in_use())
> +               return;
> +
>         /*
>          * After we redirect standard output, we won't be able to use an =
ioctl
>          * to get the terminal size. Let's grab it now, and then set $COL=
UMNS
>
> However, IMHO it would make sense to try pager.<subcommand> if a
> previous attempt failed, e.g.:
>
> $ git config pager.show my-valid-pager
> $ GIT_PAGER=3Dinvalid-pager git -p show
>
> So this will first try invalid-pager, fail, and not try again, with the
> above patch. As a user, I would expect that my-valid-pager to be run in
> case invalid-pager failed.
>
> What do you think?

I think a better approach is to just die early and not fallback if the
user's pager setting is broken. I.e. let's not second-guess their
explicit configuration, trust it, and if it doesn't work die() or
error().

We do fallback on emitting to stdout, so perhaps there's a reason to do
more exhaustive fallbacks here, I'm not really sure about the above.

The use of pager_in_use() in the above patch smells iffy though, we're
able to do that because we did the setenv() of GIT_PAGER_IN_USE=3Dtrue.

We then use that to check if we set it up ourselves and skip setting it
up, but any other program invoked by us will be fooled by
GIT_PAGER_IN_USE=3Dtrue. Maybe that's intentional, but won't we then
expect a working pager in some cases (maybe not)...

It seems non-obvious at best, perhaps we should push a list of failed
pagers, or just the one failed one if we're not doing fallbacks..

Presumably we can invoke N git <something>, where those <something> have
different pager.<something> config...



