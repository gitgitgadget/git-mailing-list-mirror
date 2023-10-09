Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3872E95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbjJIBht (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJIBhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:37:48 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A688F
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:37:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7743448d88eso282676985a.2
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696815464; x=1697420264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAgVCR4ZKiDo+VDpJmnjopEoaptwZYN/3vISJbWU6kc=;
        b=2jGStRSe5twRlNHqG3IlLnIZxDqbUsFelpZWDLlUUj7dXrI6jANjvpxktY1GIdl5iy
         lo02gFNbBnF+UTWgagArmzgELOsNgfISQXPU4y1Stm6ca5XncOhea9V2fiuXoUTElfIw
         bHIRXlsyyTPgeO5BBjd+j/med3H2Hb1yqvldIcrgu7erQdGPgUhNmL2zeAby0b0Fgxa/
         ykrSCYJo6SaPh0dDjo+JnN8k5ADazux3Xzrepy6F1XGAFsCxn8L2KUDFTLiFCqYFz/+E
         PMyqOUnPDWIcGZEifnKqEwD/j99aE5egMCrAuNIyMHF4lolzWfqTaAGk4iMdUS3PsrYY
         vvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696815464; x=1697420264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAgVCR4ZKiDo+VDpJmnjopEoaptwZYN/3vISJbWU6kc=;
        b=sG0JURGaD2hsGzVrHaJvJ2FQSwyBaNrrivclmOlXEOi89Aq2i+ZcJti2H/sAZ6QI5Z
         zMuquchf30WUY//wt/RnMn/RcG2YGL/QQj2gPZQSvAJIFbUga1p7mpL2cNYbuJX3afgh
         l9FQG1R6codCGCpAb54BWT1UAk7smS3ARHuXTI/FWO55ACH5yDhMMFRJUetlWgX0hYdm
         gJA2gA3JPIGqxbbT2JZ3DrH+oHqxGba2T04//Wdge0HuqwBZAia1sUciyN8IGUuNgLOR
         +IlPDfVkr5xHcw34/w6y6ejPnAhvjsnU0ykNWSIeRA/Z+ioVg6yGbzwkzT5OZjnOxT3V
         xnAQ==
X-Gm-Message-State: AOJu0Yz0kzw/R2ODdTvJ5eWYqnYV68XQll5r335a0fIePdf/3vQXKxxa
        IkLx7Oi4XtaQYi6FrVDZm/VpjA==
X-Google-Smtp-Source: AGHT+IGyWO18j2dloSIaP+akw59bTxMgJEFoBV0JHVWE9smegXGBoevlUeGc5KZ4NRA1X+IN8pAn3w==
X-Received: by 2002:a05:620a:22f5:b0:774:1adc:c572 with SMTP id p21-20020a05620a22f500b007741adcc572mr13581558qki.74.1696815464331;
        Sun, 08 Oct 2023 18:37:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d2-20020a05620a158200b00767d4a3f4d9sm3169480qkk.29.2023.10.08.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:37:43 -0700 (PDT)
Date:   Sun, 8 Oct 2023 21:37:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@gmail.com>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZSNZZrWyCqRH+0Bd@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
 <CABPp-BE+mJ4e==fWNqUNi5RVkoui_xeZN+axnM6vBykDqAzHiA@mail.gmail.com>
 <ZSLS9G1lHruig48a@nand.local>
 <20231008173329.GA1557002@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231008173329.GA1557002@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2023 at 01:33:29PM -0400, Jeff King wrote:
> On Sun, Oct 08, 2023 at 12:04:04PM -0400, Taylor Blau wrote:
>
> > > I was interested in the same question as Junio, but from a different
> > > angle.  fast-import documentation points out that the packs it creates
> > > are suboptimal with poorer delta choices.  Are the packs created by
> > > bulk-checkin prone to the same issues?  When I was thinking in terms
> > > of having "git merge" use fast-import for pack creation instead of
> > > writing loose objects (an idea I never investigated very far), I was
> > > wondering if I'd need to mark those packs as "less optimal" and do
> > > something to make sure they were more likely to be repacked.
> > >
> > > I believe geometric repacking didn't exist back when I was thinking
> > > about this, and perhaps geometric repacking automatically handles
> > > things nicely for us.  Does it, or are we risking retaining
> > > sub-optimal deltas from the bulk-checkin code?
> > >
> > > (I've never really cracked open the pack code, so I have absolutely no
> > > idea; I'm just curious.)
> >
> > Yes, the bulk-checkin mechanism suffers from an even worse problem which
> > is the pack it creates will contain no deltas whatsoever. The contents
> > of the pack are just getting written as-is, so there's no fancy
> > delta-ficiation going on.
>
> I wonder how big a deal this would be in practice for merges.
> pack-objects will look for deltas between any two candidates objects,
> but in practice I think most deltas are between objects from multiple
> commits (across the "time" dimension, if you will) rather than within a
> single tree (the "space" dimension). And a merge operation is generally
> creating a single new tree (recursive merging may create intermediate
> states which would delta, but we don't actually need to keep those
> intermediate ones. I won't be surprised if we do, though).
>
> We should be able to test that theory by looking at existing deltas.
> Here's a script which builds an index of blobs and trees to the commits
> that introduce them:
>
>   git rev-list HEAD |
>   git diff-tree --stdin -r -m -t --raw |
>   perl -lne '
>     if (/^[0-9a-f]/) {
>       $commit = $_;
>     } elsif (/^:\S+ \S+ \S+ (\S+)/) {
>       $h{$1} = $commit;
>     }
>     END { print "$_ $h{$_}" for keys(%h) }
>   ' >commits.db
>
> And then we can see which deltas come from the same commit:
>
>   git cat-file --batch-all-objects --batch-check='%(objectname) %(deltabase)' |
>   perl -alne '
>     BEGIN {
>       open(my $fh, "<", "commits.db");
>       %commit = map { chomp; split } <$fh>;
>     }
>     next if $F[1] =~ /0{40}/; # not a delta
>     next unless defined $commit{$F[0]}; # not in index
>     print $commit{$F[0]} eq $commit{$F[1]} ? "inner" : "outer", " ", $_;
>   '
>
> In git.git, I see 460 "inner" deltas, and 193,081 "outer" ones. The
> inner ones are mostly small single-file test vectors, which makes sense.
> It's possible to have a merge result that does conflict resolution in
> two such files (that would then delta), but it seems like a fairly
> unlikely case. Numbers for linux.git are similar.
>
> So it might just not be a big issue at all for this use case.

Very interesting, thanks for running (and documenting!) this experiment.
I'm mostly with you that it probably doesn't make a huge difference in
practice here.

One thing that I'm not entirely clear on is how we'd treat objects that
could be good delta candidates for each other between two packs. For
instance, if I write a tree corresponding to the merge between two
branches, it's likely that the resulting tree would be a good delta
candidate against either of the trees at the tips of those two refs.

But we won't pack those trees (the ones at the tips of the refs) in the
same pack as the tree containing their merge. If we later on tried to
repack, would we evaluate the tip trees as possible delta candidates
against the merged tree? Or would we look at the merged tree, realize it
isn't delta'd with anything, and then not attempt to find any
candidates?

> > I think Michael Haggerty (?) suggested to me off-list that it might be
> > interesting to have a flag that we could mark packs with bad/no deltas
> > as such so that we don't implicitly trust their contents as having high
> > quality deltas.
>
> I was going to suggest the same thing. ;) Unfortunately it's a bit
> tricky to do as we have no room in the file format for an optional flag.
> You'd have to add a ".mediocre-delta" file or something.

Yeah, I figured that we'd add a new ".baddeltas" file or something. (As
an aside, we probably should have an optional flags section in the .pack
format, since we seem to have a lot of optional pack extensions: .rev,
.bitmap, .keep, .promisor, etc.)

> But here's another approach. I recall discussing a while back the idea
> that we should not necessarily trust the quality of deltas in packs that
> are pushed (and I think Thomas Gummerer even did some experiments inside
> GitHub with those, though I don't remember the results). And one way
> around that is during geometric repacking to consider the biggest/oldest
> pack as "preferred", reuse its deltas, but always compute from scratch
> with the others (neither reusing on-disk deltas, nor skipping
> try_delta() when two objects come from the same pack).
>
> That same strategy would work here (and for incremental fast-import
> packs, though of course not if your fast-import pack is the "big" one
> after you do a from-scratch import).

Yeah, definitely. I think that that code is still living in GitHub's
fork, but inactive since we haven't set any of the relevant
configuration in GitHub's production environment.

> Possibly it exacerbates the "no deltas" issue from above (though it
> would depend on the command).  The bigger question to me is one of
> checkpointing. When do we finish off the pack with a .idx and make it
> available to other readers? We could do it at program exit, but I
> suspect there are some commands that really want to make objects
> available sooner (e.g., as soon as "git add" writes an index, we'd want
> those objects to already be available). Probably every program that
> writes objects would need to be annotated with a checkpoint call (which
> would be a noop in loose object mode).
>
> So maybe it's a dumb direction. I dunno.

I wouldn't say it's a dumb direction ;-). But I'd be hesitant pursuing
it without solving the "no deltas" question from earlier.

Thanks,
Taylor
