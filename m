From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/5] index-pack: perform automatic gc, share receive.gc config with receive-pack
Date: Wed, 16 May 2012 19:29:34 +0700
Message-ID: <1337171377-26960-3-git-send-email-pclouds@gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdQT-0002Ti-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887Ab2EPMdw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:33:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2EPMdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:33:51 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1047153pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VO1fKrW8wevZTVgpAhb+dHlw65o+Y/r6TH4wDMJ+09A=;
        b=E+7xGSpj4k5Rn2YqLUR5MiIsJrqI5fARXDnIAsoxlp13VIMtjNB8jxhihqHdxcgoYJ
         Nfhz8c1tLCCnK+jVLrsPNmgWxuADhMNxh3a1s6p3Y+JXTSdUbUr3beDuKf8RkVYWy59R
         Iaq1Uj0FsDn1eeU898YHJC2sY+8lK8HV4EcerVr3zGIxVd8v6J17z2ApHE/dO6yPDDCM
         eswO6j8st4VsLY8LTx6STsDLAfetVAhGW9WIUXVfjeGABe/YQht6My8AvASkwPJM+A0g
         QRpmS0f3QpAIMx+5ViQ6NOwSSMPlHwkzYcqIPUIuthe2e0Xn7hle+oaYQ9u2SuTrSvUX
         MGWw==
Received: by 10.68.222.134 with SMTP id qm6mr16589534pbc.14.1337171631048;
        Wed, 16 May 2012 05:33:51 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id og6sm5337285pbb.42.2012.05.16.05.33.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:33:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:29:59 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197875>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    7 ++++---
 builtin/index-pack.c     |    6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..3b6d773 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1754,9 +1754,10 @@ rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
=20
 receive.autogc::
-	By default, git-receive-pack will run "git-gc --auto" after
-	receiving data from git-push and updating refs.  You can stop
-	it by setting this variable to false.
+	By default, git-receive-pack and git-index-pack will run
+	"git-gc --auto" after receiving data from git-push and
+	updating refs.  You can stop it by setting this variable to
+	false.
=20
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dc2cfe6..4e888ea 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -10,6 +10,7 @@
 #include "fsck.h"
 #include "exec_cmd.h"
 #include "thread-utils.h"
+#include "gc.h"
=20
 static const char index_pack_usage[] =3D
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ve=
rify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -1463,12 +1464,13 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 	curr_index =3D write_idx_file(index_name, idx_objects, nr_objects, &o=
pts, pack_sha1);
 	free(idx_objects);
=20
-	if (!verify)
+	if (!verify) {
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
 		      keep_name, keep_msg,
 		      pack_sha1);
-	else
+		gc("receive.autogc", 0);
+	} else
 		close(input_fd);
 	free(objects);
 	free(index_name_buf);
--=20
1.7.8.36.g69ee2
