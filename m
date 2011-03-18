From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] setup_gently: use xgetcwd()
Date: Fri, 18 Mar 2011 18:39:29 +0700
Message-ID: <1300448369-5896-2-git-send-email-pclouds@gmail.com>
References: <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
 <1300448369-5896-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	kusmabite@gmail.com, cmn@elego.de
X-From: git-owner@vger.kernel.org Fri Mar 18 12:42:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Y4E-0001iP-Id
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 12:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab1CRLmB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 07:42:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43182 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab1CRLmA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 07:42:00 -0400
Received: by iwn34 with SMTP id 34so3876054iwn.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=hnJIIIwj7GMj6zb6RKlnV00p6uGupcgAuG9cAcjZpDg=;
        b=rvpnLVOrla5n3/p6QAC6qcKE7fs0/7kslKWzq50Dr7uFw3F0BwVvuYe8mwzrJXftYx
         x2UsxqhPLucTRAWco778qm86EFd4XCBSLcD5Vy22YC1Mm7kCtC4XvNNiiobRIZeAYkRO
         uSRNor2M1r1hn6Ffl39z7F4CI9rln8SFIOdI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sTSUAkgciwMK/6VDn2zZ8p05B3lxvqT57xaaZjRrHX0QgLXjt9fnlW92+7VGsXH8Ik
         +oxuUs5dPgZ0j65wufCgw+ka/r42bfVIi3pHHjOq0u9kisyH4XGgMSift8QZJUbQfRNm
         a31Gv+V/Hc+6CqkM4QvH1hxlRtwrGplaViur0=
Received: by 10.43.64.132 with SMTP id xi4mr1470308icb.165.1300448519763;
        Fri, 18 Mar 2011 04:41:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.206.4])
        by mx.google.com with ESMTPS id 8sm1405261iba.21.2011.03.18.04.41.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 04:41:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 18 Mar 2011 18:39:42 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300448369-5896-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169312>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  On Fri, Mar 18, 2011 at 5:34 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
  > It was pointed out elsewhere [1] that PATH_MAX only specifies max
  > length of a path element, not full path. I think we'd need to stay
  > away from preallocated PATH_MAX-sized arrays.
  >
  > [1] http://mid.gmane.org/AANLkTikXvx7-Q8B_dqG5mMHGK_Rw-dFaeQdXi0zW9=
8SD@mail.gmail.com
 =20
  Perhaps this as a start? I don't intend to kill all PATH_MAX by mysel=
f
  though until I finish all other topics I'm working on.

 setup.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 03cd84f..f7b3556 100644
--- a/setup.c
+++ b/setup.c
@@ -506,7 +506,8 @@ static dev_t get_device_or_die(const char *path, co=
nst char *prefix)
 static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
-	static char cwd[PATH_MAX+1];
+	static struct strbuf sb_cwd =3D STRBUF_INIT;
+	char *cwd;
 	const char *gitdirenv, *ret;
 	char *gitfile;
 	int len, offset, ceil_offset;
@@ -521,9 +522,9 @@ static const char *setup_git_directory_gently_1(int=
 *nongit_ok)
 	if (nongit_ok)
 		*nongit_ok =3D 0;
=20
-	if (!getcwd(cwd, sizeof(cwd)-1))
-		die_errno("Unable to read current working directory");
-	offset =3D len =3D strlen(cwd);
+	xgetcwd(&sb_cwd);
+	offset =3D len =3D sb_cwd.len;
+	cwd =3D sb_cwd.buf;
=20
 	/*
 	 * If GIT_DIR is set explicitly, we're not going
--=20
1.7.4.74.g639db
