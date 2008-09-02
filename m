From: Petr Baudis <pasky@suse.cz>
Subject: Re: pack count on repo.or.cz [was "Medium term dreams"]
Date: Tue, 2 Sep 2008 13:15:31 +0200
Message-ID: <20080902111531.GL10360@machine.or.cz>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz> <20080902011433.GA12682@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 13:16:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaTsO-0000pR-Q6
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 13:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYIBLPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYIBLPh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 07:15:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54033 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbYIBLPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 07:15:36 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 028863939B44; Tue,  2 Sep 2008 13:15:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080902011433.GA12682@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94666>

On Mon, Sep 01, 2008 at 09:14:33PM -0400, Jeff King wrote:
> On Tue, Sep 02, 2008 at 03:04:10AM +0200, Petr Baudis wrote:
> 
> > Unfortunately, I'm not aware how to decreate the packs count with
> > current Git without losing _any_ objects. So yes, you could say that
> > this is an artifact of the forking infrastructure - we just can't afford
> > to lose objects.
> 
> Hmm, I thought that was the point of adding the "-A" flag to git-repack.

Ok, I did

	git repack -A -d

in repo.or.cz's git.git. What next? I have brand-new

	-rw-rw-r-- 1 root root  1314056 2008-09-02 13:07 pack-d19ca8b0cfd0e3357c475a3e96ce55b9f7195667.idx
	-rw-rw-r-- 1 root root 17344999 2008-09-02 13:07 pack-d19ca8b0cfd0e3357c475a3e96ce55b9f7195667.pack

but all the old packs too; git repack didn't delete anything,
git prune-packed seems to have no effect either.

> Though an even simpler solution, since you control all of the repos, is
> to just temporarily add references from the "parent" of the fork to
> every ref of every forked child. Then do the repack in the parent, which
> should then contain all of the objects for all of the children, delete
> the temporary references, and prune in the children (who should see most
> of their objects now in the parent).

So not just refs but also alternates? What if someone accesses the
reposiory at that moment? I would also need to make the symlinks quite
densely to avoid refs/forkee/-induced loops.

I might as well just use a common repository for all the forks then. But
this does not scale at all for dumb transports, does it?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
