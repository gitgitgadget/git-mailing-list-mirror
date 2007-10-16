From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Make the output of "git svn clone" less confusing.
Date: Tue, 16 Oct 2007 02:32:28 -0700
Message-ID: <20071016093228.GA30503@soma>
References: <87k5poflp5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihin2-00070U-8P
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131AbXJPJca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 05:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757124AbXJPJca
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:32:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46487 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755569AbXJPJc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:32:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 6DEC27DC0FE;
	Tue, 16 Oct 2007 02:32:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k5poflp5.fsf@lysator.liu.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61127>

David K=E5gedal <davidk@lysator.liu.se> wrote:
> The problem is that the first thing it prints is
>=20
>   Initialized empty Git repository in .git/
>=20
> even if actually created a subdirectory and changed into it first. Bu=
t to the
> user, it looks like it is creating a .git/ dir in the directory he/sh=
e is
> started git from.

Thanks for bringing it up I just noticed this the other day myself and
thought it might be confusing.

> ---
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> This change makes it more chatty, which might not be a good thing. Bu=
t
> I think the previous output was worse.
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index 777e436..d4450ca 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -286,6 +286,7 @@ sub do_git_init_db {
> =20
>  sub init_subdir {
>  	my $repo_path =3D shift or return;
> +	print "Creating directory $repo_path\n";
>  	mkpath([$repo_path]) unless -d $repo_path;
>  	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";

Since mkpath() isn't guaranteed to get called, maybe putting a

	print "Entering directory $repo_path\n"

right before the chdir is better.

The other option would be to alter git-init to print the absolute path
of the repository being initialized...

--=20
Eric Wong
