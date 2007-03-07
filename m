From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git push failure with update hook success
Date: Wed, 7 Mar 2007 12:38:04 -0500
Message-ID: <20070307173804.GC27922@spearce.org>
References: <17902.59497.831409.218529@lisa.zopyra.com> <17902.60536.5890.608883@lisa.zopyra.com> <20070307170904.GB27922@spearce.org> <17902.62836.920473.810183@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:38:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP066-0000lS-Tq
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 18:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbXCGRiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 12:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbXCGRiQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 12:38:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44833 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422948AbXCGRiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 12:38:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP05P-0007RE-MJ; Wed, 07 Mar 2007 12:37:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7E60820FBAE; Wed,  7 Mar 2007 12:38:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17902.62836.920473.810183@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41681>

Bill Lear <rael@zopyra.com> wrote:
> Ok, thank you for fixing this.  I guess the call run_update_hook()
> should not in fact come after the write_ref_sha1() block, and just
> before the 'return 0' line, because you don't want to run the
> write_ref_sha1() at all if the update hook complains.

Exactly.  :-)
 
> >You probably want to use the post-update hook to send email.
> >This hook will always run if it exists and is executable, but it
> >won't be given a ref that failed to be updated.
> >
> >Of course an unfortunate downside to the post-update hook is it
> >does not receive the old SHA-1 of the ref; it just gets the ref name.
> 
> Hmm, I agree that this sounds like the better place, logically
> speaking, for the email report to be generated, but unfortunate since
> I'm lame with git, so writing a post-update hook from scratch will
> probably be beyond my abilities, but since I just watched "Touching
> the Void" last night, I might be inspired to brave it.
>
> Since it just gets the ref name, would one (of sufficient skill) be
> able to reconstruct the same sort of report that the "pre" update hook
> does?  That is, from the ref name can I get the old SHA-1?  If I try
> to write this, what I think I would like to do is just call the
> existing update hook from the post-update hook, with the post update
> hook figuring out the proper arguments to pass along.

If you have a reflog enabled you can use name@{1}..name to generate
the list, but this is subject to a race condition as the ref could
be updated by someone else before you get to look at it to generate
the output.

I'm actually working on a patch right now to create a new hook
(hooks/post-receive ?) that takes the 3 arg form like hooks/update
does, avoiding the race condition entirely.
 
-- 
Shawn.
