Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B45C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 06:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8DC20719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 06:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQU9y0h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCZGCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:02:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34244 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZGCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 02:02:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id j16so4714724otl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0auW6XUe869j2jfG6DJUPp0ioAuQJDwg5f5J10OtVgA=;
        b=lQU9y0h4p5WNy/D9t9z/SytMysbX3p1FlivrD8rzYsUMs8pdJHFTrufwnTtvSDDx9h
         dzG5Z3a+xnnYZvzxovjcpA8Vr3YqXRl0tjfvNWDrB33JvApx4Wb0thRNS78pEXb+ztyi
         g9VZFYUYGYCE0ETYwN5nKnkp7qHrW/yONWdxIPvVSfeYLTS/RQVQ6Y2uAOFtskFFTSmY
         vWu4cnFtfrqumGJCP2YKsdPkkqQGQp0MT0lfSB2c6er3Ajrk1Nfga/8QabuZUqgXuABV
         DDPGpTy7eCIY8c7Nu+IMZoiuOpoNWoWnOmUFCtZD4KTtor+2VT7kK8S+M7iURPYsd4cE
         P/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0auW6XUe869j2jfG6DJUPp0ioAuQJDwg5f5J10OtVgA=;
        b=E0fKUVk3AqpH4DADHjW+E33//E9JnFagjPu1jFg6blJXZcNH77RvOsI56Yx6qmmqBv
         skID2/iy5a0vENpR/4nmayvXgWs+tL346p9ySLC14XLTialCE/0kCAEdKafdDiSu5Srx
         ExQ+1Eaj5fWszsh+idHRB8pF/8R80SazG/znreK//a4NkzbSyYvGN3chaSKkyO1XpFIv
         cvGkSIV6P8VOV0c+ZaUc3uWYUQm+MJYjLz/O095CX7Nqe4/vI+qNxw4iKkDjiHABnrPH
         GA7fcPvvN/vPj8/qOhYZaXoKtfQ+EAjaTmcDSAIDlAGSD+w9i7bKEKd0d61c7QiV9/wJ
         KI1w==
X-Gm-Message-State: ANhLgQ3nGuVj/VC3imA4DD/rEdXLtNlFBIZyzPezafcKngMiwsqtWEVC
        3plfCg2Ppvr7YM3AKc9EmVD8t08hdj/lGHULzaquckeg02g=
X-Google-Smtp-Source: ADFU+vsjaIoQFAO2AkpYDdh4/9NHYOmhuKft6j7SaJ7ofGqu1MyidXPkY8hfGt6xE5OUR6Oc5lx8Bj5nfCGTni1EHaQ=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr5277563otl.162.1585202551846;
 Wed, 25 Mar 2020 23:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com> <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com>
In-Reply-To: <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Mar 2020 23:02:20 -0700
Message-ID: <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus!

On Wed, Mar 25, 2020 at 4:15 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Mar 24, 2020 at 4:55 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> >
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > ---
> > >
> > > Note: I still have to make --ignore-sparsity be able to work together
> > > with --untracked. Unfortunatelly, this won't be as simple because the
> > > codeflow taken by --untracked goes to grep_directory() which just
> > > iterates the working tree, without looking the index entries. So I will
> > > have to either: make --untracked use grep_cache(), and grep the
> > > untracked files later; or try matching the working tree paths against
> > > the sparsity patterns, without looking for the skip_worktree bit in
> > > the index (as I mentioned in the previous patch's comments). Any
> > > preferences regarding these two approaches? (or other suggestions?)
> >
> > Hmm.  So, 'tracked' in git is the idea that we are keeping information
> > about specific files.  'sparse-checkout' is the idea that we have a
> > subset of those that we can work with without materializing all the
> > other tracked files; it's clearly a subset of the realm of 'tracked'.
> > 'untracked' is about getting everything outside the set of 'tracked'
> > files, which to me means it is clearly outside the set of sparsity
> > paths too (and thus you could take --untracked as implying
> > --ignore-sparsity, though whether you do might not matter in practice
> > because of the items I'll discuss next). Of course, I am also
> > assuming `--untracked` is incompatible with --cached or specifying
> > revisions or trees (based on it's definiton of "In addition to
> > searching in the tracked files in the *working tree*, search also in
> > untracked files." -- emphasis added.)
>
> Hm, I see the point now, but I'm still a little confused: The "in the
> working tree" section of the definition would exclude non checked out
> files, right? However, git-grep's description says "Look for specified
> patterns in the tracked files *in the work tree*", and it still
> searches non checked out files (loading them from the cache, even when
> --cache is not given). I know that's exactly what we are trying to

I really respect Duy and he does some amazing work and I wish he were
still active in git, but the SKIP_WORKTREE stuff wasn't his best work
and even he downplayed it: "In my defense it was one of my first
contribution when I was naiver...I'd love to hear how sparse checkout
could be improved, or even replaced."[0]

I've seen enough egregiously confusing cases and enough
difficult-to-recover-from cases with the implementation of the
SKIP_WORKTREE handling that I think it is dangerous to assume behavior
you see with it is intended design.  A year and a half ago, I read all
available docs to figure out how to sparsify and de-sparsify, and read
them several times but was still confused.  If I could only figure it
out with great difficulty, a lot of google searching, and even trying
to look at the code, what chance did "normal" users stand?  To add
more flavor to that argument, let me cite [1] (the three paragraphs
starting with "Playing with sparse-checkout, it feels to me like a
half-baked feature"), [2], as well as good chunks of [3], [4], and
[5].

[0] https://lore.kernel.org/git/CACsJy8ArUXD0cF2vQAVnzM_AGto2k2yQTFuTO7PhP4ffHM8dVQ@mail.gmail.com/
[1] https://lore.kernel.org/git/CABPp-BFKf2N6TYzCCneRwWUektMzRMnHLZ8JT64q=MGj5WQZkA@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BGE-m_UFfUt_moXG-YR=ZW8hMzMwraD7fkFV-+sEHw36w@mail.gmail.com/
[3] https://lore.kernel.org/git/pull.316.git.gitgitgadget@gmail.com/
[4] https://lore.kernel.org/git/pull.513.git.1579029962.gitgitgadget@gmail.com/
[5] https://lore.kernel.org/git/a46439c8536f912ad4a1e1751852cf477d3d7dc7.1584813609.git.gitgitgadget@gmail.com/

But let me try to explain it all below from first principles in a way
that will hopefully make sense why falling back to loading from the
cache when --cached is not given is just flat wrong.  The explanation
from first principles should also help explain --untracked a bit
better, and when there are decisions about whether to use sparsity
patterns.

> change with this patchset, but we will still give the
> --ignore-sparsity option to allow the old behavior when needed (unless
> we prohibit using --ignore-sparsity without --cached or $REV). I guess
> my doubt is whether the problem is in the implementation of the
> working tree grep, which considers non checked out files, or in the
> docs, which say "tracked files *in the work tree*".
>
> I tend to go with the latter, since using `git grep --ignore-sparsity`
> in a sparse checked out working tree, to grep not present files as
> well, kind of makes sense to me. And if the problem is indeed in the
> docs, then I think we should also allow --ignore-sparsity when
> grepping with --untracked, since it's an analogous case.

It's probably not a surprise to you given what I've already said above
to hear me say that the docs are correct in this case.  But not only
are the docs correct, I'll go even further and claim that falling back
to the cache when --cached is not passed is indefensible and leads to
surprises and contradictions.  But instead of just claiming that, let
me try to spell out a bit better why I believe that from first
principles, though:

There were previously three types of files for git:
  * tracked
  * ignored
  * untracked
where:
  * tracked was defined as "recorded in index"
  * ignored was defined as "a file which is not tracked and which
matches an ignore rule (.gitignore, .git/info/exclude, etc.)"
  * untracked was defined as "all other files present in the working directory".
With the SKIP_WORKTREE bit and sparse-checkouts, we actually have four
types because we split the "tracked" category into two:
  * tracked and matches the sparsity patterns (implies it will be
missing from the working directory as the SKIP_WORKTREE bit is set)
  * tracked and does not match the sparsity patterns (implies it will
be present in the working directory, as the SKIP_WORKTREE bit is not
set)
But let's ignore the splitting of the tracked type for a minute as
well as everything else related to sparseness.  Let's just look at how
grep was designed.

git grep has traditionally been about searching "tracked files in the
work tree" as you highlighted (and note that sparsity bits came four
years later in 2009, so cannot undercut that claim).  If the user has
made edits to files and hasn't staged them, grep would search those
working tree files with their edits, not old cached versions of those
files.  People were told that git grep was a great way to just search
relevant stuff (instead of normal grep which would look through build
results and random big files in your working directory that you
weren't even tracking).  Then in 2011 grep gained options like
--untracked to extend the search in the working tree to also include
untracked files, and added --no-exclude-standard (which is "only
useful with --untracked") so that people had a way to search *all*
files in the working tree (tracked, untracked, and ignored files).
(Note: no mechanism was provided for searching tracked and ignored
files without untracked as far as I can tell, though I don't see why
that would make sense.)  git-grep also gained options like --no-index
so that it could be used in a directory that wasn't tracked by git at
all -- it turns out people liked git-grep better than normal grep (I
think it got colorization first?), even for things that weren't being
tracked by git.  But again, all these cases were about searching files
that existed in the working tree.

Of course, people sometimes wanted to search a version other than what
existed in the working tree.  And thus options like --cached or
specifying a REVISION were added early on.

Sometimes, code that wasn't meant to be used together accidentally is
used together or the docs suggest they can be used together.  In 2010,
someone had to clarify that --cached was incompatible with <tree>; not
sure why someone would attempt to use them together, but that's the
type of accident that is easy to have in the implementation or docs
because it doesn't even occur to people who understand the design and
the data structures why anyone would attempt that.  Inevitably,
someone comes along who doesn't understand the underlying data
structures or design or terminology and tries incompatible options
together...and then gets surprised.  (Side note: I think this kind of
issues occurs fairly frequently, so I'm unlikely to assume options
were meant to be supported together based solely on a lack of logic
that would throw an error when both are specified.  We could probably
add a bunch of useful microprojects around checking for flags that
should be incompatible and making sure git throws errors when both are
specified.  We had lots of cases in rebase, for example, where if
users happened to specify two flags then one would just be silently
ignored.)

REVISION and --cached are not just incompatible with each other; each
is incompatible with all three of --untracked, --no-index, and
--no-exclude-standard.  This is because REVISION and --cached are
about picking some version other than what exists in the working tree
to search through, while those other options are all intended for when
we are searching through files in the working tree (and in particular,
exist to extend how many files in the working tree we look through).

One more useful case to consider before we start adding SKIP_WORKTREE
into the mix.  Let's say that you have three files:
   fileA
   fileB
   fileC
and all of them are tracked.  You have made edits to fileA and fileB,
and ran 'rm fileC' (NOT 'git rm fileC', i.e. the deletion is not
staged).  Now, you run 'git grep mystring'.  Quick question: Which
files are searched for 'mystring'?  Well...
  * REVISION and --cached were left out of the git grep command, so
working tree files should be searched, not staged versions or versions
from other commits
  * No flags like --untracked or --no-exclude-standard were included,
so only tracked files in the working tree should be searched
  * There are two files in the working tree, both tracked: fileA and fileB.
So, this searches fileA and fileB.  In particular: NO VERSION of fileC
is searched.  fileC may be tracked/cached, but we don't search any
version of that file, because this particular command line is about
searching the working directory and fileC is not in the working
directory.  To the best of my knowledge, git grep has always behaved
that way.


Users understand the idea of searching the working copy vs. the index
vs. "old" (or different) versions of the repository.  They also
understand that when searching the working copy, by default a subset
of the files are searched.  Tell me: given all this information here,
what possible explanation is there for SKIP_WORKTREE entries to be
translated into searches of the cache when --cached is not specified?
Please square that away with the fact that 'rm fileC' results in fileC
NOT being searched.

It's just completely, utterly wrong.

Also, hopefully this helps answer your question about --untracked and
skip_worktree.  --untracked is only useful when searching through the
working tree, and is entirely about adding the "untracked" category to
the things we search.  The skip_worktree bit is about adding more
granularity to the "tracked" category.  The two are thus entirely
orthogonal and --untracked shouldn't change behavior at all in the
face of sparse checkouts.

And I also think it explains more when the sparsity patterns and
--ignore-sparsity-patterns flags even matter.  The division of working
tree files which were tracked into two subsets (those that match
sparsity patterns and those that don't) didn't matter because only one
of those two sets existed and could be searched.  So the question is,
when can the sparsity pattern divide a set of files into two subsets
where both are non-empty?  And the answer is when --cached or REVISION
is specified.  This is the case Junio recently brought up and said
that there are good reasons users might want to limit to just the
paths that match the sparsity patterns, and other reasons when users
might want to search everything[6].  So, both cases need to be
supported fairly easily, and this will be true for several commands
besides just grep.

[6] https://lore.kernel.org/git/xmqq7dz938sc.fsf@gitster.c.googlers.com/

> > If the incompatibility of
> > --untracked and --cached/REVSIONS/TREES is not enforced, we may want
> > to look into erroring out if they are given together.  Once we do, we
> > don't have to worry about grep_cache() at all in the case of
> > --untracked and shouldn't.  Files with the skip_worktree bit won't
> > exist in the working directory, and thus won't be searched (this is
> > what makes --untracked imply --ignore-sparsity not really matter).
> >
> > In short: With --untracked you are grepping ALL (non-ignored) files in
> > the working directory -- either because they are both tracked and in
> > the sparsity paths (anything tracked that isn't in the sparsity paths
> > has the skip_worktree bit and thus isn't present), or because it is an
> > untracked file.  [And this may be what grep_directory() already does.]
> >
> > Does that make sense?
>
> It does, and thanks for a very detailed explanation. But as I
> mentioned before, I'm a little uncertain about --untracked implying
> --ignore-sparsity. The commit that added --untracked (0a93fb8) says:
>
> "grep --untracked" would find the specified patterns from files in
> untracked files in addition to its usual behaviour of finding them in
> the tracked files
>
> So, in my mind, it feels like --untracked wasn't meant to limit the
> search to "all non-ignored files in the working directory", but to add
> untracked files to the search (which could also contain tracked but
> non checked out files). Wouldn't the "all non-ignored files in the
> working directory" case be the use of --no-index?

--no-index is specifically designed for when the directory isn't
tracked by git at all.  It would be equivalent, though, to saying we
wanted to search all files in the working copy regardless of whether
they are tracked, untracked, or ignored, i.e. equivalent to specifying
both --untracked and --no-exclude-standard.

And you were right to be uncertain about --untracked implying
--ignore-sparsity; --untracked is completely orthogonal to sparsity.
(However, it wouldn't much matter if it did imply that option or if it
implied its opposite: --untracked implies we are only looking at the
working directory files, and thus we aren't even going to check the
sparsity patterns, we'll just check which files exist in the working
directory.  `git sparse-checkout reapply` will care about the sparsity
patterns and possibly add files to the working copy or remove some,
but grep certainly shouldn't be having a side effect like that; it
should just search the directory as it exists.)

> > > diff --git a/builtin/grep.c b/builtin/grep.c
> > > index 52ec72a036..17eae3edd6 100644
> > > --- a/builtin/grep.c
> > > +++ b/builtin/grep.c
> ...
> > >
> > > @@ -487,7 +492,7 @@ static int grep_cache(struct grep_opt *opt,
> > >         for (nr = 0; nr < repo->index->cache_nr; nr++) {
> > >                 const struct cache_entry *ce = repo->index->cache[nr];
> > >
> > > -               if (ce_skip_worktree(ce))
> > > +               if (!ignore_sparsity && ce_skip_worktree(ce))
> >
> > Oh boy on the double negatives...maybe we want to rename this flag somehow?
>
> Yeah, I also thought about that, but couldn't come up with a better
> name myself... My alternatives were all too verbose.
>
> ...
> > I'm super excited to see work in this area.  I hope I'm not
> > discouraging you by attempting to provide what I think is the bigger
> > picture I'd like us to work towards.
>
> Not at all! :) Thanks a lot for the bigger picture and other
> explanations. They help me understand the long-term goals and make
> better decisions now.

Hope this email helps too.  I've composed it over about 4 different
sessions with various interruptions, so there's a good chance all my
edits and loss of train of thought might have made something murky.
Let me know which part(s) are confusing and I'll try to clarify.

Elijah
