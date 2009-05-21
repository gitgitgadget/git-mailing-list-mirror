From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Terminate argv with NULL before calling setup_revisions()
Date: Thu, 21 May 2009 19:32:44 +1000
Message-ID: <1242898364-27391-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 21 11:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M74e7-0000h0-9W
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 11:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbZEUJcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 05:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZEUJcy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 05:32:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:42733 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZEUJcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 05:32:53 -0400
Received: by rv-out-0506.google.com with SMTP id f9so323056rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=51Jaghb/3o9IQSaxB6ixDFuUYfv2ZR2GZ1qFE+kgFKc=;
        b=pSSC+ya8IeBLaNrUwftpDaM/8MlSTZybg543jpeCgV4XslbLVibymgrQw9g94mLKLR
         8F+zMiuuZ296aTBXkBMw5xuZpTtBC5VTBU6sauvUXZ8Ei49kPSRJMJZGk7DAPUjzngIK
         tniGt7Yn645ChqZkpsNH09SxUACkVH9ntPgl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=qy63PIXzc6QIkTN+aUZ1pay4UeeGIhj8whvRvO+mGvdGUl71hHPhz9vSmGV93x/kup
         YnP6xs9bczAikMSTn8Ji9TcJ3mrgXDAsy8+Mb4bf6gmk7rGFTHW/vyP1LppmX3/pTf4R
         lE2VBLURJUdh4mcdTlTMcavQaYKUo0aDv9+iw=
Received: by 10.140.144.6 with SMTP id r6mr1024756rvd.185.1242898375350;
        Thu, 21 May 2009 02:32:55 -0700 (PDT)
Received: from dektop ([121.91.24.237])
        by mx.google.com with ESMTPS id f42sm6016502rvb.41.2009.05.21.02.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 02:32:54 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 21 May 2009 19:32:46 +1000
X-Mailer: git-send-email test
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119665>

It is convention that argv should be terminated with NULL, even if
argc is used to specify the size of argv. setup_revisions() requires
this and may segfault otherwise.

This patch makes sure that all argv (that I can find) is NULL terminate=
d.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bundle.c    |    2 +-
 http-push.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index d0dd818..e4b2aa9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -98,7 +98,7 @@ int verify_bundle(struct bundle_header *header, int v=
erbose)
 	 */
 	struct ref_list *p =3D &header->prerequisites;
 	struct rev_info revs;
-	const char *argv[] =3D {NULL, "--all"};
+	const char *argv[] =3D {NULL, "--all", NULL};
 	struct object_array refs;
 	struct commit *commit;
 	int i, ret =3D 0, req_nr;
diff --git a/http-push.c b/http-push.c
index 29e8ebf..dac2c6e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2326,7 +2326,7 @@ int main(int argc, char **argv)
 	new_refs =3D 0;
 	for (ref =3D remote_refs; ref; ref =3D ref->next) {
 		char old_hex[60], *new_hex;
-		const char *commit_argv[4];
+		const char *commit_argv[5];
 		int commit_argc;
 		char *new_sha1_hex, *old_sha1_hex;
=20
@@ -2406,6 +2406,7 @@ int main(int argc, char **argv)
 			commit_argv[3] =3D old_sha1_hex;
 			commit_argc++;
 		}
+		commit_argv[commit_argc] =3D NULL;
 		init_revisions(&revs, setup_git_directory());
 		setup_revisions(commit_argc, commit_argv, &revs, NULL);
 		revs.edge_hint =3D 0; /* just in case */
--=20
test
