From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/2] perl libs: perl -w + use warnings is redundant
Date: Fri, 21 May 2010 16:52:21 +0000
Message-ID: <1274460741-9674-1-git-send-email-avarab@gmail.com>
References: <1274453455-1941-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 18:53:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFVT1-0004iw-S6
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934134Ab0EUQwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 12:52:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58517 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934181Ab0EUQwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:52:32 -0400
Received: by fxm5 with SMTP id 5so1041499fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=04aCkDLVE8Im3zeNn4dELgNUYa73tR1Y1eAkR4ZCiiQ=;
        b=kXcHlmDc5Ms9vAC0b15JzeO8ASe3dy0pvJ9/P3DPj3kxyEIJuy41LRyz6RLN3wOka4
         yjlotGnCMN0RQFA66lZ6qBnptij9IDHukPwd77BcoxJtzF1yP7gyr6FGQFFUAduTGnHf
         qTGwTEJFUe4M8Fu7yIeN/6MFpD6/86Ob3sxpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hkJux2ZWyie/aHk0XK74GORSYDqD0h1IXXwBDB/3BSvWkrZcl23n8IIwy/AACS44PX
         LWCJ9Tb419oz9ZJP2yhCRABW5GREchhHgULIintVKJirFgmrm7wjkSicwLCbxxmuzrk2
         eSlxVKImXRzVrBFJ1WCQaxB9u9ssbIPGoPcBY=
Received: by 10.223.97.149 with SMTP id l21mr1688269fan.91.1274460750582;
        Fri, 21 May 2010 09:52:30 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 7sm5299027far.18.2010.05.21.09.52.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 09:52:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.98.g4a5f
In-Reply-To: <1274453455-1941-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147483>

Change the Perl scripts to turn on lexical warnings, but only in Perl
scripts that definitely require 5.6.0 or later. I.e. those that either
did 'use warnings' in addition to -w already, or used the three-arg
form of open.

-w sets warnings for all code that interpreter runs. "use warnings" is
lexically scoped. The former is probably not what the authors wanted.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Turns out that I missed a case or two that could 'use
warnings'. I.e. used three-arg open.

 Documentation/cat-texi.perl                 |    3 ++-
 Documentation/cmd-list.perl                 |    4 ++--
 contrib/examples/git-remote.perl            |    3 ++-
 contrib/examples/git-svnimport.perl         |    2 +-
 contrib/fast-import/import-directories.perl |    3 ++-
 contrib/stats/mailmap.pl                    |    3 ++-
 git-add--interactive.perl                   |    3 ++-
 git-archimport.perl                         |    2 +-
 git-cvsimport.perl                          |    2 +-
 git-send-email.perl                         |    2 +-
 10 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 828ec62..082978f 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
+use warnings;
=20
 my @menu =3D ();
 my $output =3D $ARGV[0];
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 04f9977..07d526e 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -1,5 +1,5 @@
-#!/usr/bin/perl -w
-
+#!/usr/bin/perl
+use warnings;
 use File::Compare qw(compare);
=20
 sub format_one {
diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-re=
mote.perl
index b17952a..48ab0ef 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -1,6 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 use strict;
+use warnings;
 use Git;
 my $git =3D Git->repository();
=20
diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git=
-svnimport.perl
index 4576c4a..ead4c04 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast=
-import/import-directories.perl
index 3a5da4a..7f3afa5 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
 #
@@ -140,6 +140,7 @@ by whitespace or other characters.
=20
 # Globals
 use strict;
+use warnings;
 use integer;
 my $crlfmode =3D 0;
 my @revs;
diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
index 4b852e2..ff296fa 100755
--- a/contrib/stats/mailmap.pl
+++ b/contrib/stats/mailmap.pl
@@ -1,4 +1,5 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
+use warnings;
 my %mailmap =3D ();
 open I, "<", ".mailmap";
 while (<I>) {
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 21f1330..c2e7ab4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,6 +1,7 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 use strict;
+use warnings;
 use Git;
=20
 binmode(STDOUT, ":raw");
diff --git a/git-archimport.perl b/git-archimport.perl
index 98f3ede..6ee3fca 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9e03eee..d5e5677 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..bbb03f7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
--=20
1.7.1.98.g4a5f
