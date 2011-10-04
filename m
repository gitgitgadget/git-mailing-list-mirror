From: Phil Hord <phil.hord@gmail.com>
Subject: [PATCH 4/4] Add test showing git-fetch groks gitfiles
Date: Tue, 4 Oct 2011 16:09:23 -0400
Message-ID: <CABURp0qH37rH7kW7Po+azGQBZPfYHO3iPVJVhNZJr+k=TRN3yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBJF-0007x1-3q
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933617Ab1JDUJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:09:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58947 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403Ab1JDUJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:09:44 -0400
Received: by eya28 with SMTP id 28so861296eya.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WO1odBM2mG96SlkK2eiR6A/w6sjs9cG5UBA7Er4dpzk=;
        b=XAEYK9Awfmbc3+ilUc3Fi/zMFLyciJcQXsbfujxdICQHIDzuJMkrBqLBJmvXlc7nnA
         +9PQiExEFWk2N9ccrICJHM5ERokhV6cRhsV4bFpPXOy0hPUBMilGvnM+utnBG7ixmIz8
         HxKCWjcEVR/sGxhr4kYmk2msboNeeS6ysiUzU=
Received: by 10.216.138.221 with SMTP id a71mr2041386wej.102.1317758983095;
 Tue, 04 Oct 2011 13:09:43 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 13:09:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182796>

Add a test for two subtly different cases: 'git fetch path/.git'
and 'git fetch path' to confirm that transport recognizes both
paths as git repositories when using the gitfile mechanism.

Signed-off-by: Phil Hord <hordp@cisco.com>

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index e810314..87ee016 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -206,6 +206,20 @@ test_expect_success 'clone from .git file' '
 	git clone dst/.git dst2
 '

+test_expect_success 'fetch from .git gitfile' '
+	(
+		cd dst2 &&
+		git fetch ../dst/.git
+	)
+'
+
+test_expect_success 'fetch from gitfile parent' '
+	(
+		cd dst2 &&
+		git fetch ../dst
+	)
+'
+
 test_expect_success 'clone separate gitdir where target already exists' '
 	rm -rf dst &&
 	test_must_fail git clone --separate-git-dir realgitdir src dst
-- 
1.7.7.503.g26392.dirty
