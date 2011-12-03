From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Sat, 3 Dec 2011 01:23:47 +0100
Message-ID: <20111203002347.GB2950@centaur.lab.cmartin.tk>
References: <CAFE9C7B.2BFEC%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sat Dec 03 01:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWdOX-0003ZO-MJ
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 01:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204Ab1LCAXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 19:23:49 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:54122 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab1LCAXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 19:23:48 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9dc94.pool.mediaWays.net [77.185.220.148])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 4F437461A0;
	Sat,  3 Dec 2011 01:23:05 +0100 (CET)
Received: (nullmailer pid 2433 invoked by uid 1000);
	Sat, 03 Dec 2011 00:23:47 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFE9C7B.2BFEC%joshua.redstone@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186247>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2011 at 11:17:10PM +0000, Joshua Redstone wrote:
> Hi,
> I have a git repo with about 300k commits,  150k files totaling maybe 7GB.
>  Locally committing a small change - say touching fewer than 300 bytes
> across 4 files - consistently takes over one second, which seems kinda
> slow.  This is using git 1.7.7.4 on a linux 2.6 box.  The time does not
> improve after doing a git-gc (my .git dir has maybe 250 files after a git
> gc).  The same size commit on a brand new repo takes < 10ms.  Any thoughts
> on why committing a small change seems to take a long time on larger repo=
s?

By "same size commit" do you mean the same amount of changes, or the
same amount of files? Committing doesn't depend on the size of the
repo (by itself), but on the size of the index, which depends on the
amount of files to be committed (as git is snapshot-based). At one
point, commit forgot how to write the tree cache to the index (a
performance optimisation). Do the times improve if you run 'git
read-tree HEAD' between one commit and another? Note that this will
reset the index to the last commit, though for the tests I image you
use some variation of 'git commit -a'.

Thomas Rast wrote a patch to re-teach commit to store the tree cache,
but there were some issues and never got applied.

>=20
> Fwiw, I also tried doing the same test using libgit2 (via the pygit2
> wrapper), and it was ever slower (about 6 seconds to commit the same small
> change).

I don't know about the python bindings, but on the (somewhat
unscientific) tests for libgit2's write-tree (the slow part of a
creating a commit), it performs slightly faster than git's (though I
think git's write-tree does update the tree cache, which libgit2
doesn't currently). The speed could just be a side-effect of the small
test repo. From your domain, I assume the data is not for public
consumption, but it'd be great if you could post your code to pygit2's
issue tracker so we can see how much of the slowdown comes from the
bindings or the library.

   cmn


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO2WwTAAoJEHKRP1jG7ZzTTk4IAJ1qnjLe5I6qdVSMPVTQY0Ir
dOjOFxK6eXQgII/FZYnHjTzrjjWAEQS2uuQaP6ILI7yZDEEncu3HdnCAE6TqAoTu
FEeZbitG6uaJw2S93TEXpytvo61hX8PoTIO9+d+eKosLnxQTxTKlu6VItNxR+Qy7
FDypHlmj27JgckNYKuCaIpyD2vDuXoM+tuT3uFOs06EKy+mDc9kDjueHW2khTaBl
xWP5OrUyu1ra6P0WvDLNemwAORo6W0EiU8AUHYCBnEYOAH4k/66wtRAbxpgRWEai
A1R+7HDdT3UekYztL8BxwITyTXx+Vvz6fSZDC18Pe24M29PPrbV4g7FxtRlioS8=
=PdPB
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
