From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: [PATCH] NO_PERL_MAKEMAKER should behave more like ExtUtils::MakeMaker
Date: Tue, 13 Oct 2009 13:14:31 +0200
Message-ID: <1255432471-14168-1-git-send-email-tgc@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 13:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxfYR-0002YW-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 13:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbZJMLZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 07:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbZJMLZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 07:25:57 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:53023 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbZJMLZ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 07:25:56 -0400
X-Greylist: delayed 647 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2009 07:25:56 EDT
Received: from throll.sb.statsbiblioteket.dk (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server
 (TLS) id 8.1.393.1; Tue, 13 Oct 2009 13:14:32 +0200
Received: from throll.sb.statsbiblioteket.dk (localhost.localdomain
 [127.0.0.1])	by throll.sb.statsbiblioteket.dk (8.13.1/8.13.1) with ESMTP id
 n9DBEWrH014198	for <git@vger.kernel.org>; Tue, 13 Oct 2009 13:14:32 +0200
Received: (from tgc@localhost)	by throll.sb.statsbiblioteket.dk
 (8.13.1/8.13.1/Submit) id n9DBEVEM014197	for git@vger.kernel.org; Tue, 13 Oct
 2009 13:14:31 +0200
X-Authentication-Warning: throll.sb.statsbiblioteket.dk: tgc set sender to tgc@statsbiblioteket.dk using -f
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130159>

This change makes NO_PERL_MAKEMAKER behave more as ExtUtils::MakeMaker
by installing the modules into the perl libdir and not $(prefix)/lib.
It will default to sitelib but will allow the user to choose by setting
the INSTALLDIRS variable which is also honored by ExtUtils::MakeMaker.

Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
---
 perl/Makefile |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 4ab21d6..264cfc1 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -20,7 +20,12 @@ clean:
 	$(RM) $(makfile).old
 
 ifdef NO_PERL_MAKEMAKER
-instdir_SQ = $(subst ','\'',$(prefix)/lib)
+perllib = site
+ifdef INSTALLDIRS
+perllib = $(INSTALLDIRS)
+endif
+perlinstdir := $(shell sh -c "$(PERL_PATH_SQ) -V:install$(perllib)lib | cut -d\' -f2")
+instdir_SQ = $(subst ','\'',$(perlinstdir))
 $(makfile): ../GIT-CFLAGS Makefile
 	echo all: private-Error.pm Git.pm > $@
 	echo '	mkdir -p blib/lib' >> $@
-- 
1.6.4.4
