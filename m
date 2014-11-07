From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 5/7] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Fri,  7 Nov 2014 11:41:59 -0800
Message-ID: <1415389321-10386-6-git-send-email-sahlberg@google.com>
References: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:42:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpQX-0007IV-N7
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbaKGTmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:42:13 -0500
Received: from mail-qc0-f201.google.com ([209.85.216.201]:54225 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaKGTmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:42:06 -0500
Received: by mail-qc0-f201.google.com with SMTP id l6so278905qcy.0
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZND2vS7YeWX2SD4Oyz5sS+i4iKJsGJ6fmlAEf5M+tpU=;
        b=OZlFazEj+lx8baYDypGJRYkQ+7snAsuuBfS1GrOd/ng5UTAhM3pzotiHXhrPdu0zzs
         /PBMxhHsm+OMg3e7lL18tiHYds6k2HAXVBRkDZnLHwbnKh/SFiPkrbSLAz6KsTBs+hSl
         OuQY9kJooQkUQsVfGXkAeCTIGgY6sgczEopFiB8/Sk09YrW7ZLPZdSH17NiE2BXJjo/e
         CTfHdVnHaLdpuPCsHCSSlfD68naLRRNNC53i9nQf0ziiYiLz7LZE4Px73KL0PZZk0VBO
         bOyvLL3sSsd6NX7m/glrmp+/8iGJ+yGgYnkXOXynKZiFVLDm/6IKYXG99kieb04yhrWS
         2/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZND2vS7YeWX2SD4Oyz5sS+i4iKJsGJ6fmlAEf5M+tpU=;
        b=LXLSPpQeS8j+31/Lae9Z2CvdVe/ffhHamvPneJWq/a/ZM0KtvHs7PXLue1BGadpvzI
         J5Kec0m9z5YfHOPGdu12XHB76XBOG71o1MrDRrUK6wzN+u4Ue7ZnI4nN7pQv1LFKrnm9
         McIOhTMVv53PDmhblEZZFGu9zRZoz9/uRmUb9DcRkI+54D80Z7pMLZNRSwSSn2KghA3f
         G2jZcgrUZJ/3/lVN/YmfMBDBZtdkgUuHklDZSaTLg4KRu0hxHxjsnnCaWfXP0Xu/QUF1
         aQjtNGlt+5+hqI5MATqfCbKEai6VA1FWuVOS3B5H8ws/uZssml1lCwYj6zjsVhGk3PBl
         1eJg==
X-Gm-Message-State: ALoCoQl6euQeEztz3JzbLMgk90QkdKtJJYpMmMbKrRCbCnfhw7QTzZpiCNT0uubDCotUgfRJP5s3
X-Received: by 10.236.203.200 with SMTP id f48mr10347974yho.14.1415389324622;
        Fri, 07 Nov 2014 11:42:04 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id k66si400865yho.7.2014.11.07.11.42.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:42:04 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id psTDqlkw.1; Fri, 07 Nov 2014 11:42:04 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CBE44E08CB; Fri,  7 Nov 2014 11:42:03 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389321-10386-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 t/t5543-atomic-push.sh | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..4903227
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='pushing to a mirror repository'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+invert () {
+	if "$@"; then
+		return 1
+	else
+		return 0
+	fi
+}
+
+mk_repo_pair () {
+	rm -rf master mirror &&
+	mkdir mirror &&
+	(
+		cd mirror &&
+		git init &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	mkdir master &&
+	(
+		cd master &&
+		git init &&
+		git remote add $1 up ../mirror
+	)
+}
+
+
+test_expect_success 'atomic push works for a single branch' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git push --mirror up
+		echo two >foo && git add foo && git commit -m two &&
+		git push --atomic-push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+'
+
+test_expect_success 'atomic push works for two branches' '
+
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git push --mirror up
+		echo two >foo && git add foo && git commit -m two &&
+		git checkout second &&
+		echo three >foo && git add foo && git commit -m three &&
+		git checkout master &&
+		git push --atomic-push --mirror up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" = "$mirror_master"
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" = "$mirror_second"
+'
+
+# set up two branches where master can be pushed but second can not
+# (non-fast-forward). Since second can not be pushed the whole operation
+# will fail and leave master untouched.
+test_expect_success 'atomic push fails if one branch fails' '
+	mk_repo_pair &&
+	(
+		cd master &&
+		echo one >foo && git add foo && git commit -m one &&
+		git branch second &&
+		git checkout second &&
+		echo two >foo && git add foo && git commit -m two &&
+		echo three >foo && git add foo && git commit -m three &&
+		echo four >foo && git add foo && git commit -m four &&
+		git push --mirror up
+		git reset --hard HEAD~2 &&
+		git checkout master
+		echo five >foo && git add foo && git commit -m five &&
+		! git push --atomic-push --all up
+	) &&
+	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
+	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
+	test "$master_master" != "$mirror_master" &&
+
+	master_second=$(cd master && git show-ref -s --verify refs/heads/second) &&
+	mirror_second=$(cd mirror && git show-ref -s --verify refs/heads/second) &&
+	test "$master_second" != "$mirror_second"
+'
+
+test_done
-- 
2.1.0.rc2.206.gedb03e5
