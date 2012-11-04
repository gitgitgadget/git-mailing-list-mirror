From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 11/16] test-lib: avoid full path to store test results
Date: Sun,  4 Nov 2012 03:13:33 +0100
Message-ID: <1351995218-19889-12-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjf-0002j1-ID
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2KDCOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab2KDCOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:31 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=U9K3ZuzQYe7uX/964cvZ//YwFtFbdCJ6B804A+epHFg=;
        b=QD2BaOeTnfGYCl1AKLZY5YQo3EbjdKh0JQdWKOqqB+e5W4L9TcmrDMHYCOTBfXKbym
         NJIq+K7lXb6yeMG17ehcJcd2TcsidhgIcLzljbWDCXFp21IQUohC5b5XW2yC5x8N83Nk
         7YDlsyWXOYbLWLrIdUMNaAD5bF3D1Idsevo5LN76BzMBZF0hHzzZxHnR9nz0F94gTCJG
         1Q6tYHR9Q0MFVn2W5PmGcKwGs6E3PEyfhXYKMNrScoJ7fepsKYf2likT2vtM8QVeZ1tV
         jJ2FbBq48ICs6HhSpU92Ano/CmJ/PYtWs7LH5jrHuL4bmRQFTLC74JbVankBuXR/JBWV
         EtVw==
Received: by 10.204.150.141 with SMTP id y13mr1394125bkv.1.1351995270875;
        Sat, 03 Nov 2012 19:14:30 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id ht18sm7948427bkc.14.2012.11.03.19.14.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208999>

No reason to use the full path in case this is used externally.

Otherwise we might get errors such as:

./test-lib.sh: line 394: /home/bob/dev/git/t/test-results//home/bob/dev/git/contrib/remote-hg/test-2894.counts: No such file or directory

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 514282c..5a3d665 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -389,7 +389,8 @@ test_done () {
 	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
 		mkdir -p "$test_results_dir"
-		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
+		base=${0##*/}
+		test_results_path="$test_results_dir/${base%.sh}-$$.counts"
 
 		cat >>"$test_results_path" <<-EOF
 		total $test_count
-- 
1.8.0
