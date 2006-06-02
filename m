From: Martin Waitz <tali@admingilde.org>
Subject: Re: git reset --hard not removing some files
Date: Fri, 2 Jun 2006 11:37:36 +0200
Message-ID: <20060602093736.GL14325@admingilde.org>
References: <20060601160052.GK14325@admingilde.org> <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 11:37:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm66C-0004FR-IL
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 11:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWFBJhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFBJhi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 05:37:38 -0400
Received: from admingilde.org ([213.95.32.146]:15011 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751365AbWFBJhh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 05:37:37 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fm664-0006uZ-6M; Fri, 02 Jun 2006 11:37:36 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606010918060.5498@g5.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21154>


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Jun 01, 2006 at 09:21:38AM -0700, Linus Torvalds wrote:
> Those files were _never_ tracked.

You are right, I used the wrong demonstration to show my problem.
I had one problem like this in the linux-kernel and tried to
reproduce them in the git repository but did it wrong...

GIT reset seems to have a problem when a file is tracked and ignored
at the same time.

This fails:

diff --git a/t/t7101-reset.sh b/t/t7101-reset.sh
index a919140..865e0f6 100755
--- a/t/t7101-reset.sh
+++ b/t/t7101-reset.sh
@@ -21,10 +21,12 @@ test_expect_success \
      cp ../../COPYING path1/COPYING &&
      cp ../../COPYING COPYING &&
      cp ../../COPYING path0/COPYING-TOO &&
+     echo COPYING > .gitignore &&
      git-add path1/path2/COPYING &&
      git-add path1/COPYING &&
      git-add COPYING &&
      git-add path0/COPYING-TOO &&
+     git-add .gitignore &&
      git-commit -m change -a'

 test_expect_success \


This hit me as the Linux kernel .gitignore includes ".*" which matches
all the .gitignore files and so they are not removed when you go
back to 2.6.13.  But with the new git checks regarding files in
the working dir, git then refuses to pull in newer Linux versions
because it would overwrite ".gitignore".

--=20
Martin Waitz

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEgAbfj/Eaxd/oD7IRAmPTAJkBo1AIB0K8AWMwU1Lfp43sy5DUiACfbHZm
H8ZSgbMij7F3DFhb8jwBROU=
=aekz
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
