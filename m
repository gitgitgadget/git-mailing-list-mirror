From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 13/26] USE_PAGER should not be used without RUN_SETUP*
Date: Tue, 16 Feb 2010 23:05:04 +0700
Message-ID: <1266336317-607-14-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPzs-0008Ll-Jp
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032Ab0BPQJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:09:26 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365Ab0BPQJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:09:24 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OKRLfB+h6ndc8mAEActB/TcpaMXuWptBrNW1DkSJkBs=;
        b=o0qrtiFZnlB9t6rjchFYgsNzdn1BrliSjUvqYGbovvZhdzNCh/i7BaCGAeZAUomViD
         5f78EzGw0+Kf3IsoMJ3NA7Kfrd5DnSvHzR4XsJjg+WKSp3cSlPjcx5IQShluNvSkveLq
         ODSFqPlA1ohFbWYjOwWfBpFRbqVhE3q5T/HcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GJjcKx2VMj8hhHeiiOjadUrV6+kkS7Y2SNI6D/leMedX8Q/EfsM/Ie6b1w/D1levES
         nHiSGCkzbG8aQ+6f+4DW4PRX0Y79C3hVN+wUysAMRxm1q1BUlL5NnfQ8hyfeC5IEXLO3
         aUP4uJ46iIq6SGgamzgBDIO/znRmOnXb2tmhU=
Received: by 10.100.18.25 with SMTP id 25mr4611397anr.134.1266336564387;
        Tue, 16 Feb 2010 08:09:24 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 22sm2874671ywh.0.2010.02.16.08.09.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:09:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:41 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140111>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 3462b49..1d1ad1a 100644
--- a/git.c
+++ b/git.c
@@ -266,8 +266,11 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
-		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
+		if (use_pager =3D=3D -1 && p->option & USE_PAGER) {
+			if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) =3D=3D 0)
+				die("Internal error: USE_PAGER must be together with RUN_SETUP*");
 			use_pager =3D 1;
+		}
 	}
 	commit_pager_choice();
=20
--=20
1.7.0.195.g637a2
