From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Allow e-mails to be sent with the Unix sendmail tool
Date: Sat, 14 Jun 2008 11:05:04 +0200
Message-ID: <20080614090504.GB14282@diana.vm.bytemark.co.uk>
References: <20080614072824.7899.42222.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Ri5-0003Hl-NG
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488AbYFNJFO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 05:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYFNJFO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:05:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2531 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbYFNJFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 05:05:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K7Rh2-0003nf-00; Sat, 14 Jun 2008 10:05:04 +0100
Content-Disposition: inline
In-Reply-To: <20080614072824.7899.42222.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84993>

On 2008-06-14 08:28:24 +0100, Catalin Marinas wrote:

> If the stgit.smtpserver configuration option does not have a
> host:port format, it is assumed to be an external tool. For example,
> to use sendmail just set this variable to "/usr/sbin/sendmail -t -i"
> (see the examples/gitconfig file).

Looks good, except that the new feature (and the fact that it's
magically triggered if the smtpserver starts with a /) is not
documented. Maybe add something like this to the patch:

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 4027170..2b1b92c 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -31,10 +31,13 @@ usage =3D r"""%prog [options] [<patch1>] [<patch2>]=
 [<patch3>..<patch4>]
=20
 Send a patch or a range of patches by e-mail using the SMTP server
 specified by the 'stgit.smtpserver' configuration option, or the
-'--smtp-server' command line option. The From address and the e-mail
-format are generated from the template file passed as argument to
-'--template' (defaulting to '.git/patchmail.tmpl' or
-'~/.stgit/templates/patchmail.tmpl' or
+'--smtp-server' command line option. (You may give the absolute path
+to sendmail instead, followed by any sendmail options you wish to
+use.)
+
+The From address and the e-mail format are generated from the template
+file passed as argument to '--template' (defaulting to
+'.git/patchmail.tmpl' or '~/.stgit/templates/patchmail.tmpl' or
 '/usr/share/stgit/templates/patchmail.tmpl'). A patch can be sent as
 attachment using the --attach option in which case the 'mailattch.tmpl=
'
 template will be used instead of 'patchmail.tmpl'.
@@ -133,8 +136,10 @@ options =3D [make_option('-a', '--all',
                        help =3D 'sleep for SECONDS between e-mails sen=
ding'),
            make_option('--refid',
                        help =3D 'use REFID as the reference id'),
-           make_option('--smtp-server', metavar =3D 'HOST[:PORT]',
-                       help =3D 'SMTP server to use for sending mail')=
,
+           make_option('--smtp-server',
+                       metavar =3D 'HOST[:PORT] or "/path/to/sendmail =
-t -i"',
+                       help =3D ('SMTP server (or sendmail program) to=
 use for'
+                               ' sending mail')),
            make_option('-u', '--smtp-user', metavar =3D 'USER',
                        help =3D 'username for SMTP authentication'),
            make_option('-p', '--smtp-password', metavar =3D 'PASSWORD'=
,

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
