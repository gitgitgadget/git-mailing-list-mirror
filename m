From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] Fix '\%o' for printf from coreutils
Date: Thu, 31 Oct 2013 12:51:32 +0100
Message-ID: <20131031115131.GA28379@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 13:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbr4z-0001nR-4z
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 13:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab3JaMKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Oct 2013 08:10:13 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:60712 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145Ab3JaMKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 08:10:10 -0400
X-Greylist: delayed 1106 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2013 08:10:10 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 3DDE85F0043;
	Thu, 31 Oct 2013 12:52:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jCE6LeJb7nma; Thu, 31 Oct 2013 12:51:50 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2D9A25F0027;
	Thu, 31 Oct 2013 12:51:50 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 8426634CFD; Thu, 31 Oct 2013 12:51:32 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237122>

The printf utility provided by coreutils when interpreting '\%o' format
does not recognize %o as formatting directive. For example
printf '\%o 0 returns \%o and warning: ignoring excess arguments,
starting with =E2=80=980=E2=80=99, which results in failed tests in
t5309-pack-delta-cycles.sh. In most shells the test ends with success a=
s
the printf is a builtin utility.

=46ix it by using '\\%o' which is interpreted consistently in all versi=
ons
of printf.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---

I've found it while testing v1.8.5-rc0 with mksh which does not
provide a builtin printf.

Kacper

 t/lib-pack.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index 7e8685b..b96e125 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -12,10 +12,10 @@
 # Print the big-endian 4-byte octal representation of $1
 uint32_octal () {
 	n=3D$1
-	printf '\%o' $(($n / 16777216)); n=3D$((n % 16777216))
-	printf '\%o' $(($n /    65536)); n=3D$((n %    65536))
-	printf '\%o' $(($n /      256)); n=3D$((n %      256))
-	printf '\%o' $(($n           ));
+	printf '\\%o' $(($n / 16777216)); n=3D$((n % 16777216))
+	printf '\\%o' $(($n /    65536)); n=3D$((n %    65536))
+	printf '\\%o' $(($n /      256)); n=3D$((n %      256))
+	printf '\\%o' $(($n           ));
 }
=20
 # Print the big-endian 4-byte binary representation of $1
--=20
1.8.4.2

--=20
  Kacper Kornet
