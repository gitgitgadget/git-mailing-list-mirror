From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] t9500: skip gitweb tests if perl version is too old
Date: Fri, 22 Jun 2007 17:49:08 +0200
Message-ID: <20070622154908.GA7946MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 17:49:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1lNo-0006XB-Lf
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 17:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbXFVPtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbXFVPtL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 11:49:11 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:50559 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757299AbXFVPtK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 11:49:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JK1007LKNXWVL@smtp16.wxs.nl> for git@vger.kernel.org; Fri,
 22 Jun 2007 17:49:09 +0200 (CEST)
Received: (qmail 7951 invoked by uid 500); Fri, 22 Jun 2007 15:49:08 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50704>

gitweb calls Encode::decode_utf8 with two arguments,
but old versions of perl only allow this function to be called
with one argument.  Even older versions of perl do not even
have an Encode module.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 t/t9500-gitweb-standalone-no-errors.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 44ae503..d948724 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -60,6 +60,12 @@ gitweb_run () {
 
 . ./test-lib.sh
 
+perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+    test_expect_success 'skipping gitweb tests, perl version is too old' :
+    test_done
+    exit
+}
+
 gitweb_init
 
 # ----------------------------------------------------------------------
-- 
1.5.2.2.249.g45fd
