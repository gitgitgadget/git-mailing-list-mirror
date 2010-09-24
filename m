From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] perl: use "use warnings" instead of -w
Date: Fri, 24 Sep 2010 20:00:53 +0000
Message-ID: <1285358453-19292-2-git-send-email-avarab@gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Tor Arntsen <tor@spacetec.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 22:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzESr-00031t-Ak
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052Ab0IXUBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 16:01:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64603 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab0IXUBE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:01:04 -0400
Received: by wyb28 with SMTP id 28so2264491wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5vRzwpged7s0x1FhEqZ8vXk5WvjGRtmihSYyx3XBSNA=;
        b=NWCiQtrQLcwHbpflNnQWgJdN51IiPwssTQNJ7ozOQJpz5XBHWo6pkAejMq1Gw0gDm6
         7NKU1Be/LQp3gOsC7HjoVvy84+/NfUP1fx4Fp7QBb+fcKV/aJGky1XDRygxv9UBX4BjZ
         4oMQCo9SRw/ywEYMwTvDIwznBlxW9LRjJviik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CeRQ0qxlnxGmdPJTmBxYY0oT+01TPyTqnL9loTgm6ZEjiO4RfZCW00A0dX28j22JTL
         qX9gu9G4qPx6NPY+3KWsTVxuqkFd02WQErYNukqBTKxfEqoxUD2AsTQn2MlE0euYvGZI
         HL9cNXx3hz7nvMZe+G/dLD0xxHMY/+woVempI=
Received: by 10.227.146.213 with SMTP id i21mr3320714wbv.99.1285358463214;
        Fri, 24 Sep 2010 13:01:03 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm2144047wbe.5.2010.09.24.13.01.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 13:01:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a
In-Reply-To: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157049>

Change the Perl scripts to turn on lexical warnings instead of setting
the global $^W variable via the -w switch.

The -w sets warnings for all code that interpreter runs, while "use
warnings" is lexically scoped. The former is probably not what the
authors wanted.

As an auxiliary benefit it's now possible to build Git with:

    PERL_PATH=3D'/usr/bin/env perl'

Which would previously result in failures, since "#!/usr/bin/env perl -=
w"
doesn't work as a shebang.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This is a re-send, it's independent of bumping the version to 5.8 (use
warnings was introduced in 5.6), but a good idea anyway.

 contrib/examples/git-svnimport.perl         |    2 +-
 contrib/fast-import/import-directories.perl |    3 ++-
 git-add--interactive.perl                   |    3 ++-
 git-archimport.perl                         |    2 +-
 git-cvsexportcommit.perl                    |    3 ++-
 git-cvsimport.perl                          |    2 +-
 git-send-email.perl                         |    2 +-
 7 files changed, 10 insertions(+), 7 deletions(-)

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
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a96fb53..77f60fa 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,7 +1,8 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 use 5.008;
 use strict;
+use warnings;
 use Git;
=20
 binmode(STDOUT, ":raw");
diff --git a/git-archimport.perl b/git-archimport.perl
index 947638c..bc32f18 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 9a8188b..39a426e 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,7 +1,8 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 use 5.008;
 use strict;
+use warnings;
 use Getopt::Std;
 use File::Temp qw(tempdir);
 use Data::Dumper;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 53869fb..249aeaf 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
=20
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-send-email.perl b/git-send-email.perl
index 314e59e..d10d869 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl -w
+#!/usr/bin/perl
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
--=20
1.7.3.256.g00e8a
