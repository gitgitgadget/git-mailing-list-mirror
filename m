From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 10:50:38 -0700
Message-ID: <7vu032h1g1.fsf@assigned-by-dhcp.cox.net>
References: <20060919232851.GA12195@spearce.org>
	<7vac4ujzf0.fsf@assigned-by-dhcp.cox.net>
	<20060920161407.GQ8259@pasky.or.cz>
	<20060920162145.GA23260@spearce.org>
	<7v1wq6jy3q.fsf@assigned-by-dhcp.cox.net>
	<20060920164912.GD23260@spearce.org>
	<7vac4uihr3.fsf@assigned-by-dhcp.cox.net>
	<20060920173126.GG23260@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 20 19:50:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ6Dc-0002NC-Mn
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWITRul (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWITRul
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:50:41 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30101 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932166AbWITRuk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 13:50:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920175039.MCBW13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 13:50:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QhqR1V00H1kojtg0000000
	Wed, 20 Sep 2006 13:50:26 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920173126.GG23260@spearce.org> (Shawn Pearce's message of
	"Wed, 20 Sep 2006 13:31:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27387>

Shawn Pearce <spearce@spearce.org> writes:

> I meant ".git/remotes must have only one file 'origin' and
> nothing else".  Because what does it mean to mirror two different
> repositories at the same time into the same ref namespace?  The most
> recently fetched would always win.
>
> But now that I'm writing this I can see someone wanting multiple
> remotes so they could store different URLs for the same repository
> and call fetch on another if the first isn't responding.  So I
> retract this entirely.  So there doesn't even need to be remotes
> file; the URL could just be passed on the command line.  A remotes
> file (like the default "origin" one) is just a handy place to store
> the URL.

Another possibility.  The mirror might want to do something
like:

        .git/refs/remotes/davem/sparc-2.6.git/...
	.git/refs/remotes/torvalds/linux-2.6.git/...
	.git/refs/remotes/jgarzik/netdev-2.6.git/...

to be a super-mirror of related projects.  This would give a
convenient way for the visitors to browse them all at one place,
and would save object store.  There are minor details such as
gitweb may not allow browsing refs/remotes and git-fetch may not
let you fetch from refs/remotes (I haven't checked), but they
are fixable as needed.

> Because we don't want to update HEAD with the SHA1 that's on the
> remote if that's actually going to update some other ref which
> doesn't have the same value.  :-)

What I thought you were going to do with HEAD would be to update
it not by the object name but modifying where it points at.
IOW, if HEAD is a symlink pointing at refs/heads/master and the
remote HEAD now points at refs/heads/next, you do not:

	echo $the_commit_object_name_of_remote_next >.git/HEAD 

which obviously is insane, but you would do

	rm -f .git/HEAD && ln -s refs/heads/next .git/HEAD

> But I agree with you entirely about HEAD being a SHA1 and not its
> actual link target in the network protocol.  An annoying bug.

Which fortunately is fixable ;-).
