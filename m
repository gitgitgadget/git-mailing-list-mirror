From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 06/10] t7900: Test git branch -r/-a output w/remote-tracking branches in refs/peers/*
Date: Sat, 11 May 2013 18:21:16 +0200
Message-ID: <1368289280-30337-7-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYN-0007Zt-5T
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab3EKQVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:38 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:62503 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab3EKQVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:37 -0400
Received: by mail-wg0-f46.google.com with SMTP id n12so4863377wgh.25
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ITCINJTAGGvCjXgNHIfcoKW+tT4BIqLjsdlN8uAPJ+k=;
        b=FYztusPLEBOYeZPJluPQWPMx9P4C+HODbhc2Edyj3lovuxQNj4LOLRoI+7ALtQ05Ls
         sntt4ROOiNGXByxz5yKVp0lplIKMK5E6bX7xH0t44KOam0m5juRTc7lIjXz0rfALuNt3
         MNO/uBL8VyBeEjY+junJxBkUmYDO4APeEIIuAw+ZQpNJAlAPleVO/mGrEVJX3q4PKL7I
         DsFzwtF6v4vnJtRRbToInCYjkbpnRDNekvWyBI8KlnP+EKKXgYz/U+KcFEfp47Lb13EH
         r4EHBqAwrCaBgRiXt6N835x4/oTaRqK6K8noGtEOQUPZZT2vzKvU6zzec3sBCDNS+PU9
         lCXg==
X-Received: by 10.180.206.172 with SMTP id lp12mr9776448wic.11.1368289295858;
        Sat, 11 May 2013 09:21:35 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223985>

These tests will be made to pass by subsequent patches.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7900-working-with-namespaced-remote-refs.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
index 33266e0..279664c 100755
--- a/t/t7900-working-with-namespaced-remote-refs.sh
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -107,4 +107,25 @@ test_expect_success 'remote-tracking branches are shortened correctly' '
 	test_cmp expect actual
 '
 
+cat >expect.branch-r << EOF
+  origin/master
+  origin/other
+EOF
+
+test_expect_failure 'git branch -r should show remote-tracking branches' '
+	git branch -r >actual.branch-r &&
+	test_cmp expect.branch-r actual.branch-r
+'
+
+cat >expect.branch-a << EOF
+* master
+  peers/origin/heads/master
+  peers/origin/heads/other
+EOF
+
+test_expect_failure 'git branch -a should also show remote-tracking branches' '
+	git branch -a >actual.branch-a &&
+	test_cmp expect.branch-a actual.branch-a
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f
