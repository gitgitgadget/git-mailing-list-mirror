From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 9/9] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 30 Dec 2014 15:41:38 -0800
Message-ID: <1419982898-23108-10-git-send-email-sbeller@google.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, ronniesahlberg@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:42:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66QP-0007uT-53
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaL3Xl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:41:59 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51936 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbaL3Xl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:41:57 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so13130926igb.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ly2+ubZkYfWn4AwUWLD5P72UQ63vWn1YATgANzvbLwU=;
        b=LLRPXQ3MjilIGVhs2IKbp3JVB+UR/CfungF90KKq+HIYaUF9e6eKCG8l6H66TwW9hr
         BaFdeHzqbI/mNEjQZj/0p1Z1rEEaE8iCqlYeut2PT8Yz4gSimeoRrHxwX5rae7uJL/lW
         QK991sYzm0J6NZZq5CPA5clW7WwBd+r6EA8eLEsHTa9ql2LxR5znfdX1xdJNx5KWKuuI
         wX+CaaW2Bevm5wJjZY5dbxsk+NSeUzk7iub8KgZNq2mnpRHVBOCh6P5XCaVXzVT2FOxI
         RuLqzxRYJSkAmZtazk/NSO5NP2ChaIw0X/Nl/pqAF4w9yZLvQykTUFGwu0honv7Jika5
         FXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ly2+ubZkYfWn4AwUWLD5P72UQ63vWn1YATgANzvbLwU=;
        b=BfKEWnvKWe5L/m9mJBa9lfgsi6B+rWuBhcpEG96WeEpMf2UoeDTFaHkPadgj9i/oOF
         85NkpqeiUtPG+iomBiF0Amk+4GBkEihFZkhrYTqcl02pYsSw6zqGYPXO+n89EUHdQx+T
         fDZ+12CPw8M6TZvQ6NKGBIfNAoc3n5vx49TN8G9+D/Y6tSs1FCUyvNmxi0uYcgxFNIwa
         b5FjOaM9jdI3e0pj0XQ7OkweKZjF0wuXwpNmqMXKwZ12qbc1+24LpClQYhsC5ffAhheV
         KYZValGZpQ9lknB0vpVIqh5TLlMNmCb3CkAKqZRDzvc1Lzlc0m9FPWvoFJHyGqhZ36KO
         pOcQ==
X-Gm-Message-State: ALoCoQm7awLVpWbvvNcgV00T+irbopTtqDNRzCmYado5HdM5RvdRpdIycFsMu5/wjwtRkgfbnqeo
X-Received: by 10.43.44.201 with SMTP id uh9mr47306487icb.51.1419982916541;
        Tue, 30 Dec 2014 15:41:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e545:220a:6cf6:2fed])
        by mx.google.com with ESMTPSA id e3sm13394475igg.16.2014.12.30.15.41.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:41:55 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419982898-23108-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261957>

This adds tests for the atomic push option.
The first four tests check if the atomic option works in
good conditions and the last three patches check if the atomic
option prevents any change to be pushed if just one ref cannot
be updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
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
