From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/9] rev-parse: prints --git-dir relative to user's cwd
Date: Mon,  1 Nov 2010 13:26:27 +0700
Message-ID: <1288592794-24221-2-git-send-email-pclouds@gmail.com>
References: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 07:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCnrO-0001mP-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 07:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab0KAG0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 02:26:47 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61059 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0KAG0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 02:26:46 -0400
Received: by ywc21 with SMTP id 21so583893ywc.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=U2U2CfZ7MHbTSeTdIeAYvOhJ9J4WDOd8vwXjUyH+JW4=;
        b=JNCvPKEOPe4XL3HixAUCuo8Vvx3qsa8rf76ZPUK1JtKIfLmQoms1SOUrzLrxrZ7JkW
         QrXj19wvyi9ALafLFXe4dCncSc64dfuQ6s1BpihwwCq6MPkvH38NspiDNq+i/oe0W6kh
         Rzl1NpFx79SnTIlaAeWyBVsnmGLLviBpnu/G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PuDp+5ihWRlQNeHh6AVT698OsCZJu0XtqNvHqn65+sQYqVuaHJz3Y2N8oi/dXda0PC
         khJeueavX7OgllCTvaH9fcPm7biZdRjGpwoKT6EbmIFHTz6y0dAeM6O1ESHcnmB+IwAV
         GmnscyO2beRBnr5tlJj1Dm7gqXizfDqdHaqGA=
Received: by 10.90.232.10 with SMTP id e10mr8308298agh.49.1288592805381;
        Sun, 31 Oct 2010 23:26:45 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id m27sm4942576yha.29.2010.10.31.23.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 23:26:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 01 Nov 2010 13:26:47 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160459>

git_dir variable in environment.c is relative to git's cwd, not user's
cwd. Convert the relative path (actualy by making it absolute path)
before printing out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Unchanged, except the commit message.

 builtin/rev-parse.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..65c287b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -647,7 +647,11 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 				static char cwd[PATH_MAX];
 				int len;
 				if (gitdir) {
-					puts(gitdir);
+					if (is_absolute_path(gitdir) || !prefix) {
+						puts(gitdir);
+						continue;
+					}
+					puts(make_absolute_path(gitdir));
 					continue;
 				}
 				if (!prefix) {
--=20
1.7.3.2.210.g045198
