From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 01/18] Makefile: pass CPPFLAGS through to fllow customization
Date: Fri, 14 May 2010 09:31:32 +0000
Message-ID: <20100514093725.884968000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:37:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrKs-0001WK-9U
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692Ab0ENJh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:37:27 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:54101 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab0ENJh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:37:26 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 4F83C5C48
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:54:18 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 4F83C5C48
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 2718CCD4;
	Fri, 14 May 2010 09:37:26 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 0A89211D4D1; Fri, 14 May 2010 09:37:25 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=user-cppflags.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147059>

Without this patch there is no straight forward way to pass additional
CPPFLAGS at configure-time.  At TWW, everything non-vendor package is
installed to its own subdirectory, so we need the following to show
the preprocessor where the headers for the libraries we will link
later can be found:

	$SHELL ./configure \
	CPPFLAGS="-I${SB_VAR_CURL_INC}\
	 -I${SB_VAR_LIBEXPAT_INC}\
	 -I${SB_VAR_LIBZ_INC}\
	${CPPFLAGS+ $CPPFLAGS}" <<...>>

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile      |    2 +-
 config.mak.in |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -246,7 +246,7 @@ endif
 
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
-ALL_CFLAGS = $(CFLAGS)
+ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -3,6 +3,7 @@
 
 CC = @CC@
 CFLAGS = @CFLAGS@
+CPPFLAGS = @CPPFLAGS@
 LDFLAGS = @LDFLAGS@
 CC_LD_DYNPATH = @CC_LD_DYNPATH@
 AR = @AR@

-- 
Gary V. Vaughan (gary@thewrittenword.com)
