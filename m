From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about shared repositories
Date: Tue, 06 Nov 2007 15:25:38 -0800
Message-ID: <7vd4unez2l.fsf@gitster.siamese.dyndns.org>
References: <472F99F8.4010904@gmail.com>
	<7v8x5cmern.fsf@gitster.siamese.dyndns.org>
	<4730E056.7080809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 00:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXo4-0005My-Vd
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbXKFXZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbXKFXZu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:25:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43748 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbXKFXZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:25:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F28572F2;
	Tue,  6 Nov 2007 18:26:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 213AC92F9A;
	Tue,  6 Nov 2007 18:26:06 -0500 (EST)
In-Reply-To: <4730E056.7080809@gmail.com> (Francesco Pretto's message of "Tue,
	06 Nov 2007 22:44:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63747>

Francesco Pretto <ceztkoml@gmail.com> writes:

> Signed-off-by: Francesco Pretto <ceztkoml@gmail.com>
> ---
>  More detailed instructions on how to set up shared repositories.
>  Removed an old reference to the need of setting umask of ssh
>  users of shared repositories.
>  Added a reference to "git for CVS users" doc in git-init manual.

Honestly speaking, I am not too thrilled about making the
cvs-migration document much longer than what it currently is.

Having said that, let's take a look at each hunk.

> @@ -71,7 +71,40 @@ Setting Up a Shared Repository
>  We assume you have already created a git repository for your project,
>  possibly created from scratch or from a tarball (see the
>  link:tutorial.html[tutorial]), or imported from an already existing CVS
> -repository (see the next section).
> +repository (see the next section). Moreover, we assume you can write in a
> +public accessible directory and give other users the permission to do so.
> +You could need or not admin privileges to do so, depending on your
> +system configuration and how you decide to export the repository.

I do not think the above helps anybody.  Later sections say
"make it writable by foo group" and such specifically, and from
such descriptions, the reader either (1) understands what are
prerequisite for being able to do so, or (2) is clueless enough
to get puzzled by failure message from "chgrp git foo", and would
not even make the connection to the above text after seeing such
a failure anyway.

> +It's recommended, but not strictly necessary, to create a specific group for
> +every project/repository you'll want to create, so it will be easier to give
> +or prevent access of users to specific repositories.

I'd say this is not git specific nor cvs migrant specific advice
but falls into a common sense category.  Better not clutter the
document with such, and keep it short and readable in one
sitting.

> +... With admin privilege launch:
> +
> +------------------------------------------------
> +$ groupadd $group
> +------------------------------------------------
> +
> +If you want to add an user to this group, launch:
> +
> +------------------------------------------------
> +$ usermod -a -G $group $username
> +------------------------------------------------

I tend to edit /etc/group with vi ;-) and I suspect these two
commands are specific to the distro you happen to use.

For something like "cvs migration", I really do not want a set
of step-by-step hand holding instructions.  Just telling them to
"pick a group for the project, make repositories belonging to
the project owned by that group, and make them writable by the
group members" should be enough.  CVS migrants may not know how
the world works with respect to git, but they are not idiots.
Introductory UNIX command guide is not the goal of the document.
Try to tell them _what_ needs to happen, not _how_, when that
level of the detail is sufficient.

> +In our example, we will store the shared repository in the /pub dir, so the
> +user creating it will need write permission there. There's no problems if you
> +choose another directory, but you'll have to ensure it will be accessible by
> +other users, on local or by remote (this could be not the case of home
> +directories).

Everything up to "by other users" is good, but ", on local or
by..." are unnecessary.  If your stress is on shared
repositories, do not even mention "home", unless you are very
convinced that it is a very typical use case, in which case you
should be certain about what you recommend and there is no place
for expression like "this could be ..." for such a sure
recommendation.

> +If you just want to create a directory that is writable by every users that have
> +a local account, launch with privileged credentials:
> +
> +------------------------------------------------
> +$ mkdir /pub
> +$ chmod a+w,+t /pub
> +------------------------------------------------

Unneeded --- again, this is not a UNIX command guide --- and
wrong.  You do not necessarily need to "launch with privileged
credentials" to do this anyway.  As long as you can chmod the
directory, that is all that is needed.

>  Next, give every team member read/write access to this repository.  One
>  easy way to do this is to give all the team members ssh access to the
>  machine where the repository is hosted.  If you don't want to give them a
>  full shell on the machine, there is a restricted shell which only allows
>  users to do git pushes and pulls; see gitlink:git-shell[1].

This part is a very good advice.  It is git specific knowledge
new cvs migrants need to learn.  Oops, the reason this part is
good is because it is from the original text --- no wonder ;-).

> -Put all the committers in the same group, and make the repository
> -writable by that group:
> +The following two commands will require admin privileges; first, enable
> +git-shell putting it on the trusted shells list of the system:
>  
>  ------------------------------------------------
> -$ chgrp -R $group /pub/my-repo.git
> +$ echo `which git-shell` >> /etc/shells
> +------------------------------------------------

Saying that /etc/shells may control what shells are allowed as
the login shell on many systems is probably a very good idea.
However, there is no need for an introductory UNIX guide that is
even WRONG.  Why "echo `foo`" when just "foo" would work?  Why
aren't you checking if /etc/shells already have git-shell
defined?

> +
> +Now, let's create the commit users:
> +
> +------------------------------------------------
> +$ useradd -g $group -s `which git-shell` $username
>  ------------------------------------------------
>  
> -Make sure committers have a umask of at most 027, so that the directories
> -they create are writable and searchable by other group members.
> +These users will be enabled to push on repositories owned by the group $group.
> +Later, you can give access to other projects simply by adding them to
> +other groups. Similarly, you can prevent access to repositories simply
> +removing those users from related groups.

The original text's point about umask does not apply to modern
git anymore, so the above lines can simply deleted.  Almost
everything else you added to this hunk is unnecessary UNIX
guide.

> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -101,6 +101,13 @@ $ git-add .     <2>
>  <2> add all existing file to the index
>  
>  
> +SHARED REPOSITORIES
> +-------------------
> +
> +Please refer to link:cvs-migration.html[git for CVS users], section "Setting Up
> +a Shared Repository", for details on how to set up shared repositories.
> +
> +
>  Author
>  ------
>  Written by Linus Torvalds <torvalds@osdl.org>

This part is a good idea, but instead of putting it at the
bottom, it may make it more prominent to have this at the end of
option description for "--shared".
