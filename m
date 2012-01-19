From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed
Date: Fri, 20 Jan 2012 00:17:23 +0400
Message-ID: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@navytux.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 21:24:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnyWy-0007Oi-8A
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911Ab2ASUYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 15:24:15 -0500
Received: from forward11.mail.yandex.net ([95.108.130.93]:55449 "EHLO
	forward11.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623Ab2ASUYO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 15:24:14 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jan 2012 15:24:14 EST
Received: from smtp12.mail.yandex.net (smtp12.mail.yandex.net [95.108.131.191])
	by forward11.mail.yandex.net (Yandex) with ESMTP id D6B07E826B1;
	Fri, 20 Jan 2012 00:16:32 +0400 (MSK)
Received: from smtp12.mail.yandex.net (localhost [127.0.0.1])
	by smtp12.mail.yandex.net (Yandex) with ESMTP id B831C16A04AE;
	Fri, 20 Jan 2012 00:16:32 +0400 (MSK)
Received: from unknown (unknown [83.171.93.225])
	by smtp12.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GWCKJdRo-GWCeoDA1;
	Fri, 20 Jan 2012 00:16:32 +0400
X-Yandex-Spam: 1
Received: from kirr by mini.zxlink with local (Exim 4.77)
	(envelope-from <kirr@mini.zxlink>)
	id 1RnyQK-0004vv-1k; Fri, 20 Jan 2012 00:17:28 +0400
X-Mailer: git-send-email 1.7.9.rc2.124.ge3180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188833>

Starting from GNU Make 3.82 $(wildcard ...) no longer sorts the result
(from NEWS):

    * WARNING: Backward-incompatibility!
      Wildcards were not documented as returning sorted values, but the results
      have been sorted up until this release..  If your makefiles require sorted
      results from wildcard expansions, use the $(sort ...)  function to request
      it explicitly.

    http://repo.or.cz/w/make.git/commitdiff/2a59dc32aaf0681dec569f32a9d7ab88a379d34f

so we have to sort tests list or else they are executed in seemingly
random order even for -j1.

Signed-off-by: Kirill Smelkov <kirr@navytux.spb.ru>
---
 t/Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 9046ec9..66ceefe 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,9 +17,9 @@ DEFAULT_TEST_TARGET ?= test
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
-T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
-TSVN = $(wildcard t91[0-9][0-9]-*.sh)
-TGITWEB = $(wildcard t95[0-9][0-9]-*.sh)
+T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
+TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
+TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 
 all: $(DEFAULT_TEST_TARGET)
 
-- 
1.7.9.rc2.124.ge3180
