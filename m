From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Failing tests in t0027-autocrlf.sh under msysgit/git-win-sdk
Date: Thu, 02 Oct 2014 14:39:05 +0200
Message-ID: <542D4769.60503@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git-win-sdk@googlegroups.com
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 14:39:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZffF-0004B3-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 14:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbaJBMjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 08:39:17 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:36182 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752499AbaJBMjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Oct 2014 08:39:16 -0400
Received: from p5ddc25b7.dip0.t-ipconnect.de ([93.220.37.183] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XZff5-0006jX-J4; Thu, 02 Oct 2014 14:39:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1412253556;64b081ef;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257799>

Hi,

I've enabled EXPENSIVE and ran the git test suite under msysgit/git-win-sdk with
git version 2.1.0.9753.g360f311.dirty.

Now I have some failing tests in t0027-autocrlf.sh in the MINGW only section which puzzle me.

The offending test sets are

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 72dd3e8..90c4cd1 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -245,18 +245,18 @@ if test_have_prereq MINGW
 then
 check_files_in_ws ""      false ""        LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
 check_files_in_ws ""      true  ""        CRLF  CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
-check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
+# check_files_in_ws ""      false "auto"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul # first broken
 check_files_in_ws ""      true  "auto"    CRLF  CRLF  CRLF         LF_mix_CR    CRLF_nul
-check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
+# check_files_in_ws ""      false "text"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul # broken
 check_files_in_ws ""      true  "text"    CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 check_files_in_ws ""      false "-text"   LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
 check_files_in_ws ""      true  "-text"   LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
 
 check_files_in_ws native  false ""        LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
 check_files_in_ws native  true  ""        CRLF  CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
-check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
+# check_files_in_ws native  false "auto"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul # broken
 check_files_in_ws native  true  "auto"    CRLF  CRLF  CRLF         LF_mix_CR    CRLF_nul
-check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
+# check_files_in_ws native  false "text"    LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul # broken
 check_files_in_ws native  true  "text"    CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 check_files_in_ws native  false "-text"   LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul
 check_files_in_ws native  true  "-text"   LF    CRLF  CRLF_mix_LF  LF_mix_CR    CRLF_nul

I tried with NATIVE_CRLF = YesPlease but 117 failed too.

First question, under what MINGW system do these tests pass?
Second question any hints how to tackle this?

The first failing test is
not ok 117 - checkout core.eol= core.autocrlf=false gitattributes=auto file=LF
#
#                       compare_ws_file eol__crlf_false_attr_auto_ LF    crlf_false_attr__LF.txt
#


where I have in the trash directory

$ diff -Nur *expect* *actual*
--- LF.expect   2014-10-02 12:15:17 +0000
+++ eol__crlf_false_attr_auto_.actual.crlf_false_attr__LF.txt   2014-10-02 12:15
:17 +0000
@@ -1,3 +1,3 @@
-0000000   l   i   n   e   1  \n   l   i   n   e   2  \n   l   i   n   e
-0000020   3
-0000021
+0000000   l   i   n   e   1  \r  \n   l   i   n   e   2  \r  \n   l   i
+0000020   n   e   3
+0000023

Reading convert.h tells me that for undefined NATIVE_CRLF the native EOL is LF.
Which looks like the test is correct.

Thomas
