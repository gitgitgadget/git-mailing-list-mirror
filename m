From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/2] test-lint: detect 'export FOO=bar'
Date: Mon, 8 Jul 2013 17:20:32 +0200
Message-ID: <24ee18d3b06883c4185821f5ffb5faed26e6a436.1373296313.git.trast@inf.ethz.ch>
References: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDF2-0004LA-TX
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab3GHPUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 11:20:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:9742 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab3GHPUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:20:36 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Jul
 2013 17:20:33 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Jul
 2013 17:20:33 +0200
X-Mailer: git-send-email 1.8.3.2.947.g0347b11
In-Reply-To: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229864>

Some shells do not understand the one-line construct, and instead need

  FOO=3Dbar &&
  export FOO

Detect this in the test-lint target.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

I wrote:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
[...]
> > -		export HARNESS_ACTIVE=3Dt &&
> > +		HARNESS_ACTIVE=3Dt &&
> > +		export HARNESS_ACTIVE &&
[...]
> Ack.  Sorry for breaking this -- I suppose test-lint would have caugh=
t
> me out?

Well, no, not yet.


 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index 8b5a71d..45971f4 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -21,6 +21,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)=
';
 	/test\s+[^=3D]*=3D=3D/ and err '"test a =3D=3D b" is not portable (pl=
ease use =3D)';
+	/^\s*export\s+[^=3D]*=3D/ and err '"export FOO=3Dbar" is not portable=
 (please use FOO=3Dbar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
--=20
1.8.3.2.947.g0347b11
