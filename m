From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/3] valgrind: ignore ldso and more libz errors
Date: Mon, 26 Jan 2009 00:19:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260019000.14855@racer>
References: <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
 <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302> <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de>
 <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREGu-0007Kl-4Y
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbZAYXSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZAYXSn
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:18:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:42248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855AbZAYXSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:18:42 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:18:40 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp015) with SMTP; 26 Jan 2009 00:18:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aaWxDb+8aLQZ6wWeab4iORjCxk/oCafFneTGfMd
	Jq1MI29+9I1ZB1
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901260014470.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107123>


On some Linux systems, we get a host of Cond and Addr errors
from calls to dlopen that are caused by nss modules. We
should be able to safely ignore anything happening in
ld-*.so as "not our problem."

[Johannes: I added some more...]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/valgrind/default.supp |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 2482b3b..b2da4fd 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -5,12 +5,36 @@
 }
 
 {
+	ignore-zlib-errors-value8
+	Memcheck:Value8
+	obj:*libz.so*
+}
+
+{
 	ignore-zlib-errors-value4
 	Memcheck:Value4
 	obj:*libz.so*
 }
 
 {
+	ignore-ldso-cond
+	Memcheck:Cond
+	obj:*ld-*.so
+}
+
+{
+	ignore-ldso-addr8
+	Memcheck:Addr8
+	obj:*ld-*.so
+}
+
+{
+	ignore-ldso-addr4
+	Memcheck:Addr4
+	obj:*ld-*.so
+}
+
+{
 	writing-data-from-zlib-triggers-errors
 	Memcheck:Param
 	write(buf)
-- 
1.6.1.482.g7d54be
