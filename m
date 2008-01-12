From: Pavel Roskin <proski@gnu.org>
Subject: Re: Signing by StGIT broken
Date: Fri, 11 Jan 2008 23:58:03 -0500
Message-ID: <1200113883.26841.18.camel@rd>
References: <1199933596.21499.15.camel@dv>
	 <20080110074252.GA18629@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 05:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYS3-0003KA-3o
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 05:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757527AbYALE6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 23:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757416AbYALE6G
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 23:58:06 -0500
Received: from c60.cesmail.net ([216.154.195.49]:23410 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757407AbYALE6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 23:58:05 -0500
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 11 Jan 2008 23:58:04 -0500
Received: from [192.168.1.28] (pool-96-227-100-57.phlapa.east.verizon.net [96.227.100.57])
	by relay.cesmail.net (Postfix) with ESMTP id D38E8618FE1;
	Fri, 11 Jan 2008 23:58:03 -0500 (EST)
In-Reply-To: <20080110074252.GA18629@diana.vm.bytemark.co.uk>
X-Mailer: Evolution 2.12.2 (2.12.2-2.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70263>

On Thu, 2008-01-10 at 08:42 +0100, Karl Hasselstr=F6m wrote:
> On 2008-01-09 21:53:16 -0500, Pavel Roskin wrote:
>=20
> > "stg edit --sign" is not working anymore. It was working in version
> > 0.14.
>=20
> Thanks for the report and the detailed analysis. I'll write a test an=
d
> fix it (but not quite immediately, so feel free to beat me to it).

The fix below appears to work (thus making it a self-signing patch :))
but with my modest Python experience it absolutely needs to be reviewed=
=2E
I don't even know how to wrap the long line without making it look
misleading.

No testsuite fixes, sorry.  But the existing testsuite passes.


=46ix "stg edit --sign"

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/commands/edit.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index b9699d5..650d5a3 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -90,7 +90,10 @@ def __update_patch(pname, text, options):
     bottom =3D patch.get_bottom()
     top =3D patch.get_top()
=20
-    message, author_name, author_email, author_date, diff =3D parse_pa=
tch(text)
+    if text:
+        message, author_name, author_email, author_date, diff =3D pars=
e_patch(text)
+    else:
+        message =3D author_name =3D author_email =3D author_date =3D d=
iff =3D None
=20
     out.start('Updating patch "%s"' % pname)
=20

--=20
Regards,
Pavel Roskin
