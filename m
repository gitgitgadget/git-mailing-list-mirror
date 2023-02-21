Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FC1C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBUW2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBUW2C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:28:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44375B740
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:28:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ec43so22644384edb.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=43wJhQ7UhlbsjDjGYQws9YHTpFRLkIg0lWHSqLPMsmo=;
        b=OArMXQvXyVnD5DMi+8l9ftxEIbZ3y6VA/fjD8hPA8Roxjf+W9QjAMeEXs30ineQDUU
         alqVIcB0BiMG3aZwjZckqaBrmTNyKHSzpczrpCj8Ze7dKihe8VAR3o/P2YSIcbQUJiH9
         w6FfK7IazWChifpXWSh9n38fhx6bpf7Cp/VeWAp6J1dpsNtdznO9MM/DB4bxJKfcTcg7
         j9OQZE8owrrpOsJYndwqtEk45hDr/Pq1x3obALCkQ61Z1kUedo1Q++KxczAAYJgtKL4h
         5++2Cc7eoazPbmpq6WuInlA3ghe+nJpyGuyf+QEwCNKWVMDgsE/LSnNKSljTlNyTsyol
         WEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43wJhQ7UhlbsjDjGYQws9YHTpFRLkIg0lWHSqLPMsmo=;
        b=CEmY4NRVT6vEXfESMG6fIyYvPb8Owj23B60/L/Ez0/uZEOhztk1+EWAfi2RCrII1lg
         QNkw6dK2WGh3KFh/RFRlYv2WMzk1oVIjOlQ9sGBlIbuiXVrT9mOnsYRFB4aC8IQWlXrW
         NZ/zxGekNPJpMI/ACn3unlffkTlf4weXsLrnjC7/dfV7rB29KVVvi5KnRXv51hfNnwlZ
         ZG8UrC4OpxAiKCIQEbXJ/9XYtmJaRuLWgv7xWF7VGJatISu4uYxEAqNJk9zLS/s0xP3W
         HWx0Nrt5bBdXFsjJ2qJSW+YGudcZAOLLdERmAH5S/L8PLe22SQuF3XW7rzUcwXARSifF
         pAkQ==
X-Gm-Message-State: AO0yUKWGpVlqZWGndFnAQVjpQ+T0iCMnbnueGz4xhxPuQNdyM7q3ze4F
        fxlR3DK3MBMrQZfH3f2ZbICUv717St+toggmTk7xnFP+YnYDaEPPqF8qMQ==
X-Google-Smtp-Source: AK7set8nLdJ/VfkMI0EJM9Aem8wAvkE81O11KXgR5fnc5i2uo0SDfUIs/dC/YCoJSFXLk2ocnmtt/eZZn7QnOqkxv6A=
X-Received: by 2002:a50:d701:0:b0:4ad:7265:82db with SMTP id
 t1-20020a50d701000000b004ad726582dbmr2768084edi.1.1677018479480; Tue, 21 Feb
 2023 14:27:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y/UXBw3Y9YnXUBIN@nand.local>
In-Reply-To: <Y/UXBw3Y9YnXUBIN@nand.local>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 21 Feb 2023 14:27:47 -0800
Message-ID: <CAJoAoZm+bS3pT_DOaQfafW6dyV=m3ZUs=oxNZ_sKdfFO7uxM9A@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 11:10 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Feb 17, 2023 at 01:12:23PM -0800, Emily Shaffer wrote:
> > This turned out pretty long-winded, so a quick summary before I dive in:
> >
> > - We want to compile parts of Git as independent libraries
> > - We want to do it by making incremental code quality improvements to Git
> > - Let's avoid promising stability of the interfaces of those libraries
> > - We think it'll let Git do cool stuff like unit tests and allowing
> >   purpose-built plugins
> > - Hopefully by example we can convince the rest of the project to join
> >   in the effort
>
> Like others, I am less interested in the VFS-specific components you
> mention here, but I suspect that is just one particular instance of
> something that would be benefited by making git internals exposed via a
> linkable library.
>
> I don't have objections to things like reducing our usage of globals,
> making fewer internal functions die() when they encounter an error, and
> so on. But like Junio, I suspect that this is definitely an instance of
> a "devil's in the details" kind of problem.
>
> That's definitely my main concern: that this turns out to be much more
> complicated than imagined and that we leave the codebase in a worse
> state without much to show.

Yeah, I'm really hoping we don't end up with ugly half-changes too.
Some examples of "partial credit" that I'd be happy with:

- Fewer internal libraries relying on globals like
the_repository/the_index/etc (we've already started this effort,
libification or no)
- An "ugly" library interface becoming clearer and easier to use (and
internal callers updated)
- Figuring out an "error reporting type" that works well for us

There are some things that *are* ugly, for example, calling a library
via a vtable. But I do feel comfortable waiting to introduce that kind
of thing until we really need it, at which point I suspect we'll have
already made some successful strides with libification in general.

It's not so great to just trust me to say "I promise not to make ugly
changes" - I'd appreciate the community's help pushing back if we
propose doing something in an untidy way without clear justification.

> A lesser version of that outcome would be
> that we cause a lot of churn in the tree with not much to show either.

I'm actually not so concerned about this! The "churn", as I see it,
comes in the form of code cleanup that already makes Git more
understandable for Git hackers. We do spend some time on that now, as
a project, but I wouldn't be unhappy if we spent even more :)

>
> So I think we'd want to see some more concrete examples with clear
> benefits to gauge whether this is a worthwhile direction. I think that
> strbuf.h is too trivial an example to demonstrate anything useful. Being
> able to extract config.h into its own library so that another non-Git
> program could link against it and implement 'git config'-like
> functionality would be much more interesting.

Sure - I'm also looking forward to seeing it.

Thanks for your thoughtful reply.
 - Emily
