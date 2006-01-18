From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 13:58:57 +0100
Message-ID: <20060118125857.GO28365@pasky.or.cz>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 13:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzCsk-00072X-FY
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 13:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWARM5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 07:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWARM5n
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 07:57:43 -0500
Received: from w241.dkm.cz ([62.24.88.241]:44518 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932521AbWARM5n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 07:57:43 -0500
Received: (qmail 25949 invoked by uid 2001); 18 Jan 2006 13:58:57 +0100
To: Mathias Waack <Mathias.Waack@rantzau.de>
Content-Disposition: inline
In-Reply-To: <20060118125158.GN28365@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14821>

Dear diary, on Wed, Jan 18, 2006 at 01:51:58PM CET, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
>   But if you want r1/a, r2/b to turn to r/r1/a, r/r2/b, you will have
> to rewrite the history of each (and then do the above). One rough
> and untested sketch...
> 
> 	mkdir r1-rewritten
> 	cd r1-rewritten
> 	cp -a ../r1/.git .

	mkdir commitmap

> 	for commit in $(git-rev-list --topo-order HEAD | tac); do
> 		git-read-tree --prefix=r1/ $commit
> 		# here, setup the AUTHOR/COMMITTER variables
> 		# appropriately (you can look at cg-commit's
> 		# $copy_commit handler)
> 		git-cat-file commit "$commit" | sed -e '1,/^$/d' | \
> 			git-commit-tree $(git-write-tree) \
> 				$(for parent in $(cg-object-id -p $commit); do

					echo -p

> 					cat commitmap/$parent
> 				  done) >commitmap/$commit
> 		last_commit=$commit
> 	done
> 	git-update-ref HEAD $(cat commitmap/$last_commit)

	rm -rf commitmap
	cg-reset

  And at this point, git-prune will have plenty of work to do (many of
your tree and commit objects will be outdated - you just rewrote them).

  It's quite beautiful that you can do this all without checkouting a
single thing - you just load the tree to the index, prepend "r1/" to all
the paths, and commit it back.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
