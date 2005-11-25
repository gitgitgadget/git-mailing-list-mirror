From: Ryan Anderson <ryan@michonline.com>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 14:51:22 -0500
Message-ID: <20051125195121.GG16995@mythryan2.michonline.com>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org> <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	Git ML <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 25 20:54:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efjbc-0003vU-Mb
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 20:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVKYTvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 14:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVKYTvd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 14:51:33 -0500
Received: from mail.autoweb.net ([198.172.237.26]:17644 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751471AbVKYTvd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 14:51:33 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EfjbO-0003Ct-LZ; Fri, 25 Nov 2005 14:51:23 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EfjbO-0007Ru-00; Fri, 25 Nov 2005 14:51:22 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1EfjbO-0007lP-34; Fri, 25 Nov 2005 14:51:22 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12748>

On Fri, Nov 25, 2005 at 11:12:00AM -0800, Linus Torvalds wrote:
> 
> Ok, 
> 
>   Nico gave me private access to the tree, so I quickly cloned it and 
> started bisecting it to figure out where the problem was. I haven't looked 
> at the source code, and all the commit messages seem to be in German 
> (which I can kind of understand if I work at it, but not very well), but 
> it definitely turns out none of that matters.
> 
> The problem is a bad merge. And in fact, that merge lost _more_ than just 
> the three files under Code/Spikes/Statistik/, it also lost a file called 
> Code/lw1/Client/Pics/icon/lw1-icon.png.
> 
> I don't quite see _how_ it lost them. The merge in question is a totally 
> trivial in-index merge, and when I re-do it, I don't lose those files. In 
> this case, all the lost files were from the "other branch" of the merge, 
> and they were new to that branch. IOW, in git-merge-one-file parlance, it 
> is that trivial "added in one" case.

Can something like this sequence do it?

	git-init-db
	git add file1 ; git commit -m "1"
	(cd .. ; git clone tree1 tree2 )
	(cd .. ; git clone tree1 tree3 )
	git add file2 ; git commit -m "2"
	git push ../tree2/
	git add file3 ; git commit -m "3"

	cd ../tree3/
	git add file4
	git commit -m "4"

	cd ../tree2/
	git pull ../tree3/

The key point being that the merge is done in a tree that has its index
out of sync with its HEAD (git push ../tree2/ .... git pull ../tree3/ )

I think that's the situation where I've personally managed to lose
and/or revert some changes.

-- 

Ryan Anderson
  sometimes Pug Majere
