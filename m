From: elupus <elupus@ecce.se>
Subject: Re: git 1.5.4.3 push incorrectly honors grafts file
Date: Tue, 5 May 2009 03:00:20 +0200
Message-ID: <1tckgcdml91fv$.asxg8bv2cluc$.dlg@40tude.net>
References: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net> <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net> <20090504204022.GE4863@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 03:00:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M191T-0006If-8k
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 03:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbZEEBAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 21:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbZEEBAb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 21:00:31 -0400
Received: from main.gmane.org ([80.91.229.2]:39055 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbZEEBAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 21:00:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M191H-0002Id-Bs
	for git@vger.kernel.org; Tue, 05 May 2009 01:00:27 +0000
Received: from c83-254-4-118.bredband.comhem.se ([83.254.4.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 May 2009 01:00:27 +0000
Received: from elupus by c83-254-4-118.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 May 2009 01:00:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c83-254-4-118.bredband.comhem.se
User-Agent: 40tude_Dialog/2.0.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118277>

On Tue, 5 May 2009 00:40:22 +0400, Dmitry Potapov wrote:

> 
> It may happen only if your graft makes some part of history unreachable. And
> as I said above, using the grafts file should be avoided wherever possible,
> and graft that replaces or removes some parents should only be used if you
> are going to run git-filter-branch after that.

Understandable, but not really an option in my case. (see below)

> If you migrate from SVN to Git and want to edit history after importing, you
> should run filter-branch before making this repository public.  Re-writing
> public history is always a bad idea, regardless how it is done. If you use
> git-svn for bidirectional synchronization then you most like use grafts in
> the way it was not intended to use...

In my case i'm not migrating. I'm following a svn repo, but want to do my
own development in git.

> If git gc will not honor grafts then it may delete those that are referred
> by grafts, which is clearly wrong. So, perhaps, what you really want is that
> git-gc should consider grafts as an additional source of information rather
> than replacement. (Actually, git-gc is high level wrapper over git-repack,
> git-prune, etc, which should be changed.) Also, git-fsck needs to be changed
> to consider grafts as an additional source of information...

Yea, sounds like the correct approach.

> IMHO, grafts should not be used at all except very rare cases like editing
> an imported history before making it public.

Suppose so, but they are also very usefull for git svn repo's where they
can be used to correct for merge history. For example a feature branch
getting resynced to the trunk multiple times during it's lifetime. Adding
grafts for atleast the latest such occurance, makes it way easier to git
diff / git merge --squash and so on between the branches.

Also after the branch have been merged back into trunk, there could be a
point to add a graft as the previous branch will likely be deleted from the
svn repo, and thus would end up unreachable in the git repo should one
decide to remove the ref to the tip since there is not branch tracking in
the git svn client.

In a perfect world (not a likely one as i'll not spend time on implementing
it) I would like to be able to add new parents to commits and have them
become permanent through something like filter-branch, without this ruining
anything for anybody that pulls from this repo.

Joakim
