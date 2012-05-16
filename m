From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/5] commit: reinstate "gc --auto"
Date: Wed, 16 May 2012 19:29:35 +0700
Message-ID: <1337171377-26960-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed May 16 14:34:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdQf-0002gi-0J
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936Ab2EPMeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:34:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45919 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2EPMeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:34:01 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so927067dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fdux/VFx7haUw9s8z2MOfageC69sXts6Q9xXQKV0/u8=;
        b=I3zy+LdMmsXBO9z9xu1H4JGEry5VhpQpgoU0XSIFmTb8Laj/RfFxKDXwSEsGX31jrj
         mQBUWBQ9ztVxlE3FDDzlsJEnxzjWP4ufGU0Diy0+K9QZ3/X7w4TjJcs+QikH/p4SXZFH
         XWm0fmBIape1h4JTeUuk4o2t0kg5+YnuF7ruf79qrtW29e6Ny19JbhJLZ/0sPV47MZbf
         tJcPVTllZCLtfXb8/FjTuHpfVBM4OJBGYN7A+y6v6NaxpkfyFZzs2gmC8/DG0RSrCeVe
         rvvYCfiawvKyg4bOtME1jg9PCAJMU81nn+7JIpSCHyBQ1P5xO0e0OVU4riONzggMlcjY
         b7TQ==
Received: by 10.68.191.201 with SMTP id ha9mr16397627pbc.75.1337171641478;
        Wed, 16 May 2012 05:34:01 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id ov3sm5342184pbb.35.2012.05.16.05.33.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:34:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:30:10 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1337171377-26960-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197876>

This check was lost after sh->C conversion

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    4 ++++
 builtin/commit.c         |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3b6d773..8f5dd48 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -904,6 +904,10 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
=20
+commit.autogc::
+	By default, git-commit will run "git gc --auto" after each
+	commit. You can stop it by setting this variable to false.
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/builtin/commit.c b/builtin/commit.c
index a2ec73d..bf7d0aa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -28,6 +28,7 @@
 #include "submodule.h"
 #include "gpg-interface.h"
 #include "column.h"
+#include "gc.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	"git commit [options] [--] <filepattern>...",
@@ -1589,6 +1590,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		     "new_index file. Check that disk is not full or quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
=20
+	gc("commit.autogc", 0);
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
--=20
1.7.8.36.g69ee2
