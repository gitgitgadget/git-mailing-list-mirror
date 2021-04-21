Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F2AC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D7661450
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhDUSfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbhDUSfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:35:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326BAC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:34:38 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x20so9583020oix.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FBq9lUUaC4gao5gJPgTWR4x2znuthOMSY5UljAQShoI=;
        b=k5FbZNLSkXR9Lwa0GYz397nBIo0qCKIHeQ5w6+NFCGnWdZEtAvsZlvkBsxZA5qbwuU
         tiPj1MnBL0AX6CjUKgtxgnyD1ORr7enavLwRZ/VPMW245I0QOZXOvDg6JmQvh5wa8leb
         OktGL126U8j1IWQZl/Qice0HxnM9kwQWGMe9Lp0XRZ2HYvYtz+orPO0RCWX1YZ7/ZSl3
         m1s4nuZCI9p4HiZnhYcuVwvNLrZzxN4KlLxLerLiF50sW8nYeB/hvdlq/LkhDKXHN5Vl
         Rd7r+UJFij9pOYYYbzIB8zk7UexBQXYapBqKLDm9RopSh/ysWmv5q+9BgJprDT0JQ3ub
         dl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FBq9lUUaC4gao5gJPgTWR4x2znuthOMSY5UljAQShoI=;
        b=sLAAzvxwCVZF5U8PtuISQ8kRXNePITPSvJx0Wm+10Ha/nK/E3TJavwzCkcyt0WhTl1
         sNNgtCOm7ZjhDRSuhVFGBzVF0Np9HuU8bYkcFhR7TGOlDrdienWtUusXfWmM/3umddJC
         ZHyK4HVufYNzll6EDAamQer5tup+Kpdvgj1w0Qg8YskMGawTUl93rVEhFHlZpWrIPMhb
         Ugjguc1+JBrgAWakQfu5Gtj2VZOBJZWMH3fNBmmA5ZxP54YNmXhqVbhhje9pq0tF82TR
         +F2xsUD+nnt7ZhpmKlMU5sFaR3CBl3M30hlcl6hZQGuDvddMT0oRI6VuLCYyy3JV6ULs
         AHgA==
X-Gm-Message-State: AOAM532IfF6lll1yzFuDbrdcTzj+bxpkKO+V/MsmzYejnbBWFLNAY22N
        6SI9YZLSGU/bEATEpq95EhBn4sc0GEss8Rhua10=
X-Google-Smtp-Source: ABdhPJzR80VxxWCoOT514YkF4+2tXoNsnUdkZvFMJLkUPeSv/D5KJr/leK+woSpBa8zKCexuhrv65m86rYHklMZFz3k=
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr7571026oia.167.1619030077644;
 Wed, 21 Apr 2021 11:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210420190552.822138-1-lukeshu@lukeshu.com> <xmqqa6ps4otm.fsf@gitster.g>
 <87zgxs2gp9.fsf@evledraar.gmail.com>
In-Reply-To: <87zgxs2gp9.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 11:34:26 -0700
Message-ID: <CABPp-BFY65wddHHw2Uhortcux+TzMYBZS1wwfnsasYeishXa-w@mail.gmail.com>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 1:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Apr 20 2021, Junio C Hamano wrote:
>
> > Luke Shumaker <lukeshu@lukeshu.com> writes:
> >
> >> That'd work fine if they're lightweight tags, but if they're annotated
> >> tags, then after the rename the internal name in the tag object
> >> (`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
> >> is still mostly fine, since not too many tools care if the internal
> >> name and the refname disagree.
> >>
> >> But, fast-export/fast-import are tools that do care: it's currently
> >> impossible to represent these tags in a fast-import stream.
> >>
> >> This patch adds an optional "name" sub-command to fast-import's "tag"
> >> top-level-command, the stream
> >>
> >>     tag foo
> >>     name bar
> >>     ...
> >>
> >> will create a tag at "refs/tags/foo" that says "tag bar" internally.
> >>
> >> These tags are things that "shouldn't" happen, so perhaps adding
> >> support for them to fast-export/fast-import is unwelcome, which is why
> >> I've marked this as an "RFC".  If this addition is welcome, then it
> >> still needs tests and documentation.
> >
> > I actually think this is a good direction to go in, and it might be
> > even an acceptable change to fsck to require only the tail match of
> > tagname and refname so that it becomes perfectly OK for Gitk's
> > "v0.0.1" tag to be stored at say "refs/tags/gitk/v0.0.1".
>
> Do you mean to change fsck to care about this it all? It doesn't care
> about the refname pointing to a tag, and AFAICT we never did.
>
> All we check is that the pseudo-"refname" is valid, i.e. if we were to
> use the thing we find on the "tag" line as a refname, does it pass
> check_refname_format()?
>
> "git tag -v" doesn't care either:
>
>         $ git update-ref refs/tags/a-v-2.31.0 3e90d4b58f3819cfd58ac61cb86=
68e83d3ea0563
>         $ git tag -v a-v-2.31.0
>         object a5828ae6b52137b913b978e16cd2334482eb4c1f
>         type commit
>         tag v2.31.0
>         tagger Junio C Hamano <gitster@pobox.com> 1615834385 -0700
>         [.. snip same gpgp output as for v2.31.0 itself..]
>
> I think at this point the right thing to do is to just explicitly
> document that we ignore it, and that the export/import chain should be
> as forgiving about it as possible.
>
> I.e. we have not cared about this before for validation, and
> e.g. core.alternateRefsPrefixes and such things will break any "it
> should be under refs/tags/" assumption.
>
> There's also perfectly legitimate in-the-wild use-cases for this,
> e.g. "archiving" tags to not-refs/tags/* so e.g. the upload-pack logic
> doesn't consider and follow them. Not being able to export/import those
> repositories as-is due to an overzelous data check there that's not in
> fsck.c would suck.

Not would suck, but does suck.  I had to document it as a shortcoming
of fast-export/fast-import -- see
https://www.mankier.com/1/git-filter-repo#Internals-Limitations, where
I wrote, "annotated and signed tags outside of the refs/tags/
namespace are not supported (their location will be mangled in weird
ways)".

The problem is, what's the right backward-compatible way to fix this?
Do we have to add a flag to both fast-export and fast-import to stop
assuming a "refs/tags/" prefix and use the full refname, and require
the user to pass both flags?  How is fast-import supposed to know that
"refs/alternate-tags/foo" is or isn't
"refs/tags/refs/alternate-tags/foo"?

And if we need such a flag, should fast-import die if it sees this new
"name" directive and the flag isn't given?
