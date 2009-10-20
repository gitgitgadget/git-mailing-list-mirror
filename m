From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] Makefile: set PERL_PATH and SHELL_PATH unconditionally
Date: Tue, 20 Oct 2009 02:06:28 -0700
Message-ID: <1256029588-24128-1-git-send-email-kraai@ftbfs.org>
References: <7vr5syshat.fsf@alter.siamese.dyndns.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 20 11:09:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Aic-0007VK-1n
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 11:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZJTJJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 05:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZJTJJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 05:09:16 -0400
Received: from zoom.lafn.org ([206.117.18.8]:34063 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbZJTJJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 05:09:15 -0400
Received: from macbookpro (pool-173-51-225-123.lsanca.fios.verizon.net [173.51.225.123])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id n9K99AEt037476
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 02:09:10 -0700 (PDT)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1N0Afn-0006Hj-RS; Tue, 20 Oct 2009 02:06:31 -0700
X-Mailer: git-send-email 1.6.5
In-Reply-To: <7vr5syshat.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: clamav-milter 0.95.1 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130778>

Do not check whether PERL_PATH and SHELL_PATH are undefined before
setting their default values.  This prevents them from being set via
environment variables.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 On Mon, Oct 19, 2009 at 11:36:26PM -0700, Junio C Hamano wrote:
 > Matt Kraai <kraai@ftbfs.org> writes:
 > 
 > > The top-level Makefile currently contains
 > >
 > >> ifndef SHELL_PATH
 > >> 	SHELL_PATH = /bin/sh
 > >> endif
 > >> ifndef PERL_PATH
 > >> 	PERL_PATH = /usr/bin/perl
 > >> endif
 > >
 > > The checks are only necessary if these variables need to be overridden
 > > by environment variables, not just via the make command line.  Is this
 > > the case?
 > 
 > It may not have been the original intention, but the above would mean that
 > some people may have learned to run "SHELL_PATH=/bin/ksh make" and
 > changing it would break things for them, no?

 Yes, that's what I was concerned about.  This appears to be possible
 for PERL_PATH on all platforms and for SHELL_PATH on platforms other
 than SCO UnixWare, SunOS, and IRIX.

 > I do not think changing them is bad per-se, but we would need to add extra
 > warnings in the release note to explain this change, that's all.  This
 > would only affect people who build from the source (including distro
 > people) so it is not really a big deal.

 I hope this patch is OK.

 Documentation/RelNotes-1.6.6.txt |    3 +++
 Makefile                         |    8 ++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
index 5f1fecb..bfda14c 100644
--- a/Documentation/RelNotes-1.6.6.txt
+++ b/Documentation/RelNotes-1.6.6.txt
@@ -58,3 +58,6 @@ release, unless otherwise noted.
    whitespace attribute).  The 'trailing-space' whitespace error class has
    become a short-hand to cover both of these and there is no behaviour
    change for existing set-ups.
+
+ * PERL_PATH and SHELL_PATH may not be overridden using environment
+   variables during the build.
diff --git a/Makefile b/Makefile
index 42b7d60..5bac305 100644
--- a/Makefile
+++ b/Makefile
@@ -392,12 +392,8 @@ ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 OTHER_PROGRAMS = git$X
 
 # Set paths to tools early so that they can be used for version tests.
-ifndef SHELL_PATH
-	SHELL_PATH = /bin/sh
-endif
-ifndef PERL_PATH
-	PERL_PATH = /usr/bin/perl
-endif
+SHELL_PATH = /bin/sh
+PERL_PATH = /usr/bin/perl
 
 export PERL_PATH
 
-- 
1.6.5
