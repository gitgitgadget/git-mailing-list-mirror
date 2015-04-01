From: Thomas Schneider <thosch97@gmail.com>
Subject: [PATCH] =?UTF-8?q?checkout:=20Say=20=E2=80=9Cit=E2=80=9D=20instea?= =?UTF-8?q?d=20of=20=E2=80=9Cthem=E2=80=9D=20for=20one=20commit?=
Date: Wed,  1 Apr 2015 19:38:00 +0200
Message-ID: <1427909880-9846-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schneider <thosch97@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 19:38:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdMar-0006CW-Re
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 19:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbbDARiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2015 13:38:12 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35618 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbDARiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 13:38:11 -0400
Received: by wgdm6 with SMTP id m6so61203275wgd.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=kya3EAMqpwmFJdmdjv0hdCFZIBp3+FSrSiyi4XjcdfA=;
        b=y1dxnEd8r3nUs36xM8ZmmKSLb0iICiiWbsdr5UTE37dP+SJeVNA1BdrUjPQHGELNHI
         /aEASegYJteUPmBpxJNMYFcVqnmESZ8ckTx9dm+aqHSIBjiVreN1n0w1XJtB1L12jJeE
         j4IL6HjEmpohpChsLais9tKszHE49SyMXJo1btV0SyAzVHs2hmj/X+n3IGreyLj0MtST
         0qYWN6IJwy4uqFmg5iEpk9XEgYJofPe/vdL/978HGE7OLW4F5A/SuTEYmxs/IUSAmAhm
         zEW3Obd98ht0qNAeOuL8s360MvZpEBPqsFMHjDZf19KEh2X0YckEfokKbJsFGsqDyoSg
         Bzvw==
X-Received: by 10.181.9.98 with SMTP id dr2mr16984982wid.62.1427909890564;
        Wed, 01 Apr 2015 10:38:10 -0700 (PDT)
Received: from tatooine.fritz.box (p4FEF96D6.dip0.t-ipconnect.de. [79.239.150.214])
        by mx.google.com with ESMTPSA id lx10sm3630620wjb.17.2015.04.01.10.38.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 10:38:09 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266614>

When detached and checking out a branch again, git checkout warns about
commit(s) that might get lost.  It used to say =E2=80=9CIf you want to =
keep them
[=E2=80=A6]=E2=80=9D even for only one commit.

Signed-off-by: Thomas Schneider <thosch97@gmail.com>
---
 builtin/checkout.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e141fc..4aad49a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -743,10 +743,17 @@ static void suggest_reattach(struct commit *commi=
t, struct rev_info *revs)
=20
 	if (advice_detached_head)
 		fprintf(stderr,
-			_(
+			Q_(
+			/* The singular version */
+			"If you want to keep it by creating a new branch, "
+			"this may be a good time\nto do so with:\n\n"
+			" git branch <new-branch-name> %s\n\n",
+			/* The plural version */
 			"If you want to keep them by creating a new branch, "
 			"this may be a good time\nto do so with:\n\n"
-			" git branch <new-branch-name> %s\n\n"),
+			" git branch <new-branch-name> %s\n\n",
+			/* Give ngettext() the count */
+			lost),
 			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 }
=20
--=20
2.1.0
