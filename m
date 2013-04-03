From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] test-lint-duplicates: Only check for numbered test cases
Date: Wed, 3 Apr 2013 07:54:02 +0200
Message-ID: <201304030754.03100.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 07:54:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNGen-0000c6-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 07:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762532Ab3DCFyK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 01:54:10 -0400
Received: from mout.web.de ([212.227.15.4]:61541 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762503Ab3DCFyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 01:54:09 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Ls91n-1UlZse3Sdb-013UKQ; Wed, 03 Apr 2013 07:54:07 +0200
X-Provags-ID: V02:K0:4ZvsAXii0lu0dKMmjX8SexDnrRPuTtXleBlYkfl4NRq
 SwR8rC1kZz+a3bkCp6ws+I96suzgAtvuEWqUui9Rp8p2kcOMM5
 UsIV6f07nGzPEENw9+dqAOVNTd84X2+q7VUNiMkulbUiwdWkYs
 nK+ZUPIGyta7DaT7o7EFt2RLJxVWOZqofpXroKkNDVTFkkMV8o
 /pLbn/H549arC0axxuXUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219918>

Running make inside contrib/remote-helpers fails in "test-lint-duplicat=
es"

This was because the regexp checking for duplicate numbers strips every=
thing
after the first "-" in the filename, including the prefix.

As a result, 2 pathnames like
"xxxx/contrib/remote-helpers/test-bzr.sh" and
"xxxx/contrib/remote-helpers/test-hg-bidi.sh"

are both converted into
"xxxx/contrib/remote", and reported as duplicate.

Improve the regexp:
Remove everything after tNNNN- (where X stand for a digit)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 1923cc1..f123d02 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,7 +48,7 @@ clean: clean-except-prove-cache
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-s=
yntax
=20
 test-lint-duplicates:
-	@dups=3D`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` &&=
 \
+	@dups=3D`echo $(T) | tr ' ' '\n' | sed -ne 's|\(.*/\)*t\([0-9][0-9][0=
-9][0-9]\)-.*|\2|p' | sort | uniq -d` && \
 		test -z "$$dups" || { \
 		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
=20
--=20
1.8.2.411.g65a544e
