From: Pavel Roskin <proski@gnu.org>
Subject: Re: 'pu' branch for StGIT
Date: Wed, 08 Aug 2007 18:18:34 -0400
Message-ID: <1186611514.7383.4.camel@dv>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
	 <1186549433.2112.34.camel@dv>
	 <20070808092027.GB7860@diana.vm.bytemark.co.uk>
	 <20070808213917.GA22521@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItrW-0001JJ-QG
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692AbXHHWSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 18:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbXHHWSj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:18:39 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:34146 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632AbXHHWSi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 18:18:38 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IItuL-0001l7-Dg
	for git@vger.kernel.org; Wed, 08 Aug 2007 18:21:37 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IItrP-0003HW-3v; Wed, 08 Aug 2007 18:18:35 -0400
In-Reply-To: <20070808213917.GA22521@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55381>

Hello, Karl!

On Wed, 2007-08-08 at 23:39 +0200, Karl Hasselstr=F6m wrote:

> > Hmm, I hadn't noticed. That would be an unintended side-effect of
> > the DAG patches, presumably. I'll look into it tonight.
>=20
> I can't reproduce.

OK, it's trickier.  There are some bad patch names that don't get
imported properly.  In particular, patches ending with ".diff" are
committed after import.

Try changing this in the testsuite:

diff --git a/t/t1800-import.sh b/t/t1800-import.sh
index 8c8c9a0..6cd3cdb 100755
--- a/t/t1800-import.sh
+++ b/t/t1800-import.sh
@@ -15,7 +15,7 @@ test_expect_success \
 test_expect_success \
     'Apply a patch created with "git diff"' \
     '
-    stg import ../t1800-import/git-diff &&
+    stg import -n git.diff ../t1800-import/git-diff &&
     [ $(git cat-file -p $(stg id) \
         | grep -c "tree e96b1fba2160890ff600b675d7140d46b022b155") =3D=
 1 ] &&
     stg delete ..

And now run the test

$ ./t1800-import.sh -i -v
=2E..
Importing patch "git.diff" ... done
No patches applied

The mainline StGIT is OK.

--=20
Regards,
Pavel Roskin
