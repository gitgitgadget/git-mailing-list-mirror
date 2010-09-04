From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/63] tests: locate i18n lib&data correctly under --valgrind
Date: Sat,  4 Sep 2010 22:10:23 +0000
Message-ID: <1283638229-14199-4-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sam Reed <sam@reedyboy.net>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 00:11:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os0x3-0003Lx-Pc
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab0IDWKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 18:10:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57357 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab0IDWKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:10:53 -0400
Received: by wyf22 with SMTP id 22so1463766wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=vgzVGx3l32XGtzNQK0umObMDWpqNtQZXb+b4wrhZlLA=;
        b=fk1CGX+Tty3/Hca84Akhmy/4JjKfBH4i7Sw+kfDAeMDZsW49rjNpBX2dg9UolhKHjW
         imkgLLb33TYyhfyD8hiSGY52kOlSLki+VdojqH+VwCDMpZQyoSSpi0gc4MKmcHU1Pnyr
         XUu6joj0EuSVQ1KvcwplTWU3eEzAwoGH0zdlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ixcu1sDLULeF0wE9X7N7DYqK5zKh+PMS7c8r0Xcl3lvV1KXPKuwH8CJh/iE4GFc48p
         7zyUSoQhF29R8ahg2TBMLnejwQIger4rvc8To8goIWByxhSHBn9bzRVhiYsd4zvRzkze
         X5VnRWngMVJVV4KpgBaeXqP0MRzomwy/I2ckE=
Received: by 10.216.145.99 with SMTP id o77mr1528509wej.113.1283638252189;
        Sat, 04 Sep 2010 15:10:52 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k15sm2261604wer.23.2010.09.04.15.10.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 15:10:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155372>

=46rom: Thomas Rast <trast@student.ethz.ch>

The new t020[01] for gettext support did not find git-sh-i18n and the
translation data when run under --valgrind: lib-gettext.sh tried to
locate them under $GIT_EXEC_PATH, which normally is the git build
directory, but is changed by --valgrind to point to the wrappers.

Introduce a new variable $GIT_BUILD_DIR which can be used to locate
data that resides under the build directory, and use that instead.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-gettext.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 831ee38..f0cdd3d 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -5,11 +5,11 @@
=20
 . ./test-lib.sh
=20
-GIT_TEXTDOMAINDIR=3D"$GIT_EXEC_PATH/share/locale"
-GIT_PO_PATH=3D"$GIT_EXEC_PATH/po"
+GIT_TEXTDOMAINDIR=3D"$GIT_BUILD_DIR/share/locale"
+GIT_PO_PATH=3D"$GIT_BUILD_DIR/po"
 export GIT_TEXTDOMAINDIR GIT_PO_PATH
=20
-. "$GIT_EXEC_PATH"/git-sh-i18n
+. "$GIT_BUILD_DIR"/git-sh-i18n
=20
 if test_have_prereq GETTEXT
 then
--=20
1.7.2.3.313.gcd15
