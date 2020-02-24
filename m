Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B3C35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA91B20714
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 06:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="zjZ1T6DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBXGCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:02:44 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41072 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXGCo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 01:02:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so8666976ljc.8
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 22:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=id07NO2GJypvehx4fqQ0sicw1cS/tUkqGG2gJY9eNDY=;
        b=zjZ1T6DZt69rwMdltr5lOe9vI/WpTZEO8dU86wPlBlHD0tJu1DOQgKMPrkq+uFmYLT
         4GYQmyWU1Phgd58/O05sqUb5OnL/W25uS/2cM6cC2m9H/Gc+/XmWr4lGUw+U74FQ4wHk
         HfPg7bln9uy5LMpz+/ZeR9b/APxgwW9QTcYSD7Gdd4c1uhTvosZKlz8K+3OxRl/yY/zA
         7JkYyZMFxbOne9erLivKfMjrcUIiT4bPi43sDSbdd4fP5eVYyLPzydzhOw1S1NHb/Vec
         KV/PhP5bttHLUOwupAqx0QGVOtW9fDz7JK0FDx/6mxPjE9iQ8Wd/3AfA9NcME14iesOu
         C1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=id07NO2GJypvehx4fqQ0sicw1cS/tUkqGG2gJY9eNDY=;
        b=Cyq22qz4pOJzTNWGjxQ/IlzKhKlcKifnmURA1cl/dw6CuS9LFRnx0Q5M+uabcjLdmM
         AJkSDBqftWMUXpcHklyOJPmh9ZWmDO6IubHZSQ3jEvP70qilA8ukQGg+Y/bP38HKMXu/
         QWleiUF2mV4u4SrRKycUYxwuA3eyu0x5dXAGHRDfm1v/EisNlGvyup11HLo1WItfNx94
         d8qHaJPJa4kwhEPdnYdYkIsR6hyG4d9GvuXdR/tZelEFytRNrJ0Hyd7br+GJSqcyN9VJ
         n/hpbuisioiQDKlWLbM83F/pZZjoROeL20U+4Skc91nBDpfewkvPlhOlgVNU4a4J3tfa
         kvAA==
X-Gm-Message-State: APjAAAXrRLRtMmRDWfgEXt8oMzR/aeSPvpVFjHFg44wElyKRpt+LwjJp
        f+QXL4inPNbII+RIyKQhAbt1SL0sjMDShCG+qPFIeQ==
X-Google-Smtp-Source: APXvYqyDGsW1HhclEztnXlelJTFb4O5EXc6qql0QsuZsSEZ5HCGBA8GCWvvf0XHw58gE6YOsxhqWqytE/zdpBbq61Lc=
X-Received: by 2002:a2e:7009:: with SMTP id l9mr29140594ljc.96.1582524161910;
 Sun, 23 Feb 2020 22:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20200221201545.1244861-1-kolyshkin@gmail.com> <20200223050557.6380-1-matheus.bernardino@usp.br>
 <CAGmPdrxRNVSvQYzOx9-nhtztGgS_q92y3GO8n1nqRE5UJWiQRg@mail.gmail.com>
In-Reply-To: <CAGmPdrxRNVSvQYzOx9-nhtztGgS_q92y3GO8n1nqRE5UJWiQRg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 24 Feb 2020 03:02:30 -0300
Message-ID: <CAHd-oW72kMzYqcRMffQRb+VB8=HdQt8noJgAfGYxpEsWZdbMuA@mail.gmail.com>
Subject: Re: [PATCH v2] completion: add diff --color-moved[-ws]
To:     Kirill Kolyshkin <kolyshkin@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 1:41 AM Kirill Kolyshkin <kolyshkin@gmail.com> wrote:
>
> On Sat, 22 Feb 2020 at 21:06, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >
> > On Fri, Feb 21, 2020 at 5:15 PM Kir Kolyshkin <kolyshkin@gmail.com> wrote:
> > >
> > > Note that while --color-moved-ws= accepts comma-separated
> > > list of values, there is no (easy?) way to make it work
> > > with completion (see e.g. [1]).
> >
> > This puzzled me for some time, but I think I finally got a way to make the
> > comma-separated completion work. Bellow is the code that does the trick,
[...]
> Thanks! I played with it, and I can't say I like it. The issues I see are:
>
> 1. It does not suggest a comma, so it doesn't work as "discovery mode".

In fact, it is possible to make it suggest the commas. But them, the
output would be too polluted, IMO, as we would get twice as much
suggestions. For example:

$ git diff --color-moved-ws=<tab><tab>
allow-indentation-change allow-indentation-change, ignore-all-space
ignore-all-space, ignore-space-at-eol ignore-space-at-eol,
ignore-space-change ignore-space-change, no no,

Besides, the completion without csv also does not help on the
"discovery mode" for lists of values. So I think it is still better to
use the csv completion, than not using it at all. I.e. there is no
additional downside, and we get the bonus of nice completions when the
user tries something as `git diff
--color-moved-ws=ignore-space-at-eol,<tab><tab>`.

> 2. It's not smart enough to not repeat the option that is already there,

Hmm, in my setup, it is not repeating options. I also added a test
case at t6120-describe.sh to make sure there is no repetition. Could
you please execute this test in your environment and report back if it
fails there? (maybe I'm using some non-portable code?)

For reference, the section that should be responsible for avoiding
repetitions is the following:

> > +       # Filter out already used values from completion reply
> > +       for value in $2
> > +       do
> > +               if ! [[ ",$cur_values," =~ ",$value," ]]
> > +               then
> > +                       available_values="$available_values $value"
> > +               fi
> > +       done

> 3. (this is not about the __gitcomp_csv, but rather about the way
> --color-moved-ws option arguments work) Some values for --color-moved-ws
> are not meant to be used together with others, e.g. --color-moved-ws=no
> is exclusive, and it looks like allow-indentation-change is exclusive, too.
> Others are more complicated, e.g. ignore-space-change "includes"
> ignore-space-at-eol so once the former is set, it does not make sense
> to suggest the latter. Even coding all these rules (what makes sense
> with what, and what doesn't) sounds a bit too complicated.

I don't think completion should handle these cases. Take a look at the
completion for git-describe, for example. The option --long is
incompatible with --no-abbrev, but the completion script won't stop
suggesting one because the user already typed the other. IMO,
introducing all these rules to completion would make the script
unnecessarily complex. In the end, git-describe itself will warn
and/or exit if incompatible options are given; the completion is more
like a helper, IMO.

> So, all of the above makes me think that maybe it doesn't make
> much sense to have csv completion at all.

Hmm, I understand your point. But as I mentioned earlier, I think
adding the csv completion won't cause any extra harm; and as a bonus,
it will help users that already want to type a list of values to do it
faster. So I still think it is better than not using it at all.
