From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] ls-tree: show size of trees with -l
Date: Sat, 14 Aug 2010 03:20:23 +0700
Message-ID: <1281730823-10797-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 14 11:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkD76-0001rp-HX
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 11:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933582Ab0HNJdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 05:33:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63578 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab0HNJdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 05:33:09 -0400
Received: by pxi10 with SMTP id 10so1119368pxi.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=32AIXNMb0VFiW/7bQlEnnDR8pzevDQmrL50YAwHu9Vo=;
        b=FWSbs8M18Y/NEPnxaYG2f+18zaFmMw9b7+Vt/3ZGSz5yXXYlQ6/AdNY/HYJlV/OciE
         p3FS0Wphri30ACKHOOAoipI+Xqr+yUmuA3xJPxJ63zElmn8kGJM/n76WJ4t0Fnb5D1M6
         7DcdzgZvgKuvW377q3sRGG0WYfrpOQKZWaUio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=hM4UzRQWxpvMnPU2Ax3WGA4JxZCHtaHNa7Mc/NTQZHaDUIMrxqMc8dHM0NQw4HrW+Y
         1r5zRQRJrsZewnEHPIrsoYx2raPgpR4fjoMlfUmBFJKMJYlnpb/g88jX9NTxz0FfYjDZ
         dyu9zsKE4b4CtMtDw8fxYu9paKzkigKUN3osY=
Received: by 10.143.18.20 with SMTP id v20mr1522120wfi.12.1281778388959;
        Sat, 14 Aug 2010 02:33:08 -0700 (PDT)
Received: from dektop ([119.12.209.140])
        by mx.google.com with ESMTPS id v13sm2115290wfv.5.2010.08.14.02.33.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 02:33:07 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 14 Aug 2010 03:20:24 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153549>

In commit a5bbda8 (Add an option to git-ls-tree to display also the
size of blob), Jakub said that size of non-blob entries had no
meaning therefore dashes were printed instead.

I would say tree size, along with blob size, helps estimate bandwidth
needed to transfer a single commit, for example. Of course it's not
completely accurate as all objects will be compressed. But it gives a
rough figure to compare.

Pack v4 has not come yet (and it's been three years, I truely hope it
will come next year). When it comes, I will gladly send a revert patch
of this one if it proves too expensive to compute tree size.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 By the way, dashes will still be printed for subprojects, I guess.

 Documentation/git-ls-tree.txt |    2 +-
 builtin/ls-tree.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.=
txt
index 1f89d36..9e02905 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -50,7 +50,7 @@ OPTIONS
=20
 -l::
 --long::
-	Show object size of blob (file) entries.
+	Show object size of entries.
=20
 -z::
 	\0 line termination on output.
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index dc86b0d..7df87ec 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -93,7 +93,7 @@ static int show_tree(const unsigned char *sha1, const=
 char *base, int baselen,
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
 			char size_text[24];
-			if (!strcmp(type, blob_type)) {
+			if (!strcmp(type, blob_type) || !strcmp(type, tree_type)) {
 				unsigned long size;
 				if (sha1_object_info(sha1, &size) =3D=3D OBJ_BAD)
 					strcpy(size_text, "BAD");
--=20
1.7.1.rc1.69.g24c2f7
