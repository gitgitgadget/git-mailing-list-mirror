From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch: only print upstream relationship with -v -v
Date: Wed, 17 Mar 2010 22:05:44 +0700
Message-ID: <1268838344-8581-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 16:09:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrusD-0004X7-TX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391Ab0CQPJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 11:09:24 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:57746 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0CQPJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:09:23 -0400
Received: by pxi36 with SMTP id 36so608499pxi.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=IS4La1PMJcLRRVgty86Ue4LBk6QP8pG0Ore0FRxPWLQ=;
        b=YOekEfbpBjhdMIYgzRQxbSQnWFPA2ygCN3jP9WDdYtgPUM7R88IrzCGBiWTHKlBSbA
         RDZJ6Zf0dGsjspXNWRlK8tv/K1zdPyk3fu6SKIbqE8EKCoW+LWv752SMwC7LcEN1eLhr
         DPf63QivDYhYnrg6JJK81VXuhgQ0hRvXBGQ8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=cOHgS3FTyYNxE87Hl8YtNiIC+eqI2f+d5zz1oBnsmOEHm+6w2Rb14lf/C7eh+zhL4E
         e8YCjx94W5KUXvlMJk0GhflZnYSABtE2qlNa63y3OGTYsVF/d+sQDeMzUYuKZeZhLF4j
         zB4aHP0xi+7cAOchH9HN1oPxEMmAr7/1gUTpM=
Received: by 10.140.58.5 with SMTP id g5mr961664rva.130.1268838559343;
        Wed, 17 Mar 2010 08:09:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.229.137])
        by mx.google.com with ESMTPS id 20sm8240370pzk.7.2010.03.17.08.09.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 08:09:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 17 Mar 2010 22:05:46 +0700
X-Mailer: git-send-email 1.7.0.1.390.g67bca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142398>

"git branch -v" is unusable for me because it's too slow. After this
patch:

pclouds@do ~/w/git $ time ./git branch -v > /dev/null
real    0m0.016s
user    0m0.011s
sys     0m0.004s

pclouds@do ~/w/git $ time ./git branch -v -v > /dev/null
real    0m8.960s
user    0m8.854s
sys     0m0.029s

This is on a repository with ~30 branches, some are hundreds of
patches behind upstream.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Maybe it's just me, with my old branches...

 Documentation/git-branch.txt |    6 +++---
 builtin/branch.c             |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 903a690..4380846 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -101,9 +101,9 @@ OPTIONS
=20
 -v::
 --verbose::
-	Show sha1 and commit subject line for each head, along with
-	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well.
+	Show sha1 and commit subject line for each head. If given twice,
+	also the relationship to upstream branch (if any). If given
+	three times, print the name of the upstream branch, as well.
=20
 --abbrev=3D<length>::
 	Alter the sha1's minimum display length in the output listing.
diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..eb407f0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -439,8 +439,8 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 			sub =3D subject.buf;
 		}
=20
-		if (item->kind =3D=3D REF_LOCAL_BRANCH)
-			fill_tracking_info(&stat, item->name, verbose > 1);
+		if (item->kind =3D=3D REF_LOCAL_BRANCH && verbose > 1)
+			fill_tracking_info(&stat, item->name, verbose > 2);
=20
 		strbuf_addf(&out, " %s %s%s",
 			find_unique_abbrev(item->commit->object.sha1, abbrev),
--=20
1.7.0.1.390.g67bca
