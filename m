From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 2/5] valgrind: ignore ldso errors
Date: Wed, 22 Oct 2008 16:30:45 -0400
Message-ID: <20081022203045.GB4547@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:32:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskN8-00086c-3J
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYJVUas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbYJVUas
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:30:48 -0400
Received: from peff.net ([208.65.91.99]:3570 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbYJVUas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:30:48 -0400
Received: (qmail 4152 invoked by uid 111); 22 Oct 2008 20:30:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:30:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:30:45 -0400
Content-Disposition: inline
In-Reply-To: <20081022202810.GA4439@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98900>

On some Linux systems, we get a host of Cond and Addr errors
from calls to dlopen that are caused by nss modules. We
should be able to safely ignore anything happening in
ld-*.so as "not our problem."

Signed-off-by: Jeff King <peff@peff.net>
---
This was from a Debian etch system, while my lenny systems seemed to
have no trouble. I'm sure we will pick up a few commits like these as
people run it on various platforms, but hopefully they should shake out
pretty quickly.

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
1.6.0.2.825.g6d19d
