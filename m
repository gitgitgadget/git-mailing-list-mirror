From: David Roundy <droundy@abridgegame.org>
Subject: Re: [darcs-devel] Re: A darcs that can pull from git
Date: Tue, 26 Apr 2005 08:47:09 -0400
Message-ID: <20050426124704.GB28120@abridgegame.org>
References: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr> <20050425133116.GG11667@abridgegame.org> <7i4qdusxdw.fsf@lanthane.pps.jussieu.fr> <20050426110613.GB20723@abridgegame.org> <20050426123445.GE18971@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 14:49:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQPT9-0001pz-L5
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 14:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDZMwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 08:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVDZMwY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 08:52:24 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:296 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261498AbVDZMwR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 08:52:17 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DQPT3-0007vI-UM; Tue, 26 Apr 2005 08:47:09 -0400
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>,
	Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050426123445.GE18971@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2005 at 02:34:45PM +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 26, 2005 at 01:06:17PM CEST, I got a letter
> where David Roundy <droundy@abridgegame.org> told me that...
> > Do the git have any suggestions about how to avoid excess downloads or
> > excess copies of a git repository? It seems to me like it would make sense
> > to always download sha1s to ~/.gitcache/, and then hardlink them to the
> > current git repository, so you wouldn't end up ever downloading the same
> > sha1 twice.  Or we should use $GITCACHE/, to give the user some
> > flexibility.  But perhaps this is an already-solved problem, and I've just
> > not noticed...
> 
> I'm not sure about the problem you are actually trying to solve, and I
> didn't manage to guess it quickly just from the mails themselves;
> cg-init /local/path now hardlinks the sha1 objects to the local
> .git/objects directory, so you get no space waste. If you are talking
> about downloading stuff from remote repositories, http-pull might help.

Yeah, what I was wondering about was the scenario where a user does (and
pardon any errors, I haven't actually used cogito) something like

cd foo
cg-init http://remote_repository
cd ../bar
cg-init ../foo

(so far we've only got hard links and everything is great)

http-pull http://remote_repository (downloads a few more commits to bar)
cd ../foo
http-pull http://remote_repository

Does this last pull download the same commits as the previous one? Ideally
it wouldn't.  The whole point of the sha1-named files is that you don't
have to worry about where you got it from.  Ideally the second pull would
get the actual files from ../bar, where they've already been downloaded.

Or perhaps (and this was what I was *really* hoping) all the cogito remote
operations would store a hardlink of their results in a common cache
directory, so that one could actually do

cd foo
cg-init http://remote_repository
cd ../bar
cg-init http://remote_repository

without either downloading anything twice, or wasting any disk space.  In
practice what's more likely in practice is that you'll want to

cd foo
cg-init http://linus_remote_repository
cd ../bar
cg-init http://gregkh_remote_repository

and would like to avoid downloading redundant info.
-- 
David Roundy
http://www.darcs.net
