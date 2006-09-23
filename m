From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/4 (take 4)] Add t5510 to test per branch configuration affecting git-fetch.
Date: Sat, 23 Sep 2006 22:52:17 +0200
Message-ID: <871wq2fgqm.fsf@gmail.com>
References: <87ac4qfgvc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 22:52:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GREU5-0006ar-GL
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWIWUwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 16:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWIWUwW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:52:22 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:59573 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964907AbWIWUwW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 16:52:22 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8NKqJQ04257
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 22:52:19 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87ac4qfgvc.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sat, 23 Sep
	2006 22:49:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27629>


=46rom: Junio C Hamano <junkio@cox.net>
Signed-off-by: Junio C Hamano <junkio@cox.net>
Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 I hope the attribution is ok.

 t/t5510-fetch.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
new file mode 100755
index 0000000..e71581a
--- /dev/null
+++ b/t/t5510-fetch.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# Copyright (c) 2006, Junio C Hamano.
+
+test_description=3D'Per branch config variables affects "git fetch".
+
+'
+
+. ./test-lib.sh
+
+D=3D`pwd`
+
+test_expect_success setup '
+	echo >file original &&
+	git add file &&
+	git commit -a -m original'
+
+test_expect_success "clone and setup child repos" '
+	git clone . one &&
+	cd one &&
+	echo >file updated by one &&
+	git commit -a -m "updated by one" &&
+	cd .. &&
+	git clone . two &&
+	cd two &&
+	git repo-config branch.master.remote one &&
+	{
+		echo "URL: ../one/.git/"
+		echo "Pull: refs/heads/master:refs/heads/one"
+	} >.git/remotes/one
+'
+
+test_expect_success "fetch test" '
+	cd "$D" &&
+	echo >file updated by origin &&
+	git commit -a -m "updated by origin" &&
+	cd two &&
+	git fetch &&
+	test -f .git/refs/heads/one &&
+	mine=3D`git rev-parse refs/heads/one` &&
+	his=3D`cd ../one && git rev-parse refs/heads/master` &&
+	test "z$mine" =3D "z$his"
+'
+
+test_done
--=20
1.4.2.1.g279b
