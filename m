From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] t: mailmap: add simple name translation test
Date: Sat,  4 Feb 2012 21:50:24 +0200
Message-ID: <1328385024-6955-4-git-send-email-felipe.contreras@gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Jim Meyering" <jim@meyering.net>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 20:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtleO-0005Zw-NK
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab2BDTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 14:51:52 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:64663 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754508Ab2BDTva (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 14:51:30 -0500
Received: by lbom4 with SMTP id m4so754826lbo.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=j80qnn/T5AL01eEKeF3V943wrueaAfrjBVtuE3exr/U=;
        b=khjfJTFkfIIKSK0NKDUVmqm3tnI9xiSaA3LGSlb8mqaJaCxTxIBYzNYnO68Xpr1lrj
         sTIYQRvHr3Q5uDtM9vsifsAKtfMnkIz8VdJ4G6iKikaNo+600zR4E51GNBAwLgNO6t4Y
         oxf33xRKdJfB1GnS3pb74TbV/uWk6VZQJ9SX4=
Received: by 10.112.85.33 with SMTP id e1mr3070145lbz.45.1328385088716;
        Sat, 04 Feb 2012 11:51:28 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id pd3sm4215070lab.14.2012.02.04.11.51.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 11:51:28 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.g97f7d
In-Reply-To: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189899>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4203-mailmap.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index b1bc521..589e39e 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -157,6 +157,9 @@ A U Thor <author@example.com> (1):
 CTO <cto@company.xx> (1):
       seventh
 
+Mr. Right <right@company.xx> (1):
+      eight
+
 Other Author <other@author.xx> (2):
       third
       fourth
@@ -196,6 +199,11 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	test_tick &&
 	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
 
+	echo eight >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "Wrong <right@company.xx>" -m eight &&
+
 	mkdir -p internal_mailmap &&
 	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
 	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
@@ -204,6 +212,7 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	echo "Other Author <other@author.xx>         <nick2@company.xx>" >> internal_mailmap/.mailmap &&
 	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
 	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
+	echo "Mr. Right <right@company.xx>" >> internal_mailmap/.mailmap &&
 
 	git shortlog -e HEAD >actual &&
 	test_cmp expect actual
@@ -212,6 +221,9 @@ test_expect_success 'Shortlog output (complex mapping)' '
 
 # git log with --pretty format which uses the name and email mailmap placemarkers
 cat >expect <<\EOF
+Author Wrong <right@company.xx> maps to Mr. Right <right@company.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
 Author CTO <cto@coompany.xx> maps to CTO <cto@company.xx>
 Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
 
@@ -248,6 +260,7 @@ OBJID (Other Author DATE 4) four
 OBJID (Santa Claus  DATE 5) five
 OBJID (Santa Claus  DATE 6) six
 OBJID (CTO          DATE 7) seven
+OBJID (Mr. Right    DATE 8) eight
 EOF
 test_expect_success 'Blame output (complex mapping)' '
 	git blame one >actual &&
@@ -264,6 +277,7 @@ OBJID (<other@author.xx>          DATE 4) four
 OBJID (<santa.claus@northpole.xx> DATE 5) five
 OBJID (<santa.claus@northpole.xx> DATE 6) six
 OBJID (<cto@company.xx>           DATE 7) seven
+OBJID (<right@company.xx>         DATE 8) eight
 EOF
 test_expect_success 'Blame output (complex mapping)' '
 	git blame -e one >actual &&
-- 
1.7.9.1.g97f7d
