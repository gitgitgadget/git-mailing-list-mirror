From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 08/14] read-cache: add GIT_TEST_FORCE_WATCHER for testing
Date: Fri, 17 Jan 2014 16:47:34 +0700
Message-ID: <1389952060-12297-9-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4630-0002uW-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbaAQJs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:48:59 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:40525 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbaAQJsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:54 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so3792845pdi.7
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3k9WtsYwOev/Tb7jxckPPxU5/W9o3Y87/RIk9V7ewwk=;
        b=n82/H++oe6TsjzVshyvTYahQtSBIbzPq6r2vtdDoTc6SxmpudYWATKXrJbw3IFdSqq
         RQ9Y6V9rieH5ff64y48Ilj+xI13dHBDnzkfOFAkv8kxzX7JQCR/SZp3pJXbefQKpCeJB
         F+ga914rmfC5s/xGV1QjEcnUmGE69cH5J1R60Dnhzx763Q6U/U2w3rYkf/FxmK0Codox
         jITr+g8WQKf4Bb8TcF26zn39Jjsto8/zQNKrsQ27InEtOgZnMCdRZjtU0PiIYgAcOaXz
         Dc3GPBfOoQQgKXYF0HsO+9bS5mOLtMnr8b8wPjSgBkbj+Il0h3ulLgAXcLC/KYTIzykI
         ksnw==
X-Received: by 10.68.198.68 with SMTP id ja4mr1149057pbc.24.1389952133544;
        Fri, 17 Jan 2014 01:48:53 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id db3sm21358113pbb.10.2014.01.17.01.48.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:48 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240588>

This can be used to force watcher on when running the test
suite.

git-file-watcher processes are not automatically cleaned up after each
test. So after running the test suite you'll be left with plenty
git-file-watcher processes that should all end after about a minute.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 read-cache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 5dae9eb..a1245d4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1544,7 +1544,12 @@ static void validate_watcher(struct index_state =
*istate, const char *path)
 	}
=20
 	if (autorun_watcher =3D=3D -1) {
-		git_config(watcher_config, NULL);
+		if (getenv("GIT_TEST_FORCE_WATCHER")) {
+			watch_lowerlimit =3D 0;
+			recent_limit =3D 0;
+			autorun_watcher =3D 1;
+		} else
+			git_config(watcher_config, NULL);
 		if (autorun_watcher =3D=3D -1)
 			autorun_watcher =3D 0;
 	}
--=20
1.8.5.1.208.g05b12ea
