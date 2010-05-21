From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] perl shebangs: Use /usr/bin/env, not /usr/bin/perl
Date: Fri, 21 May 2010 16:54:15 +0000
Message-ID: <1274460855-9769-1-git-send-email-avarab@gmail.com>
References: <AANLkTinKPntmpqYXTADzivGic3HfeMEDm2f35N8Z7dMc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 19:00:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFVaA-0008VB-GD
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 19:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934255Ab0EUQ7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:59:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52862 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934248Ab0EUQyY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:54:24 -0400
Received: by fxm5 with SMTP id 5so1043127fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TZ4qvOi74g5i23h5aN/F18kFyZ+vJHgUiW1BiexTT/Y=;
        b=xpmB4AABIqJkQt6uLNA8ME5fOHtjLumIRiSsQ8cDVCFq7uT7PXHq6NAWa9r1Nl/w7a
         cA3oJztnxel+9KXnuS2Ns18dqvVvaXxctjnbqvtkiJItiedd/YD3ncw6K8zAzfdNOk+C
         GydXMmS8D/dhfgmRUQRfZvT6219VHx70pNAl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EqMn2wDeM8tuBU0Rg9ujSFpWQP1G7ox79ruTWX8X49fqk/r28zT7rqPYjkNXi3lFCS
         l+rpJzY1/c90CNsqUGrYZB+d64nT1a9047UdQrUqwoD0hg3h1kLXk9PYqikYFgUW1w9Z
         zz/uZ1vXDmnW4Zbwj06oJJuV0bcwCQ8RHGl1s=
Received: by 10.223.23.67 with SMTP id q3mr1685372fab.59.1274460862159;
        Fri, 21 May 2010 09:54:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 2sm5316149fav.13.2010.05.21.09.54.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 09:54:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.98.g4a5f
In-Reply-To: <AANLkTinKPntmpqYXTADzivGic3HfeMEDm2f35N8Z7dMc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147485>

Change the Perl Git utilities to use #!/usr/bin/env perl as a shebang
instead of #!/usr/bin/perl. In cases where perl -w was part of the
shebang I've replaced it with BEGIN { $^W =3D 0 }. use warnings would b=
e
better, but this doesn't break systems still running perl 5.005.

This only affects shebangs in the uninstalled source tree. On
installation shebangs will still be munged to PERL_PATH, which is
currently /usr/bin/perl by default.

With this change all the code in Git that uses a shebang now uses
/usr/bin/env, except those things that use /bin/sh and /bin/bash. All
the Python code already used it, and some of the Perl code.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Replaces /usr/bin/env perl -w with just perl + BEGIN { $^W =3D 1 } whic=
h
has the same effect as -w. I.e. turns on warnings globally.

 Documentation/build-docdep.perl             |    2 +-
 Documentation/cat-texi.perl                 |    2 +-
 Documentation/cmd-list.perl                 |    4 ++--
 Documentation/fix-texi.perl                 |    3 ++-
 compat/vcbuild/scripts/clink.pl             |    3 ++-
 compat/vcbuild/scripts/lib.pl               |    3 ++-
 contrib/blameview/blameview.perl            |    2 +-
 contrib/buildsystems/engine.pl              |    3 ++-
 contrib/buildsystems/generate               |    3 ++-
 contrib/buildsystems/parse.pl               |    3 ++-
 contrib/continuous/cidaemon                 |    2 +-
 contrib/continuous/post-receive-cinotify    |    2 +-
 contrib/examples/git-remote.perl            |    2 +-
 contrib/examples/git-rerere.perl            |    2 +-
 contrib/examples/git-svnimport.perl         |    2 +-
 contrib/fast-import/git-import.perl         |    2 +-
 contrib/fast-import/import-directories.perl |    2 +-
 contrib/fast-import/import-tars.perl        |    2 +-
 contrib/hooks/setgitperms.perl              |    2 +-
 contrib/hooks/update-paranoid               |    2 +-
 contrib/stats/mailmap.pl                    |    3 +--
 contrib/stats/packinfo.pl                   |    2 +-
 git-add--interactive.perl                   |    2 +-
 git-archimport.perl                         |    2 +-
 git-cvsexportcommit.perl                    |    4 ++--
 git-cvsimport.perl                          |    2 +-
 git-cvsserver.perl                          |    2 +-
 git-send-email.perl                         |    2 +-
 gitweb/gitweb.perl                          |    2 +-
 t/gitweb-lib.sh                             |    2 +-
 t/t7006/test-terminal.perl                  |    2 +-
 t/t9138-git-svn-authors-prog.sh             |    2 +-
 t/t9700/test.pl                             |    2 +-
 33 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/Documentation/build-docdep.perl b/Documentation/build-docd=
ep.perl
index ba4205e..dc50f21 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 my %include =3D ();
 my %included =3D ();
diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 082978f..3b4fb2d 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use warnings;
=20
 my @menu =3D ();
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 07d526e..dfb9014 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -1,5 +1,5 @@
-#!/usr/bin/perl
-use warnings;
+#!/usr/bin/env perl -w
+
 use File::Compare qw(compare);
=20
 sub format_one {
diff --git a/Documentation/fix-texi.perl b/Documentation/fix-texi.perl
index ff7d78f..bd5b6dd 100755
--- a/Documentation/fix-texi.perl
+++ b/Documentation/fix-texi.perl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
=20
 while (<>) {
 	if (/^\@setfilename/) {
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/c=
link.pl
index 4374771..748e659 100644
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
 ######################################################################
 # Compiles or links files
 #
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib=
=2Epl
index d8054e4..86b8977 100644
--- a/compat/vcbuild/scripts/lib.pl
+++ b/compat/vcbuild/scripts/lib.pl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
 ######################################################################
 # Libifies files on Windows
 #
diff --git a/contrib/blameview/blameview.perl b/contrib/blameview/blame=
view.perl
index 1dec001..438b737 100755
--- a/contrib/blameview/blameview.perl
+++ b/contrib/blameview/blameview.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use Gtk2 -init;
 use Gtk2::SimpleList;
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engi=
ne.pl
index 23da787..ad4b82c 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
 ######################################################################
 # Do not call this script directly!
 #
diff --git a/contrib/buildsystems/generate b/contrib/buildsystems/gener=
ate
index bc10f25..e3a352f 100644
--- a/contrib/buildsystems/generate
+++ b/contrib/buildsystems/generate
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
 ######################################################################
 # Generate buildsystem files
 #
diff --git a/contrib/buildsystems/parse.pl b/contrib/buildsystems/parse=
=2Epl
index c9656ec..4f932a9 100644
--- a/contrib/buildsystems/parse.pl
+++ b/contrib/buildsystems/parse.pl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
 ######################################################################
 # Do not call this script directly!
 #
diff --git a/contrib/continuous/cidaemon b/contrib/continuous/cidaemon
index 4009a15..9f10ce5 100644
--- a/contrib/continuous/cidaemon
+++ b/contrib/continuous/cidaemon
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # A daemon that waits for update events sent by its companion
 # post-receive-cinotify hook, checks out a new copy of source,
diff --git a/contrib/continuous/post-receive-cinotify b/contrib/continu=
ous/post-receive-cinotify
index b8f5a60..aeef222 100644
--- a/contrib/continuous/post-receive-cinotify
+++ b/contrib/continuous/post-receive-cinotify
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # A hook that notifies its companion cidaemon through a simple
 # queue file that a ref has been updated via a push (actually
diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-re=
mote.perl
index 48ab0ef..ee050a6 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl -w
=20
 use strict;
 use warnings;
diff --git a/contrib/examples/git-rerere.perl b/contrib/examples/git-re=
rere.perl
index 4f69209..110c27f 100755
--- a/contrib/examples/git-rerere.perl
+++ b/contrib/examples/git-rerere.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # REuse REcorded REsolve.  This tool records a conflicted automerge
 # result and its hand resolution, and helps to resolve future
diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git=
-svnimport.perl
index ead4c04..c4ded33 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/contrib/fast-import/git-import.perl b/contrib/fast-import/=
git-import.perl
index f9fef6d..275c3b9 100755
--- a/contrib/fast-import/git-import.perl
+++ b/contrib/fast-import/git-import.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Performs an initial import of a directory. This is the equivalent
 # of doing 'git init; git add .; git commit'. It's a little slower,
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast=
-import/import-directories.perl
index 7f3afa5..a02daa8 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
 #
diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import=
/import-tars.perl
index 95438e1..1b667e3 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 ## tar archive frontend for git-fast-import
 ##
diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms=
=2Eperl
index a577ad0..b33f094 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright (c) 2006 Josh England
 #
diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paran=
oid
index d18b317..95595ac 100644
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use File::Spec;
diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
index ff296fa..af92759 100755
--- a/contrib/stats/mailmap.pl
+++ b/contrib/stats/mailmap.pl
@@ -1,5 +1,4 @@
-#!/usr/bin/perl
-use warnings;
+#!/usr/bin/env perl -w
 my %mailmap =3D ();
 open I, "<", ".mailmap";
 while (<I>) {
diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
index be188c0..51823ac 100755
--- a/contrib/stats/packinfo.pl
+++ b/contrib/stats/packinfo.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # This tool will print vaguely pretty information about a pack.  It
 # expects the output of "git verify-pack -v" as input on stdin.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c2e7ab4..0826aab 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 use strict;
 use warnings;
diff --git a/git-archimport.perl b/git-archimport.perl
index 6ee3fca..a5e79fd 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 59b6722..a707f5c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,5 +1,5 @@
-#!/usr/bin/perl -w
-
+#!/usr/bin/env perl
+BEGIN { $^W =3D 1 }
 use strict;
 use Getopt::Std;
 use File::Temp qw(tempdir);
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d5e5677..5470c81 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl -w
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13751db..dc1c5dd 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 ####
 #### This application is a CVS emulation layer for git.
diff --git a/git-send-email.perl b/git-send-email.perl
index bbb03f7..27bdca5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 77e5f79..dbb0cc0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # gitweb - simple web interface to track changes in git repositories
 #
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 5a734b1..9572c6a 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -6,7 +6,7 @@
 gitweb_init () {
 	safe_pwd=3D"$(perl -MPOSIX=3Dgetcwd -e 'print quotemeta(getcwd)')"
 	cat >gitweb_config.perl <<EOF
-#!/usr/bin/perl
+#!/usr/bin/env perl
=20
 # gitweb configuration for tests
=20
diff --git a/t/t7006/test-terminal.perl b/t/t7006/test-terminal.perl
index 73ff809..840bab7 100755
--- a/t/t7006/test-terminal.perl
+++ b/t/t7006/test-terminal.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use strict;
 use warnings;
 use IO::Pty;
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-=
prog.sh
index 83cc5fc..ac1dcd7 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -8,7 +8,7 @@ test_description=3D'git svn authors prog tests'
 . ./lib-git-svn.sh
=20
 cat > svn-authors-prog <<'EOF'
-#!/usr/bin/perl
+#!/usr/bin/env perl
 $_ =3D shift;
 if (s/-sub$//)  {
 	print "$_ <$_\@sub.example.com>\n";
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 666722d..abfc9ba 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
=20
 use 5.006002;
--=20
1.7.1.98.g4a5f
