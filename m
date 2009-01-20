From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] valgrind: ignore ldso errors
Date: Tue, 20 Jan 2009 16:05:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201604530.5159@intel-tinevez-2-302>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 16:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPIBY-00036v-Ek
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 16:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562AbZATPFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756480AbZATPFO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 10:05:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:54419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755870AbZATPFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 10:05:13 -0500
Received: (qmail invoked by alias); 20 Jan 2009 15:05:10 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 20 Jan 2009 16:05:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rrDt1vTJriHEzwTD9hhuHSUh3QxvRAAty63b8LD
	SVRyDB5xi1zxQC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0901201602410.5159@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106481>


From: Jeff King <peff@peff.net>

On some Linux systems, we get a host of Cond and Addr errors
from calls to dlopen that are caused by nss modules. We
should be able to safely ignore anything happening in
ld-*.so as "not our problem."

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

	This is Peff's patch, unchanged.

 t/valgrind/default.supp |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 2482b3b..1013847 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -11,6 +11,18 @@
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
 	writing-data-from-zlib-triggers-errors
 	Memcheck:Param
 	write(buf)
-- 
1.6.1.243.g6c8bb35
