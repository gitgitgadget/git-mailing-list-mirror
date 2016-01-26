From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 10/19] mingw: disable mkfifo-based tests
Date: Tue, 26 Jan 2016 15:35:06 +0100 (CET)
Message-ID: <5e9685e6bf906f99ae9cf551f55a12f5853137d6.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4iQ-0004mL-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966111AbcAZOfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:62693 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965934AbcAZOfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:09 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M8pKi-1aGPkE3ipw-00CAFL; Tue, 26 Jan 2016 15:35:06
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YvzMXTMDZHBNvvEHJqONa8SXaEQO9ZHQ7Sh9b0ZXdBEgR7JGMTJ
 lExH9ueJ1KLrvcodp3l0xSsw2F/xMYsPc8e61l/up+M/VolH3Cjytr5dSEyFih67343jHMj
 HD38yXun7FPd6Wz38/ScdGiShQPXiwjEBBcuEQkwCLoLpIJW/vUbQsX8ydwDtjJOX9X21Sk
 tP37WU04F+KlKH33B36FA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dYYMdn9xk1E=:uoEA+9Pz1+Sn3PSQs3CARg
 1OVKyure5a2HoyC5NkNru0dSw8glKqrl4uGP/9pqrl3eSPE0MJC/MGlTbqLQyhvLIg0NdYSS7
 LLdq2le93aZdNr+5qU+PwaTHGPt7XdbsFeVYUJ3oNDWzlNuMHESBXEZ+T+90UnAN9UCgEvkDg
 P4WEoaa9zjluOluZy6nbwvt1k6kRW7MN9bfzh0YQfq5typCsrdBVOP8j/oRBxwVyx0sSGblqp
 M1wE6Z3/UVZssVjMjF04HbOqX5OEGEJQVYdcbYbL+6rYq+spEw5/9fvpHhps0nQ/XUPEcyiS/
 mPrr4ztZtnIiCTnSi+/SNzEnKCR6FwXFwJKA6eVcNHxm0yoABXzNJsj/kKBY3z43+E3L8MCVE
 kNPg8f7vPHkPdYqsZ0hwP2GURlLvYSVkmaNkFlm5fUUh/eseZ3TLSszlgR+Zsg4Y3sH7im7k1
 fftOOgI5R9ZnIxybO8MEi9roIEDokco72/MMA9L4eczRtTbI/+JSX9g8gawMkWWtZxmTpqHKL
 xXrrwoTyn64jJFoXYOP1pup52btqxutIl8C3ezxPmK7XFJVAJmYLP64Qww9OqAuvxujPiLHkz
 TxRZ3kw97ixQyNykrH938IeFpJFTi3sDB3bJEA/N8jgPUuf5Z5M5o3y9fdrlOZQFshpF77K69
 +BjP9mdUivk6RUHyroxRTZZ+amHWvZvJR1I85SMSnXoCfYC0R9h+m0e+FT0z4e8rhPO6EVFeG
 KSqwglWh3RvEXvrxEnhB778B5TGXHs8mqI+60qb0frLSywl96dnDhHbSh326Sh+fCbTI5+ZR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284821>

MSYS2 (the POSIX emulation layer used by Git for Windows' Bash) actually
has a working mkfifo. The only problem is that it is only emulating
named pipes through the MSYS2 runtime; The Win32 API has no idea about
named pipes, hence the Git executable cannot access those pipes either.

The symptom is that Git fails with a '<name>: No such file or directory'
because MSYS2 emulates named pipes through special-crafted '.lnk' files.

The solution is to tell the test suite explicitly that we cannot use
named pipes when we want to test on Windows.

This lets t4056-diff-order.sh, t9010-svn-fe.sh and t9300-fast-import.sh
pass.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd4b02e..1470c8d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -998,7 +998,7 @@ test_i18ngrep () {
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
 	case $(uname -s) in
-	CYGWIN*)
+	CYGWIN*|MINGW*)
 		false
 		;;
 	*)
-- 
2.7.0.windows.1.7.g55a05c8
