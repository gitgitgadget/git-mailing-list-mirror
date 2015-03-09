From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/16] list-files: show paths relative to cwd
Date: Mon,  9 Mar 2015 17:18:21 +0700
Message-ID: <1425896314-10941-4-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumV-0001mF-Az
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbbCIKTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:12 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37015 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbbCIKTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:09 -0400
Received: by pdbnh10 with SMTP id nh10so68094623pdb.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iRG7MHfHARGJFsGrgTPgXRNYRbx8ylWpQ/0G1YscZHM=;
        b=DaUvXHO+qBt+WYqxCyOAS/uyoBFV3tAqf2iWzhTI5qSMYGeg9rAwaOu0nE888JI4E2
         LZ0v0DAveh3wNlOR1Y+ahk/+Wl6FzaQ85PSam4lKJPpsk+eKM0qvp33ET07mbeWse4Vq
         seN3p8HGw4xyaO/iDpuFTPfhH0iny9w2SBIEec+1vptFGmYB99GwPiYcHvwwNi9uCcR4
         nznOS2ECxb7O56t7cGt6kgTv9LVTMDz4g5qCVAsWGEB0iom2BrNeMZmbFsq6nGVYP6sU
         faU4REAxf3jocMZ8Vnd/OdugZ0yvSN34mt8DKEZQVLMgqjhI7gXuhagXOp0+q6CM9+1Y
         K+pA==
X-Received: by 10.70.18.97 with SMTP id v1mr24143040pdd.152.1425896349139;
        Mon, 09 Mar 2015 03:19:09 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id z2sm18358675pde.94.2015.03.09.03.19.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:05 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265146>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index b99f2b7..c444a53 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -3,6 +3,7 @@
 #include "parse-options.h"
 #include "pathspec.h"
 #include "dir.h"
+#include "quote.h"
=20
 static struct pathspec pathspec;
 static const char *prefix;
@@ -22,7 +23,7 @@ static void add_one(struct string_list *result, const=
 char *name)
 	struct strbuf sb =3D STRBUF_INIT;
 	struct string_list_item *item;
=20
-	strbuf_addstr(&sb, name);
+	quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
 	item =3D string_list_append(result, strbuf_detach(&sb, NULL));
 	item->util =3D (char *)name;
 }
--=20
2.3.0.rc1.137.g477eb31
