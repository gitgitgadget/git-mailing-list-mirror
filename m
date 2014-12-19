From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Fri, 19 Dec 2014 11:39:01 -0800
Message-ID: <1419017941-7090-8-git-send-email-sbeller@google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 19 20:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y23Ob-0005fi-M2
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 20:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaLSTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 14:39:23 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:40174 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbaLSTjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 14:39:21 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so1204630igd.8
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 11:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPO8ULUbpPoNBZsRIvtRhrfRA1fSU+XZ5y9Ae1kxI00=;
        b=lUTFklxqen/1O9P/ftuc/ioTtC/aJ1FPpOY45Fxi9G3r+2nXBcTiD1CltkJpGCbPHd
         MBHBo65KkY9ReIi8AS0ia0wFsOxRFbfPP5I9wj3xazySuGw26ScCwokH8fwyRZvKLmWD
         mkn1WWW382KqH9k3yUV0apZRNfsytL1lyG2ENhq/1amXY9QQ6lgbgNT1kAYG3I1inO/Y
         sjDvEJXCImKc6K8z8Tuq2omBWVcGZOvUm9eoXsEkWgJoriKguUdkRTqEVjtOEBGuiTpv
         lkgkcXu2ty7yBTxpq9m49+rvIMnGFOPqeMUWFDgEgbHug5e2hxBvs8nrv2xKud+ZZAIJ
         P+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPO8ULUbpPoNBZsRIvtRhrfRA1fSU+XZ5y9Ae1kxI00=;
        b=QTu0Pu7gtlfkGnsP1kTX7jG/1g/qq408VYaqPx2D7pIwG5o9qxXMbgj09vv2HGiBpQ
         uq4TvRWxWYmv+ZhTl6FGgARXFM1QQGI3HuzEV5dx74X3Fq+yT2pnhK1TpbGowUglXXtC
         o5mx8gOOZ1R4egZx8zKur8MBQLbQZH7156m2pFkHsir1XiAwiTGLs6jV92FEXi+4GRTa
         2Yya1XgiqLCRQjLDW1QyE2s0Yv5lu4+iiOGx47i1XE8mH49DtloN1U/U0BS+tEu8+cZp
         aaZBVznBwLumSKm5TwQxN8HBZJACRbdP0VOHOTBixvg0x6SdwPjTeMIKo2bsEpoQqVY6
         WBHQ==
X-Gm-Message-State: ALoCoQk0q9aszQ/I2hgxqef/+AB2U3l8uIFGKp+f+NPj43DJp5dSh4sDW+XJfapNk/TYkSkK33fu
X-Received: by 10.50.103.41 with SMTP id ft9mr4813513igb.6.1419017961066;
        Fri, 19 Dec 2014 11:39:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5827:d4a2:8bd5:ac5d])
        by mx.google.com with ESMTPSA id 5sm4943037ioe.6.2014.12.19.11.39.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 11:39:20 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419017941-7090-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261591>

This adds tests for the atomic push option.
The first four tests check if the atomic option works in
good conditions and the last three patches check if the atomic
option prevents any change to be pushed if just one ref cannot
be updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v6: the same as v2, so I can resend the whole series as v6
    
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

 t/t5543-atomic-push.sh | 178 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..b81a542
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,178 @@
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
+test_done
-- 
2.2.1.62.g3f15098
