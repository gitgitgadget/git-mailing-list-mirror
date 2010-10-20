From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] setup_git_env: print the true $GIT_DIR for debugging
Date: Wed, 20 Oct 2010 10:11:57 +0700
Message-ID: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 05:12:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8P6F-0007Ib-JE
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 05:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416Ab0JTDMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 23:12:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50920 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074Ab0JTDMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 23:12:17 -0400
Received: by pxi16 with SMTP id 16so789834pxi.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MwOwO2fBTE9TCXLXfIzVlmxldNUgDwj9h5nJx0JnqK8=;
        b=xaLFFKdKs9j8gebgg0buyFBHWBZOj3jajPQdenKDJrdf0ZDneLvwIWOIvFQJOJZzOr
         eH7xPaIxuCdML1kArGkvZiAScT7LP1WB0fKTzIcSdJsDld8fhgdJuzG8pu/5KlsG6nAj
         ZR2O1qIfi41fvvPAnvStgaRUtCl4gjSNw4FXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MlA6iaSd+RE6Lzt8x+YAkv8jAdG1b9IrRnynGBZUVSqscZUEbj1IZqX2HqOjFcfN/N
         DJ6Fr5kp53WfjqoQ2UxgFoPyOrPjATLr1c9kINqyiH4zh/oIItkD5nY/BVDZNLk/fyLT
         ungaDLLwQcmdh6u9HEk2ahYpF0/j74EsYPVoo=
Received: by 10.142.165.21 with SMTP id n21mr5384725wfe.299.1287544336620;
        Tue, 19 Oct 2010 20:12:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id t38sm26354122wfc.21.2010.10.19.20.12.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 20:12:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Oct 2010 10:12:07 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159386>

Ideally, GIT_DIR_ENVIRONMENT should be set before setup_git_env() is
called and "setup: GIT_DIR defaults to .git" should never be printed
out. If it is printed, $GIT_DIR is set up automatically, unexpectedly,
elsewhere.

Checking for that line is a good way to know if setup code works
properly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Second try. Better tests.

 environment.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/environment.c b/environment.c
index de5581f..e34adc3 100644
--- a/environment.c
+++ b/environment.c
@@ -91,8 +91,12 @@ static void setup_git_env(void)
 		git_dir =3D read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 		git_dir =3D git_dir ? xstrdup(git_dir) : NULL;
 	}
-	if (!git_dir)
+	if (!git_dir) {
+		trace_printf("setup: GIT_DIR defaults to .git\n");
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+	}
+	else
+		trace_printf("setup: GIT_DIR set to %s\n", git_dir);
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
--=20
1.7.0.2.445.gcbdb3
