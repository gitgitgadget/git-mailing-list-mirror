From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Makefile: limit specifying -DGIT_USER_AGENT=... to keep ccache efficient
Date: Sun, 24 Jun 2012 19:37:37 +0700
Message-ID: <1340541457-9056-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 14:42:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sim95-0002N8-0f
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 14:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab2FXMmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 08:42:22 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51056 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2FXMmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2012 08:42:21 -0400
Received: by pbbrp8 with SMTP id rp8so5410996pbb.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=BHT9Mo6TAQW21BSCQfoZOOEceDl/vA7b8SwZ4CI85J0=;
        b=Fj8JaT4fowGZZvP8lrWYPfO1IUROeeoHg7V0bPuW8udfzRMI1h4FUjNB1sRqtxfr2N
         6TYjub2Ysd14U7SntnvR/TZoqF1FZMmgfljrRTMCiyNpdnpzikGcHvA/g8lB/UQRSbSG
         29ma7u9B3fkP4VX3w3CZKqZvXCXpCs1TNOfvqpwQkR8J9cDEyi0ZmsV12BylIUKURAFx
         0k1t37mmCG9goKnIJo0i0N90Z7Xfkkl4XPbTDUovrPSY5lpV2KOhy4yiru9JinG7P3V+
         XZtBJjPvkVYa+5/R3VWRxiyEsjBwbhJn9lyN1ztkE8Tk6aXNlCVNWNqlyK9Dps5aRsUW
         bGDg==
Received: by 10.68.232.201 with SMTP id tq9mr30020320pbc.70.1340541740782;
        Sun, 24 Jun 2012 05:42:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.50.32])
        by mx.google.com with ESMTPS id sk5sm5265398pbc.7.2012.06.24.05.42.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 05:42:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 24 Jun 2012 19:37:38 +0700
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200525>

GIT_USER_AGENT changes as HEAD changes. Defining it in BASIC_FLAGS
means every time HEAD changes, the compiling options for every object
file is changed, which defeats the purpose of using ccache.

As version.c is the only file that uses this definition, limit
defining only when compiling this file.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f62ca2a..b3ce00d 100644
--- a/Makefile
+++ b/Makefile
@@ -1929,7 +1929,6 @@ endif
 GIT_USER_AGENT_SQ =3D $(subst ','\'',$(GIT_USER_AGENT))
 GIT_USER_AGENT_CQ =3D "$(subst ",\",$(subst \,\\,$(GIT_USER_AGENT)))"
 GIT_USER_AGENT_CQ_SQ =3D $(subst ','\'',$(GIT_USER_AGENT_CQ))
-BASIC_CFLAGS +=3D -DGIT_USER_AGENT=3D'$(GIT_USER_AGENT_CQ_SQ)'
=20
 ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS +=3D -DDEFAULT_HELP_FORMAT=3D'"$(DEFAULT_HELP_FORMAT)"'
@@ -2000,7 +1999,8 @@ builtin/help.sp builtin/help.s builtin/help.o: EX=
TRA_CPPFLAGS =3D \
 	'-DGIT_INFO_PATH=3D"$(infodir_SQ)"'
=20
 version.sp version.s version.o: EXTRA_CPPFLAGS =3D \
-	'-DGIT_VERSION=3D"$(GIT_VERSION)"'
+	'-DGIT_VERSION=3D"$(GIT_VERSION)"' \
+	'-DGIT_USER_AGENT=3D"$(GIT_USER_AGENT)"'
=20
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
--=20
1.7.8
