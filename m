From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 7/7] t5521: test --dry-run does not make any changes
Date: Sat,  2 May 2015 23:37:15 +0800
Message-ID: <1430581035-29464-8-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZUJ-0003EP-7s
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbbEBPhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:47 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34933 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbEBPhp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:45 -0400
Received: by pabtp1 with SMTP id tp1so119406386pab.2
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oWph2Y+Zeg6DT1IQxiN+Ck9QLqAQTJzARbQLglKJyp0=;
        b=CcsZGWxJjUYfZ0a0/+VJPTsKQQ+hNH0TJiZnxtEDhXrCYhD8gvYLlH8Exke4v9J38P
         ADw6+LoYbuDoEK5npD0Vp2xk+j/4xs3mOknuAHV9uDQZyaXTxJ+adhoZly2nOAFeoayO
         ul8yIqyn/Is55YkXisoihpEZ8MZNCnxug6U1ilhoIRZT4PtL5O4k3aKvB4HzLB5W90z2
         pGhxdQEm3/Kxgzou4oj9DaB4/y2dqkSroelILwnKFiut93/xTio2buvwkNwTWOg1FBLh
         wfVKT6FPW2zmW7r9H3/YgBwQ0Rx6Aingg5PF2rlkd1CbxSwDxJXHQAH5yCYltOTssJea
         +llw==
X-Received: by 10.66.160.71 with SMTP id xi7mr27256274pab.19.1430581064542;
        Sat, 02 May 2015 08:37:44 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268237>

Test that when --dry-run is provided to git-pull, it does not make any
changes, namely:

* --dry-run gets passed to git-fetch, so no FETCH_HEAD will be created
  and no refs will be fetched.

* The index and work tree will not be modified.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5521-pull-options.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 453aba5..7c4d624 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -117,4 +117,17 @@ test_expect_success 'git pull --all' '
 	)
 '
 
+test_expect_success 'git pull --dry-run' '
+	git init clonedry &&
+	test_when_finished "rm -rf clonedry" &&
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
