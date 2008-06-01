From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix path duplication in git svn commit-diff
Date: Sun, 1 Jun 2008 02:48:40 -0700
Message-ID: <20080601094840.GB16064@hand.yhbt.net>
References: <20080517150330.31899.12398.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 11:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2kBy-0005Ch-Na
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 11:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbYFAJsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2008 05:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbYFAJsl
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 05:48:41 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56215 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbYFAJsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 05:48:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BD30D7DC026;
	Sun,  1 Jun 2008 02:48:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080517150330.31899.12398.stgit@yoghurt>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83443>

Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Given an SVN repo file:///tmp/svntest/repo, trying to commit changes
> to a file proj/trunk/foo.txt in that repo with this command line
>=20
>   git svn commit-diff -r2 HEAD^ HEAD file:///tmp/svntest/repo/proj/tr=
unk
>=20
> gave the error message
>=20
>   Filesystem has no item: File not found: transaction '2-6', path
>   '/proj/trunk/proj/trunk/foo.txt'
>=20
> This fixes the duplication.
>=20
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

Thanks Karl,

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>=20
> I really don't have a clue as to why this was broken, but the patch
> fixes the problem for me, and doesn't break the tests. I got the idea
> from dcommit, which is setting svn_path to '' unconditionally.

Hardly anybody uses commit-diff directly :)

It was a low-level plumbing command that I used to implement the
original version of dcommit in.

>  git-svn.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>=20
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index 2c53f39..1c2a10a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -741,7 +741,7 @@ sub cmd_commit_diff {
>  	my $usage =3D "Usage: $0 commit-diff -r<revision> ".
>  	            "<tree-ish> <tree-ish> [<URL>]";
>  	fatal($usage) if (!defined $ta || !defined $tb);
> -	my $svn_path;
> +	my $svn_path =3D '';
>  	if (!defined $url) {
>  		my $gs =3D eval { Git::SVN->new };
>  		if (!$gs) {
> @@ -765,7 +765,6 @@ sub cmd_commit_diff {
>  		$_message ||=3D get_commit_entry($tb)->{log};
>  	}
>  	my $ra ||=3D Git::SVN::Ra->new($url);
> -	$svn_path ||=3D $ra->{svn_path};
>  	my $r =3D $_revision;
>  	if ($r eq 'HEAD') {
>  		$r =3D $ra->get_latest_revnum;
>=20

--=20
Eric Wong
