From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Newbie using git -- need a little help
Date: Sun, 17 Jun 2007 21:17:45 +0200
Message-ID: <20070617191745.GD21291@cip.informatik.uni-erlangen.de>
References: <42118.74778.qm@web57410.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Smith <wolf1boy79@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 21:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I00Gb-0001O9-T5
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXFQTRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758220AbXFQTRr
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:17:47 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50268 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757495AbXFQTRr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 15:17:47 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id B79B43F43A; Sun, 17 Jun 2007 21:17:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <42118.74778.qm@web57410.mail.re1.yahoo.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50365>

Hello Robert,

> I'm not sure what I'm doing wrong.  I see the change once the tree is
> pushed to the server (from the desktop), but it is undone
> automatically with a git commit -a.

When you push to your server, the repository is updated (that is the
thing that is in .git) but your working tree isn't.

So when you push to a repository that also has a working tree attached
to it, you have to do a "git checkout" on the working tree. Or pull from
the repository and not push to it.

For a long time I did the same thing you did. I had a repository with a
working tree that I pushed into. I did it with bitkeeper and I did with
git. However these days I dropped that idea because it is not worth the
trouble (and it wasn't from the beginning) I just got used to it and did
not thought about it.

What I do now is the following:

On my laptop:

        mkdir dir
        git init
        # add some files
        git add .
        git commit 

Than I publish my project to the server without giving the repository at
the server a working directory attached to it. A working directory is
where you can edit files and commit changes locally, just in case I
didn't introduce the term yet.

        # This creates the repository _without_ the working tree on the server.
        ssh 131.188.30.102 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db

        # This adds the remote origin to the config so that I don't have to
        # type in the long repository path each time I am going to push or pull
        # something.
        git remote add origin 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/astro.git

        # Now I publish my stuff to the central repository. You need at least
        # one commit in order to be able to do that.
        git push origin master:master


        # I add a few lines to my config so that when I type in "git pull" it
        #fetches the stuff and merges it with my local repositories master branch.

        "vim .git/config" and add the following lines:

[branch "master"]
        remote = origin
        merge = refs/heads/master
EOF

        # Now I can fetch back to see if everything works
        git pull

Now I am fine the infrastructure is all set up. The next time I am going
to access the project from a different machine I simply do:

        git pull 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/astro.git

And that's it. The origin and where it is going to merge stuff is set
automatically up by git. Note: I use ssh (attached to a ssh-agent so that I
don't have to passwords all the time I am doing a push or pull). I hope that
helps you and didn't miss your original question. I just fly over your e-Mail
and picked a few keywords to comment on.

        Thomas
