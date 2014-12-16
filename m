From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 10:49:07 -0800
Message-ID: <1418755747-22506-6-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
 <1418755747-22506-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 16 19:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xBb-0005n1-JN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 19:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbaLPStZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 13:49:25 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57025 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaLPStV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 13:49:21 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so13406966iec.22
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zenrYrL0yI9BMYd5KlAfQCKbdkEaQKax7059AGg2OAA=;
        b=GMJ1Lfqk90o9x8/JIifmPoOx8KTqj2Jcg9GnJBbJWCTkjKDN2z/l00JpF0mu9mYykN
         7q1FHv8vmW8pMhP0skwCRuTDgfDAJelW7fjfVlPcBp5/uefvA7sBAuFxQZXJLLV7CWVc
         cMLOzVaw/Go3QtpmigLaEJwLffBs7NbyFWFYlu1SjEvoa83+wd+chDPaXgfNyJUXKNJ1
         y3JBOKy68B0NQq/aG9G4XtCgAJ8BnIvOSWmLpY6reW9BOq+5IOX9p25Q/VGz2/AJuiTq
         fKnZ84m+qakIzkVGFrjHlEbP5skHyHrkY+bbdXQYp1p5jvX7ltQ8wn44MzVIotOPolzx
         ltWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zenrYrL0yI9BMYd5KlAfQCKbdkEaQKax7059AGg2OAA=;
        b=ZcbFRYncN00PyPOHIxnEapv4tKkuss3DDpQ09s8zDGRM2qjwiszzLYoc+X0ClLXCDO
         pKGYLGKtjtnVqqdPYpTWXYlPQ1KEDovGevivGRaujY30IITE3dP+8S7ydIfgaGvH5EoE
         aIDX60YnOwt3T+qKggKV1R6e0ZK9EUmEyxuDWUBBBwwNNtf+pO3bVoqCMBLhhl3Zwwzu
         CNvk63oC+fkJzk6E59bLivKhOOll9zUkyGdH36diaUNZcgePxeACI7gom4v6VSRfNaXJ
         6CqDJSIkFuIlAAVkjLpKdGJcO1btrdIePbhRZXu71WakGLCDnzWMGGW2K2lhXbOi2pnn
         82JQ==
X-Gm-Message-State: ALoCoQnragqDdlRBAro6PrE4eXaXTfTvWtmpB02VHzbvoomphLF1/x5GVqevch/ELk2RfbcVXXKA
X-Received: by 10.107.11.10 with SMTP id v10mr26826615ioi.12.1418755760288;
        Tue, 16 Dec 2014 10:49:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4db1:657a:aafa:5d88])
        by mx.google.com with ESMTPSA id q7sm6677797igx.9.2014.12.16.10.49.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Dec 2014 10:49:19 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418755747-22506-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261446>

This adds tests for the atomic push option.
The first four tests check if the atomic option works in
good conditions and the last three patches check if the atomic
option prevents any change to be pushed if just one ref cannot
be updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
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

 t/t5543-atomic-push.sh | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100755 t/t5543-atomic-push.sh

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
new file mode 100755
index 0000000..6354fc0
--- /dev/null
+++ b/t/t5543-atomic-push.sh
@@ -0,0 +1,176 @@
+#!/bin/sh
+
+test_description='pushing to a repository using the atomic push option'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+mk_repo_pair () {
+	rm -rf workbench upstream &&
+	test_create_repo upstream &&
+	test_create_repo workbench &&
+	(
+		cd upstream && git config receive.denyCurrentBranch warn
+	) &&
+	(
+		cd workbench && git remote add up ../upstream
+	)
+}
+
+# refname, expected value, e.g.
+# test_ref_upstream refs/heads/master HEADS{0}
+test_ref_upstream () {
+	test "$#" == "2" # if this fails, we have a bug in this script.
+	test "$(git -C upstream rev-parse --verify $1)" == "$2"
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
+	test_ref_upstream master $(git -C workbench rev-parse --verify master)
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
+	test_ref_upstream master $(git -C workbench rev-parse --verify master) &&
+	test_ref_upstream second $(git -C workbench rev-parse --verify second)
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
+	test_ref_upstream master $(git -C workbench rev-parse --verify master) &&
+	test_ref_upstream second $(git -C workbench rev-parse --verify second)
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
+	test_ref_upstream master $(git -C workbench rev-parse --verify master) &&
+	test_ref_upstream second $(git -C workbench rev-parse --verify second)
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
+		! git push --atomic --all up
+	) &&
+	test_ref_upstream master $(git -C workbench rev-parse --verify HEAD@{7}) &&
+	test_ref_upstream second $(git -C workbench rev-parse --verify HEAD@{4})
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
+	test_ref_upstream master $(git -C workbench rev-parse --verify HEAD@{3}) &&
+	test_ref_upstream second $(git -C workbench rev-parse --verify HEAD@{1})
+'
+
+test_expect_failure 'atomic push obeys update hook preventing a branch to be pushed' '
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
+	test_ref_upstream master $(git -C workbench rev-parse --verify HEAD@{3}) &&
+	test_ref_upstream second $(git -C workbench rev-parse --verify HEAD@{1})
+'
+
+test_done
-- 
2.2.0.31.gad78000.dirty
