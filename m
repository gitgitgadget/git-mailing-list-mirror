From: John Keeping <john@keeping.me.uk>
Subject: Prebuilt man pages on Google code
Date: Sun, 16 Dec 2012 16:28:27 +0000
Message-ID: <20121216162827.GA22351@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 17:28:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkH58-0007WU-GD
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 17:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab2LPQ2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2012 11:28:33 -0500
Received: from anakin.london.02.net ([87.194.255.134]:42482 "EHLO
	anakin.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab2LPQ2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 11:28:32 -0500
Received: from river.lan (188.222.177.116) by anakin.london.02.net (8.5.140)
        id 4FED9D1503C60547; Sun, 16 Dec 2012 16:28:27 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211593>

While investigating Asciidoc's quoting in this thread [1], I noticed
that my system man pages don't display Asciidoc double quoted text
correctly.

[1] http://article.gmane.org/gmane.comp.version-control.git/211533

=46or example in git-fast-import(1):

   Here <name> is the person=E2=80=99s display name (for example `Com M=
 Itter'')
   and `<email> is the person=E2=80=99s email address (`cm@example.com'=
'). `LT
   and GT are the literal less-than (\x3c) and greater-than (\x3e)
   symbols.

It turns out that Gentoo installs the man pages from git-core on Google
code, and the error can be seen in the "source" there [2].

[2] http://code.google.com/p/git-manpages/source/browse/man1/git-fast-i=
mport.1#379

When I generate man pages here, I get paired quotes (\u201C and \u201D)=
:

   Here <name> is the person=E2=80=99s display name (for example =E2=80=
=9CCom M Itter=E2=80=9D)
   and <email> is the person=E2=80=99s email address (=E2=80=9Ccm@examp=
le.com=E2=80=9D). LT and
   GT are the literal less-than (\x3c) and greater-than (\x3e) symbol

I can't see any configuration option that could cause this difference,
so I assume it must be caused by some particular tool version on the
machine used to generate these man pages.

If the output is a side-effect of avoiding non-ASCII characters, is is
useful to do something like this (with appropriate Makefile support)?

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 1273a85..6655ec7 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -89,6 +89,16 @@ template::[header-declarations]
 endif::backend-docbook[]
 endif::doctype-manpage[]
=20
+ifdef::doctype-manpage[]
+ifdef::git-asciidoc-man-ascii[]
+[attributes]
+lsquo=3D&#39;
+rsquo=3D&#39;
+ldquo=3D&#34;
+rdquo=3D&#34;
+endif::git-asciidoc-man-ascii[]
+endif::doctype-manpage[]
+
 ifdef::backend-xhtml11[]
 [attributes]
 git-relative-html-prefix=3D
