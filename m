Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C6F1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 12:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeJZVVI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 17:21:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36501 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeJZVVI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 17:21:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id x2-v6so1173062eds.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LaRj/zFUaC8Ao+Mmms13zJVQ1Ns0SbfrD9WoBinGVYQ=;
        b=g5YrMFG+3IqAwfiKhL39PVTou12ze9ikhnc8ZJdbbrPUTRPqNJhp1qaYiLHPPu9G+G
         BR09ejKQ1wsKyQFdTMxvjC6oT4ugLZiN8rgbOd8VYdW3JPYLn+c2ZDyH4PolPQSe0oIa
         frwqZq2B13AxFHUObu/bBRXt/hHjUB4pXKQ5vFApdj8+KTKjheoa/edIGHxoIQ8tgizJ
         TRe4Shz01tJ2W2G7dN2hNA6GSUC9jIPNWAO1ruGmEX63N+V/NLWrjENNyY5uJtRGNL4e
         zCTefrrK9HRmNp3LTGSb4CqUGAAnC5uFRLPwsucut3rh+tkp/SG/55jzqLK5IWnLvUFd
         tv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LaRj/zFUaC8Ao+Mmms13zJVQ1Ns0SbfrD9WoBinGVYQ=;
        b=gutzf4awcu1NqA+g7xCSUWB7n61LCrjAwfvnmDJUAOsHBqshs00ytnsEYN1bRspr65
         N6gWMGoi/3+DFwwXL2ypvWh7e+/Xq4LTHOnjp9Y6ZBEgfuTfOPiG0EZFoYvoP1bBWs+m
         KUhTB9i3g3pWhkxYCYM6PcLAprrNrGYGlR8Ln34UO2MOU2V+vhgBOe40Fon8hCkcerAJ
         DsF+yQoFqaBe/arQmO/54au9nogKXcV71URdcCn8sIyb7utHAok+/aJ4KeIQUuPmjpKe
         E0Z9aKXb7WIPKYONFA3urLwUZAml7kfZH284Dob/WCPYPdJ4cESdxZ5nxdz13q5oJXmZ
         QxvA==
X-Gm-Message-State: AGRZ1gLc1jF6pmcSvdAwrdhI1RM09CF7oq/IpW7mPxwp7qJRvR2NU0kA
        l9j1O7FjD/cdCvqU6Zvn+VJOIbnO
X-Google-Smtp-Source: AJdET5cd6QrHoA51Ksk8CfoPe1XoZ/4Od/zBAEaUMO3EAWAhDvxBpFds5JTFIPumyXDLHDiNiE5tRQ==
X-Received: by 2002:a50:8f23:: with SMTP id 32-v6mr2896537edy.158.1540557847635;
        Fri, 26 Oct 2018 05:44:07 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id r55-v6sm4814490edd.80.2018.10.26.05.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 05:44:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com>
        <20181018225739.28857-1-avarab@gmail.com>
        <20181019220755.GA31563@sigill.intra.peff.net>
        <87ftx0dg4r.fsf@evledraar.gmail.com>
        <20181020185852.GA6234@sigill.intra.peff.net>
        <20181026083905.GA1705@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181026083905.GA1705@sigill.intra.peff.net>
Date:   Fri, 26 Oct 2018 14:44:05 +0200
Message-ID: <87sh0slvxm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 26 2018, Jeff King wrote:

> On Sat, Oct 20, 2018 at 02:58:53PM -0400, Jeff King wrote:
>
>> On Sat, Oct 20, 2018 at 01:14:28PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> > > I'd guess this sort of thing is pretty rare. But I wonder if we're
>> > > crossing the line of trying to assume too much about what the user's
>> > > arbitrary code does.
>> > >
>> > > A simple depth counter can limit the fork bomb, and with a high enough
>> > > depth would be unlikely to trigger a false positive. It could also
>> > > protect non-aliases more reasonably, too (e.g., if you have a 1000-deep
>> > > git process hierarchy, there's a good chance you've found an infinite
>> > > loop in git itself).
>> >
>> > I don't think this edge case you're describing is very plausible, and I
>> > doubt it exists in the wild.
>> >
>> > But going by my personal incredulity and a git release breaking code in
>> > the wild would suck, so agree that I need to re-roll this to anticipate
>> > that.
>>
>> I agree it's probably quite rare, if it exists at all. But I also wonder
>> how important looping alias protection is. It's also rare, and the
>> outcome is usually "gee, I wonder why this is taking so long? ^C".
>
> Hmph. So I was speaking before purely hypothetically, but now that your
> patch is in 'next', it is part of my daily build. And indeed, I hit a
> false positive within 5 minutes of building it. ;)
>
> I have an alias like this:
>
>   $ git help dotgit
>   'dotgit' is aliased to '!git rev-parse 2>/dev/null || cd ~/compile/git; git'
>
> The idea being that I can run "git dotgit foo" to run "git foo" in the
> current directory, or if it is not a git repository, in my checkout of
> git.git.
>
> I use it in two ways:
>
>   - some of my aliases know about it themselves. So I have an alias "ll"
>     that does:
>
>       $ git help ll
>       'll' is aliased to '!git dotgit --no-pager log --no-walk=unsorted --format='%h (%s, %ad)' --date=short'
>
>     with the idea being to produce a nice annotation for a commit id.
>     Using "git dotgit" there lets me just run it from any directory,
>     since 99% of the time I am working on git.git anyway.
>
>   - I have a vim command defined:
>
>       command! -nargs=* Git :call MaybeInlineCommand("git dotgit <args>")
>
>     so I can do ":Git foo" inside vim and it uses either the current
>     repo (e.g., if I'm writing a commit message) or git.git (e.g., if
>     I'm writing an email and didn't start in the repo).
>
> So of course the alias expansion is something like (in older versions of
> Git):
>
>   1. "git dotgit ll" runs the dotgit alias, which sees that we need to go
>      to the git.git checkout
>
>   2. that runs "git ll"
>
>   3. that runs "git dotgit log"; this second dotgit invocation sees we're
>      already in a repository and is a noop
>
>   4. git-log runs
>
> With your patch, step 3 complains:
>
>   $ git dotgit ll
>   fatal: alias loop detected: expansion of 'dotgit' does not terminate:
>   dotgit <==
>   ll ==>
>
> So I would really prefer a depth counter that can be set sufficiently
> high to make this case work. ;)
>
>
> As an aside, I got to experience this error message as an unsuspecting
> user would. Unfortunately the output was not super helpful for figuring
> out the cause. I scratched my head for a while before remembering that
> "ll" uses "dotgit" explicitly (which was quite apparent when running
> GIT_TRACE=1, or "git help ll"). I think showing the alias definitions in
> the loop output would have made it much more obvious (if perhaps a bit
> uglier).  E.g., something like:
>
>   fatal: alias loop...
>   ==> dotgit is aliased to '!git rev-parse ...'
>   <== ll is aliased to '!git dotgit ...'
>
> -Peff

Yikes.

Junio: After your previous "What's cooking" in
<xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com> I sent
<87ftx0dg4r.fsf@evledraar.gmail.com>, but should have just replied to
"What's cooking".

I.e. I think this topic should just be ejected, I'll try to submit a
re-roll, but don't know if I have time in the next few days.

Can you please queue a "git revert" of it (or rewind next, but not sure
if you want to do that...).
