Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB782C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1D21D7D
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLTRdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:33:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52299 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTRdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:33:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so9748604wmc.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+aQQ8SUwNudUGM4/lQP4gxs1puZvAgnC9u8tJA+2Ig=;
        b=NmMN0PYqMZXkuVXggWVdk95gcykajekjS4LeZdo0cH5ROetvkzfNcSYKUMsL0z0b+c
         Wgwf9f+sZNZkMvxOqwgb3zUDvMmKlZy6W+4YWfgNaFDvcdXufbFbIXVaPvQbrSMa9PtH
         235IhOXe7QCspkAhIz/o1p/hA8KZadx3nMT9lRa8xsrjgIdaTEi4sYTOnHMFhprsqzhF
         9pWVVANz5dxUz4VsHUUJIdW28uvGxhpKG4lEQ5v2lMhc9yweqTLWRxd3zWxEcA/0MaJZ
         twgINrqVaJA8IhhZ9LFHlpp+W04JofBM5gKXSzgZi139EcgI6zWV8XkQaVU0/Zv5XTTE
         T/Bw==
X-Gm-Message-State: APjAAAWkEO3qCViXWAltWpvS0bfwkTqb5G3W8ukDFoyffju1ucbS7m6c
        55uqpjGOXrlxmn9bzlNDu3UzjSykfjA+e5Ntmgo=
X-Google-Smtp-Source: APXvYqztYPAAqsuRJoAUZugdLHddl471YNisMM+GorB/hQ7kxcNKRr6kffEdomJakLkBexNiYKKX4iepU+iv/VTeYy0=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr17270682wma.84.1576863188792;
 Fri, 20 Dec 2019 09:33:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
 <83e47748bc9c541c725f6c42c553b1a69fd717ac.1576794144.git.liu.denton@gmail.com>
 <CAPig+cQuPDDun3NxnTwvmjo9zvPzSq+5f2utkHkS0f1c1Nwbvg@mail.gmail.com> <20191219231940.GA67903@generichostname>
In-Reply-To: <20191219231940.GA67903@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Dec 2019 12:32:57 -0500
Message-ID: <CAPig+cSy7HX9K=fAfgQk1en4zzu1HYKbSmjSZHhAVqg-RcAcPw@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] t1501: remove use of `test_might_fail cp`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 6:18 PM Denton Liu <liu.denton@gmail.com> wrote:
> On Thu, Dec 19, 2019 at 05:52:56PM -0500, Eric Sunshine wrote:
> > [...] I'd rather see:
> >     { cp repo.git/sharedindex.* repo.git/repos/foo || :; } &&
> > which is the idiomatic way this sort of thing is handled in existing tests.
> >
> > While it's true that it may look a bit cryptic to people new to shell
> > scripting, as with any idiom, it's understood at a glance by people
> > familiar with it. That bit about "at a glance" is important: it's much
> > easier to comprehend idiomatic code than code which you have to spend
> > a lot of time _reading_ [...]
>
> The reason why I chose to do this was because I found myself writing the
> above many times in (currently unsent) later test cases that I cleaned
> up. As a result, I felt like it could be wrapped up more nicely with a
> helper function. That being said, if you think that open coding the
> idiom looks nicer, I can reroll to inline it.

I wouldn't say that the idiom "looks nicer", but rather that it has
value specifically because it is an idiom, therefore it reduces
cognitive load (as explained above).

Idioms aside, the new function test_non_git_might_fail() may increase
cognitive load because the reader needs to remember its purpose and
behavior since it's a black box compared to the open-coded version,
yet adds no actual value. Compare that with, say, test_must_fail()
which not only adds value but would significantly increase cognitive
load if open-coded, thus is well justified. That's not to say that
one-liner functions can't necessarily have value; a well named
function or one which introduces an important abstraction may very
well be worthwhile, but I can't convince myself that
test_non_git_might_fail() succeeds in that way.

So, to answer your question, my preference leans toward open-coding this.
