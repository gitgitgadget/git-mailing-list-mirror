From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: using git-svn with --no-metadata
Date: Sat, 21 Aug 2010 22:17:21 +0200
Message-ID: <E1OmuVR-0001qE-H7@smtp.tt-solutions.com>
References: <E1OmnCj-0001Z7-2U@smtp.tt-solutions.com> <20100821183711.GA14986@dcvr.yhbt.net> <20100821190711.GA19129@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="1150699296-41-1282421842=:6920"
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 22:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omur3-0003EU-5N
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab0HUUjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:39:43 -0400
Received: from sunset.tt-solutions.com ([82.238.156.189]:51826 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0HUUjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:39:43 -0400
X-Greylist: delayed 1324 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Aug 2010 16:39:42 EDT
Received: from [192.168.17.86] (helo=Twilight)
	by smtp.tt-solutions.com with esmtp (Exim 4.69)
	(envelope-from <vz-git@zeitlins.org>)
	id 1OmuVR-0001qE-H7; Sat, 21 Aug 2010 22:17:33 +0200
In-Reply-To: <20100821190711.GA19129@dcvr.yhbt.net>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows NT 6.1 (build 7600), 64-bit edition
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154159>

--1150699296-41-1282421842=:6920
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Sat, 21 Aug 2010 18:37:11 +0000 Eric Wong <normalperson@yhbt.net> wrote:

EW> >  Now to my question: I thought it would be a good idea to import an svn
EW> > repository with --no-metadata option as I hoped that this would avoid the
EW> > rewriting of commits which happen when git topic branches are checked in
EW> > into svn with "git svn dcommit". The documentation (for my 1.7.1 version)
EW> > did say that:
EW> 
EW> dcommit would have to rewrite commits anyways, since we sync the
EW> usernames and commit times from SVN.  You can't avoid rewriting commits
EW> unless you use "git svn set-tree" (on the other hand, set-tree can be
EW> unfriendly to other SVN users).

 Thank you for this information, I didn't think about commit times at all
but if a rewrite is unavoidable because of them anyhow I'll just have to
[continue to] live with it.

EW> Nowadays git-filter-branch is in mainline git, and I recommend
EW> using that for projects ready to drop SVN/git-svn entirely for git.

 Unfortunately life is not that perfect yet (but I'm working on it ;-) and
I need to continue to use svn while I prefer, of course, use git for my own
development.

 Just in case you're curious, let me describe the problem I have with
commit rewriting. First, my setup is such that I have a single git-svn
clone (under Linux) but as most of the projects I'm working on are
cross-platform I also have git clones of this repository under Windows, Mac
&c. And when I implement some feature under, say, Windows, on a branch
win-work I then push it to Linux machine (where I can test that it didn't
break anything under Unix) and then use "git svn dcommit" from there. So
far all is well but the problem is that when I update my Windows repository
master branch, it has different commits from the ones on win-work branch.
So I can't e.g. "git branch -d win-work" but need to use "branch -D" (if I
am perfectly sure I committed everything) or, usually, "git rebase master
win-work" and only then delete the branch after git tells me that there are
no differences left.

 All this is hardly catastrophic but if I could avoid it somehow it would
be even better. Now that I know that "svn clone --no-metadata" won't help
me with this I wonder if the others have any better ways of working in such
setup?

EW> >From 4c169c696bee06472ca3511a0f58c1c1b52b9fe9 Mon Sep 17 00:00:00 2001
EW> From: Eric Wong <normalperson@yhbt.net>
EW> Date: Sat, 21 Aug 2010 18:52:14 +0000
EW> Subject: [PATCH] Documentation/git-svn: discourage "noMetadata"
EW> 
EW> "noMetadata" is a limited and sometimes harmful option.
EW> Recommend git-filter-branch instead (if at all) for one-shot
EW> imports instead.
EW> 
EW> This also fixes an out-of-date reference to "rev_db" format,
EW> noticed by Vadim Zeitlin.
EW> 
EW> Signed-off-by: Eric Wong <normalperson@yhbt.net>
EW> ---
EW>  Documentation/git-svn.txt |   14 ++++++++++++--
EW>  1 files changed, 12 insertions(+), 2 deletions(-)
EW> 
EW> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
EW> index 4b84d08..8abbcdc 100644
EW> --- a/Documentation/git-svn.txt
EW> +++ b/Documentation/git-svn.txt
EW> @@ -56,6 +56,8 @@ COMMANDS
EW>  	as well, they take precedence.
EW>  --no-metadata;;
EW>  	Set the 'noMetadata' option in the [svn-remote] config.
EW> +	This option is not recommended, please read the 'svn.noMetadata'
EW> +	section of this manpage before using this option.
EW>  --use-svm-props;;
EW>  	Set the 'useSvmProps' option in the [svn-remote] config.
EW>  --use-svnsync-props;;
EW> @@ -597,13 +599,21 @@ svn.noMetadata::
EW>  svn-remote.<name>.noMetadata::
EW>  	This gets rid of the 'git-svn-id:' lines at the end of every commit.
EW>  +
EW> -If you lose your .git/svn/git-svn/.rev_db file, 'git svn' will not
EW> +If you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
EW>  be able to rebuild it and you won't be able to fetch again,

 s/it/them/

EW> -either.  This is fine for one-shot imports.
EW> +either.  This is sometimes useful for one-shot imports.

 Sorry if I sound like a broken record but this still seems to be unclear
to me for the same reasons as the original text, i.e. because there is
still the "if you lose ... then you won't be able to fetch again"
implication (at least to me). Wouldn't something like

	This option can only be used for one-shot imports as 'git svn'
	will not be able to fetch again without metadata. Additionally,
	if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
	be able to rebuild them.

be more clear?

 Thanks again,
VZ

--1150699296-41-1282421842=:6920
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAkxwNFIACgkQBupB3k9sHobmeQCfR0SU89HW+EmJjbCNRppExm/2
VEAAn3qsMmAWTac6nHHuZqBQRACpOc5z
=UfQl
-----END PGP SIGNATURE-----

--1150699296-41-1282421842=:6920--
