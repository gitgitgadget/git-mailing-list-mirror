From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] reset: setup worktree on --mixed
Date: Sat, 15 Feb 2014 16:14:21 +0700
Message-ID: <1392455661-20665-1-git-send-email-pclouds@gmail.com>
References: <CA+C-WL_x=+OPn4Ec-6Y13w1+dd5G5v8W6=i15WH47pyP3ggjuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, patrick@parcs.ath.cx,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 10:14:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEbKp-0008P2-OI
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 10:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbaBOJOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 04:14:18 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:39791 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaBOJON (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 04:14:13 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so13276130pbb.21
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BdOJE61wX6l6xStlAUo3QOMcs0WwqwVwDGL1pg8Sf9w=;
        b=ABsuvyThAqt3Wd/pVp1I3F0BM7z3fGjX01pgiVK4V1yB4aw+YMG2Vk6mqDaPPkng5x
         xNp4jPmvI+Bh6bFoxK80UtsFYoT8ZobDBVMyDoQ2fnY29H69ht1SQ8CscsFbFdJdp5Tf
         Ktw4G7lX3tRT3ybhM0i3lPDYgG6249HMBdM8Sv3aUwJWCKm5APPzHQz0QuTKBYd9Zp+9
         pDOUgnTDKHb8zw2CSSEIhFd4qBUOlYH3tiC0nlHzLGnQwSy6/s6LedAgk4EzyYZzuaIX
         8Vaiu1ICTzfW/fVLIWPYGNHz5fRoeTBywywCHZ+Rergqp5KB2pMLD+WFWrWhg09gyLwd
         WRzw==
X-Received: by 10.68.129.234 with SMTP id nz10mr10305733pbb.16.1392455652814;
        Sat, 15 Feb 2014 01:14:12 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id om6sm25269724pbc.43.2014.02.15.01.14.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 01:14:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 16:14:23 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <CA+C-WL_x=+OPn4Ec-6Y13w1+dd5G5v8W6=i15WH47pyP3ggjuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242182>

--mixed does mainly two things: read_from_tree(), which does not
require a worktree, and refresh_index(), which does.

Reported-by: Patrick Palka <patrick@parcs.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reset.c  |  2 +-
 t/t7102-reset.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..9928c28 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	if (reset_type =3D=3D NONE)
 		reset_type =3D MIXED; /* by default */
=20
-	if (reset_type !=3D SOFT && reset_type !=3D MIXED)
+	if (reset_type !=3D SOFT)
 		setup_work_tree();
=20
 	if (reset_type =3D=3D MIXED && is_bare_repository())
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 8d4b50d..ee117e2 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -535,4 +535,15 @@ test_expect_success 'reset with paths accepts tree=
' '
 	git diff HEAD --exit-code
 '
=20
+test_expect_success 'reset --mixed sets up work tree' '
+	git init mixed_worktree &&
+	(
+		cd mixed_worktree &&
+		test_commit dummy
+	) &&
+	: >expect &&
+	git --git-dir=3Dmixed_worktree/.git --work-tree=3Dmixed_worktree rese=
t >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
