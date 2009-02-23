From: Eric Wong <normalperson@yhbt.net>
Subject: Re: empty symlink detection breakage
Date: Sun, 22 Feb 2009 20:33:47 -0800
Message-ID: <20090223043347.GA21136@dcvr.yhbt.net>
References: <20090222015611.GA14378@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 05:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbSXF-0003gl-QI
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 05:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZBWEdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 23:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZBWEdt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 23:33:49 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50893 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbZBWEds (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 23:33:48 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2977E1F5FC;
	Mon, 23 Feb 2009 04:33:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090222015611.GA14378@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111078>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> Hi Eric,=20
>=20
> seems that the empty symlink stuff gets confused about which revision=
 to
> use when looking for the parent's file.

<snip>

> Note how it tries to look at revision 3 instead of revision 5 (which =
it
> correctly detected as the parent). The import succeeds when
> svn.brokenSymlinkWorkaround is set to false. Testcase below.

Thanks Bj=F6rn,

I've pushed out a one line bugfix to git://git.bogomips.org/git-svn

diff --git a/git-svn.perl b/git-svn.perl
index ef01fb9..bce24a8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2421,6 +2421,7 @@ sub find_parent_branch {
 			# do_switch works with svn/trunk >=3D r22312, but that
 			# is not included with SVN 1.4.3 (the latest version
 			# at the moment), so we can't rely on it
+			$self->{last_rev} =3D $r0;
 			$self->{last_commit} =3D $parent;
 			$ed =3D SVN::Git::Fetcher->new($self, $gs->{path});
 			$gs->ra->gs_do_switch($r0, $rev, $gs,

--=20
Eric Wong
