From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to import stuff?
Date: Wed, 25 Jan 2006 16:15:27 -0800
Message-ID: <7vvew7kfog.fsf@assigned-by-dhcp.cox.net>
References: <43D80C77.70207@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 01:15:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1unU-0003bX-Eq
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 01:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWAZAPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 19:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWAZAPa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 19:15:30 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60814 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751262AbWAZAP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 19:15:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126001412.CUFK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 Jan 2006 19:14:12 -0500
To: Ian Molton <spyro@f2s.com>
In-Reply-To: <43D80C77.70207@f2s.com> (Ian Molton's message of "Wed, 25 Jan
	2006 23:40:39 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15145>

Ian Molton <spyro@f2s.com> writes:

> git checkout -b v2.6.16-rc1 v2.6.16-rc1

You are creating a branch called v2.6.16-rc1 while you have a
tag with the same name.  From this point on, when you say
v2.6.16-rc1 when git expects an arbitrary revision name, the
commit Linus tagged with that name is used.  When git expects
you to use it a branch name, it uses the branch head commit of
the branch you created here.  Once you create a new commit in
that branch, these two will refer to different commits depending
on the context.  Unless you really understand what you are
doing, this would confuse you, so do not do this.  Use some
other branch name.  Better yet...

> git checkout -b v2.6.16-rc1-mm3

Starting from a vanilla clone from Linus, up to this point you
could probably have done:

	$ git checkout -b v2.6.16-rc1-mm3 v2.6.16-rc1

You do not need v2.6.16-rc1 branch if you immediately create
another branch, which is the branch you would want to work on.

> patch -Np1 < 2.6.16-rc1-mm3
> So far so good - I have a tree with the patches applied

        $ git apply --index 2.6.16-rc1-mm3

If the patch you are using cleanly applies without fuzz, this
would apply them to the working tree, and all the new and/or
removed files are registered to the index, without you having to
say "git update-index".

> git update-index --add --remove --refresh --ignore-missing
>
> seems to generate a list of said files, but I cant seem to figure out
> how to get it to actually do anything useful with them.

I have no idea what this update-index line with only the
flags means, so let's forget about that.

After applying the patch with "patch -p1 -E" on top of the
vanilla version:

	$ git add .

would add all the new files.  Then

	$ git commit -a -m '2.6.16-rc1-mm3'

would notice removed and modified files as well when making a
commit.

HOWEVER.

I honestly do not understand what value you are expecting to get
out of git, if you are rolling the whole thing from -mm series
into a singe commit.  Commit is designed to be easily handled as
an atomic change, and being able to pick and choose only parts
of it was never part of its design goal, so I do not understand
what useful things you are expecting to do, after you create
that commit.

IOW, there is a reason -mm series is available as individual
broken-out/ files.
