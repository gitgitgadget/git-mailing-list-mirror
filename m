From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Mon, 15 Dec 2014 11:56:08 -0800
Message-ID: <1418673368-20785-6-git-send-email-sbeller@google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
Cc: mhagger@alum.mit.edu, jrnieder@gmail.com, gitster@pobox.com,
	ronniesahlberg@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0bkv-00021J-Jp
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 20:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaLOT4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 14:56:30 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39151 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbaLOT40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 14:56:26 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so11455600ieb.40
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Fc/qdyhxBRNm1AZhiyFHuwNYyGkLV/k6WEKfhRaLuM=;
        b=kqFr5VQcFUIPCCkgDI6+o3oIwL32z6idbPsJxeCQfGqGAD1w/zqRPQuXk62OPKW2qK
         rqJtDHHy5NZFwnMkl2icJlBB32Akaei2WNR6KiFFwxLsLdlPN05vTSwSScdc1KWN90gi
         xOTB8dVTVREitUOgE+JBtNVf3AgkkvRkR4ZaQuTp11GF9IW6xHTO2OkyOdogJtI2zGzP
         t0gz6bLA2QZEZUrmorfmqWZurDuCpYYQtLSfrTpOgc9RfNEL0cp5AoGmp5wdECBtIvRP
         ZDRhcDrctYsdzXhjjsEocgqVVU9VretzCWyt8T6rB+KpX03LJAxkjTdghx949gkOKO+F
         2BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Fc/qdyhxBRNm1AZhiyFHuwNYyGkLV/k6WEKfhRaLuM=;
        b=Z7xGDB+2SIH0z32dY/j50Gd+0XEKjBhyjjfRzJtgq0/502DmIDyMk/P2K3+ypBupHn
         PUSf7Tn043yEWpzcEbgs8P9MKkPrVxWWzw9InqCxqTX+vRRXGgMWBnYtYdEyMlk2qodX
         1FwqwUpdBUQtDKJVh6waXf0AySQsjWxJ+YzJswMUaX52nCKE65U1Nq4NQS99dzpz8I6k
         IAk4PXfH5GMMGgg6tyHVFUazM1AmxqRWCBsHOhCJH8N/aApQHZe/G0MXM0bk9xNXquaS
         WM+pO5yBI/CojTvNt8cfA/8lxFkVzAlRlMIvBcgixEfT8ox9RzR+PqpYerJl8GMEK5LU
         iwHg==
X-Gm-Message-State: ALoCoQlbX6FLpvlMz/0T6tf0ep4b2VKCe8J/gsnfzl67UqWxlXy+ko16ZdAP0nyE5k3Mp26UOblK
X-Received: by 10.50.114.69 with SMTP id je5mr19399414igb.24.1418673385528;
        Mon, 15 Dec 2014 11:56:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ccd:69a0:9bbf:bab9])
        by mx.google.com with ESMTPSA id sd6sm5341811igb.4.2014.12.15.11.56.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 11:56:25 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc2219e3.dirty
In-Reply-To: <1418673368-20785-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261414>

This adds tests for the atomic push option.
The first four tests check if the atomic option works in
good conditions and the last three patches check if the atomic
option prevents any change to be pushed if just one ref cannot
be updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Originally Ronnie had a similar patch prepared. But as I added
    more tests and cleaned up the existing tests (e.g. use test_commit
    instead of "echo one >file && gitadd file && git commit -a -m 'one'",
    removal of dead code), the file has changed so much that I'd rather
    take ownership.

 t/t5543-atomic-push.sh | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..6cbedc5
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,185 @@
+#!/bin/sh
+
+test_description='pushing to a repository using the atomic push option'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+mk_repo_pair () {
+	rm -rf workbench upstream thirdparty &&
+	mkdir upstream &&
+	(
+		cd upstream &&
+		git init --bare #&&
+		#git config receive.denyCurrentBranch warn
+	) &&
+	mkdir workbench &&
+	(
+		cd workbench &&
+		git init &&
+		git remote add up ../upstream
+	)
+}
+
+test_push_failed () {
+	workbench_master=$(cd workbench && git show-ref -s --verify refs/heads/master) &&
+	upstream_master=$(cd upstream && git show-ref -s --verify refs/heads/master) &&
+	test "$workbench_master" != "$upstream_master" &&
+
+	workbench_second=$(cd workbench && git show-ref -s --verify refs/heads/second) &&
+	upstream_second=$(cd upstream && git show-ref -s --verify refs/heads/second) &&
+	test "$workbench_second" != "$upstream_second"
+}
+
+test_push_succeeded () {
+	workbench_master=$(cd workbench && git show-ref -s --verify refs/heads/master) &&
+	upstream_master=$(cd upstream && git show-ref -s --verify refs/heads/master) &&
+	test "$workbench_master" = "$upstream_master"
+
+	workbench_second=$(cd workbench && git show-ref -s --verify refs/heads/second) &&
+	upstream_second=$(cd upstream && git show-ref -s --verify refs/heads/second) &&
+	test "$workbench_second" = "$upstream_second"
+}
+
+test_expect_success 'atomic push works for a single branch' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git push --atomic-push --mirror up
+	) &&
+	workbench_master=$(cd workbench && git show-ref -s --verify refs/heads/master) &&
+	upstream_master=$(cd upstream && git show-ref -s --verify refs/heads/master) &&
+	test "$workbench_master" = "$upstream_master"
+'
+
+test_expect_success 'atomic push works for two branches' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git branch second &&
+		git push --mirror up &&
+		test_commit two &&
+		git checkout second &&
+		test_commit three &&
+		git push --atomic-push --mirror up
+	) &&
+	test_push_succeeded
+'
+
+test_expect_success 'atomic push works in combination with --mirror' '
+	mk_repo_pair &&
+	ls workbench &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second &&
+		test_commit two &&
+		git push --atomic-push --mirror up
+	) &&
+	test_push_succeeded
+'
+
+test_expect_success 'atomic push works in combination with --force' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second &&
+		test_commit two &&
+		test_commit three &&
+		test_commit four &&
+		git push --mirror up &&
+		git reset --hard HEAD^ &&
+		git push --force --atomic-push up master second
+	) &&
+	test_push_succeeded
+'
+
+# set up two branches where master can be pushed but second can not
+# (non-fast-forward). Since second can not be pushed the whole operation
+# will fail and leave master untouched.
+test_expect_success 'atomic push fails if one branch fails locally' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second master &&
+		test_commit two &&
+		test_commit three &&
+		test_commit four &&
+		git push --mirror up
+		git reset --hard HEAD~2 &&
+		git checkout master &&
+		test_commit five &&
+		! git push --atomic-push --all up
+	) &&
+	test_push_failed
+'
+
+test_expect_success 'atomic push fails if one branch fails remotely' '
+	# prepare the repo
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second master &&
+		test_commit two &&
+		git push --mirror up
+	) &&
+	# a third party modifies the server side:
+	(
+		git clone upstream thirdparty &&
+		cd thirdparty
+		git checkout second
+		test_commit unrelated_changes &&
+		git push origin second
+	) &&
+	# see if we can now push both branches.
+	(
+		cd workbench &&
+		git checkout master &&
+		test_commit three &&
+		git checkout second &&
+		test_commit four &&
+		! git push --atomic-push up master second
+	) &&
+	test_push_failed
+'
+
+test_expect_success 'atomic push fails if one tag fails remotely' '
+	# prepare the repo
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second master &&
+		test_commit two &&
+		git push --mirror up
+	) &&
+	# a third party modifies the server side:
+	(
+		git clone upstream thirdparty &&
+		cd thirdparty
+		git checkout second
+		git tag test_tag &&
+		git push --tags origin second
+	) &&
+	# see if we can now push both branches.
+	(
+		cd workbench &&
+		git checkout master &&
+		test_commit three &&
+		git checkout second &&
+		test_commit four &&
+		git tag test_tag &&
+		! git push --tags --atomic-push up master second
+	) &&
+	test_push_failed
+'
+
+test_done
-- 
2.2.0.33.gc2219e3.dirty
