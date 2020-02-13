Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C38C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28DD206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jEbU7FIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBMR4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:56:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42207 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMR4I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 12:56:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id e8so2621969plt.9
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1LgEXpA3+i6S4EIfYy4LOG/Iu6wUSupawqPZnbjxbDU=;
        b=jEbU7FINGNNXOOMie2V1FczROnKTk2bulcYubwld1Uc0P5q8CEt2HCpqp7ZFfqsIkI
         iBcaZUm4ZjvN2DscBTS1CphmVoAMcTZRdZ4kEyHSupJOk3j1vlyU2XZQdbRD+6WvoFeY
         gp1SQhv7P5LYHrNzg19PkyJN5Sqv3TUdLY+Sb+a/VZmVEqWuQlcgBsY5ZmZS9mYWUC2Z
         sPzu0T7uzaiaAtZl6i4hK94ZQzyc1hJtd1EAMR5/9/71HSiWQ/9svI1FAGifA18TVqiv
         nXx3lpseWyXTfAs/DN+71w0zUSkzfunKgwZG7Odyl3L4bdTYkq6JD7hnzgZ+OCltXGSM
         a0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1LgEXpA3+i6S4EIfYy4LOG/Iu6wUSupawqPZnbjxbDU=;
        b=l/+mOEWiNiZLSTElyIEMu5Gf1TJb+lWkKFpm7PbiIdf14fZZFDTLSlCu7vbKENyUG2
         2ikVA4mhrHkovF+eiH1zxXBkfSlCvI4IFb/sKPDUvoh6YtG0Y/1fXyI5xlnPOXWhIAj6
         jWnjLBeI/vXTamheI7181aBbSI5tfsQMFRwC+4CAmz6r5RdY8F/lyFqJPJY7iAJOz7Cg
         XBHxrTw+aTkOvHn9aauHPnbC5gS5Eql5h2FfY010xVEPo1fzgbYuW8hVJzy691Tz+z1u
         wtd9pBsUTaxxFR5Q5tSPOBl+YUfogaAg0acqen4D8+aLW/U/OiawY2HCMMoUcVt1Cyjo
         B0iQ==
X-Gm-Message-State: APjAAAV8dGOvEecG9LH4qY2CiVQrM9HVDLeDTM0gHL9XH31BKkGz4Yve
        PUzb8kiS1H7GDgEiw+KsYIJ+4dvrMfTpYjFF
X-Google-Smtp-Source: APXvYqx1i7oTcZKosAEs/9eUphwI9lom1PvvsAqX6CHp6SW5QqeazLgbTJXnJ46PYvlG+bgzvzquyg==
X-Received: by 2002:a17:902:321:: with SMTP id 30mr30922628pld.130.1581616566914;
        Thu, 13 Feb 2020 09:56:06 -0800 (PST)
Received: from localhost ([205.175.106.72])
        by smtp.gmail.com with ESMTPSA id t11sm3512988pjo.21.2020.02.13.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:56:06 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:56:05 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
Message-ID: <20200213175605.GC45518@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
 <CAN0heSqGe0HpAj+qoYkif4pyjaW5EBNsRce9OmxMaZXTSW7C9w@mail.gmail.com>
 <20200204045124.GG5790@syl.local>
 <20200213113313.GO10482@szeder.dev>
 <20200213114800.GP10482@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213114800.GP10482@szeder.dev>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 12:48:00PM +0100, SZEDER Gábor wrote:
> On Thu, Feb 13, 2020 at 12:33:13PM +0100, SZEDER Gábor wrote:
> > On Mon, Feb 03, 2020 at 08:51:24PM -0800, Taylor Blau wrote:
> > > On Fri, Jan 31, 2020 at 08:34:41PM +0100, Martin Ågren wrote:
> > > > On Fri, 31 Jan 2020 at 01:30, Taylor Blau <me@ttaylorr.com> wrote:
> > > > > The 'write' mode of the 'commit-graph' supports input from a number of
> >
> > s/mode/subcommand/

Sure.

> > > > > different sources:
> >
> > I note that you use the word "sources" here, in the subject line as
> > well (as '--input=<source>'), and in the code as well (e.g.  the in
> > the error message "unrecognized --input source, %s").  I like this
> > word, I think the words "input" and "source" go really well together.
> >
> > > > > pack indexes over stdin, commits over stdin, commits
> > > > > reachable from all references, and so on.
> >
> > It's interesting to see that you stopped listing and went for "and so
> > on" right when it got interesting/controversial with '--append'... :)

Only because I figured that I had illustrated the point as "here are the
input sources that we currently understand", like "--stdin-packs",
"--stdin-commits", and so on, not because I find this option to be
controversial.

> > > > > Each of these options are
> > > > > specified with a unique option: '--stdin-packs', '--stdin-commits', etc.
> >
> > It also supports the very inefficient scanning through all objects in
> > all pack files to find commit objects, which, sadly, ended up being
> > the default, and thus doesn't have its own --option.  Should there be
> > a corresponding '--input=<source>' as well?  (Note that I don't mean
> > this as a suggestion to add one; on the contrary, the less exposure it
> > gets the better.)

Maybe... although I (like you, I think) have a hard time imagining that
this would ever get used, since it *is* the default source of input, so
you could just as easily *not* write '--input' anything and get the same
effect.

> > > > > Similar to our replacement of 'git config [--<type>]' with 'git config
> > > > > [--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
> > > > > `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
> > > > > deprecate '[--<input>]' in favor of '[--input=<source>]'.
> > > > >
> > > > > This makes it more clear to implement new options that are combinations
> > > > > of other options (such as, for example, "none", a combination of the old
> > > > > "--append" and a new sentinel to specify to _not_ look in other packs,
> > > > > which we will implement in a future patch).
> > > >
> > > > Makes sense.
> > > >
> > > > > Unfortunately, the new enumerated type is a bitfield, even though it
> > > > > makes much more sense as '0, 1, 2, ...'. Even though *almost* all
> > > > > options are pairwise exclusive, '--stdin-{packs,commits}' *is*
> > > > > compatible with '--append'. For this reason, use a bitfield.
> > > >
> > > > > -With the `--append` option, include all commits that are present in the
> > > > > -existing commit-graph file.
> > > > > +With the `--input=append` option, include all commits that are present
> > > > > +in the existing commit-graph file.
> > > >
> > > > Would it be too crazy to call this `--input=existing` instead, and have
> > > > it be the same as `--append`? I find that `--append` makes a lot of
> > > > sense (it's a mode we can turn on or off), whereas "input = append"
> > > > seems more odd.

I don't think that I have a strong preference here, since I don't find
'--input=append' to be out of the ordinary, so I'd be happy with either.
If you'd strongly prefer that we call this '--input=existing', then
that's fine with me.

I called it '--input=append' to translate 1-to-1 from '--<source>' to
'--input=<source>'. I would worry a little about saying, "yeah, if you
want to use the new '--input'-style options, just write what you used to
write *unless* that thing is '--append' in which case write 'existing'
instead".

Maybe '--append' was poorly-named to begin with, so I think the
question is really: if we believe that it is poorly named, is now the
right time to correct that naming?

> > > Hmm. When I wrote this, I was thinking of introducing equivalent options
> > > that are identical in name and functionality as '--input=<mode>' instead
> > > of '--<mode>'. So, I guess that is to say that I didn't spend an awful
> > > amount of time thinking about whether or not '--input=append' made sense
> > > given anything else.
> > >
> > > So, I don't think that '--input=existing' is a bad idea at all, but I do
> > > worry about advertising this deprecation as "'--<mode>' becomes
> > > '--input=<mode>', except when your mode is 'append', in which case it
> > > becomes '--input=existing'".
> >
> > But here you suddenly start using the word "mode" both in
> > '--input=<mode>' and in '--<mode>'.
> >
> > On one hand, I don't think that the word "mode" goes as well with
> > "input" as "source" does.
> >
> > On the other, is '--append' really a source/mode, like '--reachable'
> > and '--stdin-commits' are?
>
> Well, re-reading this question got me confused right after sending it,
> so let me try to rephrase.
>
> Is '--append' really a "source", like '--reachable' and
> '--stdin-commits' are?  No:
>
> >  Source, no: from wordsmithing perspective
> > it doesn't fit with "source", and being orthogonal to the "real"
> > source options while they are mutually exclusive seems to be a clear
> > indication that it isn't.
>
> Or is it a "mode" modifying how other options are handled?  Yes:
>
> > Mode, yes: it's a mode of operation where
> > no longer reachable/present commits are not discarded from the
> > commit-graph.
> >
> > So I don't think that adding '--input=append' is a good idea, even if
> > we were call it differently, e.g. '--input=existing' as suggested
> > above.
> >
> > However, I do think that '--input=existing' would better express what
> > '--input=none' in the next patch wants to achieve.

So, I guess I'm left wondering what we can do to move forward here. For
my part, I see a couple of options:

  (a) we could replace every instance of '--input=<source>' with
      '--input=<mode>', which seems it would make "append" a valid
      pattern-match for "mode", and move on.

  (b) we could stick with '--input=<source>' and 's/append/existing',
      and move on

  (c) or do something else that I didn't think of here and go forward
      with that instead.

Let me know which you'd prefer that I do, and I'd be happy to send an
updated version of the series for you to look at.

Thanks,
Taylor
