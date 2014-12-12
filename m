From: Christian Hesse <mail@eworm.de>
Subject: [PATCH 2/3] skip RFC1991 tests for gnupg 2.1
Date: Fri, 12 Dec 2014 09:50:13 +0100
Message-ID: <1418374214-8241-2-git-send-email-mail@eworm.de>
References: <20141212094753.160a0fb5@leda.localdomain>
 <1418374214-8241-1-git-send-email-mail@eworm.de>
Cc: git@vger.kernel.org, Christian Hesse <mail@eworm.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:51:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLwL-0003LF-Lg
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbaLLIvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:51:04 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:34983 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbaLLIvC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 03:51:02 -0500
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id E509B241AD;
	Fri, 12 Dec 2014 09:51:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de E509B241AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418374260; bh=buLvxHP9o8yDEWcjzo2dCqYEkyVzOxz7JstB/i7/Uz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=3nS9ZLrbhcxGOKf7Y2kGO3n3YKSZWyYQwDuHZDj1gg7ZLJL80cCYA7B4QQA7RcA9z
	 EWoFA/D5ztuBqq1VRRM6vIEBVTQOmYRmX6U0wFMmM39n5BNGbMH8kLl5j2yBJmOI0s
	 YOpSeiOzbhsaJVZE1KM9Bmdhr2rixpYOqT3T9iI8=
Received: by leda.eworm.de (Postfix, from userid 1000)
	id BB270100CAA; Fri, 12 Dec 2014 09:50:55 +0100 (CET)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418374214-8241-1-git-send-email-mail@eworm.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261316>

GnuPG >= 2.1.0 does not longer support RFC1991, so skip these
tests.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 t/lib-gpg.sh   |  3 +++
 t/t7004-tag.sh | 14 +++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 4e57942..b0138ad 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -26,6 +26,9 @@ else
 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust
 		test_set_prereq GPG
+		if echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>/dev/null; then
+			test_set_prereq RFC1991
+		fi
 		;;
 	esac
 fi
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 796e9f7..35c805a 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1081,7 +1081,7 @@ test_expect_success GPG \
 get_tag_header rfc1991-signed-tag $commit commit $time >expect
 echo "RFC1991 signed tag" >>expect
 echo '-----BEGIN PGP MESSAGE-----' >>expect
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'creating a signed tag with rfc1991' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
@@ -1095,7 +1095,7 @@ cp "$1" actual
 EOF
 chmod +x fakeeditor
 
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'reediting a signed tag body omits signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
@@ -1103,13 +1103,13 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'verifying rfc1991 signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'list tag with rfc1991 signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
@@ -1123,12 +1123,12 @@ test_expect_success GPG \
 
 rm -f gpghome/gpg.conf
 
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'verifying rfc1991 signature without --rfc1991' '
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'list tag with rfc1991 signature without --rfc1991' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
@@ -1139,7 +1139,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
+test_expect_success GPG,RFC1991 \
 	'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
-- 
2.2.0
