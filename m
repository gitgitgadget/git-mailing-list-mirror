From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] builtin/init-db.c: eliminate -Wformat warning on Solaris
Date: Tue, 20 Dec 2011 23:27:41 +0000
Message-ID: <1324423661-31174-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 00:27:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd95z-00065H-ON
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 00:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab1LTX1k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 18:27:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57590 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab1LTX1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 18:27:38 -0500
Received: by eekc4 with SMTP id c4so7063196eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 15:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=XxxxJqc4ScV4mLlW/9RI3Sa6RgLJGb0jdCKGjdTcMks=;
        b=u1VA6B/hhDYIXbnkGYEZ4iots7KJlCEgaY1SLzitV6E77GmVE6ACkTFHdDntbHNvo6
         R4Mm92p/ACJYgMmG0QJAB6coP+0d7LiiHUlXQgN9/Zb11/fUXuuRGrJDyhHKy/DIHqN7
         SjBVogwHKLgESq4cH/hLhpCLDacvENsRxJm+4=
Received: by 10.14.3.232 with SMTP id 80mr1726105eeh.2.1324423657439;
        Tue, 20 Dec 2011 15:27:37 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id z54sm13083869eeh.5.2011.12.20.15.27.36
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 15:27:36 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187535>

On Solaris systems we'd warn about an implicit cast of mode_t when we
printed things out with the %d format. We'd get this warning under GCC
4.6.0 with Solaris headers:

    builtin/init-db.c: In function =E2=80=98separate_git_dir=E2=80=99:
    builtin/init-db.c:354:4: warning: format =E2=80=98%d=E2=80=99 expec=
ts argument of type =E2=80=98int=E2=80=99, but argument 2 has type =E2=80=
=98mode_t=E2=80=99 [-Wformat]

We've been doing this ever since v1.7.4.1-296-gb57fb80. Just work
around this by adding an explicit cast.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d07554c..0dacb8b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -351,7 +351,7 @@ static void separate_git_dir(const char *git_dir)
 		else if (S_ISDIR(st.st_mode))
 			src =3D git_link;
 		else
-			die(_("unable to handle file type %d"), st.st_mode);
+			die(_("unable to handle file type %d"), (int)st.st_mode);
=20
 		if (rename(src, git_dir))
 			die_errno(_("unable to move %s to %s"), src, git_dir);
--=20
1.7.7.3
