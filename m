From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH] t3200-branch: test setting branch as own upstream
Date: Wed,  5 Mar 2014 16:31:55 +0900
Message-ID: <1394004715-18776-1-git-send-email-modocache@gmail.com>
References: <xmqqmwh5ikl0.fsf@gitster.dls.corp.google.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 08:32:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL6JJ-00041E-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 08:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbaCEHcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 02:32:08 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43098 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbaCEHcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 02:32:07 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so707941pbb.36
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 23:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j7JUPHBXMuaNSzEBU1hL/6ByhhpgyX5HJchMoOVurbw=;
        b=HZgujE78ArbSvE0UAWrdwvvVgd3dyzDeg3CHCO9Fe9XO85cptXuwA4E7lORytxky/T
         /LDcHqxcLufg9snvj+dQqdI+XBEBHiY0yz4xFGFK7qK67GIhlIMYqvEFXcmju+wAqOzR
         SLo5gm+iu30jT5UNxVbji0adceYtgerCdLSEVlPpSBJEINbFYXFMGvUKXJh+M9F0oB8a
         P02DCaL2IXelIrshvkYNfnQ4E7VKAsUhcMOli6I9Tw0Q/Lexjrz1SfH0SX432SSdyU62
         57ysDamFIJYTlTVdbm85RREYNFe2Zhq4jkZCxpEbjcfChz3Rt+QEITiSFarvo8j9/vFx
         no7Q==
X-Received: by 10.68.76.68 with SMTP id i4mr4835657pbw.73.1394004727110;
        Tue, 04 Mar 2014 23:32:07 -0800 (PST)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id om6sm4782456pbc.43.2014.03.04.23.32.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 23:32:06 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
In-Reply-To: <xmqqmwh5ikl0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243421>

No test asserts that "git branch -u refs/heads/my-branch my-branch"
emits a warning. Add a test that does so.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 t/t3200-branch.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..e6d4015 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -507,6 +507,16 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
+	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
+	cat >expected <<EOF &&
+warning: Not setting branch my13 as its own upstream.
+EOF
+	test_i18ncmp expected actual &&
+	test_must_fail git config branch.my13.remote &&
+	test_must_fail git config branch.my13.merge
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.8.3.4 (Apple Git-47)
