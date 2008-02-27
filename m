From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 5/9] http-push: Avoid calling setup_git_directory() twice
Date: Wed, 27 Feb 2008 23:39:18 +0700
Message-ID: <20080227163918.GA28071@laptop>
References: <cover.1204130175.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 17:40:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUPKh-0001zI-BZ
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 17:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbYB0QjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYB0QjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 11:39:25 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:56726 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYB0QjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 11:39:24 -0500
Received: by an-out-0708.google.com with SMTP id d31so645074and.103
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 08:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        bh=FqzkQt1/ZHdbaYsBcThWJPYJ6QJl0B2qxWQRAVR30YU=;
        b=gkRQyifxlgG6RW4x5H7GNMf/WBsRLGP36SAsf4Q12Yy2e2F3HauKvB7P3Ny5Tby47G7Em9jdRdmznEoxI2817xj0dkzL4frughdUW5g2u2eWZYacJNtdG8oZPf0uFY6XR8RRcE+ILyaA4f/KtR8hpOrcJkvWkh3aEzomZ8A6nUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=HBuIDbs9xbwV3vnSrTB9ngarFSqTJBSs13ttjlc7boKtBmfhHbaPjbnjx959t6V7p2am1d8f29UNE2hUbCPA/IcxLRtvPo/0hYMUpIiS0J1XypBOq+GisQRPAZ8khENDTrBAGe/gWW9OUaI5aOehhjvX67SC0Tn2HHYqtuVi5nU=
Received: by 10.100.41.16 with SMTP id o16mr12611057ano.90.1204130363779;
        Wed, 27 Feb 2008 08:39:23 -0800 (PST)
Received: from pclouds@gmail.com ( [117.5.1.231])
        by mx.google.com with ESMTPS id b29sm13120326ana.19.2008.02.27.08.39.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Feb 2008 08:39:22 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Feb 2008 23:39:18 +0700
Content-Disposition: inline
In-Reply-To: <cover.1204130175.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75237>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 http-push.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 406270f..1dd78e8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2173,7 +2173,7 @@ int main(int argc, char **argv)
 	struct ref *ref;
 	char *rewritten_url =3D NULL;
=20
-	setup_git_directory();
+	const char *prefix =3D setup_git_directory();
=20
 	remote =3D xcalloc(sizeof(*remote), 1);
=20
@@ -2375,7 +2375,7 @@ int main(int argc, char **argv)
 			commit_argv[3] =3D old_sha1_hex;
 			commit_argc++;
 		}
-		init_revisions(&revs, setup_git_directory());
+		init_revisions(&revs, prefix);
 		setup_revisions(commit_argc, commit_argv, &revs, NULL);
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
--=20
1.5.4.2.281.g28d0e
