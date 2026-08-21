Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33ED41D22F
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353353; cv=none; b=mYQJEQ52H8Ib15cHNfa6UGmepR2CS+HrNu66DZYfAHLSbY+Q+c/NApoudWRJ5LYfEwKwIdHl99ou3I7DJIwaCxtFatsdRhBn7y/4KvlnWcBQUYpH6Wq2DSBJbeM0Um38c1ZpAf6Zmyd6QrgwZpGXQ9rhXaQHlcG1+l2HnREPfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353353; c=relaxed/simple;
	bh=YkG1YCVtxc5Fmzn1wEgU14rxVcaElKWrEaXGNeMLiBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDHOJNiTrUEJ3ZMlaAcLkPGXMG6eoo74MyfYm/4txdaFO/I476MEBjB6jVYT8DXl6BscGJDPDB1glCb95o8L+D5OZeurcikX83M0nCzLW9yf7ufT3zwfnlAWfporMR7t2Vo9J7ozjYYIbFSqr4DZoJAw2snpR9d52BB9YFTdBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zitro.id; spf=pass smtp.mailfrom=fe-bounces.zitro.id; dkim=pass (1024-bit key) header.d=zitro.id header.i=@zitro.id header.b=QD6gFIY8; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zitro.id
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.zitro.id
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zitro.id header.i=@zitro.id header.b="QD6gFIY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zitro.id;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=fe-ef2ef2159a; t=1787353345;
 bh=j83l8mgPitfctiIDwBhbX+eqLyTPNDUKcjs6pFxg2/8=;
 b=QD6gFIY8Y3aJ1YzpVEU17FzMOgCzHth8IrNR3PJG3PZmLOmdvRgamB/NrR2DBmVzudmab5a4c
 10teKNGM4bONpuX0MEhvAKOJoEPZbbUdmyFn+g/RXkanwK5ZAbjjd4hDbR9Jn5OwyGvdFW308En
 0b53AdimeweZARx/DHqbg6A=
X-Forward-Email-ID: 6a88d90096141d1f979b2776
X-Forward-Email-Sender: rfc822; 0@zitro.id, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Volodymyr Vriukalo <0@zitro.id>
To: git@vger.kernel.org
Cc: Volodymyr Vriukalo <0@zitro.id>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Glen Choo <glencbz@gmail.com>
Subject: [PATCH 1/2] branch: do not track a start point with no ref
Date: Sat, 22 Aug 2026 01:01:41 +0200
Message-ID: <20260822-vv-branch-recurse-no-start-ref-v1-1-46dc140acaa8@zitro.id>
In-Reply-To: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
References: <20260822-vv-branch-recurse-no-start-ref-v1-0-46dc140acaa8@zitro.id>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3886; i=0@zitro.id; h=from:subject:message-id; bh=YkG1YCVtxc5Fmzn1wEgU14rxVcaElKWrEaXGNeMLiBM=; b=owGbwMvMwCXWv3ZB/MVrrO8ZT6slMWR1XM+eW95WYWOYkG0w0aIn+OiUBf2HXzj7hTL+rNYSf nWZUWhlRykLgxgXg6yYIour7+z8TLbeWRozD26DmcPKBDKEgYtTACZydg/DPzuB11fzb6fymi94 kBrB3LPlWunsExvfv2W6kHZnh5FJyklGhuNVvMzWdQV7babOdJzDtOi6akFsdkWH/IsPtxTncok 08gAA
X-Developer-Key: i=0@zitro.id; a=openpgp; fpr=23DE306A7F9E54C26627EF2975B69E8242090518
Content-Transfer-Encoding: 8bit

Forcing a branch to a commit that no ref points at aborts when both
  `submodule.recurse` and `submodule.propagateBranches` are set and
  the repository has a remote configured:

    BUG: refspec.c:442: refspec_find_match: need either src or dst
    Aborted (core dumped)

`create_branches_recursively()` resolves the start point through
  `dwim_branch_start()`, which leaves `branch_point` NULL when the
  start point names no ref -- an object id, or a revision expression
  such as `HEAD~0`.  That NULL becomes `tracking_name`, and the
  `setup_tracking()` call below it is guarded on `track` alone.
  `setup_tracking()` assigns it to `tracking.spec.dst` without
  checking, then hands the spec to `for_each_remote()`, so
  `refspec_find_match()` receives a query with neither src nor dst
  and trips its assertion.
`for_each_remote()` never reaches that callback where no remote is
  configured, which is why the abort needs one.

961b130d20 (branch: add --recurse-submodules option for branch
  creation, 2022-01-28) added the call with no guard at all.
75388bf5b4 (branch: support more tracking modes when recursing,
  2022-03-29) added the guard on `track`.

Updating the branch happens before the abort, so the command does
  what was asked and then exits 134.
Callers that check the exit status therefore see a failure that did
  not happen, and one that rolls back on failure would undo a
  successful update.

`create_branch()` already declines this: it calls `setup_tracking()`
  under `if (real_ref && track)`, leaving tracking unset when the
  start point resolved to no ref.
Make the recursive path agree.
Checking for NULL inside `setup_tracking()` would also silence the
  abort, but it would put the decision in the callee for one caller
  that has the answer already, and leave the two creation paths
  disagreeing about when tracking is set up.

Reproducing it needs all four of:

  - `submodule.recurse=true`
  - `submodule.propagateBranches=true`
  - a configured remote
  - a start point that is not a ref name

Submodules take no part, so the new test builds a repository with
  neither a submodule nor a `.gitmodules`, where `propagateBranches`
  is set and has nothing to propagate to.

Assisted-by: An LLM.
Signed-off-by: Volodymyr Vriukalo <0@zitro.id>
---
 branch.c                    |  2 +-
 t/t3207-branch-submodule.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..182fc4a3dd 100644
--- a/branch.c
+++ b/branch.c
@@ -806,7 +806,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 * tedious to determine whether or not tracking was set up in the
 	 * superproject.
 	 */
-	if (track)
+	if (tracking_name && track)
 		setup_tracking(name, tracking_name, track, quiet);
 
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index fe72b24716..54f7caeb2f 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -98,6 +98,23 @@ test_expect_success 'should respect submodule.recurse when creating branches' '
 	)
 '
 
+test_expect_success 'should move a branch to a start point that names no ref' '
+	test_when_finished "rm -rf no-submodules" &&
+	git init no-submodules &&
+	(
+		cd no-submodules &&
+		test_commit one &&
+		test_commit two &&
+		git remote add origin . &&
+		git config submodule.propagateBranches true &&
+		git config submodule.recurse true &&
+		git branch branch-a HEAD~1 &&
+		oid=$(git rev-parse HEAD) &&
+		git branch -f branch-a "$oid" &&
+		test_cmp_rev HEAD branch-a
+	)
+'
+
 test_expect_success 'should ignore submodule.recurse when not creating branches' '
 	test_when_finished "reset_test" &&
 	(

-- 
2.55.0.2.g927b4b9963

