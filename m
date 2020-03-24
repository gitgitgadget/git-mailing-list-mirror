Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE03C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B452E208CA
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YXXz4izO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCXXIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:08:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39241 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgCXXIa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 19:08:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so70076pfn.6
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WSFXyg4h5Z7k+NHzSK0PA1I9sdPZOSMBvMHPUxHQ6Ns=;
        b=YXXz4izO2O/5hzPvG8lVPSI7nFfzYaO6YxbO2kuGg/uS5EZ47Ch4SB3WEvW3Hi1q2p
         2OWMpRuJTwle6nUNrAgyLPAVy0wUsjIOoCDqoPwAjeoNY2ibTJrdJ4HtbfvPk+hkQ2gD
         56c26vbte7Zuiqb2zEK052WZy4rhJ8LkQJZ+etFqUNr47MzzuDvL+Wn3YMDsGZYgKaUc
         dGbtN001JSYj9fJq2YpfgCh/kRreylJAnwkXlmygmbubhUPfYgCTqS5m62Z7lUp1JiEJ
         7DGKIf5yz9L7U//KDTHl4hafWuNu2jCRMrKTpz/HNdL/XObhb4GbapDowM0TuXGEjfrw
         3+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WSFXyg4h5Z7k+NHzSK0PA1I9sdPZOSMBvMHPUxHQ6Ns=;
        b=mIAqNwXbfjhxZGvOXSDW3vxqF0r97aTXS7f75OR4kCRQESp5O5JBDZlhICfQDP1N4v
         EX/gQ+r6aXPeeCn5rRw0Q1N3MnLVmLRbaa0hdnGwFL06UCEB/Le2PQBoYIvcgC+0nlY5
         FTnvekG8s+i3D2OsmS1e7DGtEalzPjxeu+V3xAc6HpmzL/iApkFtbUuBxrqCNVrat1kV
         HZp6h4Zv6/pa1jPV+tFZPjc0p+q/8Lq4fnta9BcSACv/mEwswq+W5eNGX6r/KFLIHUAP
         QlqdS3i04coxbpICWG/jUhPphj3RqrXwlxmCycMzompMlXSHJmK84KaTpshGn8in5RRu
         ZIbA==
X-Gm-Message-State: ANhLgQ3G2NR9blBPBpFjyIOwOFsBxlsHKyiX+rDCXfXk29eywTRanh12
        /RrR8Xc0XTMlM3nLdVayxluIwA==
X-Google-Smtp-Source: ADFU+vvxWrfKp0vC+hNcpC8dTxhHnaYuFvI0ZlNaI3y1cqk0OsKGKOQb73Jl7iTJOG935ZAPha9vdw==
X-Received: by 2002:aa7:8d82:: with SMTP id i2mr135305pfr.179.1585091308677;
        Tue, 24 Mar 2020 16:08:28 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c15sm10735944pfo.139.2020.03.24.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 16:08:28 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:08:26 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200324230826.GA42939@syl.local>
References: <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
 <20200322060434.GC578498@coredump.intra.peff.net>
 <20200322154749.GB53402@syl.local>
 <20200324061159.GC610977@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324061159.GC610977@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 02:11:59AM -0400, Jeff King wrote:
> On Sun, Mar 22, 2020 at 09:47:49AM -0600, Taylor Blau wrote:
>
> > > > [1] I'm actually not quite sure about correctness here. It should be
> > > >     fine to generate a graph file without any given commit; readers will
> > > >     just have to load that commit the old-fashioned way. But at this
> > > >     phase of "commit-graph write", I think we'll already have done the
> > > >     close_reachable() check. What does it mean to throw away a commit at
> > > >     this stage? If we're the parent of another commit, then it will have
> > > >     trouble referring to us by a uint32_t. Will the actual writing phase
> > > >     barf, or will we generate an invalid graph file?
> > >
> > > It doesn't seem great. If I instrument Git like this to simulate an
> > > object temporarily "missing" (if it were really missing the whole repo
> > > would be corrupt; we're trying to see what would happen if a race causes
> > > us to momentarily not see it):
> >
> > This is definitely a problem on either side of this patch, which is
> > demonstrated by the fact that you applied your changes without my patch
> > on top (and that my patch isn't changing anything substantial in this
> > area like removing the 'continue' statement).
> >
> > Should we address this before moving on with my patch? I think that we
> > *could*, but I'd rather go forward with what we have for now, since it's
> > only improving the situation, and not introducing a new bug.
>
> I do agree it's a problem before your patch. But I think your patch may
> make it a lot more common, if only because it means we'd _actually_ be
> dropping entries for objects that went away, instead of accidentally
> keeping them due to re-using the graph result. So it probably is worth
> trying to deal with it now, or at least thinking hard about it.
>
> The trouble is that I'm not sure what _should_ happen. Aborting the
> whole commit-graph generation seems overboard (and would be annoying for
> cases where whole swaths of history became unreachable and went away;
> presumably we'd be dropping _all_ of those objects, and the write phase
> would be just fine). I have a feeling the correct solution is to do this
> merging pass earlier, before we check close_reachable(). Or if not a
> true merging pass, at least a pass to check which existing entries are
> still valid. But I don't know how painful that reordering would be.

Maybe, but I'm not sure that moving 'close_reachable' up would
necessarily solve all of our problems. Or, at least, that it wouldn't
create a set of new problems :).

Let's say that you have (1) some connected component of your history
that is written to a commit-graph, where (2) part of that cluster has
been dropped (e.g., due to corruption, a rogue 'git gc', etc), and (3)
you're writing a new graph with '--input=graphed'.

What is 'close_reachable' supposed to do? If some of the now-missing
commits are in the reachability closure of the commits that still exist
in the repository, then we're back to where we started. We *could* have
'close_reachable' take all missing commits and drop their ancestors and
descendants, but this creates quite the headache for 'close_reachable',
which now needs to keep track of such things.

I'm hopeful that this isn't so common in practice, but I'm also not
entirely sure one way or another. I can plan to deploy this patch to
GitHub's servers for a ~month and see if we experience it. If it turns
out to be common, I'll assume that others have this problem, too, in
which case we can go back and think more about it.

But, I'm hopeful that this problem is rare enough that it isn't worth
worrying about for anybody, GitHub or not.

> -Peff

Thanks,
Taylor
