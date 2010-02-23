From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GITK PATCH 2/3] gitk: support path filters even in subdirectories
Date: Tue, 23 Feb 2010 18:10:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>  <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de> <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com> <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kirill <kirillathome@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyHt-0003LG-So
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab0BWRLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:11:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:35866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752689Ab0BWRLB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:11:01 -0500
Received: (qmail invoked by alias); 23 Feb 2010 17:10:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp054) with SMTP; 23 Feb 2010 18:10:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lyBxXNPdlcExwU2yBFQAdSCKB0jjEuIU0QIasMf
	afRcZ37FQ0+eGE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140814>


Even when running inside a subdirectory, "gitk HEAD -- ." should work.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gitk-git/gitk |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 553922f..bad9ebc 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7340,9 +7340,12 @@ proc startdiff {ids} {
 }
 
 proc path_filter {filter name} {
+    global pathprefix
     foreach p $filter {
 	if {$p == "."} {
-		return 1
+		set p $pathprefix
+	} else {
+		set p $pathprefix$p
 	}
 	set l [string length $p]
 	if {[string index $p end] eq "/"} {
@@ -11585,6 +11588,7 @@ readrefs
 
 if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
+    set pathprefix [exec git rev-parse --show-prefix]
     set curview 1
     set selectedview 1
     set nextviewnum 2
-- 
1.6.4.297.gcb4cc
