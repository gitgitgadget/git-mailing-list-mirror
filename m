From: Nicolas Troncoso Carrere <ntroncos@alumnos.inf.utfsm.cl>
Subject: [PATCH] git-send-email.perl extract_valid_address issue
Date: Mon, 29 May 2006 00:00:44 -0400
Message-ID: <200605290000.44463.ntroncos@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon May 29 05:59:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkYuM-0000oB-LM
	for gcvg-git@gmane.org; Mon, 29 May 2006 05:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWE2D60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 28 May 2006 23:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWE2D60
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 23:58:26 -0400
Received: from alegre.inf.utfsm.cl ([200.1.19.138]:51900 "EHLO
	alegre.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1751157AbWE2D6Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 23:58:25 -0400
Received: from [192.168.0.101] (pc-32-64-104-200.cm.vtr.net [200.104.64.32] (may be forged))
	(authenticated bits=0)
	by alegre.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k4T3wMIb026668
	(version=TLSv1/SSLv3 cipher=EXP1024-RC4-SHA bits=56 verify=NO)
	for <git@vger.kernel.org>; Sun, 28 May 2006 23:58:24 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.3 (alegre.inf.utfsm.cl [200.1.19.138]); Sun, 28 May 2006 23:58:24 -0400 (CLT)
X-Virus-Scanned: ClamAV 0.88/1489/Sat May 27 09:47:18 2006 on alegre.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20915>


The third fallback was returning if the match was done or not instead o=
f
returning the actual email address that was matched. This prevented sen=
ding
the mail to the people included in the CC. This bug only affect those t=
hat
dont have Email::Valid.

I initialized $valid_email as undef so it would mimic the behavior of=20
Email::Verify->address(), which returns undef if no valid address was f=
ound.

Signed-off-by: Nicolas <ntroncos@inf.utfsm.cl>


---

 git-send-email.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

84853ca89c15de7a24e9eb9fd422654b86c63be9
diff --git a/git-send-email.perl b/git-send-email.perl
index 312a4ea..dfff3e6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -316,7 +316,9 @@ sub extract_valid_address {
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
 		# but still does a 99% job, and one less dependency
-		return ($address =3D~ /([^\"<>\s]+@[^<>\s]+)/);
+                my $valid_email=3Dundef;
+                ($valid_email ) =3D ($address =3D~ /([^\"<>\s]+@[^<>\s=
]+)/);
+                return ($valid_email);
 	}
 }
--=20
Nicol=E1s Troncoso Carr=E8re                        User #272312 counte=
r.li.org
Estudiante Mag=EDster en Ciencias de la Inform=E1tica
Universidad T=E9cnica Federico Santa Mar=EDa
http://www.alumnos.inf.utfsm.cl/~ntroncos
