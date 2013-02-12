From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH 2/2] t9903: add test case for bash.showUntrackedFiles
Date: Tue, 12 Feb 2013 21:12:16 +0100
Message-ID: <1360699936-28688-3-git-send-email-martinerikwerner@gmail.com>
References: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
Cc: trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 21:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MES-0007qI-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab3BLUNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:13:12 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:45227 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3BLUNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:13:11 -0500
Received: by mail-lb0-f176.google.com with SMTP id s4so401901lbc.21
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 12:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iuWebUYbDKjWnV2yfSrXPb+s1fOQf0bZ8LLQeNs5spA=;
        b=uEzXIEbHZj3zVdrEm/2UI+of4morAkV8sAbRuh/eGLexnDS4oYlNmaKGhKlL9++9LM
         0zsizNAZgOuxQn9/AuIy+vETW88mmHJQ84vXpuC97PY6KuOIClZAyDYbTZ2eZcpYHOTF
         sHjv8HE2fvO2ar7MnfUYb23LrA9kNLJtd1SqPkQ3pFopRw1r2i3ZtdGSJIvPXG9ba/pg
         igBH0tnl/wno50xfwCEfsFhr/qkQtn+iIL81VYN17sD9L9tjsVI2rN3AdjWSZrQOBe70
         70fungjACAj9/wFTVlOnNL7TSTcEJNnX6oCcW10fZiGaeMn3+HC/ZoegsNe5EltpTvx2
         +7Ww==
X-Received: by 10.112.25.106 with SMTP id b10mr7697301lbg.68.1360699989535;
        Tue, 12 Feb 2013 12:13:09 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id er8sm14617421lbb.9.2013.02.12.12.13.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 12:13:08 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5MDy-0007V1-17; Tue, 12 Feb 2013 21:13:06 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216185>

Add a test case for the bash.showUntrackedFiles config option, which
checks that the config option can disable the global effect of the
GIT_PS1_SHOWUNTRACKEDFILES environmant variable.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t9903-bash-prompt.sh |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f17c1f8..c9417b9 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -447,6 +447,17 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
 	test_cmp expected "$actual"
 '
 
+test_expect_success 'prompt - untracked files status indicator - disabled by config' '
+	printf " (master)" > expected &&
+	echo "untracked" > file_untracked &&
+	test_config bash.showUntrackedFiles false &&
+	(
+		GIT_PS1_SHOWUNTRACKEDFILES=y &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success 'prompt - format string starting with dash' '
 	printf -- "-master" > expected &&
 	__git_ps1 "-%s" > "$actual" &&
-- 
1.7.10.4
