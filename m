From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH] commit --amend: test specifies authorship but forgets to check
Date: Wed, 30 Jul 2014 11:45:11 +0200
Message-ID: <0ba2fcaf784bb74ee5a9f8d13dce64ab09e66d7b.1406713446.git.bafain@gmail.com>
Cc: Erick Mattos <erick.mattos@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 11:45:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCQS9-0007Qj-WC
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 11:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbaG3Jpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 05:45:42 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39968 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaG3Jpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 05:45:41 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so7236790wiv.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TkH+5gKQczQs87cVIE3j89BPkErqfIlVD4DqjtAniLc=;
        b=GwytUDsqhcqjwbJ4GGyn8YubX3cWJr0iVaMLbVISbCt1I4SiZq/nq8/5tHU3vvFUrw
         KeQnYagj51IPbC00ilPO6KeGr1qWWyKNsnTMxVMa6mmKsDG9KnxvAtZWTqwNdHypmZta
         TC0vs5A6X6PiMfFEQVP2aaEaCy3WLGLK52kH1zTZzcayizqx9Slvu1giiu136GU9gFHK
         r/Mbx1X6nUxutYR309mUBT9WQi+rQmnJMnfPSg7yJ2B5qcJdavNV1BLuZSJXSBlgRH/2
         TgQlbzAvf5oGvPYm6h78LrJsiWx6/5Tz2y12FMn1Ee3qcyZOikXIUt1c2Cadjneos/Ly
         AUbQ==
X-Received: by 10.180.189.4 with SMTP id ge4mr4373822wic.25.1406713538528;
        Wed, 30 Jul 2014 02:45:38 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id ex4sm53537722wic.2.2014.07.30.02.45.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 02:45:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254482>

The test case "--amend option copies authorship" specifies that the
git-commit option `--amend` uses the authorship of the replaced
commit for the new commit. Add the omitted check that this property
actually holds.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
Without the check, the test case succeeds even with nonsense in the
`expected` file. An `--amend` implementation which simply uses the
committer name and date as if it was not amending would have been
deemed correct. This is not the case, the implementation still passes
the test suite after the correction.

Quickly skimming over the rest of the file, I couldn't find the same
thing twice.

 t/t7509-commit.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index b61fd3c..9ac7940 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -77,6 +77,7 @@ test_expect_success '--amend option copies authorship' '
 	git commit -a --amend -m "amend test" &&
 	author_header Initial >expect &&
 	author_header HEAD >actual &&
+	test_cmp expect actual &&
 
 	echo "amend test" >expect &&
 	message_body HEAD >actual &&
-- 
2.0.1
