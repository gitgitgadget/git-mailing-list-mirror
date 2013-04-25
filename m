From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] check-non-portable-shell: Check for non portable grep usage
Date: Thu, 25 Apr 2013 20:48:18 +0200
Message-ID: <201304252048.19235.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 20:48:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRDa-0007d4-Sv
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445Ab3DYSs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 14:48:26 -0400
Received: from mout.web.de ([212.227.15.4]:61484 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756519Ab3DYSs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 14:48:26 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MWirL-1TyaJ922hP-00Xtib for <git@vger.kernel.org>; Thu,
 25 Apr 2013 20:48:24 +0200
X-Provags-ID: V02:K0:VIWRXvL3DPAZGWxz5yliTyoon76qA4vLSoaNEV+G5fA
 Ck/0mO7YkWh7HgIMocV2/KWNLVE5CD1va043ebFGa9jEDPadnV
 KRhU4MLG2gtV7YT4eGY5+kjwjx1pfe2HGBlYIybvQhUVwgyZsb
 +KuObJTjguNoVO32FleUi7Mr0NrvRyXvPou/qfh+106knwZ1c8
 SAA2PSxBYnT9NmDIGcpbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222410>

The make test-lint could check for some common non portable
grep usage:

The + as a qualifier is not a "basic regular expression".
Some grep understand \+, but in general egrep should be used.

The \t can not be used to find an ASCII TAB, neither
can \s be used to find a whitespace

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell=
=2Epl
index ff87611..58f8e2c 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -16,6 +16,8 @@ sub err {
=20
 while (<>) {
 	chomp;
+	/ e?grep\s+\"[^"]*\\([st])/ and err "grep \\$1 is not portable)";
+	/ [^e]grep.*\\\+/ and err 'grep with \+ is not portable (please use e=
grep)';
 	/^\s*sed\s+-i/ and err 'sed -i is not portable';
 	/^\s*echo\s+-(\S)\s+/ and err "echo -$1 is not portable (please use p=
rintf)";
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
--=20
1.8.2.1.614.g66d7af5
