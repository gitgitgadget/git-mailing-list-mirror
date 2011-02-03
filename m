From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Add case insensitive support in matching pathspec
Date: Thu,  3 Feb 2011 23:38:26 +0700
Message-ID: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 17:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl2Dw-0006Yy-9Q
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 17:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303Ab1BCQjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 11:39:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60549 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174Ab1BCQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 11:39:54 -0500
Received: by gyb11 with SMTP id 11so541869gyb.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=Vde0dgZTgYOmDryFN/D33/r20FceZVBJyUI+TxGWlQ4=;
        b=HRgBmw8uyENiwxPo7wH6xGw30Pjtku29uhFzgn3qbZdVXZJ3AQRm+EdEsSJGNxfhNv
         oSGePUi79oldbhth4NsrFnAqcZHA6qZBkE4fv6uzvx0WRhiOD5FD/YLehC6Mlpz7r8nF
         o1WRe1TCzRGd4UVMIBtq21CWOrbb78eQiz+zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=IBtO2sIUGWy+K/WXyJ97QUg0lzsLHOOvxREIoazUxdLOOX1stJdHFHvhhZF+oafpox
         UqC6nle5o3pRrd76gOOy+14S3OitwEbZSLGaYdHi+z3hNHTrkC6ZIGHpOIX7Ba1a2zDT
         fk+djfoT8iU9nroMb2qn5rj9Hi1YEq0lv9hc0=
Received: by 10.101.186.1 with SMTP id n1mr6800606anp.209.1296751193756;
        Thu, 03 Feb 2011 08:39:53 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.206.39])
        by mx.google.com with ESMTPS id z12sm1143464anp.39.2011.02.03.08.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 08:39:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 Feb 2011 23:38:27 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165982>

Commit 21444f1 (Add case insensitivity support when using git ls-files
- 2010-10-03) teaches match_pathspec() to ignore case when
core.ignorecase=3Dtrue.

match_pathspec_depth() is developed independently and does not have
this feature. Teach it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On top of nd/struct-pathspec, but requires jj/icase-directory. I can
 rebase the series on top of master if it causes too many conflicts.

 dir.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index b1407a5..2597f81 100644
--- a/dir.c
+++ b/dir.c
@@ -192,7 +192,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 	if (!*match)
 		return MATCHED_RECURSIVELY;
=20
-	if (matchlen <=3D namelen && !strncmp(match, name, matchlen)) {
+	if (matchlen <=3D namelen && !strncmp_icase(match, name, matchlen)) {
 		if (matchlen =3D=3D namelen)
 			return MATCHED_EXACTLY;
=20
@@ -200,7 +200,7 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
=20
-	if (item->has_wildcard && !fnmatch(match, name, 0))
+	if (item->has_wildcard && !fnmatch_icase(match, name, 0))
 		return MATCHED_FNMATCH;
=20
 	return 0;
--=20
1.7.2.2
