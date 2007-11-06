From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Fix minor nits in configure.ac
Date: Tue, 6 Nov 2007 21:12:45 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106201245.GB3198@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUnH-0000Nr-6w
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbXKFUMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbXKFUMs
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:12:48 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:59475 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbXKFUMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:12:47 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 7870F40002DD2
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:12:46 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63712>

Avoid "test -o" as it is only XSI not POSIX, and not portable.
Avoid exit(3) in test programs in favor of return, to accommodate
for newer Autoconf not providing a declaration for exit.
---

The missing declaration can cause needlessly wrong configure results
with some CFLAGS.

Cheers,
Ralf

 configure.ac |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index ed7cc89..bd80517 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,7 +73,7 @@ fi \
 AC_ARG_WITH([lib],
  [AS_HELP_STRING([--with-lib=ARG],
                  [ARG specifies alternative name for lib directory])],
- [if test "$withval" = "no" -o "$withval" = "yes"; then \
+ [if test "$withval" = "no" || test "$withval" = "yes"; then \
 	AC_MSG_WARN([You should provide name for --with-lib=ARG]); \
 else \
 	GIT_CONF_APPEND_LINE(lib=$withval); \
@@ -245,9 +245,9 @@ AC_RUN_IFELSE(
 	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
 		[[char buf[64];
 		if (sprintf(buf, "%lld%hhd%jd%zd%td", (long long int)1, (char)2, (intmax_t)3, (size_t)4, (ptrdiff_t)5) != 5)
-		  exit(1);
+		  return 1;
 		else if (strcmp(buf, "12345"))
-		  exit(2);]])],
+		  return 2;]])],
 	[ac_cv_c_c99_format=yes],
 	[ac_cv_c_c99_format=no])
 ])
-- 
1.5.3.5.561.g140d
