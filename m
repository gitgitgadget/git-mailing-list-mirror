From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/20] gettext: add GETTEXT_POISON tests for shell scripts
Date: Tue,  7 Sep 2010 16:48:24 +0000
Message-ID: <1283878113-19533-1-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1O6-0004K7-4g
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196Ab0IGQso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:48:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41915 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab0IGQsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:48:41 -0400
Received: by wyf22 with SMTP id 22so4442067wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=U8iZvN6if+bFIX+uwLmMmTWkl1bHH0gHjzTJ1weZWqY=;
        b=NGW1tFZKZ7PJqZS/hIfMlWY3codOG5Tandy0O3QsK6zZZOorRc1Bb6wT/Isj+ZBVMk
         3HA1c39kUCucBAaBUREUADB5zY2nGCfyWKCmpcDm8fG/gdX4RA2gY1fCOXyZ8hSx8cw9
         llNzatm09XLD68JzjNlE3J485Exi2x2J7SRvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WoCqyM0AztC7ps6IrdcKT0agSlJTSYy76JRUz/GGkMcSdUrc8jMR1nZByrls+Fd3zE
         CAS+HubzkcnigacQdXinTIBtkzfbgbVhFpQgwMxD61OM468RnHkxr3iyZxkVbPk6J+8o
         C6IlvuyTgSFg7kgZTtBIswW5jemaE6McJm2Jg=
Received: by 10.227.37.8 with SMTP id v8mr29237wbd.180.1283878118573;
        Tue, 07 Sep 2010 09:48:38 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.48.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:48:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155718>

Test the new GETTEXT_POISON=3DYesPlease support for shell scripts. This
test is derived from the existing t0201-gettext-fallbacks.sh test.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0201-gettext-poison.sh |   36 ++++++++++++++++++++++++++++++++++++
 t/test-lib.sh             |    1 +
 2 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100755 t/t0201-gettext-poison.sh

diff --git a/t/t0201-gettext-poison.sh b/t/t0201-gettext-poison.sh
new file mode 100755
index 0000000..2361590
--- /dev/null
+++ b/t/t0201-gettext-poison.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
+#
+
+test_description=3D'Gettext Shell poison'
+
+. ./lib-gettext.sh
+
+test_expect_success GETTEXT_POISON "sanity: \$GIT_INTERNAL_GETTEXT_SH_=
SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
+    test -n "$GIT_INTERNAL_GETTEXT_SH_SCHEME"
+'
+
+test_expect_success GETTEXT_POISON 'sanity: $GIT_INTERNAL_GETTEXT_SH_S=
CHEME" is poison' '
+    test "$GIT_INTERNAL_GETTEXT_SH_SCHEME" =3D "poison"
+'
+
+test_expect_success GETTEXT_POISON 'gettext: our gettext() fallback ha=
s poison semantics' '
+    printf "# GETTEXT POISON #" >expect &&
+    gettext "test" >actual &&
+    test_cmp expect actual &&
+    printf "# GETTEXT POISON #" >expect &&
+    gettext "test more words" >actual &&
+    test_cmp expect actual
+'
+
+test_expect_success GETTEXT_POISON 'eval_gettext: our eval_gettext() f=
allback has poison semantics' '
+    printf "# GETTEXT POISON #" >expect &&
+    eval_gettext "test" >actual &&
+    test_cmp expect actual &&
+    printf "# GETTEXT POISON #" >expect &&
+    eval_gettext "test more words" >actual &&
+    test_cmp expect actual
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5a9f989..48e1256 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -967,6 +967,7 @@ if test -z "$GETTEXT_POISON"
 then
 	test_set_prereq NO_GETTEXT_POISON
 else
+	test_set_prereq GETTEXT_POISON
 	GIT_INTERNAL_GETTEXT_GETTEXT_POISON=3DYesPlease
 	export GIT_INTERNAL_GETTEXT_GETTEXT_POISON
 fi
--=20
1.7.2.3.313.gcd15
