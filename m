Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355DAC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 15:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiDHPq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 11:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiDHPqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 11:46:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40433939DF
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 08:44:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a6so18232870ejk.0
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KTiwb66MIUXE0yyHMrRHzPpC7sEvcdvlVAX3Mb1oM48=;
        b=A71luK8Qjivke/7y1qsPdJ/pMIeKKah06di0NN3SgibiEfpG2BojOoQTQtSGB4zej4
         97ALI99r9/+ZIbOzWC4qZpnrBkP3tmTvwCNH9/9xGQTtLGi3kDm+MdpVPn6QwoGL1QMU
         0EKcHd7CqOLfVJKRqZ37BjD7loDtS21O/XBEOucZ2nf6Lw1Nhwkh7ltNtMxiiBOhPksl
         7sMtzzLJ8E+L0+V29YXqGhKck9n0BJ7tgwngk8wIUHSEBg9qj03jbdnYab25ttifIM0a
         N6NthRpHP1xWXsdCg5D82s5l4o+RYQg0WzKSj6IkSsHzrfq2rWn3g1mmbAquJ4e/dZ7k
         R0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KTiwb66MIUXE0yyHMrRHzPpC7sEvcdvlVAX3Mb1oM48=;
        b=CHITctVcbblRYGTc2LtalRru6Q/BbgT2LA1eRy4zoitHkRBEXVKMte17mqd6oZvlMs
         EzkIJzdnPJZKbL8I3Zu3WsEhMyRICM+8BZSPdm//t71rD6B7e4KTdK+iT6g1/8w8lxFf
         sDkrVyFgc3aGTn3mnPk3ciVJ67dfxMgq1ykiPuzlHs1hN3h/EOdcrl5AF9Zlvdl9iNsM
         XFvgXttrz8RpJAu8J347kbKaU7Mf7rQ3AjIwkc3RVT//NeQE+OuS0eBZI8WSFfeHYEkg
         j2ZqMY7QOI9AatubcYfY0O2uhE64ACcsSJiWdHMUTUoHv5PeBZdCCJaHJhOjaDZEO40X
         m+0w==
X-Gm-Message-State: AOAM531Eq55kK3s24EeSyQooaf4i5dfKmeWcs5Dvc8vn0gtoAXgFSWOd
        Drwj0byiyzLtR7l4AZtsUk8=
X-Google-Smtp-Source: ABdhPJzfv+4dlmJSWqdGab5Ah/AQmW5sbmDiFySL07Km/4KTjPQ28hVz3c+caeuegQ7D1sqQxINg6g==
X-Received: by 2002:a17:907:980a:b0:6db:799c:cb44 with SMTP id ji10-20020a170907980a00b006db799ccb44mr18792438ejc.485.1649432644533;
        Fri, 08 Apr 2022 08:44:04 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id da23-20020a056402177700b0041394d8173csm10272626edb.31.2022.04.08.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:44:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncqmJ-001PIV-H0;
        Fri, 08 Apr 2022 17:44:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Raphael <raphael@pdev.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] pretty format: fix colors on %+ placeholder newline
Date:   Fri, 08 Apr 2022 17:14:36 +0200
References: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
 <20220405154529.966434-1-raphael@pdev.de> <xmqq8rshx687.fsf@gitster.g>
 <978e7684-2b91-379b-2fdf-bf0453bff30c@pdev.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <978e7684-2b91-379b-2fdf-bf0453bff30c@pdev.de>
Message-ID: <220408.86ee27bmws.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 08 2022, Raphael wrote:

> On 06.04.22 23:16, Junio C Hamano wrote:
> Good point, let me explain my thinking:
> I first reported this bug without the --graph option where the color
> on the second line is missing as well.
> It was pointed out that this is a problem with the pager "less" and
> not a bug in git:
> https://lore.kernel.org/git/220222.865yp7aj6z.gmgdl@evledraar.gmail.com/
> https://lore.kernel.org/git/6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de/

To be clear I meant there that at least 1/2 of what you were proposing
was really a feature request. I.e. that we pro-actively work around a
detected pager when coloring is still in effect when we hit a \n.

> Using "cat" as a pager produces the correct coloring, but since "less"
> is the default pager I find it useful to follow its conventions:
> Namely that lines are started non-colored and escape sequences must be
> repeated at the beginning of each colored line.
> This is achieved as well by my implementation.

*nod*, do we forsee any fallout from doing that where ANSI escapes now
reach "across" lines for people who were relying on the previous
behavior?

I.e. you're changing how %Cred works, which is a synonym for
%C(red). Perhaps this should be %C(red:across-nl).

>> It also is unclear why the new behaviour to save only one "color
>> escape" is sufficient.  For example, if we used
>>      git log --pretty='format:%h%C(green)%C(reverse)%+d test'
>> --graph
>> wouldn't the effects of these two add up?
>
> You are right, I forgot about this case.
> A naive solution would be to concatenate the format escapes and
> clearing the string when the color is reset.
> Is there already existing code for keeping track of which format
> strings override each other, so that only the required escape
> sequences must be stored/printed?
> Or do you see a different, more elegant solution?

Right now when we emit any color we do e.g.:

    %C(red)<thing>%C(reset)

Where as what you're really asking for, if I'm understandng it
correctly, is:

    %C(red)%C(save)<thing>%C(reset)%C(restore)

Or equivalent, and then you'd like to have the vertical pipe (and
anything else) that's printed at the beginning of a line to do the
"restore". Is that correct?

>> Whatever approach we decide to take to solve this issue, let's have
>> a test case or two added to the test suite to better document the
>> issue.
>
> Sure, I will take a look after solving the core issue.

See "test_decode_color" for numerous examples.

Anyway, just take the above as suggestions. I really haven't looked
deeply enough into this to form any sort of strong opinion.

Except that I really think it would be useful to split up these logical
changes, and have a smal series that:

 1. Tests for the current behavior of both
 2. Does just the "across lines" care, perhaps only if we detect less as a pager?
 3. Does the "don't just reset, but reset back to what was the state one
    before the coloring preceding the reset"

But now as I'm finishing up this E-Mail & testing your patch I was
expecting that this would "keep" the color such that my %s would always
be red, i.e. across the vertical bars:

	git log --oneline --graph --pretty=format:"%s => %Cred%aN <%aE>"

Which it's not, but it is what we do before this patch with:

    git -c core.pager=cat -c color.ui=always log --oneline --pretty=format:"%s => %Cred%aN <%aE>" | head -n 3

But if I do it with your patch it does it for some things (the branch
names) if I put %+d in there:

    git -c color.ui=always log --oneline --pretty=format:"%s => %Cred%aN%+d<%aE>"

But still not the subjects? I'm also confused by:
	
	This is also not a problem of any pager since the --graph option adds a
	colored pipe symbol at the beginning of the line, which makes re-setting
	the color again afterwards necessary.

Since I can't find any way to do this with --graph that'll emit coloring
across the various colored bars it emits with your patch.

Hrm, I partially take that back, it'll do it for the ref names, but not
the subjects, so I suppose it's the same.

:)

Anyway, I think all of the above might make a good case that it would be
really good to do this more incrementally, and with tests before/after
for the various formats/resets etc.

