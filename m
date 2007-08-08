From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Add an --smtp-server commandline option to "stg add"
Date: Thu, 09 Aug 2007 00:11:09 +0200
Message-ID: <20070808221002.13517.66699.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItkJ-00082K-AZ
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbXHHWLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbXHHWLM
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:11:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4446 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbXHHWLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:11:11 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IItkE-00065n-00; Wed, 08 Aug 2007 23:11:10 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55379>

The configuration option stgit.smtpserver is useful if you always talk
to the same SMTP server. But I usually set up a temporary ssh tunnel,
so I'd rather have a commandline option.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

This patch is sent using the --smtp-server commandline option. Pure
magic!

 stgit/commands/mail.py |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index cb8dc74..a7f7151 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -28,10 +28,11 @@ from stgit.config import config
 help =3D 'send a patch or series of patches by e-mail'
 usage =3D """%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>=
]
=20
-Send a patch or a range of patches by e-mail using the 'smtpserver'
-configuration option. The From address and the e-mail format are
-generated from the template file passed as argument to '--template'
-(defaulting to '.git/patchmail.tmpl' or
+Send a patch or a range of patches by e-mail using the SMTP server
+specified by the 'stgit.smtpserver' configuration option, or the
+'--smtp-server' command line option. The From address and the e-mail
+format are generated from the template file passed as argument to
+'--template' (defaulting to '.git/patchmail.tmpl' or
 '~/.stgit/templates/patchmail.tmpl' or
 '/usr/share/stgit/templates/patchmail.tmpl').
=20
@@ -117,6 +118,8 @@ options =3D [make_option('-a', '--all',
                        help =3D 'sleep for SECONDS between e-mails sen=
ding'),
            make_option('--refid',
                        help =3D 'use REFID as the reference id'),
+           make_option('--smtp-server', metavar =3D 'HOST[:PORT]',
+                       help =3D 'SMTP server to use for sending mail')=
,
            make_option('-u', '--smtp-user', metavar =3D 'USER',
                        help =3D 'username for SMTP authentication'),
            make_option('-p', '--smtp-password', metavar =3D 'PASSWORD'=
,
@@ -465,7 +468,7 @@ def func(parser, options, args):
     """Send the patches by e-mail using the patchmail.tmpl file as
     a template
     """
-    smtpserver =3D config.get('stgit.smtpserver')
+    smtpserver =3D options.smtp_server or config.get('stgit.smtpserver=
')
=20
     applied =3D crt_series.get_applied()
=20
