From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Cogito] Various bugs
Date: Tue, 7 Feb 2006 01:36:43 +0100
Message-ID: <20060207003643.GJ31278@pasky.or.cz>
References: <20060131041318.GC30744@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 01:36:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6GqU-0000jV-Rc
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 01:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWBGAgg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 19:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWBGAgg
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 19:36:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35998 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964891AbWBGAgf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 19:36:35 -0500
Received: (qmail 26472 invoked by uid 2001); 7 Feb 2006 01:36:43 +0100
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20060131041318.GC30744@diku.dk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15673>

Dear diary, on Tue, Jan 31, 2006 at 05:13:18AM CET, I got a letter
where Jonas Fonseca <fonseca@diku.dk> said that...
> A few Cogito bugs I found yesterday.
> 
>  - cg-fetch between local repos fails when the cloned branch URL does
>    not point to a .git directory and a needed object from the repository
>    being cloned is packed. git-local-fetch expects a .git directory.

Can't reproduce and I don't buy it. The very first line of local fetch
handler is

	[ -d "$uri/.git" ] && uri="$uri/.git"

>  - cg-commit -c will do the wrong thing (use the invokers gecos info)
>    when the author name is empty. One workaround is to make
>    pick_author_script append a space at the end of the GIT_* variables.
>    GIT will strip those and no gecos info is used.

I'd rather fix this in GIT than workaround in Cogito. Will follow up
with a patch.

...
Hmm.
...

I'm puzzled. GIT should handle this fine.

	export GIT_AUTHOR_NAME=''
	git-commit-tree $(cg-object-id -t)

works as expected, but for some reason escaping me it does not work
inside of cg-commit. Insights welcomed.

>  - cg-status reports a deleted file both as deleted and as unknown:
> 
> 	fonseca@antimatter:~/src/elinks/0.12 > git --version
> 	git version 1.1.6.g1506
> 	fonseca@antimatter:~/src/elinks/0.12 > cg --version
> 	cogito-0.17pre.GIT (d3aa9a2b3375e36c774ea477492db76baa1db03e)
> 	fonseca@antimatter:~/src/elinks/0.12 > cg rm AUTHORS
> 	Removing file AUTHORS
> 	fonseca@antimatter:~/src/elinks/0.12 > cg status | grep AUTHORS
> 	? AUTHORS
> 	D AUTHORS

This is fine, I'd say. The file was not deleted from the tree, either do
that manually by rm or say cg-rm -f.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
