From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/17] ls: add -R/--recursive short for --max-depth=-1
Date: Wed, 26 Mar 2014 20:48:12 +0700
Message-ID: <1395841697-11742-13-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:49:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCW-0000Sq-8I
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbaCZNs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:59 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:58758 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbaCZNs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:58 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so1955605pab.37
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yKKpwCOk+5I0ZjpUFRTSx2+WdtSFd2y+IHVY4n6sxc4=;
        b=lJX2aJWgI0Gmk+P9/EYsO0Ez7VfmdIACpHdl/RZN4s7zhYh3XRAE/qmv0x5nlfUlfS
         1RUu1fErgJX0N1ZqcMCWeM88qbaXlJ6KHbF2qPq1EYsyew4wThP4s22gGOGaWjxH1G+w
         vbPDDlOjK8DpKLO1VbPObQXgpZAATX0nA2/VYH8NqjyvQL9kzNLaveszeob5IMmS+eFF
         XcXxUjfDFOjzkzphHENTNsq5PHVrJYXdf26nMPEK/shKDnzeHOIbYu8y0n2uY3m/OC4o
         r0ArJwXvsKpe2LQsPo6g/hHhIwUr4U+F4ORgxAQRsTxIPUhs4TnsdrHiZhQacMx9IZq1
         PPwA==
X-Received: by 10.66.27.202 with SMTP id v10mr4830886pag.127.1395841737981;
        Wed, 26 Mar 2014 06:48:57 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id et3sm58530523pbc.52.2014.03.26.06.48.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:51 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245191>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls.txt | 4 ++++
 builtin/ls-files.c       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-ls.txt b/Documentation/git-ls.txt
index 67ca522..10df6b0 100644
--- a/Documentation/git-ls.txt
+++ b/Documentation/git-ls.txt
@@ -47,6 +47,10 @@ OPTIONS
 --unmerged::
 	Show unmerged files in the output (forces --stage)
=20
+-R::
+--recursive::
+	Equivalent of --max-depth=3D-1 (infinite recursion).
+
 --color[=3D<when>]::
 	Color file names. The value must be always (default), never,
 	or auto.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 1638983..772a6ce 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -725,6 +725,8 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOL('u', "unmerged", &show_unmerged,
 			N_("show unmerged files in the output")),
+		OPT_SET_INT('R', "recursive", &max_depth,
+			    N_("shortcut for --max-depth=3D-1"), -1),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
 		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
--=20
1.9.1.345.ga1a145c
