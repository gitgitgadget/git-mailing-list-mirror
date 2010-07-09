From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t0005: work around strange $? in ksh when program terminated
 by a signal
Date: Fri, 09 Jul 2010 09:05:16 +0200
Message-ID: <4C36CA2C.5050305@viscovery.net>
References: <20100709030812.GA16877@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 09:05:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX7eX-0001zl-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 09:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab0GIHFW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 03:05:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55793 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab0GIHFV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 03:05:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OX7e9-0000Zu-EJ; Fri, 09 Jul 2010 09:05:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 197011660F;
	Fri,  9 Jul 2010 09:05:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <20100709030812.GA16877@dert.cs.uchicago.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150644>

=46rom: Johannes Sixt <j6t@kdbg.org>

ksh is known to report $? of programs that terminated by a signal as
256 + signal number instead of 128 + signal number like other POSIX
compliant shells. (ksh's behavior is still POSIX compliant in this rega=
rd.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 7/9/2010 5:08, schrieb Jonathan Nieder:
> I can=E2=80=99t seem to get test-sigchain to run with ksh93 on linux:
>=20
>  $ ksh
> =20
>  ksh>$ ../bin-wrappers/test-sigchain=20
>  three
>  two
>  one
>  Terminated
>  ksh>$ echo $?
>  271

ksh is not wrong, just strange. See http://www.opengroup.org/onlinepubs=
/9699919799/utilities/V3_chap02.html#tag_18_08_02 (last sentence).

 -- Hannes

 t/t0005-signals.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 09f855a..93e58c0 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -13,6 +13,7 @@ test_expect_success 'sigchain works' '
 	test-sigchain >actual
 	case "$?" in
 	143) true ;; # POSIX w/ SIGTERM=3D15
+	271) true ;; # ksh w/ SIGTERM=3D15
 	  3) true ;; # Windows
 	  *) false ;;
 	esac &&
--=20
1.7.1.585.gf3448
