From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 01/16] user-cppflags.patch
Date: Tue, 27 Apr 2010 13:57:09 +0000
Message-ID: <20100427135807.015320000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:58:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lIn-0002JD-9P
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab0D0N6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:09 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:60009 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab0D0N6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:08 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 5DE315CDA
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:19:15 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 5DE315CDA
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id A39CCAA9;
	Tue, 27 Apr 2010 13:58:07 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 9584211D4D1; Tue, 27 Apr 2010 13:58:07 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=user-cppflags.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145902>

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
