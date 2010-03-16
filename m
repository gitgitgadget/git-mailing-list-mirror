From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 01/15] user-cppflags.patch
Date: Tue, 16 Mar 2010 05:42:21 +0000
Message-ID: <20100316054300.978104000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiD-0002tB-GT
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935153Ab0CPFxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:00 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61912 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382Ab0CPFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:55 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 20D565CC2
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:23 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 20D565CC2
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 2CA50DE8;
	Tue, 16 Mar 2010 05:43:01 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 250C011D4D5; Tue, 16 Mar 2010 05:43:01 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=user-cppflags.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142302>

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
---
 Makefile      |    6 ++++--
 config.mak.in |    1 +
 configure.ac  |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -236,7 +236,7 @@ endif
 
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
