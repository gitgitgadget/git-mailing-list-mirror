From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git reset --hard" leaves empty directories that shouldn't exist
Date: Wed, 15 Feb 2006 00:09:09 -0800
Message-ID: <7vk6bxm4be.fsf@assigned-by-dhcp.cox.net>
References: <87y80dhxfd.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 09:09:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9His-0003SW-V3
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 09:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWBOIJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 03:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbWBOIJM
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 03:09:12 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39823 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1423032AbWBOIJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 03:09:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215080730.SHTC20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 03:07:30 -0500
To: git@vger.kernel.org
In-Reply-To: <87y80dhxfd.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	14 Feb 2006 23:51:34 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16221>

Carl Worth <cworth@cworth.org> writes:

> I've been exploring the potential for git-sync, and I found some odd
> behavior with "git reset --hard". It appears that if the current tree
> has some directory structure (at least two levels deep) that does not
> exist in the tree being reset to, that empty directories are left
> around after the reset:
>
> 	$ git --version
> 	git version 1.2.0.gf6e8
> 	$ git init-db
> 	defaulting to local storage area
> 	$ touch file; git add file; git commit -m "Add file"
> 	Committing initial tree df2b8fc99e1c1d4dbc0a854d9f72157f1d6ea078
> 	$ git tag OLD
> 	$ mkdir -p a/b/c; touch a/b/c/foo; git add a/b/c/foo; git commit -m
> 	"Add foo"
> 	$ git checkout -b bogus
> 	$ git reset --hard OLD
> 	$ find a
> 	a
> 	a/b
> 	a/b/c
> 	$
>
> Is this operator error?

Git does not track directories but bends backwards to make empty
directories go away.  I do not know if it is an operator error
or not, but it appears sometimes it does not bend hard enough.

Interestingly enough, this seems to do things more carefully.

	$ ...
	$ git commit -m 'Add file'
        $ git branch OLD
        $ ...
        $ git commit -m 'Add a/b/c/foo'
        $ git checkout -b bogo
        $ git checkout OLD
