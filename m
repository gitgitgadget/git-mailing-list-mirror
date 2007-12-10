From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Don't cache DESTDIR in perl/perl.mak.
Date: Mon, 10 Dec 2007 09:31:02 +0000
Message-ID: <20071210093102.3050.qmail@06e91d20307a62.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 10:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1eyh-0008FY-BH
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 10:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXLJJap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 04:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbXLJJap
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 04:30:45 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:38540 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751012AbXLJJao (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 04:30:44 -0500
Received: (qmail 3051 invoked by uid 1000); 10 Dec 2007 09:31:02 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67694>

DESTDIR is supposed to be overridden on 'make install' after doing
'make'.  Have the automatically generated perl/perl.mak not cache the
value of DESTDIR to support that for the perl/ subdirectory also.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Makefile         |    2 +-
 perl/Makefile.PL |    6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 4cdb84b..3615be0 100644
--- a/Makefile
+++ b/Makefile
@@ -1025,7 +1025,7 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
-	$(MAKE) -C perl prefix='$(prefix_SQ)' install
+	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui install
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 6aecd89..320253e 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -17,9 +17,6 @@ if ($@ || $Error::VERSION < 0.15009) {
 	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
 }
 
-my %extra;
-$extra{DESTDIR} = $ENV{DESTDIR} if $ENV{DESTDIR};
-
 # redirect stdout, otherwise the message "Writing perl.mak for Git"
 # disrupts the output for the target 'instlibdir'
 open STDOUT, ">&STDERR";
@@ -29,6 +26,5 @@ WriteMakefile(
 	VERSION_FROM    => 'Git.pm',
 	PM		=> \%pm,
 	MAKEFILE	=> 'perl.mak',
-	INSTALLSITEMAN3DIR => '$(SITEPREFIX)/share/man/man3',
-	%extra
+	INSTALLSITEMAN3DIR => '$(SITEPREFIX)/share/man/man3'
 );
-- 
1.5.3.4
