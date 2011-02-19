From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 69/72] gettextize: git-revert "Your local changes" message
Date: Sat, 19 Feb 2011 19:24:52 +0000
Message-ID: <1298143495-3681-70-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUV-0003dU-WB
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab1BST2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32957 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab1BST20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:26 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347251eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=mBHLOaqgwpsIzRcdpKZDQYeYqG6BPM2PHEAwrElU0p0=;
        b=faF/U9sUb4YJriIjt9xIHkst6uoEWsdbzLgK22qOcUXmAm/hI93mclFtiAlGhjWlx0
         ZTd2zWSBrgmLbl5YRaPpVoq8JCFZzhl3sBKvanZhdl83GSV9J/wrmnPtWbe8gS4oRXT+
         P33Zt9WIACB1doAane9JxiXfnX7O97JW5Aobk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vTv9mQEaaM/UvLWN1U+DDoycMyxaeGcYRFQpUYETEl80+9mtevvfFFKcofUPD/VnvM
         Edhs8j2//4O+j9H3dCSsoGimQlkKrONbWNyN3DIe0QyN49vbWpr2uyeS/Plhv5kW7v1A
         c5l8nMx8meJJMTsJ8wBE058VQY8svph38gSRc=
Received: by 10.213.34.68 with SMTP id k4mr88716ebd.54.1298143705946;
        Sat, 19 Feb 2011 11:28:25 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.24
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:25 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167349>

Translate the "Your local changes [...]" message without using the
`me' variable, instead split up the two messages so translators can
translate the whole messages as-is.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c              |   18 +++++++++++++-----
 t/t3501-revert-cherry-pick.sh |    2 +-
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1ca08da..02c23c9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -302,11 +302,19 @@ static NORETURN void die_dirty_index(const char *=
me)
 	if (read_cache_unmerged()) {
 		die_resolve_conflict(me);
 	} else {
-		if (advice_commit_before_merge)
-			die("Your local changes would be overwritten by %s.\n"
-			    "Please, commit your changes or stash them to proceed.", me);
-		else
-			die("Your local changes would be overwritten by %s.\n", me);
+		if (advice_commit_before_merge) {
+			if (action =3D=3D REVERT)
+				die(_("Your local changes would be overwritten by revert.\n"
+					  "Please, commit your changes or stash them to proceed."));
+			else
+				die(_("Your local changes would be overwritten by cherry-pick.\n"
+					  "Please, commit your changes or stash them to proceed."));
+		} else {
+			if (action =3D=3D REVERT)
+				die(_("Your local changes would be overwritten by revert.\n"));
+			else
+				die(_("Your local changes would be overwritten by cherry-pick.\n")=
);
+		}
 	}
 }
=20
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick=
=2Esh
index 0439544..76d3252 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -91,7 +91,7 @@ test_expect_success 'cherry-pick on stat-dirty workin=
g tree' '
 	)
 '
=20
-test_expect_success 'revert forbidden on dirty working tree' '
+test_expect_success NO_GETTEXT_POISON 'revert forbidden on dirty worki=
ng tree' '
=20
 	echo content >extra_file &&
 	git add extra_file &&
--=20
1.7.2.3
