From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 11/26] Do not look for .git/info/exclude when gitdir is not set up
Date: Tue, 16 Feb 2010 23:05:02 +0700
Message-ID: <1266336317-607-12-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:10:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPzr-0008Ll-W2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029Ab0BPQJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:09:15 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933022Ab0BPQJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:09:10 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rU2eC7yGpaZpHDyhx+Ay+6zq0vKkn+T8EHCwwYfqLvA=;
        b=NwSChRHfaMM5FyRcUbjqkOZOVpnafxFVkieS12pPtOhDTLL9OfZS0nmyqUN3d4KPQK
         hBc5XS0iVM09MBZTwATBYz879+Ihcl0PZQAlpMk7MWWh/IvUzQeyFUGupKgjyOa2cqjl
         g0WKQRweNA60jv1Bqru8Whq2+hteUSySf4iZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qp2r9MyDcPJCXI5BeWlFqobRO+8ofgELdJjoxCHZ+Sja7N8JBrZkuOHdt0DpRKVBNn
         T7FNmaR6yKYLmnsaQeV3enUXM2l/KO6y+kqnRDNgziIQiJRKtd03qssrI0u/hwVrSROM
         he/IFhS0g88/WvAWpSHjQoe421Cqb4puZ/33Y=
Received: by 10.150.128.22 with SMTP id a22mr8177883ybd.304.1266336550437;
        Tue, 16 Feb 2010 08:09:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 6sm2829779ywd.37.2010.02.16.08.09.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:28 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140109>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 67c3af6..a8fcbce 100644
--- a/dir.c
+++ b/dir.c
@@ -1024,9 +1024,11 @@ void setup_standard_excludes(struct dir_struct *=
dir)
 	const char *path;
=20
 	dir->exclude_per_dir =3D ".gitignore";
-	path =3D git_path("info/exclude");
-	if (!access(path, R_OK))
-		add_excludes_from_file(dir, path);
+	if (!startup_info || startup_info->have_repository) {
+		path =3D git_path("info/exclude");
+		if (!access(path, R_OK))
+			add_excludes_from_file(dir, path);
+	}
 	if (excludes_file && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
--=20
1.7.0.195.g637a2
