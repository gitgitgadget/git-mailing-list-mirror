From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Fix t9101 test failure caused by Subversion "auto-props"
Date: Fri, 16 Nov 2007 14:25:10 +0100
Message-ID: <2F7DFDC9-D4E2-42D0-9E48-E51E7905FF42@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr> <73246E38-9C22-4279-A53E-678434238E5C@wincent.com> <20071116124850.GA14473@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>,
	Junio Hamano <junkio@cox.net>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 14:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It1CU-0001fd-IU
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 14:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603AbXKPNZV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 08:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757550AbXKPNZV
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 08:25:21 -0500
Received: from wincent.com ([72.3.236.74]:41920 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757393AbXKPNZU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 08:25:20 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGDPBlO020041;
	Fri, 16 Nov 2007 07:25:12 -0600
In-Reply-To: <20071116124850.GA14473@atjola.homenet>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65224>

If a user has an "auto-prop" in his/her ~/.subversion/config file for
automatically setting the svn:keyword Id property on all ".c" files
(a reasonably common configuration in the Subversion world) then one
of the "svn propset" operations in the very first test would become a
no-op, which in turn would make the next commit a no-op.

This then caused the 25th test ('test propget') to fail because it
expects a certain number of commits to have taken place but the actual
number of commits was off by one.

Bj=F6rn Steinbrink identified the "auto-prop" feature as the cause
of the failure. This patch avoids it by passing the "--no-auto-prop"
flag to "svn import" when setting up the test repository, thus ensuring
that the "svn propset" operation is no longer a no-op, regardless of th=
e
users' settings in their config.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
  t/t9101-git-svn-props.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 3c83127..d7a7047 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -48,7 +48,7 @@ EOF
         printf "\r\n" > empty_crlf
         a_empty_crlf=3D`git-hash-object -w empty_crlf`

-       svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
+       svn import --no-auto-props -m 'import for git-svn' . =20
"$svnrepo" >/dev/null
  cd ..

  rm -rf import
--=20
1.5.3.5
