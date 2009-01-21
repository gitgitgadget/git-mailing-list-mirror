From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2 v2] valgrind: ignore ldso errors
Date: Wed, 21 Jan 2009 02:36:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210236320.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer>
 <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 02:37:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPS2S-0007cd-MW
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 02:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbZAUBg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 20:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbZAUBg3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 20:36:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:40681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752273AbZAUBg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 20:36:28 -0500
Received: (qmail invoked by alias); 21 Jan 2009 01:36:26 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp012) with SMTP; 21 Jan 2009 02:36:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eQ+J1Qf6eM1VVmsicF38Rjg33L4OvYQy2oFnQLA
	bfy6hjU0dlGiu5
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901210216440.19014@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106556>


On some Linux systems, we get a host of Cond and Addr errors
from calls to dlopen that are caused by nss modules. We
should be able to safely ignore anything happening in
ld-*.so as "not our problem."

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Only change vs v1: adds Addr4 suppression, so that ld.so "errors"
	are ignored on 32-bit, too.

 t/valgrind/default.supp |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 2482b3b..6061283 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -11,6 +11,24 @@
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
1.6.1.243.g6c8bb35
