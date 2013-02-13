From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 2/3] t9903: add tests for bash.showUntrackedFiles
Date: Wed, 13 Feb 2013 21:58:18 +0100
Message-ID: <1360789100-26285-1-git-send-email-martinerikwerner@gmail.com>
References: <7vmwv854ji.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 13 21:59:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5jPv-0000nM-10
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934414Ab3BMU6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:58:35 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63314 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934131Ab3BMU6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:58:34 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so1276392lbb.36
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nv0Gis16ifkNZnENS+G/ajLIXqRyjiKRwrRUUaWllxo=;
        b=ZHFsXrChKqEynrCBBPPDaRY3F0PkVNEN984Z2LwEkGKDtKCsQfZSuo++xxek0MpUNJ
         guJxbXIzOkLwat4zbLTrqFmKEWv6QN52HIeeUOGWGbS94Q1tUpnYLA/+3pOkaU1R9n85
         QHhb3Kgc1mMsasn8Aw7Myy2oIWjDt0hEayVvPX/n8zWoUXZ9DXPcziiZuzrsRM/vt5j8
         S6ALjPylH1ropoxUhrcmZ5J9E7lJ0Tlpe5aIlC+gHAHRdOg9GdNaKXNlhs8rgFoh1zhS
         M03XmaWsmqPypsXMI2i0NKJ1b52sVvD36jWwuZawESM09QV0CQ1bHqYnjIylMxj7SC8B
         HLig==
X-Received: by 10.152.47.97 with SMTP id c1mr2630709lan.6.1360789112480;
        Wed, 13 Feb 2013 12:58:32 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id xw14sm10919981lab.6.2013.02.13.12.58.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 12:58:31 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5jPR-0006qW-8i; Wed, 13 Feb 2013 21:58:29 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <7vmwv854ji.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216287>

Add 4 test for the bash.showUntrackedFiles config option, the tests now
cover all combinations of the shell var being set/unset and the config
option being missing/enabled/disabled.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t9903-bash-prompt.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f17c1f8..dd9ac6a 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -437,6 +437,46 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
+	printf " (master)" > expected &&
+	test_config bash.showUntrackedFiles false &&
+	(
+		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - shell variable unset with config enabled' '
+	printf " (master)" > expected &&
+	test_config bash.showUntrackedFiles true &&
+	(
+		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - shell variable set with config disabled' '
+	printf " (master)" > expected &&
+	test_config bash.showUntrackedFiles false &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - shell variable set with config enabled' '
+	printf " (master %%)" > expected &&
+	test_config bash.showUntrackedFiles true &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - untracked files status indicator - not shown inside .git directory' '
 	printf " (GIT_DIR!)" > expected &&
 	(
-- 
1.7.10.4
