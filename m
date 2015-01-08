From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 10/10] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Wed,  7 Jan 2015 19:23:24 -0800
Message-ID: <1420687404-13997-11-git-send-email-sbeller@google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 08 04:24:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y93ho-0008Lm-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 04:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbbAHDYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 22:24:01 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:58475 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787AbbAHDX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 22:23:58 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so901658igd.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 19:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XE5/tPeiMbGSZLrl4kswDv0TTcBB6sKYmcCK1tW3gpw=;
        b=QULM4m1PzMrv8YYuaPJ95C3ojl5i4w6D4dLK4bDY25aDX8vf9xU3/swuBVQfngj/jG
         qsdBZwora0/B/P4WE/B5YF2Cbr+u+gMUR4PFlB3tJsKcqX72SqsJ1qOmvhI4lmflLmdh
         j4M/IfBWA6TGdsW4jjZRhLTpRsjz4oGKZZoYnJhA9Z7O+nLbtAUZ/KjckUZjY0MzKGCm
         EjcfIEPAhH8YzS1wPArb9fzapKIifluCCvzgVYZNvKOKvOLzRDQhR7TCFWCAzbji3pqI
         rKCL5qpxqwdNhxpGgvvHI+G2AMBMIjjJk2oPnxECBTEO9iSLU83yyMac+zo28EqY0WZM
         UEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XE5/tPeiMbGSZLrl4kswDv0TTcBB6sKYmcCK1tW3gpw=;
        b=ip5PF7SZxWzCUnZVeHoPO/x8yduaqP+ApjKGJzORkP0YCy8B1iV8kbM5XnUOaE2HSY
         AjgIJPpTiE+Kl4t4YszVKgCgKQy1MP+9FshFRDyNc7jtQTc+41/bnUaeUqaBaRAHcFHn
         mcO7os6l3142HS8xGcDDJmRcPKlZDASq93eujbcOBCdfOYWPqALWOGUPA5U4Ujsk/7nV
         eOK85hVLXSzQJtwTMeUfF91qyoK/+TIlTYaGmm2ffjHUevFcz21w4dlnc6wIGQygeahA
         BndLEZlYeSLcPcyccxjC63pyaaPgWkTmxV91/MhC5kkisymxSfu7NUf43qIrsvKa5wM6
         8FGQ==
X-Gm-Message-State: ALoCoQmR7WOL/H8WEQNr876pqcWXkwxGW1uUIoTzbsI0+pcs+QCW3Zh0zd45sLTiUMDWcOVVTqlb
X-Received: by 10.50.36.103 with SMTP id p7mr25890887igj.20.1420687437581;
        Wed, 07 Jan 2015 19:23:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:948f:12c6:eb26:9b9c])
        by mx.google.com with ESMTPSA id qc7sm7464680igb.5.2015.01.07.19.23.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 19:23:56 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1420687404-13997-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262171>

This adds tests for the atomic push option.
The first four tests check if the atomic option works in
good conditions and the last three patches check if the atomic
option prevents any change to be pushed if just one ref cannot
be updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v10, v11, v12:
    * no changes
    
    v9:
     add test for 'atomic push is not advertised if configured'
     at the end.
    
    v7, v8: no changes
    
    v6:
    the same as v2, so I can resend the whole series as v6
    
    v3 v4 v5 were skipped
    
    Changes v1 -> v2:
    > Please drop unused comments; they are distracting.
    
    ok
    
    > It is not wrong per-se, but haven't you already tested in
    > combination with --mirror in the previous test?
    
    I fixed the previous tests, so that there is no --mirror
    and --atomic together. There is still a first --mirror push
    for setup and a second with --atomic <branchnames> though
    
    > check_branches upstream master HEAD@{2} second HEAD~
    
    A similar function test_ref_upstream is introduced.
    
    > What's the value of this test?  Isn't it a non-fast-forward check
    > you already tested in the previous one?
    
    I messed up there. Originally I wanted to test the 2 different
    stages of rejection. A non-fast-forward check is done locally and
    we don't even try pushing. But I also want to test if we locally
    thing all is good, but the server refuses a ref to update.
    This is now done with the last test named 'atomic push obeys
    update hook preventing a branch to be pushed'. And that still fails.
    
    I'll investigate that, while still sending out the series for another
    review though.
    
    * Redone the test helper, there is test_ref_upstream now.
      This tests explicitely for SHA1 values of the ref.
      (It's needed in the last test for example. The git push fails,
      but still modifies the ref :/ )
    * checked all && chains and repaired them
    * sometimes make use of git -C <workdir>
    
    Notes v1:
    Originally Ronnie had a similar patch prepared. But as I added
    more tests and cleaned up the existing tests (e.g. use test_commit
    instead of "echo one >file && gitadd file && git commit -a -m 'one'",
    removal of dead code), the file has changed so much that I'd rather
    take ownership.

 t/t5543-atomic-push.sh | 194 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..3480b33
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,194 @@
+#!/bin/sh
+
+test_description='pushing to a repository using the atomic push option'
+
+. ./test-lib.sh
+
+mk_repo_pair () {
+	rm -rf workbench upstream &&
+	test_create_repo upstream &&
+	test_create_repo workbench &&
+	(
+		cd upstream &&
+		git config receive.denyCurrentBranch warn
+	) &&
+	(
+		cd workbench &&
+		git remote add up ../upstream
+	)
+}
+
+# Compare the ref ($1) in upstream with a ref value from workbench ($2)
+# i.e. test_refs second HEAD@{2}
+test_refs () {
+	test $# = 2 &&
+	git -C upstream rev-parse --verify "$1" >expect &&
+	git -C workbench rev-parse --verify "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'atomic push works for a single branch' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git push --atomic up master
+	) &&
+	test_refs master master
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
+		git push --atomic up master second
+	) &&
+	test_refs master master &&
+	test_refs second second
+'
+
+test_expect_success 'atomic push works in combination with --mirror' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second &&
+		test_commit two &&
+		git push --atomic --mirror up
+	) &&
+	test_refs master master &&
+	test_refs second second
+'
+
+test_expect_success 'atomic push works in combination with --force' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git branch second master &&
+		test_commit two_a &&
+		git checkout second &&
+		test_commit two_b &&
+		test_commit three_b &&
+		test_commit four &&
+		git push --mirror up &&
+		# The actual test is below
+		git checkout master &&
+		test_commit three_a &&
+		git checkout second &&
+		git reset --hard HEAD^ &&
+		git push --force --atomic up master second
+	) &&
+	test_refs master master &&
+	test_refs second second
+'
+
+# set up two branches where master can be pushed but second can not
+# (non-fast-forward). Since second can not be pushed the whole operation
+# will fail and leave master untouched.
+test_expect_success 'atomic push fails if one branch fails' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second master &&
+		test_commit two &&
+		test_commit three &&
+		test_commit four &&
+		git push --mirror up &&
+		git reset --hard HEAD~2 &&
+		test_commit five &&
+		git checkout master &&
+		test_commit six &&
+		test_must_fail git push --atomic --all up
+	) &&
+	test_refs master HEAD@{7} &&
+	test_refs second HEAD@{4}
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
+		cd upstream &&
+		git checkout second &&
+		git tag test_tag second
+	) &&
+	# see if we can now push both branches.
+	(
+		cd workbench &&
+		git checkout master &&
+		test_commit three &&
+		git checkout second &&
+		test_commit four &&
+		git tag test_tag &&
+		test_must_fail git push --tags --atomic up master second
+	) &&
+	test_refs master HEAD@{3} &&
+	test_refs second HEAD@{1}
+'
+
+test_expect_success 'atomic push obeys update hook preventing a branch to be pushed' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git checkout -b second master &&
+		test_commit two &&
+		git push --mirror up
+	) &&
+	(
+		cd upstream &&
+		HOOKDIR="$(git rev-parse --git-dir)/hooks" &&
+		HOOK="$HOOKDIR/update" &&
+		mkdir -p "$HOOKDIR" &&
+		write_script "$HOOK" <<-\EOF
+			# only allow update to master from now on
+			test "$1" = "refs/heads/master"
+		EOF
+	) &&
+	(
+		cd workbench &&
+		git checkout master &&
+		test_commit three &&
+		git checkout second &&
+		test_commit four &&
+		test_must_fail git push --atomic up master second
+	) &&
+	test_refs master HEAD@{3} &&
+	test_refs second HEAD@{1}
+'
+
+test_expect_success 'atomic push is not advertised if configured' '
+	mk_repo_pair &&
+	(
+		cd upstream
+		git config receive.advertiseatomic 0
+	) &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		test_must_fail git push --atomic up master
+	) &&
+	test_refs master HEAD@{1}
+'
+
+test_done
-- 
2.2.1.62.g3f15098
