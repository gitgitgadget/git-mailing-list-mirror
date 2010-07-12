From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v2] t0005: work around strange $? in ksh93 when program terminated
 by a signal
Date: Mon, 12 Jul 2010 08:41:13 +0200
Message-ID: <4C3AB909.80205@viscovery.net>
References: <20100709030812.GA16877@dert.cs.uchicago.edu> <4C36CA2C.5050305@viscovery.net> <iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYChi-0001Ip-DD
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab0GLGlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 02:41:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19011 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753375Ab0GLGlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:41:19 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OYChW-0001uR-3q; Mon, 12 Jul 2010 08:41:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E179B1660F;
	Mon, 12 Jul 2010 08:41:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150799>

From: Johannes Sixt <j6t@kdbg.org>

ksh93 is known to report $? of programs that terminated by a signal as
256 + signal number instead of 128 + signal number like other POSIX
compliant shells. (ksh's behavior is still POSIX compliant in this regard.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Acked-by: Jeff King <peff@peff.net>
---
Am 7/9/2010 17:45, schrieb Brandon Casey:
> This may only be true for Ksh93.  The Ksh88 man page says that
> the exit status is 128+signum.  The Public domain Korn shell, and
> ksh on IRIX 6.5, Solaris 7, 9, and 10 all exit with the standard
> behavior of 128+signum.

Thanks for you input!

Hannes

 t/t0005-signals.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 09f855a..e17c96a 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -13,6 +13,7 @@ test_expect_success 'sigchain works' '
 	test-sigchain >actual
 	case "$?" in
 	143) true ;; # POSIX w/ SIGTERM=15
+	271) true ;; # ksh93 w/ SIGTERM=15
 	  3) true ;; # Windows
 	  *) false ;;
 	esac &&
-- 
1.7.1.585.gf3448
