From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 6/6] completion: simplify __gitcomp() test helper
Date: Sun, 18 Nov 2012 11:51:57 +0100
Message-ID: <1353235917-13059-7-git-send-email-felipe.contreras@gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2Ug-000555-Af
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab2KRKwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 05:52:39 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab2KRKwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:39 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YSHdAg7CpNiiA0nEExrHCHsPcCpQiYp74yYKK/GHyz0=;
        b=S5HNSFx5X9chxzRNdGLnkdgz44s3BdqHnS1mzL981kox1h9dNCuY8E2yaLQlzkrQ7G
         k0XkaRABiiH564dzPh82yVljOwDLrYJp3ICYTpJR0GUNgCVnzactoGukWKZ21m8WCByI
         ypXn3Sc/BrUalTu8BuyTGxBEIehs198ezSRZol3//4VrJGcTHNOzvLlRTtl1Rt9s+vQu
         Z4Ls06LpFJ24/N6Bo/wpQangcL+Jbm3dKww+O8XsUzFmuftky73JX99l+QaEhqKtUlKj
         Sxh2tHeDibVyRZ81lo6JQGY5ryBdyfzQ8zsxLPNAy9DIF6S0BpU05JTWhZujQiyzAXW6
         0LWg==
Received: by 10.204.5.211 with SMTP id 19mr427369bkw.42.1353235958292;
        Sun, 18 Nov 2012 02:52:38 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id q22sm876174bkv.16.2012.11.18.02.52.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:37 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210011>

By using print_comp as suggested by SZEDER G=C3=A1bor.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index fba632f..42db3da 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -69,23 +69,18 @@ test_completion ()
 	test_cmp expected out
 }
=20
-newline=3D$'\n'
-
 # Test __gitcomp
 # Arguments are:
 # 1: current word (cur)
 # -: the rest are passed to __gitcomp
 test_gitcomp ()
 {
+	local -a COMPREPLY &&
 	sed -e 's/Z$//' > expected &&
-	(
-		local -a COMPREPLY &&
-		cur=3D"$1" &&
-		shift &&
-		__gitcomp "$@" &&
-		IFS=3D"$newline" &&
-		echo "${COMPREPLY[*]}" > out
-	) &&
+	cur=3D"$1" &&
+	shift &&
+	__gitcomp "$@" &&
+	print_comp &&
 	test_cmp expected out
 }
=20
--=20
1.8.0
