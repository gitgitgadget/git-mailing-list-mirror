From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Wed, 17 Dec 2014 10:32:57 -0800
Message-ID: <1418841177-12152-7-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418841177-12152-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 17 19:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1JPe-0000VR-5z
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 19:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbaLQSdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 13:33:17 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52304 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaLQSdL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 13:33:11 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so15655004iec.15
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 10:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l1Aw3UTzDGyvB9OfJKMb5A2z2SKb3Y9uMf6J4FFVMR4=;
        b=FxALMzOOE5MXs0RBOLFGnUKGvoF1PtGGc8Wd1nXEs9M632OZAy6S4DSHSNDuO8I3Yo
         W73AZaTgakAlWJbYnvjEbOSYiQDu310Ns/kJig8AEFQ2LpnMaJKaIkyMuFOL/WFllBn4
         ly8X3jVNfxPLIGcVG0MyGxktIcDvv881O9kbl7INbCF9URw4ewJT29E9bbH3I7WKd3MN
         pag5NaCKSRejL0mfdgR/RfVcpvTEgrSc/+kJ6T1r7/7nWsIoMrwxdOH8N9FLU+OKppff
         +ebwgPnnk8q7LU60Nw4QD1BQ0pJpaWhbJyh/R3AVFrIwJhnp0eEePysQQVm3NJBxU+Jq
         smlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l1Aw3UTzDGyvB9OfJKMb5A2z2SKb3Y9uMf6J4FFVMR4=;
        b=clK1r6xfvlPR7CfQYNXZqB9tfr7YKCtRqbsyNd2Lo221g2+kCSPWq/CnMjqzMxa4Ic
         AG9ReWIvq/u79W0NSuhvsS9Q/Q9mZc/gb5XB+q6amAPJJ5K4RpLSWSXNevaAASKm4bLr
         NjfIcibgYYVpA2jXRg4ZcHPTZ2LMDSVNv0V3DgNfsaJvh0APTZtBldjB8doXz1ixKkIJ
         yK/k0dQ1Z49pkvL0Of/Pm+GcjsS7XAWmtMDXpWZOAQWlw2/uWXQFGoMKme/t1PzmC3pM
         TvKBGkLo5gfAPb+AWufm9HTUDxUoKpkVvQtqRzsvWQM0F31g9H2OaK8aZwQbKZdgqvrW
         oIjw==
X-Gm-Message-State: ALoCoQnx+0e6JwYKznzZqoZfamQYUT0J90+G+D2lTqjOWLXb+RSxLjMc3wIRkXGjI2BEpJdHi3BG
X-Received: by 10.107.153.147 with SMTP id b141mr41487648ioe.49.1418841190481;
        Wed, 17 Dec 2014 10:33:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id la3sm2634378igb.0.2014.12.17.10.33.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:33:09 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418841177-12152-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261493>

This adds tests for the atomic push option.
The first four tests check if the atomic option works in
good conditions and the last three patches check if the atomic
option prevents any change to be pushed if just one ref cannot
be updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    Changes in v3:
    * test_refs for checking  

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
2.2.0.31.gad78000.dirty
