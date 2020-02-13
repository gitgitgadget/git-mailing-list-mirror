Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E94C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 11:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C2F2073C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 11:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Poqigocq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgBMLdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:33:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34884 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgBMLdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 06:33:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so6237718wrt.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bXQ6vxRkWA7N4KzFr82ebH/KpnsUJ3yQMo9BgixxwI0=;
        b=PoqigocqkBfr1pAPtBEBLUwf27b7AMW9qC/Z2TssLI6tNlZDXj2F9plX0EgUj9P4PM
         TrO3AQzDBL6GqGycuZaKMC0nmwb6fhKHIlXcGBQtAimuYvwjQiv4rJEHDmYDiac/IP1K
         cXKKNQavh9dbuxlFFAArnwHj/s98HAw79BNUXYIGthcIjiqUUM6zAl77bAavtt2ZUfj3
         Oe96rEkNs/supcOXWR5VRma00zXtXiiFuR59zh5iz/pc1Xz7LR4m96FfeAqwnw4bA+/I
         ch/SsnIYDMwk5uD8vbkWRA0rSc2/pXYpmD3kvlHQxSn/6a/qbUyNUhWc56/CYQlV4CTe
         8A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bXQ6vxRkWA7N4KzFr82ebH/KpnsUJ3yQMo9BgixxwI0=;
        b=aZaUL9ZZcGoRF5tGv/1B6YbpCKHKoBYrRhJyjP/Rol/hAvz4U/wabxy0NtIu6zKf9F
         y9nnaWHZUznSuHta1RbU+POk5NHM8MOg9B9TtZ/zVvzyD5JRbY65jVA1b4PjHY/8hrVo
         ZJ8jvzUnys6893/ceSZ4gvRfZMInoMyHOwtEKTJKqRhliLYignEj0UJzV56d8bgM11XZ
         CaqNDmf2AutfO2Ti6ZFYGMrdxzSMXCtDx0yOFYTtQzSgmjOlKAWi3gL0s+xigk86BqpX
         ciIFQmI0sk83eekTtt+TGweiNqwdG/SdBMNNCXIuRYmi5KYHqB9oAXeEquIc8ThbwMTc
         PZxg==
X-Gm-Message-State: APjAAAWEFz17xgvJNc5rRr1PDtuSgpOLtgpc5qtKnt2h/bUGCBHQzf5j
        FeZr/3wgcMMthoKeVZTtq54=
X-Google-Smtp-Source: APXvYqxDjpWn/bNfqXtq2tJElC2bMRH/GdSZS5M1jEo86xgQ60IA9INPs/XNWtV+bRRTVtGiY9VdjQ==
X-Received: by 2002:adf:f692:: with SMTP id v18mr21822408wrp.246.1581593597258;
        Thu, 13 Feb 2020 03:33:17 -0800 (PST)
Received: from szeder.dev (x4dbd7231.dyn.telefonica.de. [77.189.114.49])
        by smtp.gmail.com with ESMTPSA id s65sm2658751wmf.48.2020.02.13.03.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 03:33:16 -0800 (PST)
Date:   Thu, 13 Feb 2020 12:33:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
Message-ID: <20200213113313.GO10482@szeder.dev>
References: <cover.1580430057.git.me@ttaylorr.com>
 <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
 <CAN0heSqGe0HpAj+qoYkif4pyjaW5EBNsRce9OmxMaZXTSW7C9w@mail.gmail.com>
 <20200204045124.GG5790@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200204045124.GG5790@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 08:51:24PM -0800, Taylor Blau wrote:
> On Fri, Jan 31, 2020 at 08:34:41PM +0100, Martin Ågren wrote:
> > On Fri, 31 Jan 2020 at 01:30, Taylor Blau <me@ttaylorr.com> wrote:
> > > The 'write' mode of the 'commit-graph' supports input from a number of

s/mode/subcommand/

> > > different sources:

I note that you use the word "sources" here, in the subject line as
well (as '--input=<source>'), and in the code as well (e.g.  the in
the error message "unrecognized --input source, %s").  I like this
word, I think the words "input" and "source" go really well together.

> > > pack indexes over stdin, commits over stdin, commits
> > > reachable from all references, and so on.

It's interesting to see that you stopped listing and went for "and so
on" right when it got interesting/controversial with '--append'... :)

> > > Each of these options are
> > > specified with a unique option: '--stdin-packs', '--stdin-commits', etc.

It also supports the very inefficient scanning through all objects in
all pack files to find commit objects, which, sadly, ended up being
the default, and thus doesn't have its own --option.  Should there be
a corresponding '--input=<source>' as well?  (Note that I don't mean
this as a suggestion to add one; on the contrary, the less exposure it
gets the better.)

> > > Similar to our replacement of 'git config [--<type>]' with 'git config
> > > [--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
> > > `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
> > > deprecate '[--<input>]' in favor of '[--input=<source>]'.
> > >
> > > This makes it more clear to implement new options that are combinations
> > > of other options (such as, for example, "none", a combination of the old
> > > "--append" and a new sentinel to specify to _not_ look in other packs,
> > > which we will implement in a future patch).
> >
> > Makes sense.
> >
> > > Unfortunately, the new enumerated type is a bitfield, even though it
> > > makes much more sense as '0, 1, 2, ...'. Even though *almost* all
> > > options are pairwise exclusive, '--stdin-{packs,commits}' *is*
> > > compatible with '--append'. For this reason, use a bitfield.
> >
> > > -With the `--append` option, include all commits that are present in the
> > > -existing commit-graph file.
> > > +With the `--input=append` option, include all commits that are present
> > > +in the existing commit-graph file.
> >
> > Would it be too crazy to call this `--input=existing` instead, and have
> > it be the same as `--append`? I find that `--append` makes a lot of
> > sense (it's a mode we can turn on or off), whereas "input = append"
> > seems more odd.
> 
> Hmm. When I wrote this, I was thinking of introducing equivalent options
> that are identical in name and functionality as '--input=<mode>' instead
> of '--<mode>'. So, I guess that is to say that I didn't spend an awful
> amount of time thinking about whether or not '--input=append' made sense
> given anything else.
> 
> So, I don't think that '--input=existing' is a bad idea at all, but I do
> worry about advertising this deprecation as "'--<mode>' becomes
> '--input=<mode>', except when your mode is 'append', in which case it
> becomes '--input=existing'".

But here you suddenly start using the word "mode" both in
'--input=<mode>' and in '--<mode>'.

On one hand, I don't think that the word "mode" goes as well with
"input" as "source" does.

On the other, is '--append' really a source/mode, like '--reachable'
and '--stdin-commits' are?  Source, no: from wordsmithing perspective
it doesn't fit with "source", and being orthogonal to the "real"
source options while they are mutually exclusive seems to be a clear
indication that it isn't.  Mode, yes: it's a mode of operation where
no longer reachable/present commits are not discarded from the
commit-graph.

So I don't think that adding '--input=append' is a good idea, even if
we were call it differently, e.g. '--input=existing' as suggested
above.

However, I do think that '--input=existing' would better express what
'--input=none' in the next patch wants to achieve.

