From: Johan Herland <johan@herland.net>
Subject: [BUG?] How to make a shared/restricted repo?
Date: Wed, 25 Mar 2009 01:05:05 +0100
Message-ID: <200903250105.05808.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 01:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGe1-0005jN-Ah
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbZCYAFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 20:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbZCYAFN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:05:13 -0400
Received: from mx.getmail.no ([84.208.15.66]:36644 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753940AbZCYAFL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 20:05:11 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH100DI4C8J1L20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 01:05:07 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH100LO6C8IYGE0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 01:05:07 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.24.234912
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114519>

Hi,

Some colleagues of mine are working on a "secret" project, and they wan=
t to=20
create a central/server/integration repo that should be group-writable,=
 but=20
not at all accessible to anybody outside the group (i.e. files should b=
e=20
0660 ("-rw-rw----"), dirs should be 0770 ("drwxrws---")).

I started setting this up for them in the following manner:

  mkdir foo.git
  cd foo.git
  git init --bare --shared=3Dgroup
  cd ..
  chgrp -R groupname foo.git
  chmod -R o-rwx foo.git

=2E..and everything looks good, initially...

However, when I start pushing into this repo, the newly created files a=
re=20
readable to everybody (files are 0664 ("-rw-rw-r--"), dirs are 0775=20
("drwxrwsr-x")).

Instead of "git init --bare --shared=3Dgroup", I've tried using
  git init --bare --shared=3D0660
and even
  git init --bare &&
  git config core.sharedRepository 0660
but the result is still the same.

After reading the "--shared" section in the "git init" man page, this=20
behaviour is unexpected, and after reading the "core.sharedRepository"=20
section in the "git config" man page, the current behaviour is IMHO out=
right=20
_wrong_. Quoting the "git config" man page:

  core.sharedRepository
    [...] When 0xxx, where 0xxx is an octal number, files in the reposi=
tory
    will have this mode value. 0xxx will override user=E2=80=99s umask =
value, and
    thus, users with a safe umask (0077) can use this option. [...]

AFAICS, even when I set "core.sharedRepository" to 0660, files are stil=
l=20
created 0664, which is not what the documentation indicates.

Are there other ways to create such shared-but-restricted repositories?


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
