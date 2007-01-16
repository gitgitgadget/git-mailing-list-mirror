From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] document --exec for git-push
Date: Tue, 16 Jan 2007 11:45:20 -0800
Message-ID: <7vk5zmycvj.fsf@assigned-by-dhcp.cox.net>
References: <20070116150201.GA2427@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 20:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uFJ-0005eu-Po
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 20:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbXAPTpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbXAPTpX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 14:45:23 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34245 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXAPTpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 14:45:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116194521.IAEN19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jan 2007 14:45:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BvkU1W0041kojtg0000000; Tue, 16 Jan 2007 14:44:28 -0500
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20070116150201.GA2427@cepheus> (Uwe =?iso-8859-1?Q?Kleine-K?=
 =?iso-8859-1?Q?=F6nig's?= message of
	"Tue, 16 Jan 2007 16:02:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36956>

Uwe Kleine-K=F6nig  <zeisberg@informatik.uni-freiburg.de> writes:

> The text is just copied from git-send-pack.txt.

Thanks.

> There are still some options undocumented, but I don't know what they
> do exacly:
>
> 	--thin
> 	--no-thin
> 	--repo=3D
> 	-v

Usually a good way to answer that question is:

	$ git blame -C -L'/^int cmd_push/,/^}/' builtin-push.c

and then run "git show" on the commit that introduces the option
parsing, e.g. commit bcc785f6 for --repo.

----------------------------------------------------------------
commit bcc785f611dc6084be75999a3b6bafcc950e21d6
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Mon Oct 30 08:28:59 2006 -0800

git push: add verbose flag and allow overriding of default target repos=
itory

This adds a command line flag "-v" to enable a more verbose mode, and
"--repo=3D" to override the default target repository for "git push" (w=
hich
otherwise always defaults to "origin").

This, together with the patch to allow dashes in config variable names,
allows me to do

	[alias]
		push-all =3D push -v --repo=3Dall

in my user-global config file, and then I can (for any project I mainta=
in)
add to the project-local config file

	[remote "all"]
		url=3Done.target.repo:/directory
		url=3Danother.target:/pub/somewhere/else

and now "git push-all" just updates all the target repositories, and sh=
ows
me what it does - regardless of which repo I am in.

----------------------------------------------------------------

But now I wonder why Linus couldn't have just done:

	[alias]
		push-all =3D push -v all

-- >8 --
git-push documentation: remaining bits

Mention --thin, --no-thin, --repo and -v.=20

---
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a19631d..3e8dbcf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with associated obj=
ects
=20
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--exec=3D<receive-pack>] [-f | --force] <=
repository> <refspec>...
+'git-push' [--all] [--tags] [--exec=3D<receive-pack>]  [--repo=3Dall] =
[-f | --force] [--thin | --no-thin] [-v] [<repository> <refspec>...]
=20
 DESCRIPTION
 -----------
@@ -79,6 +79,18 @@ the remote repository.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
=20
+\--repo=3D<repo>::
+	When no repository is specified the command defaults to
+	"origin"; this overrides it.
+
+\--thin, \--no-thin::
+	These options are passed to `git-send-pack`.  Thin
+	transfer spends extra cycles to minimize the number of
+	objects to be sent and meant to be used on slower connection.
+
+-v::
+	Run verbosely.
+
 include::urls.txt[]
=20
 Author
