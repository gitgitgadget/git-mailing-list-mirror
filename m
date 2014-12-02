From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Mon, 01 Dec 2014 19:25:52 -0800
Message-ID: <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	<xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
	<xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
	<xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com>
	<xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
	<xmqqa936ohs3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:26:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xve6B-0002Vj-6M
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 04:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbaLBDZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 22:25:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932758AbaLBDZy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 22:25:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C32723B5D;
	Mon,  1 Dec 2014 22:25:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1GMec28P6fFrxmGtxLpDoCH+F8=; b=eZ8nYn
	YVWhFJrSQf3r601c0mJhVccU9C8SvdtqE4KHX0wW/bpdnTbbpppv/6syOFwzacbL
	6bUMclDPjSzvj3c0tEfke9Y0N91u9nvuQBfj/9M+Xl0dA4UhywJftrr5b+Z5wK2W
	k60YHitbyHck4GTAAuZ9EHjDXqAL3owxJFbOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k+VQqA/q71Uwoz9+SVB76jjEiQyFfxga
	3kTl/NbuNXffOaTlVeR3aTxt/RPnQMFBMT3KSgfAveor9SDBn2o28+9SNkLekURk
	aj2ik6DZjt/qguOPLEq+5pOpIM5OI/+nvotXdtD8NR2kxcYZBFW9YxTn9ssb0ZFI
	IdU6KjXFiGk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2953823B5C;
	Mon,  1 Dec 2014 22:25:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 834C623B5B;
	Mon,  1 Dec 2014 22:25:53 -0500 (EST)
In-Reply-To: <xmqqa936ohs3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 19:24:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBE24F1E-79D2-11E4-86F0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260527>

When receive.denyCurrentBranch is set to updateInstead, this hook
can be used to override the built-in "push-to-deploy" logic, which
insists that the working tree and the index must be unchanged
relative to HEAD.  The hook receives the commit with which the
tip of the current is going to be updated, and is responsible to
make any necessary changes to the working tree and to the index to
bring them to the desired state when the tip of the current branch
is updated to the new commit.

For example, the hook can simply run "git read-tree -u -m HEAD $1"
to the workflow to emulate "'git fetch' going in the reverse
direction with 'git push'" better than the push-to-deploy logic, as
the two-tree form of "read-tree -u -m" is essentially the same as
"git checkout" that switches branches while keeping the local
changes in the working tree that do not interfere with the
difference between the branches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 19 ++++++++++++++-
 t/t5516-fetch-push.sh  | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 11800cd..fc8ec9c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -797,6 +797,20 @@ static const char *push_to_deploy(unsigned char *sha1,
 	return NULL;
 }
 
+static const char *push_to_checkout_hook = "push-to-checkout";
+
+static const char *push_to_checkout(unsigned char *sha1,
+				    struct argv_array *env,
+				    const char *work_tree)
+{
+	argv_array_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
+	if (run_hook_le(env->argv, push_to_checkout_hook,
+			sha1_to_hex(sha1), NULL))
+		return "push-to-checkout hook declined";
+	else
+		return NULL;
+}
+
 static const char *update_worktree(unsigned char *sha1)
 {
 	const char *retval;
@@ -808,7 +822,10 @@ static const char *update_worktree(unsigned char *sha1)
 
 	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
 
-	retval = push_to_deploy(sha1, &env, work_tree);
+	if (!find_hook(push_to_checkout_hook))
+		retval = push_to_deploy(sha1, &env, work_tree);
+	else
+		retval = push_to_checkout(sha1, &env, work_tree);
 
 	argv_array_clear(&env);
 	return retval;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 85c7fec..e4436c1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1434,4 +1434,67 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 
 '
 
+test_expect_success 'updateInstead with push-to-checkout hook' '
+	rm -fr testrepo &&
+	git init testrepo &&
+	(
+		cd testrepo &&
+		git pull .. master &&
+		git reset --hard HEAD^^ &&
+		git tag initial &&
+		git config receive.denyCurrentBranch updateInstead &&
+		write_script .git/hooks/push-to-checkout <<-\EOF
+		echo >&2 updating from $(git rev-parse HEAD)
+		echo >&2 updating to "$1"
+
+		git update-index -q --refresh &&
+		git read-tree -u -m HEAD "$1" || {
+			status=$?
+			echo >&2 read-tree failed
+			exit $status
+		}
+		EOF
+	) &&
+
+	# Try pushing into a pristine
+	git push testrepo master &&
+	(
+		cd testrepo &&
+		git diff --quiet &&
+		git diff HEAD --quiet &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
+	) &&
+
+	# Try pushing into a repository with conflicting change
+	(
+		cd testrepo &&
+		git reset --hard initial &&
+		echo conflicting >path2
+	) &&
+	test_must_fail git push testrepo master &&
+	(
+		cd testrepo &&
+		test $(git rev-parse initial) = $(git rev-parse HEAD) &&
+		test conflicting = "$(cat path2)" &&
+		git diff-index --quiet --cached HEAD
+	) &&
+
+	# Try pushing into a repository with unrelated change
+	(
+		cd testrepo &&
+		git reset --hard initial &&
+		echo unrelated >path1 &&
+		echo irrelevant >path5 &&
+		git add path5
+	) &&
+	git push testrepo master &&
+	(
+		cd testrepo &&
+		test "$(cat path1)" = unrelated &&
+		test "$(cat path5)" = irrelevant &&
+		test "$(git diff --name-only --cached HEAD)" = path5 &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
+	)
+'
+
 test_done
-- 
2.2.0-141-gd3f4719
