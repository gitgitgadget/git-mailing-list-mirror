From: Matt Draisey <mattdraisey@sympatico.ca>
Subject: Re: symlinked directories in refs are now unreachable
Date: Mon, 15 Aug 2005 04:07:29 -0400
Message-ID: <1124089116.749.39.camel@della.draisey.ca>
References: <1124073677.27393.15.camel@della.draisey.ca>
	 <7v64u7941c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 15 10:11:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4a3s-0007bF-RR
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVHOILJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHOILJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:11:09 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:26780 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932206AbVHOILI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 04:11:08 -0400
Received: from Windsor-ppp121559.sympatico.ca ([216.209.168.44])
          by tomts16-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050815081058.GOLM27508.tomts16-srv.bellnexxia.net@Windsor-ppp121559.sympatico.ca>
          for <git@vger.kernel.org>; Mon, 15 Aug 2005 04:10:58 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64u7941c.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-08-14 at 22:12 -0700, Junio C Hamano wrote:
> Matt Draisey <mattdraisey@sympatico.ca> writes:
> 
> > The behaviour of the symlinked in ref directories has changed from
> > earlier versions of git.  They used to be taken into account in
> > git-fsck-cache --unreachable.
> >
> > Can the previous behaviour be reinstated?
> 
> I would not have much problem accepting a patch for that; it
> would make things safer when a symlink points to a real file
> that is outside .git/refs/ that holds a pointer to a valid
> object.
> 
> Having said that, I would first like to know why you have a
> symlink there, and the real file pointed by it outside .git/refs
> hierarchy.  The core GIT tools do not create such symlinks, so
> either you are creating one by hand, or your Porcelain is
> creating one for you for whatever reason.

It is my own home-grown Porcelain that creates the symlinks.  I've
thrown together a python programme to track a nested collection of
projects.  My own programming efforts rarely exceed two or three files
per project, and don't justify there own .git/objects repository.
Still, a few projects do benefit from having their own commit history,
while the rest are tracked as one big outermost superproject of
unrelated stuff.

> I would like to know
> a use case or two to illustrate why there are symlinks pointing
> at real files outside .git/refs/ hierarchy, and how that
> arrangement is useful.

Whether or not its useful??  Hmmm.  Debatable.

I've only written a commit tool.  All the other git and cogito tools I
invoke from the outermost directory like so 

$git-cat-file commit per/Minesweeper/master

Symlinking still works here as expected.  The per directory is just
there so I don't stomp on the outermost namespace, the Minesweeper is a
symlink to the nested project's refs directory.  Symlinking seems the
natural way to do this as they only need updating when I move
subdirectories around.

P.S. $echo new-id > .git/per/Minesweeper/master is safe here --- this is
the actual behaviour I want.
