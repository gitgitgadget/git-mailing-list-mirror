From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 4/4 (take 4)] Add test for the default merges in fetch.
Date: Sat, 23 Sep 2006 22:55:35 +0200
Message-ID: <87sliie20o.fsf@gmail.com>
References: <87ac4qfgvc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 22:55:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GREXM-0007F5-K1
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWIWUzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 16:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWIWUzp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:55:45 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:63925 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964915AbWIWUzp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 16:55:45 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8NKtbQ04418
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 22:55:37 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87ac4qfgvc.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sat, 23 Sep
	2006 22:49:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27631>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 t/t5510-fetch.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e71581a..c7faffe
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -27,6 +27,16 @@ test_expect_success "clone and setup chi
 		echo "URL: ../one/.git/"
 		echo "Pull: refs/heads/master:refs/heads/one"
 	} >.git/remotes/one
+	cd .. &&
+	git clone . three &&
+	cd three &&
+	git repo-config branch.master.remote two
+	git repo-config branch.master.merge refs/heads/one
+	{
+		echo "URL: ../two/.git/"
+		echo "Pull: refs/heads/master:refs/heads/two"
+		echo "Pull: refs/heads/one:refs/heads/one"
+	} >.git/remotes/two
 '
=20
 test_expect_success "fetch test" '
@@ -41,4 +51,17 @@ test_expect_success "fetch test" '
 	test "z$mine" =3D "z$his"
 '
=20
+test_expect_success "fetch test for-merge" '
+	cd "$D" &&
+	cd three &&
+	git fetch &&
+	test -f .git/refs/heads/two &&
+	test -f .git/refs/heads/one &&
+	{
+		echo -e "not-for-merge	branch \047master\047 of ../two/"
+		echo -e "	branch \047one\047 of ../two/"
+	} > expected &&
+	cut -f 2- .git/FETCH_HEAD > actual &&
+	diff expected actual'
+
 test_done
--=20
1.4.2.1.g279b
