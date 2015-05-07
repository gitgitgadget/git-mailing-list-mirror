From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 06/12] t5521: test --dry-run does not make any changes
Date: Thu,  7 May 2015 16:44:02 +0800
Message-ID: <1430988248-18285-7-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQA-0005Wv-6J
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbbEGIoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:38 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32970 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbEGIog (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:36 -0400
Received: by pdbnk13 with SMTP id nk13so35473210pdb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcIBsqkCehu0D+ceehQUGDZzVvRc6Ti47fec7u7qI5M=;
        b=lNNFJhA3uRmXt0uBQh6FVrwFsUbGrOBMWDAbEFNYXUBOtCudpcQ4iIY8HFWxlrcvQW
         qZpZ562gMuwoowcY5q/SpYWqHwxyfv/KhNxeBrySfw7j6rBtZamsoA0Bv7wmTph5qIpY
         ClfiwZCCMJInvc9knOKDWq5n9ALU4R+euSBdGTYXx9OEAerHiqi3o4FrnMuL1AQ8112K
         lsv/fTIK/UpupHxD8H5WzSQuhvvGvFZR6Na2UOgM436xnLnp2jiHTTMR/K+WPe2/ySw1
         P9Ki/lXA/z6HrLUrtG5ZZVUomZA0dU0Te+BIyy2J6QHIaw2MlpqSJ9s+P1UEunzCcEPf
         oyWA==
X-Received: by 10.66.120.237 with SMTP id lf13mr5050481pab.89.1430988275734;
        Thu, 07 May 2015 01:44:35 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268515>

Test that when --dry-run is provided to git-pull, it does not make any
changes, namely:

* --dry-run gets passed to git-fetch, so no FETCH_HEAD will be created
  and no refs will be fetched.

* The index and work tree will not be modified.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Moved test_when_finished to beginning of test

 t/t5521-pull-options.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 453aba5..21b1dbe 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -117,4 +117,17 @@ test_expect_success 'git pull --all' '
 	)
 '
 
+test_expect_success 'git pull --dry-run' '
+	test_when_finished "rm -rf clonedry" &&
+	git init clonedry &&
+	(
+		cd clonedry &&
+		git pull --dry-run "../parent" &&
+		test_path_is_missing .git/FETCH_HEAD &&
+		test_path_is_missing .git/refs/heads/master &&
+		test_path_is_missing .git/index &&
+		test_path_is_missing "file"
+	)
+'
+
 test_done
-- 
2.1.4
