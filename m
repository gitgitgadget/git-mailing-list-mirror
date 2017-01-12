Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45B320798
	for <e@80x24.org>; Thu, 12 Jan 2017 06:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbdALGCX (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 01:02:23 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34650 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdALGCW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 01:02:22 -0500
Received: by mail-io0-f174.google.com with SMTP id l66so11083773ioi.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 22:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6SJeaX2FSko81oB9PXGrSWLF2KAi5G8juou1BULsbs=;
        b=G5Jw+Z+gd8eoGuHX7j9wG09evaLAsaVk+2sVcr+zF73mRxwZ+ApnJjRxX1OufeZ/pK
         fyVT+hcTzR9QHFXQdcjXWzVlMTe6anlMyFqoSKpXxg0evWU8suY/2a+4yD51QZm+yGn6
         o1iOds2Hw+DKnoPXic53rHvTAaNcgqj6DWmezM/Acfebt06UrSGPr5d9NHQzvH35LeTQ
         mueUKOZkgmCN7KBMMXJ3NNkCtddhPlntvejjwVT7TVOvX+LaCkumD/EryAZs5yhx8TAK
         uwC2CHPC3/nwX6iM9E4GCdJgrj8ZLuDDPTujz2QZk2Z88E3qyHJaSArtiGqzzzgbNqg4
         06+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6SJeaX2FSko81oB9PXGrSWLF2KAi5G8juou1BULsbs=;
        b=kLdxbzTilrQHdzpZ+p77QWy4eBIrukDKxVbJfgeWQxptjT0PvYAWSs253oDEKImVg/
         ZUKizYsfyRRprGuh/HsIFtyK1tLYpcOjsstY8fSPtdZSLt9slA1ilESctTVjSpcEybUl
         hGMO08k/XeezuDIjggaEu1YMGKF++oTrb35GbWcHGjRGf+FZuSA6Bh4pjt56tVMGLCEK
         NqP7wiZ+KU6MEfM7yt0dGQ4gr9jP1efNa6wigdpRgxT6G+QjLZs6DdseSwgnGOrtAXqe
         +a5QScQl2YsUeFlEFlEqfYsCOgHIv3EDwjWtRldgl46Ic6cFlDXViUMbaWxZlivp4imh
         vj3w==
X-Gm-Message-State: AIkVDXJsvjVfOvtNP0e4ZxLFGXDyfDvGxY1kF1Hw4Kc6/HjRbyH65wdogMGya6utR5Z8Mw==
X-Received: by 10.107.9.141 with SMTP id 13mr13912319ioj.24.1484200387215;
        Wed, 11 Jan 2017 21:53:07 -0800 (PST)
Received: from d-212-11-228.eecs.umich.edu ([141.212.11.228])
        by smtp.gmail.com with ESMTPSA id r20sm4350888ioi.10.2017.01.11.21.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 21:53:06 -0800 (PST)
From:   Pat Pannuto <pat.pannuto@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Pat Pannuto <pat.pannuto@gmail.com>
Subject: [PATCH 2/2] Use 'env' to find perl instead of fixed path
Date:   Thu, 12 Jan 2017 00:51:40 -0500
Message-Id: <20170112055140.29877-3-pat.pannuto@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170112055140.29877-1-pat.pannuto@gmail.com>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on system configuration, /usr/bin/perl may not be the
preferred perl interpreter, use /usr/bin/env perl to invoke perl
instead to repsect user preferences.

In most cases this will not matter as any perl install will work,
but for applications such as git-format-patch, which may require
plugins such as Net/SMTP/SSL.pm to be installed, it is very confusing
when git fails to work after installation because it chose the
wrong perl installation.

This patch converts all shebangs to use env for consistency across
the project.

Signed-off-by: Pat Pannuto <pat.pannuto@gmail.com>
---
 Documentation/build-docdep.perl               | 2 +-
 Documentation/cat-texi.perl                   | 2 +-
 Documentation/cmd-list.perl                   | 2 +-
 Documentation/fix-texi.perl                   | 2 +-
 Documentation/lint-gitlink.perl               | 2 +-
 compat/vcbuild/scripts/clink.pl               | 2 +-
 compat/vcbuild/scripts/lib.pl                 | 2 +-
 contrib/buildsystems/engine.pl                | 2 +-
 contrib/buildsystems/generate                 | 2 +-
 contrib/buildsystems/parse.pl                 | 2 +-
 contrib/contacts/git-contacts                 | 2 +-
 contrib/credential/netrc/git-credential-netrc | 2 +-
 contrib/credential/netrc/test.pl              | 2 +-
 contrib/diff-highlight/diff-highlight         | 2 +-
 contrib/examples/git-remote.perl              | 2 +-
 contrib/examples/git-rerere.perl              | 2 +-
 contrib/examples/git-svnimport.perl           | 2 +-
 contrib/fast-import/git-import.perl           | 2 +-
 contrib/fast-import/import-directories.perl   | 2 +-
 contrib/fast-import/import-tars.perl          | 2 +-
 contrib/hooks/setgitperms.perl                | 2 +-
 contrib/hooks/update-paranoid                 | 2 +-
 contrib/long-running-filter/example.pl        | 2 +-
 contrib/mw-to-git/git-mw.perl                 | 2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl   | 2 +-
 contrib/mw-to-git/t/test-gitmw.pl             | 2 +-
 contrib/stats/mailmap.pl                      | 2 +-
 contrib/stats/packinfo.pl                     | 2 +-
 git-add--interactive.perl                     | 2 +-
 git-archimport.perl                           | 2 +-
 git-cvsexportcommit.perl                      | 2 +-
 git-cvsimport.perl                            | 2 +-
 git-cvsserver.perl                            | 2 +-
 git-difftool.perl                             | 2 +-
 git-relink.perl                               | 2 +-
 git-send-email.perl                           | 2 +-
 git-svn.perl                                  | 2 +-
 gitweb/gitweb.perl                            | 2 +-
 t/Git-SVN/Utils/can_compress.t                | 2 +-
 t/Git-SVN/Utils/fatal.t                       | 2 +-
 t/check-non-portable-shell.pl                 | 2 +-
 t/gitweb-lib.sh                               | 2 +-
 t/perf/aggregate.perl                         | 2 +-
 t/perf/min_time.perl                          | 2 +-
 t/t0202/test.pl                               | 2 +-
 t/t4034/perl/post                             | 2 +-
 t/t4034/perl/pre                              | 2 +-
 t/t9000/test.pl                               | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh        | 2 +-
 t/t9700/test.pl                               | 2 +-
 t/test-terminal.perl                          | 2 +-
 51 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.perl
index ba4205e03..dc50f21f3 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 my %include = ();
 my %included = ();
diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index 1cd28b1b5..98dcc2c42 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use warnings;
 
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index ba640a441..f440eebe3 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use warnings;
 
diff --git a/Documentation/fix-texi.perl b/Documentation/fix-texi.perl
index c247aece7..61287a0a9 100755
--- a/Documentation/fix-texi.perl
+++ b/Documentation/fix-texi.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use warnings;
 
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 476cc30b8..3e4b00eda 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use File::Find;
 use Getopt::Long;
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
index 46eb61c5c..857847703 100755
--- a/compat/vcbuild/scripts/clink.pl
+++ b/compat/vcbuild/scripts/clink.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 ######################################################################
 # Compiles or links files
 #
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
index e571b8470..9b43f1270 100755
--- a/compat/vcbuild/scripts/lib.pl
+++ b/compat/vcbuild/scripts/lib.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 ######################################################################
 # Libifies files on Windows
 #
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index a173669ce..ace1fd4bf 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 ######################################################################
 # Do not call this script directly!
 #
diff --git a/contrib/buildsystems/generate b/contrib/buildsystems/generate
index 9af89454a..d6ce919cb 100755
--- a/contrib/buildsystems/generate
+++ b/contrib/buildsystems/generate
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 ######################################################################
 # Generate buildsystem files
 #
diff --git a/contrib/buildsystems/parse.pl b/contrib/buildsystems/parse.pl
index 33ca89eb0..492acf447 100755
--- a/contrib/buildsystems/parse.pl
+++ b/contrib/buildsystems/parse.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 ######################################################################
 # Do not call this script directly!
 #
diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
index dbe2abf27..70ec2039a 100755
--- a/contrib/contacts/git-contacts
+++ b/contrib/contacts/git-contacts
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # List people who might be interested in a patch.  Useful as the argument to
 # git-send-email --cc-cmd option, and in other situations.
diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 1571a7b26..ec8178f26 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index 169b6463c..6b44ba54d 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use warnings;
 use strict;
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 81bd8040e..ecf419542 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use 5.008;
 use warnings FATAL => 'all';
diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index 5bf3ffd4c..2c8f18a13 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;
diff --git a/contrib/examples/git-rerere.perl b/contrib/examples/git-rerere.perl
index 4f692091e..110c27f4f 100755
--- a/contrib/examples/git-rerere.perl
+++ b/contrib/examples/git-rerere.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # REuse REcorded REsolve.  This tool records a conflicted automerge
 # result and its hand resolution, and helps to resolve future
diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
index c414f0d9c..d183a8d66 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/contrib/fast-import/git-import.perl b/contrib/fast-import/git-import.perl
index 0891b9e36..440790523 100755
--- a/contrib/fast-import/git-import.perl
+++ b/contrib/fast-import/git-import.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Performs an initial import of a directory. This is the equivalent
 # of doing 'git init; git add .; git commit'. It's a little slower,
diff --git a/contrib/fast-import/import-directories.perl b/contrib/fast-import/import-directories.perl
index 4dec1f18e..197307570 100755
--- a/contrib/fast-import/import-directories.perl
+++ b/contrib/fast-import/import-directories.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright 2008-2009 Peter Krefting <peter@softwolves.pp.se>
 #
diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index d60b4315e..30f3ff384 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 ## tar archive frontend for git-fast-import
 ##
diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index 2770a1b1d..18444e015 100755
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright (c) 2006 Josh England
 #
diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
index d18b317b2..95595acf5 100755
--- a/contrib/hooks/update-paranoid
+++ b/contrib/hooks/update-paranoid
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use File::Spec;
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
index a677569dd..0ca49e370 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Example implementation for the Git filter protocol version 2
 # See Documentation/gitattributes.txt, section "Filter Protocol"
diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
index 28df3ee32..50c0549b5 100755
--- a/contrib/mw-to-git/git-mw.perl
+++ b/contrib/mw-to-git/git-mw.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # Copyright (C) 2013
 #     Benoit Person <benoit.person@ensimag.imag.fr>
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 41e74fba1..f8ce245cf 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -1,4 +1,4 @@
-#! /usr/bin/perl
+#!/usr/bin/env perl
 
 # Copyright (C) 2011
 #     Jérémie Nikaes <jeremie.nikaes@ensimag.imag.fr>
diff --git a/contrib/mw-to-git/t/test-gitmw.pl b/contrib/mw-to-git/t/test-gitmw.pl
index 8d0e7c078..a8272d942 100755
--- a/contrib/mw-to-git/t/test-gitmw.pl
+++ b/contrib/mw-to-git/t/test-gitmw.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # Copyright (C) 2012
 #     Charles Roussel <charles.roussel@ensimag.imag.fr>
 #     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
index 9513f5e35..469af8240 100755
--- a/contrib/stats/mailmap.pl
+++ b/contrib/stats/mailmap.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use warnings 'all';
 use strict;
diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
index be188c0f1..51823ac94 100755
--- a/contrib/stats/packinfo.pl
+++ b/contrib/stats/packinfo.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # This tool will print vaguely pretty information about a pack.  It
 # expects the output of "git verify-pack -v" as input on stdin.
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cf6fc926a..6d7b6c35d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use 5.008;
 use strict;
diff --git a/git-archimport.perl b/git-archimport.perl
index 9cb123a07..bb423e781 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # This tool is copyright (c) 2005, Martin Langhoff.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d13f02da9..c2ebfb59f 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use 5.008;
 use strict;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1e4e65a45..5dcdd8106 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # This tool is copyright (c) 2005, Matthias Urlichs.
 # It is released under the Gnu Public License, version 2.
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index d50c85ed7..3ae5e748b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 ####
 #### This application is a CVS emulation layer for git.
diff --git a/git-difftool.perl b/git-difftool.perl
index df59bdfe9..a34d0f7fd 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # Copyright (c) 2009, 2010 David Aguilar
 # Copyright (c) 2012 Tim Henigan
 #
diff --git a/git-relink.perl b/git-relink.perl
index 236a3521a..b51348fa6 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # Copyright 2005, Ryan Anderson <ryan@michonline.com>
 # Distribution permitted under the GPL v2, as distributed
 # by the Free Software Foundation.
diff --git a/git-send-email.perl b/git-send-email.perl
index 068d60b3e..678d823af 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
diff --git a/git-svn.perl b/git-svn.perl
index fa4236478..ae3991524 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
 use 5.008;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7cf68f07b..d084360e6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # gitweb - simple web interface to track changes in git repositories
 #
diff --git a/t/Git-SVN/Utils/can_compress.t b/t/Git-SVN/Utils/can_compress.t
index d7b49b8d5..0cdedb25b 100755
--- a/t/Git-SVN/Utils/can_compress.t
+++ b/t/Git-SVN/Utils/can_compress.t
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;
diff --git a/t/Git-SVN/Utils/fatal.t b/t/Git-SVN/Utils/fatal.t
index 49e143829..75aaf1633 100755
--- a/t/Git-SVN/Utils/fatal.t
+++ b/t/Git-SVN/Utils/fatal.t
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 use warnings;
diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b170cbc04..3c3e2e7d4 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # Test t0000..t9999.sh for non portable shell scripts
 # This script can be called with one or more filenames as parameters
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index d5dab5a94..b23843ff4 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -7,7 +7,7 @@
 gitweb_init () {
 	safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
 	cat >gitweb_config.perl <<EOF
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 # gitweb configuration for tests
 
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 924b19dab..2c6278ca6 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use lib '../../perl/blib/lib';
 use strict;
diff --git a/t/perf/min_time.perl b/t/perf/min_time.perl
index c1a2717e0..2595eae61 100755
--- a/t/perf/min_time.perl
+++ b/t/perf/min_time.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 my $minrt = 1e100;
 my $min;
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 2cbf7b959..d8e967bbc 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use 5.008;
 use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
diff --git a/t/t4034/perl/post b/t/t4034/perl/post
index e8b72ef5d..87500971d 100644
--- a/t/t4034/perl/post
+++ b/t/t4034/perl/post
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 
diff --git a/t/t4034/perl/pre b/t/t4034/perl/pre
index f6610d37b..5ab5aa42f 100644
--- a/t/t4034/perl/pre
+++ b/t/t4034/perl/pre
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 
 use strict;
 
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
index dfeaa9c65..4e47f3887 100755
--- a/t/t9000/test.pl
+++ b/t/t9000/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
 
 use 5.008;
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6d06ed96c..d8b5622b5 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -712,7 +712,7 @@ test_expect_success HIGHLIGHT \
 test_expect_success HIGHLIGHT \
 	'syntax highlighting (highlighter language autodetection)' \
 	'git config gitweb.highlight yes &&
-	 echo "#!/usr/bin/perl" > test &&
+	 echo "#!/usr/bin/env perl" > test &&
 	 git add test &&
 	 git commit -m "Add test" &&
 	 gitweb_run "p=.git;a=blob;f=test"'
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 1b75c9196..c0be7e895 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use lib (split(/:/, $ENV{GITPERLLIB}));
 
 use 5.008;
diff --git a/t/test-terminal.perl b/t/test-terminal.perl
index 96b6a03e1..d1d40c0db 100755
--- a/t/test-terminal.perl
+++ b/t/test-terminal.perl
@@ -1,4 +1,4 @@
-#!/usr/bin/perl
+#!/usr/bin/env perl
 use 5.008;
 use strict;
 use warnings;
-- 
2.11.0

