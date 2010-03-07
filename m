From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/12] ls-files: support column output with --columns
Date: Sun,  7 Mar 2010 19:09:43 +0700
Message-ID: <1267963785-473-11-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFNO-0000oh-JW
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab0CGMNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:48 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33676 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0CGMNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:46 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3254848pwj.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Sa25Waq/uzlVAPi2YyQssNeMeauK7gXAqfDcnEXfmo8=;
        b=VZ6KpoVgdWQ2mdLxxUC5Pks5AuI0CpoqKmg69ZOJrZaGZ7MNZwtwFqi4QiPGqjFYjz
         JpHZzn5bj2oqpV1QLbExAj3c2oCPMczZjJdZPn/uD3FRyrMWDkIfjvl3YWAgXK2NnIxP
         gB1JLuCOcyR5+3EPO2Vt3tcL6eaC8vyZTYaFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VHD09+sivGWEIgVypfMG527ZNVMDVB+i71AyeetdPAw7pDX6RC/1Gn4RbifNzxVv80
         xmMWge07D/QIJknDT+AincGuS5CWKt40gzmX8tEUm9vMMQbHyEKF2aGdSRiRoj+7ovoe
         2T8wdt7WpxmbLa1xtkFWv/FGWuHabpbnx5gbs=
Received: by 10.114.163.9 with SMTP id l9mr2385509wae.5.1267964026090;
        Sun, 07 Mar 2010 04:13:46 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 22sm3617748pzk.5.2010.03.07.04.13.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:30 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141687>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b065061..10cb057 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,6 +13,7 @@
 #include "parse-options.h"
 #include "resolve-undo.h"
 #include "string-list.h"
+#include "column.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -33,6 +34,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static int show_colums =3D 0;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -514,6 +516,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 			"if any <file> is not in the index, treat this as an error"),
 		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
 			"pretend that paths removed since <tree-ish> are still present"),
+		OPT_BOOLEAN(0, "columns", &show_colums, "show files in columns"),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
@@ -589,6 +592,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_cache(with_tree, prefix);
 	}
+
+	if (show_colums)
+		start_columnizer(NULL);
+
 	show_files(&dir, prefix);
 	if (show_resolve_undo)
 		show_ru_info(prefix);
@@ -602,5 +609,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
 		return bad ? 1 : 0;
 	}
=20
+	if (show_colums)
+		stop_columnizer();
+
 	return 0;
 }
--=20
1.7.0.1.370.gd3c5
