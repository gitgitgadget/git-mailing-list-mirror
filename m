From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] Make prefix_path() return char* without const
Date: Thu, 11 Nov 2010 21:08:03 +0700
Message-ID: <1289484484-8632-3-git-send-email-pclouds@gmail.com>
References: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Thu Nov 11 15:10:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGXqu-0001fC-SG
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab0KKOKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:10:05 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:35076 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab0KKOKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 09:10:04 -0500
Received: by pxi15 with SMTP id 15so397998pxi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ysIB6DCvvbWQ7Z54pudFUsLxgoj3tlgGNtWlmSd8gok=;
        b=eXrvgB7/7DsgO/p6D/V3MF4Syz3iNrfC19i/yDLPm8UqPQPxjJZmh76iHR8Kd9qXcI
         ysARuz0VFG5hkFRbcr8aMnyrQghfcYV4AGP22MPfk2xeV6EBsZCnz92hxiljhAcVMZfx
         9ADhT8Gzq2RVTpwYoYoTNV9GymeiY4SbnJg84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UDBVChtNnC7FjPy5ns05FUHIGEvIBcuiYgwtJawoWPlVopAMndD3yYp1gyD2bHpXsa
         fPF3Aunj3L9Z7vkxXzoXUsKO6VGjfrYTxb1osDWMKkiuUUiFfdICoCT2ReRrSKMss6oH
         zicKgGaOYc336vln+iSRIBq51sWZOv3JEMKM4=
Received: by 10.142.50.15 with SMTP id x15mr456319wfx.426.1289484603869;
        Thu, 11 Nov 2010 06:10:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w27sm56138wfd.21.2010.11.11.06.09.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 06:10:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Nov 2010 21:08:40 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289484484-8632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161252>

prefix_path() allocates new buffer. There's no reason for it to keep
the buffer for itself and waste memory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    2 +-
 setup.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 222d9cf..bd181c6 100644
--- a/cache.h
+++ b/cache.h
@@ -428,7 +428,7 @@ extern const char **get_pathspec(const char *prefix=
, const char **pathspec);
 extern void setup_work_tree(void);
 extern const char *setup_git_directory_gently(int *);
 extern const char *setup_git_directory(void);
-extern const char *prefix_path(const char *prefix, int len, const char=
 *path);
+extern char *prefix_path(const char *prefix, int len, const char *path=
);
 extern const char *prefix_filename(const char *prefix, int len, const =
char *path);
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix, const char *name);
diff --git a/setup.c b/setup.c
index 833db12..f930dc0 100644
--- a/setup.c
+++ b/setup.c
@@ -4,7 +4,7 @@
 static int inside_git_dir =3D -1;
 static int inside_work_tree =3D -1;
=20
-const char *prefix_path(const char *prefix, int len, const char *path)
+char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig =3D path;
 	char *sanitized =3D xmalloc(len + strlen(path) + 1);
--=20
1.7.3.2.210.g045198
