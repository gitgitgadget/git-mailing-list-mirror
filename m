Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2843C3524A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 04:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0FA2086A
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 04:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TtcKMLw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDEv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:51:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50578 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBDEv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 23:51:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so795684pjb.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 20:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4AUMJ69KSKwu/KIkPBan4RIpJHhwi7kAYwFAkrjvCis=;
        b=TtcKMLw63ZXmN+SY+GE5MzyJh6zWRbtx1fqGiUTQ5cSe7gIZxnXWWmdBhCcAKkDAQQ
         Hz8nw/eiZrk0uXDJDi1fd7pRWNOKNS4oNX8HlqKsIuOrBgmhHF0BbxbOYdtNFQM6yIKt
         O2CkFVxH/X3JI4lrAmq7/IdQLGEkX87f6XmiVgm6JZKO+yUw1iE9Qs4eWfCVfzK2h5Sc
         6MOJ0dA89a8bQwe/GEt6SAM8tude+rr+VyU7xuc0KjRYZ+r8HpPmolfCmkJiPhQZqj2F
         JdjOKlVsrN0o+CUmfj7xIlHRN2zxL3stBcxwSVln5rslTCrfPB7+s6NbTHh7rHwAfAld
         bRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4AUMJ69KSKwu/KIkPBan4RIpJHhwi7kAYwFAkrjvCis=;
        b=uHaMaMp3rfg+3VjjTJ62AWnGnE9bHsu8ZEfJhwytOCOK9jnkHozWt9zLt3LKQKNQcn
         dMGiAEvvYBW8KETNgQNA6YyoWI5qk4ulXsOQ4B6DLuBTctNSt2Hdhj/kgBdu1yFVBq6b
         7F9PfAC24RrnVDY0NzUwV7kFqD6OGRSDg5zquBB+wvlupyKgwEz/zjhvVVaCATPtzdpE
         FTUv0qYxuG6xw1qmJimr2xDSezYvw3zPJH1X2j7f0BIKTVOAafIxN8fbCDSSJx7djcT7
         DZTIhyKuBNErTnhU3grDqK49jHn/KdtMKBqd4agTPZAwsxHrUr+Ab0MG8/GxY3JI4u8s
         yqvA==
X-Gm-Message-State: APjAAAWa+oTKSJT+Z82FyDKx3I9y+Tq+vW5Y/4Is+IeOCiQfsSvCr10p
        pCDwl7jjLsNZNjZcExWeZQ+CF0kRDppTuw==
X-Google-Smtp-Source: APXvYqxxxgNCGAZyYOEQluumJxiJ8IGHYzT2P7Hi7v3dAGxWaRSk6fhKtWUwz5rWhIvaHGUFvM5M2w==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr3743775pjb.94.1580791886054;
        Mon, 03 Feb 2020 20:51:26 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:7c5e:a7ec:bd9e:cd59])
        by smtp.gmail.com with ESMTPSA id b1sm22814276pfp.44.2020.02.03.20.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 20:51:25 -0800 (PST)
Date:   Mon, 3 Feb 2020 20:51:24 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
Message-ID: <20200204045124.GG5790@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
 <CAN0heSqGe0HpAj+qoYkif4pyjaW5EBNsRce9OmxMaZXTSW7C9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqGe0HpAj+qoYkif4pyjaW5EBNsRce9OmxMaZXTSW7C9w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 08:34:41PM +0100, Martin Ågren wrote:
> On Fri, 31 Jan 2020 at 01:30, Taylor Blau <me@ttaylorr.com> wrote:
> > The 'write' mode of the 'commit-graph' supports input from a number of
> > different sources: pack indexes over stdin, commits over stdin, commits
> > reachable from all references, and so on. Each of these options are
> > specified with a unique option: '--stdin-packs', '--stdin-commits', etc.
> >
> > Similar to our replacement of 'git config [--<type>]' with 'git config
> > [--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
> > `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
> > deprecate '[--<input>]' in favor of '[--input=<source>]'.
> >
> > This makes it more clear to implement new options that are combinations
> > of other options (such as, for example, "none", a combination of the old
> > "--append" and a new sentinel to specify to _not_ look in other packs,
> > which we will implement in a future patch).
>
> Makes sense.
>
> > Unfortunately, the new enumerated type is a bitfield, even though it
> > makes much more sense as '0, 1, 2, ...'. Even though *almost* all
> > options are pairwise exclusive, '--stdin-{packs,commits}' *is*
> > compatible with '--append'. For this reason, use a bitfield.
>
> > -With the `--append` option, include all commits that are present in the
> > -existing commit-graph file.
> > +With the `--input=append` option, include all commits that are present
> > +in the existing commit-graph file.
>
> Would it be too crazy to call this `--input=existing` instead, and have
> it be the same as `--append`? I find that `--append` makes a lot of
> sense (it's a mode we can turn on or off), whereas "input = append"
> seems more odd.

Hmm. When I wrote this, I was thinking of introducing equivalent options
that are identical in name and functionality as '--input=<mode>' instead
of '--<mode>'. So, I guess that is to say that I didn't spend an awful
amount of time thinking about whether or not '--input=append' made sense
given anything else.

So, I don't think that '--input=existing' is a bad idea at all, but I do
worry about advertising this deprecation as "'--<mode>' becomes
'--input=<mode>', except when your mode is 'append', in which case it
becomes '--input=existing'".

I suppose that, on the other hand, if we *were* to introduce such a
change, now would be the time to do it, before '--input=<mode>' is on
master and tagged in a release, but I'm not sure that '--input=append'
is so much worse.

I'm inclined to leave it as is, unless there are others that feel
strongly, in which case we can/should come back to it before this moves
towards being queued.

> >From the next commit message, we learn that a long `--input=append`
> triggers `fill_oids_from_all_packs()`, which wouldn't match my expecting
> from "--input=existing". So...
>
> Does this hint that we could leave `--append` alone? We'd have lots of
> different inputs to choose from using `--input`, and an `--append` mode
> on top of that. That would make your inputs truly mutually exclusive and
> you don't need the bitfield anymore, as you mention above.  Hmm?
>
> Would that mean that the falling back to `fill_oids_from_all_packs()`
> would follow from "is there an --input?", as opposed to from "is there
> an --input except --input=append?"?
>
> (I don't know whether these inputs really *have* to be exclusive, or if
> that's more of an implementation detail. That is, even without an
> "append" input, might we one day be able to handle more inputs at once?
> Maybe this is not the time to worry about that.)
>
> Martin

Thanks,
Taylor
