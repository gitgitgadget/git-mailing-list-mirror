From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v2 2/3] t9903: add tests for bash.showUntrackedFiles
Date: Wed, 13 Feb 2013 12:01:59 +0100
Message-ID: <1360753321-5002-2-git-send-email-martinerikwerner@gmail.com>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 13 12:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5a78-0000eH-3g
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 12:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786Ab3BMLCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 06:02:34 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41716 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3BMLCd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 06:02:33 -0500
Received: by mail-lb0-f174.google.com with SMTP id l12so834200lbo.5
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=tYpG/1hsi9hkRWc5tB6j3zoJTbV/Z9QRU+yReUjJPUQ=;
        b=s94EK5lZcbNZQWFPbsMrEr/ho7Dj5BnS3tf3N6hNnOw/NqHd7Fv7AnGCT+OkQxAnjk
         gki7WNX4DvzZYv+p0Zs5ezoa6XJwXrIxpa1S+m5EAdxF+xC5sDcXQN332tKzsOgsyMCa
         KDEv3mf5/Y+27d5ui8LPpGzFcR5mOmzCSMQ3aMswtNIBb/JFk2nza60RmDvBJCLJ8A8K
         Q2a3r2lRb3qXc6hLRFW4WRs2gBTQX9/CWp4Qk5WcZP+fehPGfsODcfUwSBWg05hy58Y6
         /L8LdQbeakS0yPGYs6jAunHEMXrodVS0iKvdtxqBs5qBaEusac/kdQDICNRHOVERrmVB
         Po1Q==
X-Received: by 10.112.26.106 with SMTP id k10mr2233956lbg.5.1360753351841;
        Wed, 13 Feb 2013 03:02:31 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id go4sm15250092lbb.16.2013.02.13.03.02.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 03:02:30 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5a6Z-0001K5-Rs; Wed, 13 Feb 2013 12:02:23 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216247>

Add 4 test for the bash.showUntrackedFiles config option, covering all
combinations of the shell var being set/unset and the config option
being enabled/disabled.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t9903-bash-prompt.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f17c1f8..cb008e2 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -437,6 +437,46 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
+	printf " (master)" > expected &&
+	test_config bash.showUntrackedFiles false &&
+	(
+		unset -v GIT_PS1_SHOWUNTRACKEDFILES &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - untracked files status indicator - shell variable unset with config enabled' '
+	printf " (master)" > expected &&
+	test_config bash.showUntrackedFiles true &&
+	(
+		unset -v GIT_PS1_SHOWUNTRACKEDFILES &&
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
