From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 5/7] t5520: test --rebase with multiple branches
Date: Sat,  2 May 2015 23:37:13 +0800
Message-ID: <1430581035-29464-6-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZUB-00037G-Mb
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbbEBPhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:41 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34854 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbEBPhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:39 -0400
Received: by pabtp1 with SMTP id tp1so119404882pab.2
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBF4QPcoWNuk11meipdE7dsx9tkC8ayetSMp4vEO0f4=;
        b=Xk86Pp/ccku7oK2C81Apbqs2US17+5gu/oeaNDapW0SBwyV0UIAEZtVrbh4TPKjrKV
         4Xkugr8ILa5blezqYUTpoK74gvi68tbaC/7O2Fq+bRfz9HMUAtyx72M470qkZ6oF7w8C
         FxhhmjxgCNFB2HRd/gIQJFlDrf3CbXVOXlvUz/ffpusw+8xINHrsWg3BUSNYO/SJiL5/
         Oem55FAT6cGXoRRrkVkOtINIfGF44MuqzYV0kBz2haWiRrH7VYVg1pYMIXLvY7onBFul
         SNCNotQd6gO5OIDQQIIpKsi8u5jvGdMgO33B9ah3aleWz9DNVGvcW2OI+inG9vYCdi14
         iNDg==
X-Received: by 10.66.139.234 with SMTP id rb10mr21682428pab.153.1430581058874;
        Sat, 02 May 2015 08:37:38 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268233>

Since rebasing on top of multiple upstream branches does not make sense,
since commit 51b2ead0 ("disallow providing multiple upstream branches
to rebase, pull --rebase"), git-pull explicitly disallowed specifying
multiple branches in the rebase case.

Implement tests to ensure that git-pull fails and prints out the
user-friendly error message in such a case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t5520-pull.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 25d519d..17c63ff 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -223,6 +223,14 @@ test_expect_success '--rebase' '
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
 '
+
+test_expect_success '--rebase fails with multiple branches' '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase . copy master 2>out &&
+	test_when_finished "rm -f out" &&
+	test_i18ngrep "Cannot rebase onto multiple branches" out
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.1.4
