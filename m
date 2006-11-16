X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:02:11 -0800
Message-ID: <f2b55d220611151902v794edd77i9f76815e4b03a966@mail.gmail.com>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
	 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	 <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	 <87velgs9hx.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
	 <87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>
	 <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 03:03:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YJQ/U5JLHoRN5bMyCeIZQqNvrGR+syKcX7Xc/DopFzZOyXBhX1YFsB/ukSBFLvWvTQHBaq/3gBlS4AJu8lApJdTEoobuuemNNQIFCD6OpPzazjXZ0sZTP/sQv12esT2GBcnCaCcBW0MtBoVn7nwJQOnzsQchckDl1gLMJMPGJl0=
In-Reply-To: <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31546>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXW6-00072N-76 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030585AbWKPDCN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030773AbWKPDCN
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:02:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:5270 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1030585AbWKPDCM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:02:12 -0500
Received: by wx-out-0506.google.com with SMTP id s7so442475wxc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 19:02:11 -0800 (PST)
Received: by 10.90.72.10 with SMTP id u10mr4987aga.1163646131685; Wed, 15 Nov
 2006 19:02:11 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Wed, 15 Nov 2006 19:02:11 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/15/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Actually, with different people involved it's _much_ better to do it in
> one shot.
>
> Why? Because doing a separate "fetch to local space" + "merge from local
> space" actually loses the information on what you are merging.
>
> It's a lot more useful to have a merge message like
>
>         Merge branch 'for-linus' of git://one.firstfloor.org/home/andi/git/linux-2.6
>
> than one like
>
>         Merge branch 'for-linus'
>
> which is what you get if you fetched it first.

Full ACK from a platform integrator's perspective.  Local merge is
great for trial runs but the history in a persistent branch should be
as self-contained and self-explanatory as possible.  It shouldn't
depend on what I name local tracking branches, which are just a
convenience so that I can still do trial runs when my connectivity is
broken.

I don't have to manually log the _mechanical_origin_ of a given delta;
git does that for me, and mostly just DTRT when the same delta arrives
via several paths.  When I use git pull from a remote branch (with or
without an entry in remotes/heads, which for this purpose is just
shorthand), I don't have to manually log what conflicts I have and
haven't resolved, either; I must have assimilated whatever I cared
about in the remote branch's history up to that point, because as long
as there are things in that remote branch that I haven't decided how
to handle, I stick to cherry-picking.

Obviously, fetch to local space is great (especially when you spend
some of your working hours behind a firewall that blocks outbound TCP
9418).  Fetch from local space is also great, when the local space you
are fetching from reflects local work (such as a sync point and
reconciliation of several upstream sources, which then needs to be
ported forward or back to the chosen core version for each platform).
Fetch from a local space that is just a tracker for remote work is not
great, because it doesn't capture the editorial decision implied by a
remote pull:  I looked at what the remote branch had to offer as of
this date, systematically decided which bits did and didn't belong in
the branch to which I was pulling, and pulled.

The record of that pull becomes a first-class object because it's
attached to an actual content delta in the target branch.  So it
propagates into branches that pull from it.  Pulling this delta into
another branch is different from cherry-picking a feature delta; it
implies acceptance of the reconciliation and editorial work associated
with the merge in the source branch.

Coming from me, this is all rather theoretical, as I haven't been
using this particular tool for the purpose long enough to have an
independent opinion.  But for what it's worth, the workflow Linus
describes isn't just for the guy at the top of the pyramid.

Cheers,
