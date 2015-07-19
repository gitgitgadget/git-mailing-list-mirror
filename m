From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 01/12] t4150: am.messageid really adds the message id
Date: Sun, 19 Jul 2015 23:49:07 +0800
Message-ID: <1437320958-11192-2-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqR-0005a9-To
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbbGSPtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:32 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36739 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbGSPtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:31 -0400
Received: by pdjr16 with SMTP id r16so91177621pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1a/fQ9mptsNzvwH0BiFyl/excY7482iYu5xMmz+C8I=;
        b=xoJReLXj8yK6C9kzHrF1nkpQNLXZ5bFpn+TfjwR9gH08hKTkveeTwdWjjjVeRNgV52
         R5RqwXKl31V3oXp1yK/Oca+6VzeZiNYGlKkrTqGe9DAo9uHLzxApAOcu6JfxXxMYDXco
         9MUI/HMGxNY7d3S06kxZa+GJFnezCgxJPkxeZBiQxdBxkSZ+AEEVvW/e+FbnYRxbD5/o
         BVqDuVGITxMbaVCU9Twbj4/xuVXE6BGniaOFzvSMVwyuiAZIpk7hoSnMWr4y4U+VQotQ
         JLxMjU4gS0zaLKmu0Ny+C5SPHnkk8Iu4cH3+2YbV5A1/aYaRTQ7m8RL343fLIUWspOxs
         NALA==
X-Received: by 10.70.88.2 with SMTP id bc2mr49174914pdb.153.1437320970609;
        Sun, 19 Jul 2015 08:49:30 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274214>

Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
the am.messageid setting determines whether the --message-id option is
set by default.

Add a test for this.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index b822a39..264f53f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -563,6 +563,18 @@ test_expect_success 'am --message-id really adds the message id' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am.messageid really adds the message id' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout HEAD^ &&
+	test_config am.messageid true &&
+	git am patch1.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git cat-file commit HEAD | tail -n1 >actual &&
+	grep Message-Id patch1.eml >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'am --message-id -s signs off after the message id' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc2.110.gf2a5fc6
