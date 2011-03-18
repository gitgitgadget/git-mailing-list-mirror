From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] wrapper.c: add xgetcwd()
Date: Fri, 18 Mar 2011 18:39:28 +0700
Message-ID: <1300448369-5896-1-git-send-email-pclouds@gmail.com>
References: <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	kusmabite@gmail.com, cmn@elego.de
X-From: git-owner@vger.kernel.org Fri Mar 18 12:41:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Y42-0001eL-RB
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 12:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1CRLlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 07:41:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37439 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab1CRLlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 07:41:49 -0400
Received: by iyb26 with SMTP id 26so3878958iyb.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=WQIuLMzel+9ICiA0fq1gPmmj7jZm/nIm/xR2+gFC/uI=;
        b=j3/NWbAE/2r4DKs4fY6uy4zCujM7WenhUlhyE7UDVrqlk8JI45sdc9oPp9T0OTyl/l
         yB/SKr5NGr0lJQOpE6zVN0m9VNe+KUlnYFQGtt8DA20XQbVmgm9kD+6R7G37LMtnI27g
         UijZWInZssy4BQIHsC8K72rKzFdV8VW2td21Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LUiFRMwhF7jp3sPKY4LPIsdecYh5IZz28pJ7PKOSmQYqU5Z4VwEMjczOZBvLtozOSw
         Lv6yL7SC0GbfAOW/sskIfSw4NhObp501uAmSWOPob4HeSK0wN2BIcQrATevjnoTse/4j
         wONWwBx5kSDcB8aZbDG2ZAZDLVHf13EUyLzrs=
Received: by 10.231.28.138 with SMTP id m10mr669852ibc.39.1300448508748;
        Fri, 18 Mar 2011 04:41:48 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.206.4])
        by mx.google.com with ESMTPS id mv26sm488752ibb.40.2011.03.18.04.41.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 04:41:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 18 Mar 2011 18:39:31 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169311>

getcwd() requires the input buffer must be large enough to contain
current working directory, or it will return ERANGE. We currently
treat ERANGE critical and die out.

xgetcwd() handles ERANGE and grows the buffer if necessary. Like other
functions in x* family, it will die() if fails.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |    2 ++
 wrapper.c         |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 49b50ee..e8b1398 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -433,6 +433,8 @@ extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *patte=
rn);
 extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha=
1);
+struct strbuf;
+extern void xgetcwd(struct strbuf *);
=20
 static inline size_t xsize_t(off_t len)
 {
diff --git a/wrapper.c b/wrapper.c
index 2829000..5c8cbdf 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -217,6 +217,20 @@ int xmkstemp(char *template)
 	return fd;
 }
=20
+void xgetcwd(struct strbuf *sb)
+{
+	const char *ret;
+	if (sb->alloc - sb->len < PATH_MAX)
+		strbuf_grow(sb, PATH_MAX);
+	while ((ret =3D getcwd(sb->buf + sb->len,
+			     sb->alloc - sb->len - 1)) =3D=3D NULL &&
+	       errno =3D=3D ERANGE)
+		strbuf_grow(sb, PATH_MAX);
+	if (!ret)
+		die_errno("Unable to read current working directory");
+	sb->len +=3D strlen(sb->buf + sb->len);
+}
+
 /* git_mkstemp() - create tmp file honoring TMPDIR variable */
 int git_mkstemp(char *path, size_t len, const char *template)
 {
--=20
1.7.4.74.g639db
