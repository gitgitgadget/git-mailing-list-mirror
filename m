Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C57F1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 22:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfDVWcT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 18:32:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfDVWcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 18:32:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D3B5615E3; Mon, 22 Apr 2019 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555972338;
        bh=cuiS4coESDZAqnWvZy8pe71T1wGMmpYMwR2A9V16iXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThKo9T+rbD3W5NEQtWsAt4gshRTHg7z+A7+M34AJG2IR1R/e+f8AYeZ+Ce2nWZiSn
         EZzmMVHFYPp3q8bTb1aSfkrONcsbunu27ra8SPAm0XMEEL/8UFzIE/G4QSWikIMtyI
         HpQ2lbjSwdSiXuIPc2nKtA30DuwX9KBzkkjkNJng=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66767608FC;
        Mon, 22 Apr 2019 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555972337;
        bh=cuiS4coESDZAqnWvZy8pe71T1wGMmpYMwR2A9V16iXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Msod+/vTHICqMnEMLILk4hN7iAEyhoTS7k2/ZpYLlTgCvnznwNivQMxfeJurnl+2Y
         AIer3jCz2DzNTumwuAIJlGpYUhS/P1XiglZyzXmdc5p7kf0HMLFohpCVrTibaIrOoY
         EcLFi41xMYWPomYY87LfAByWcMuIEGDMx/QakxRo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66767608FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Date:   Mon, 22 Apr 2019 16:32:16 -0600
Message-ID: <19221376.OlD5LWjr85@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-137-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20190422205653.GA30286@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx> <16052712.dFCfNLlQnN@mfick-lnx> <20190422205653.GA30286@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, April 22, 2019 4:56:54 PM MDT Jeff King wrote:
> On Mon, Apr 22, 2019 at 02:21:40PM -0600, Martin Fick wrote:
> > > Try this (with a recent version of git; your v1.8.2.1 won't have
> > > 
> > > --batch-all-objects):
> > >   # count the on-disk size of all objects
> > >   git cat-file --batch-all-objects --batch-check='%(objectsize)
> > > 
> > > %(objectsize:disk)' | perl -alne '
> > > 
> > >     $repo += $F[0];
> > >     $disk += $F[1];
> > >     END { print "$repo / $disk = ", $repo/$disk }
> > >   
> > >   '
> > 
> > This has been running for a few hours now, I will update you with results
> > when its done.
> 
> Hours? I think something might be wrong. It takes 20s to run on
> linux.git.

OK, yes I was running this on a "bad" copy of the repo, see below because I 
think it might be of some interest also...

On the better copy, the git part of the command took 3m48.025s (still not 20s, 
but not hours either), using git v2.18. The results were:

2085532480789 / 7909358121 = 263.679106304687

This seems to confirm the sizing numbers.


As for the "bad repo", let me describe:

1) It is on a different machine (only 32 processors, and some serious 
background load)

2) That copy of the repo is from a mirror clone of our source repo without 
running repacking (-f) on it. Without repacking -f, the clone is actually 16G, 
which I believe is using the deltas from the source repo which would have been 
created by people pushing new commits over and over to the source repo and 
those new objects just being added to the common pack file during repacking 
without creating a ton of new deltas. It would appear that the deltas created 
from regular repacking without using the -f may be really destroying some of 
the performance of our source repo even worse then I imagined. The rest of my 
testing has been done on a repo repacked with -f to eliminate the variability 
imposed from the source repo because I figured it would adversely impact 
things, but I did not imagine it being that bad because even the clone time of 
the bad repo is not that bad, so I wonder why the git cat-file is way worse?


> The key is really having objects where the size of change versus the
> file size is small (so the marginal cost of each revision is small), and
> then having lots of changes (to give you a big multiplier).

Right.

> > > So yes, if you really do have to hash 2TB of data, that's going to take
> > > a while.
> > 
> > I was hoping I was wrong. Unfortunately I sense that this is not likely
> > something we can improve with a better algorithm. It seems like the best
> > way to handle this long term is likely to use BUP's rolling hash
> > splitting, it would make this way better (assuming it made objects small
> > enough). I think it is interesting that this approach might end up being
> > effective for more than just large binary file repos. If I could get this
> > repo into bup somehow, it could potentially show us if this would
> > drastically reduce the index-pack time.
> 
> It fundamentally can't help without changing Git's object model, since
> you need to have complete hashes of all of those files. If you're
> proposing to do rolling hashes to split blobs into multiple objects that
> would definitely work. But it wouldn't be compatible with Git anymore.

Right. I really just meant to point out how many people may want the BUP style 
rolling hash split blobs in git even without having gigantic blobs since it 
might really help with smaller blobs and long histories with small deltas. 
Most of the git performance issues tend to focus on large repos with large 
blobs, that is what BUP was made for, but it could really help normal git 
users, possibly even the kernel as we start to develop some seriously longer 
histories. I think most assumptions have been that this is not likely to be a 
problem any time soon.

> Are you running it in the same repo, or in another newly-created repo?

Yes.

> Or alternatively, in a new repo but repeatedly running index-pack? After
> the first run, that repo will have all of the objects. And so for each
> object it sees, index-pack will say "woah, we already had that one;
> let's double check that they're byte for byte identical" which carries
> extra overhead (and probably makes the lock contention way worse, too,
> because accessing existing objects just has one big coarse lock).
> 
> So definitely do something like:
> 
>   for threads in 1 2 3 4 5 12 56; do
> 	rm -rf repo.git
> 	git init --bare repo.git
> 	GIT_FORCE_THREADS=$threads \
> 	  git -C repo.git index-pack -v --stdin </path/to/pack
>   done
> 
> to test.

Makes sense, testing now...

> > Perhaps the locking can be improved here to make threading more effective?
> 
> Probably, but easier said than done, of course.
> 
> > > We also hash non-deltas while we're receiving them over the network.
> > > That's accounted for in the "receiving pack" part of the progress meter.
> > > If the time looks to be going to "resolving deltas", then that should
> > > all be threaded.
> > 
> > Would it make sense to make the receiving pack time also threaded because
> > I
> > believe that time is still longer than the I/O time (2 or 3 times)?
> 
> It's a lot harder to thread since we're eating the incoming bytes. And
> unless you're just coming from a local disk copy, the network is
> generally the bottleneck (and if you are coming from a local disk copy,
> then consider doing a local clone which will avoid all of this hashing
> in the first place).

Is that really a fair assumption in today's intranets? Many corporate LANs 
have higher bandwidth than normal disks, don't they?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

