From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Guard a few Makefile variables against user environments
Date: Wed, 25 Mar 2009 17:27:28 +0100 (CET)
Message-ID: <1d60c2034e0b5058cb691f572eb57f0aefb9fdc7.1237998428u.git.johannes.schindelin@gmx.de>
References: <cover.1237998428u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: a1291762@gmail.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 25 17:30:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVzQ-0002NE-4H
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763142AbZCYQ1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762342AbZCYQ1h
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:27:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:57591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761328AbZCYQ1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:27:33 -0400
Received: (qmail invoked by alias); 25 Mar 2009 16:27:30 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 25 Mar 2009 17:27:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oCBRzeYfoFGRC+7AHFJrMBl/gH07EKXMrlews35
	/ncKM9vO/V1rsB
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1237998428u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114620>

Some variables are not initialized in the Makefile, but appended to.  If
the user has those variables in her environment, it will break the
build.

The variable names were found using these commands:

	$ s='[ \t]';
	$ S='[^ \t]';
	$ comm -23 \
		<(sed -n "s/^$s*\($S*\)$s$s*+=.*/\1/p" < Makefile |
		  sort | uniq) \
		<(sed -n "s/^$s*\($S*\)$s$s*=.*/\1/p" < Makefile |
		  sort | uniq)

This fixes msysGit issue 216.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 43a8364..d77fd71 100644
--- a/Makefile
+++ b/Makefile
@@ -263,6 +263,18 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 BASIC_CFLAGS =
 BASIC_LDFLAGS =
 
+# Guard against environment variables
+BUILTIN_OBJS =
+BUILT_INS =
+COMPAT_CFLAGS =
+COMPAT_OBJS =
+LIB_H =
+LIB_OBJS =
+PROGRAMS =
+SCRIPT_PERL =
+SCRIPT_SH =
+TEST_PROGRAMS =
+
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool-helper.sh
-- 
1.6.2.1.493.g67cf3
