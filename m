Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00671F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeKKR0q (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:26:46 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45471 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeKKR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:26:45 -0500
Received: by mail-ua1-f66.google.com with SMTP id e16so832771uam.12
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 23:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/pjAcsDD0SRmqGQvMR1M5nX1n+0EJBfBK/f9wyTsl4=;
        b=V7xHTAvT2Xt7z4gs7gemhN5Xi6uKqSzDg+5GX7Ns6tM1sN9c7AycoKtT0uCWbypn+y
         +4Rx17Gzya66G+VjhkyB694zBms/OoVghK7nan44gCJUNAM8/ixTm889dv8hbxNroU92
         Hv+WNqARE++x3B3XuRBQ/lGtLkLdRrhwewu3bm6CE5kIeujquU0yXqV5UvheiWcKqpM8
         iqiFEQrs9xNKQi7tAgYyaivntyPTDmEQglTBpO41aPZ3QtsqOJJIfFOcS87QeY2tX/C1
         H/klZ6n44DQFETevpg+e2EMPUAGgO9h7/f+fDFz415ulgFho5x3rZC38KouEB/8/wmnx
         x1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/pjAcsDD0SRmqGQvMR1M5nX1n+0EJBfBK/f9wyTsl4=;
        b=cbNPoSDYtjwMKurItaSRhSADjdbc/Xcy3wRwTerzPKQe2i79+YMNRTVXgEcDMBjzQ6
         ceaMucxiboJbA6xUddFCamJT/4w7oGS4NmjoP0YUwwRokics8v9IihXODMV0O0URB9iM
         mN2hkGh9wphvmF+HmJoLOpfg/pqJfPO9B3ezO/5u6UaoCPP23dmaRtbMP9k2WJ3JsK0p
         2E2qDnZfGOcRW5y+hArgHD2iQ4RYYuaAvgC7cWqPAwt8uvYxm23axTZr4e4ZGoSerAO3
         UrnNoidAXt0b+a+3NZZJY5+sysD7moVn1Z3pgq6ava6Z14P8I2U94hWh7itK624+CNbv
         A2UQ==
X-Gm-Message-State: AGRZ1gK6VQfrLX5JQWLPTHJocSF0UefiMXOCB2t5ry2aiHId6LUBjbsM
        Nfrabunixqn4H0F9AHLEOpUkmBpxf4M/kxdqUo4=
X-Google-Smtp-Source: AJdET5dcxc3sT515R19cQkO470zDhDS/tEyt3sL94ymjLRjkcM9HAS5+oy88YznuQWfYwM9FBCIMFtvtQOp3Miix/3g=
X-Received: by 2002:ab0:2314:: with SMTP id a20mr6658857uao.130.1541921936458;
 Sat, 10 Nov 2018 23:38:56 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-5-newren@gmail.com>
 <20181111064442.GD30850@sigill.intra.peff.net>
In-Reply-To: <20181111064442.GD30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 10 Nov 2018 23:38:45 -0800
Message-ID: <CABPp-BFy1aS3mHGF99Lr=+APruzC3pF5PCEph8SU71uuyOnQ7Q@mail.gmail.com>
Subject: Re: [PATCH 04/10] fast-export: avoid dying when filtering by paths
 and old tags exist
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:44 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:06PM -0800, Elijah Newren wrote:
>
> > If --tag-of-filtered-object=rewrite is specified along with a set of
> > paths to limit what is exported, then any tags pointing to old commits
> > that do not contain any of those specified paths cause problems.  Since
> > the old tagged commit is not exported, fast-export attempts to rewrite
> > such tags to an ancestor commit which was exported.  If no such commit
> > exists, then fast-export currently die()s.  Five years after the tag
> > rewriting logic was added to fast-export (see commit 2d8ad4691921,
> > "fast-export: Add a --tag-of-filtered-object  option for newly dangling
> > tags", 2009-06-25), fast-import gained the ability to delete refs (see
> > commit 4ee1b225b99f, "fast-import: add support to delete refs",
> > 2014-04-20), so now we do have a valid option to rewrite the tag to.
> > Delete these tags instead of dying.
>
> Hmm. That's the right thing to do if we're considering the export to be
> an independent unit. But what if I'm just rewriting a portion of history
> like:
>
>   git fast-export HEAD~5..HEAD | some_filter | git fast-import
>
> ? If I have a tag pointing to HEAD~10, will this delete that? Ideally I
> think it would be left alone.

A couple things:
  * This code path only triggers in a very specific case: If a tag is
requested for export but points to a commit which is filtered out by
something else (e.g. path limiters and the commit in question didn't
modify any of the relevant paths), AND the user explicitly specified
--tag-of-filtered-object=rewrite (so that the tag in question can be
rewritten to the nearest non-filtered ancestor).
  * You didn't specify to export any tags, only HEAD, so this
situation isn't relevant (the tag wouldn't be exported or deleted).
  * You didn't specify --tag-of-filtered-object=rewrite, so this
situation isn't relevant (even if you had specified a tag to filter,
you'd get an abort instead)

But let's say you do modify the example some:
   git fast-export --tag-of-filtered-object=rewrite
--signed-tags=strip --tags master -- relatively_recent_subdirectory/ |
some_filter | git fast-import

The user asked that all tags and master be exported but only for the
history that touched relatively_recent_subdirectory/, and if any tags
point at commits that are pruned by only asking for commits touching
relatively_recent_subdirectory/, then rewrite what those tags point to
so that they instead point to the nearest non-filtered ancestor.  What
about a commit like v0.1.0 that likely pre-dated the introduction of
relatively_recent_subdirectory/?  It has no nearest ancestor to
rewrite to.  The previous answer was to abort, which is really bad,
especially since the user was clearly asking us to do whatever smart
rewriting we can (--signed-tags=strip and
--tag-of-filtered-object=rewrite).

Perhaps there's a different answer that's workable as well, but this
one, in these circumstances, seemed the most reasonable to me.

> > +test_expect_success 'rewrite tag predating pathspecs to nothing' '
> > +     test_create_repo rewrite_tag_predating_pathspecs &&
> > +     (
> > +             cd rewrite_tag_predating_pathspecs &&
> > +
> > +             touch ignored &&
>
> We usually prefer ">ignored" to create an empty file rather than
> "touch".

Will fix.

>
> > +             git add ignored &&
> > +             test_commit initial &&
>
> What do we need this "ignored" for? test_commit should create a file
> "initial.t".

I think I original had plain "git commit", then switched to
test_commit, then didn't recheck.  Thanks, will fix.

> > +             echo foo >bar &&
> > +             git add bar &&
> > +             test_commit add-bar &&
>
> Likewise, "test_commit bar" should work by itself (though note the
> filename is "bar.t" in your fast-export command).
>
> > +             git fast-export --tag-of-filtered-object=rewrite --all -- bar >output &&
> > +             grep -A 1 refs/tags/v0.0.0.0.0.0.1 output | grep -E ^from.0{40}
>
> I don't think "grep -A" is portable (and we don't seem to otherwise use
> it). You can probably do something similar with sed.
>
> Use $ZERO_OID instead of hard-coding 40, which future-proofs for the
> hash transition (though I suppose the hash is not likely to get
> _shorter_ ;) ).

Will fix these up as well...after waiting for more feedback on
possible alternate suggestions.
