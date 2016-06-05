From: tboegi@web.de
Subject: [PATCH v1 1/1] connect: [host:port] is lagacy for ssh
Date: Sun,  5 Jun 2016 13:09:53 +0200
Message-ID: <1465124993-3379-1-git-send-email-tboegi@web.de>
References: <xmqqinxozzuj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org, mh@glandium.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 05 13:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9VqW-00061z-Dq
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 13:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbcFELDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 07:03:49 -0400
Received: from mout.web.de ([212.227.15.3]:53680 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbcFELDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 07:03:48 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LuZgO-1ba9OQ1eLo-00znTw; Sun, 05 Jun 2016 13:03:26
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqinxozzuj.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:brXXzu8P/y3mBg9lC4fazTVmK+tKzl8IMWIfmn9crsaFNp+pO4k
 NqlTGEWb6/UZ2Zb9GPovbCatdjvy/nMoQpkXG5dee0Q42sUVQlhYF2GYFhJuFVeftzapeJf
 cNCoNx+gOAnV1I3duVXjAnNhidEpX/1h94l3bHu/ENusvQegv19NffsYh+uIkFKJEJDby+J
 k7YfJ5uxY4nAG/Q/7FniQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p9B4zJx5hBc=:4ZWxwsp0jdjaXzLbDU3PyT
 18G+CMc0bowQiI2mcrrZ1zQZ3Qe6SnG9PjzhKxouu0Ka3lhGig95s31Deiq3cfD9MRxOqGQ7p
 nV7cAnylatCGmR94c46w0PZAILNqTv2Z832ZpURQlbX5YDavuncAjOLOqISeBLjz/Gc6HrTmI
 VrtUDinoMOpLruCPGAF18/mcacKDcDEE1SbVmGoZ4CClO6iJXsPVXTDtcMm2LCWzDWybkUJxP
 nKad85Kie92E7v3WvklwjFLCriZ6zLlHSLRYC3KIa3AP1A5UIG/FpSI+asy8Nxw2jM6fP+Usd
 Zp6aJfZumUaE1nGB4a7joLn+XIGyloZ8rqRRzjAInLykP2MZSoQ+KqKtcqGl0HMdWzmoSo7Pb
 9P8Gsso1D45gcDPfYYKUVHzuybvPc2wEwfdja2QWVbQSt5Fr0gJXBXTw0yxZoIou0j0VtCzYH
 /CMbCp+MCTUYN1XQFsP/i+Qkh5sY3kOveCi6WMZOimH0vEMHp2dVkWKd8d5bNiWRsFHtdI8GG
 /3NmfXVoLvnCyirLpt9QuyPneFa0UBSgTJ8Z1Jg87fHImA4oRu4ztrksF6+l7rDJTuPj81HJE
 I4RoE9v0+RGJ6TQo5kD/JwWFklRZFS9i3Xv9OnjSV1tJtPdJGuWVqU9gR8ruUd8qvgtUoA8Yg
 Q+QSS7dG7d1rOUf35tL9rLuYUhBHr7AQncUbX/vmHl8p2looAOB7TOJY9ViT9UUx94FAr+L9T
 ClQ8VVR6gXayN3zGL8PvIiYb81D1fF+xnKMl2x5Iv6LhlWo7ON+GoOwiGiMnpsHfo2ORufiJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296472>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Early versions of the parser in connect.c handled
git clone [host:123]:/path the same as
git clone ssh://host:123/path

Keep that feature as legacy, but disable it for all other protocols.
Everything inside [] should go into the host part.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

This is my attempt to keep the legacy for ssh only,
and fixes my comments
 connect.c             | 11 ++++-------
 t/t5500-fetch-pack.sh | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/connect.c b/connect.c
index 076ae09..9576d0f 100644
--- a/connect.c
+++ b/connect.c
@@ -618,10 +618,7 @@ static enum protocol parse_connect_url(const char =
*url_orig, char **ret_user,
 		}
 	}
=20
-	/*
-	 * Don't do destructive transforms as protocol code does
-	 * '[]' unwrapping in get_host_and_port()
-	 */
+	/* '[]' unwrapping is done in get_host_and_port() */
 	end =3D host_end(&host, 0);
=20
 	if (protocol =3D=3D PROTO_LOCAL)
@@ -670,10 +667,10 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_user,
 	/*
 	 * get_host_and_port does not return a port in the [host:port]:path
 	 * case. In that case, it is called with "[host:port]" and returns
-	 * "host:port" and NULL.
-	 * To support this undocumented legacy we still need to split the por=
t.
+	 * "host:port" and NULL. To support this undocumented legacy
+	 * (for ssh only) we still need to split the port.
 	 */
-	if (!port)
+	if (!port && protocol =3D=3D PROTO_SSH)
 		port =3D get_port(host);
=20
 	*ret_user =3D user ? xstrdup(user) : NULL;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2d9c4be..b7d21da 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -618,6 +618,23 @@ do
 			'
 		done
 	done
+	# git with scheme and []
+	for p in git
+	do
+		for h in [host:123]
+		do
+			for c in "" :
+			do
+				test_expect_success "fetch-pack --diag-url $p://$h$c/$r" '
+					check_prot_host_port_path $p://$h/$r $p "$h" NONE "/$r"
+				'
+				# "/~" -> "~" conversion
+				test_expect_success "fetch-pack --diag-url $p://$h$c/~$r" '
+					check_prot_host_port_path $p://$h/~$r $p "$h" NONE "~$r"
+				'
+			done
+		done
+	done
 	# file with scheme
 	for p in file
 	do
--=20
2.0.0.rc1.6318.g0c2c796
