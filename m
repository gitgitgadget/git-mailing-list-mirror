Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28241DEEB
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353366; cv=none; b=YEhorbyQ9eBtdLvIqej/GokrjgJZ803/C5xXXnioVdcK6H5CYsniBbsCAUwOgIoM5c2ZC9O8ThcGsng9sIF+UqoY3O+UIK1NQNQtt4Ww5eySIl+d/If6u1ARrVbGYDp8+l0vMULg6kn53qK8FJXV3qKKYScyqRXaXW9CPobYn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353366; c=relaxed/simple;
	bh=/b7ULMG8w38YPlVctPS+7y6SQscY1UuArm9YWpek2Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJVGloFc95eWS6N2+VrsaM7ejT/c9IgsvfmGwU85Ivmb1gpPK1flNzHvyJMmAFJcds/jk1zIY1jiVRuiF4wVvrIUhuaDm4D85JZGdCJ0HyzPAgJZ2MDSBDKCR4oIAwexAox8SYsKNuIA7C9oJbgydGFKSRqfic0c2EtuuQIJ/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zitro.id; spf=pass smtp.mailfrom=fe-bounces.zitro.id; dkim=pass (1024-bit key) header.d=zitro.id header.i=@zitro.id header.b=dT2lHgCk; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zitro.id
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.zitro.id
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zitro.id header.i=@zitro.id header.b="dT2lHgCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zitro.id;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=fe-ef2ef2159a; t=1787353354;
 bh=Fvf7pVYujewH04ZFHnCpDwBDCqjZedYhZerD/7a96Zw=;
 b=dT2lHgCkPCNI4meDzSyeb69ChXSGRO03J9RiCFfBF7fuExAQP2I3a9HeO3Q703PBFw1L3ZwUi
 dqIqjb4iOZP5HY25WurhNxVSF1At7DtQjya1VeI7xOeWFaQf2+uJqz2tDItZf3ZEPo/E+sDzb71
 4GSdBgfyIykrSy8Ygq3S0pI=
X-Forward-Email-ID: 6a88d90896141d1f979b279b
X-Forward-Email-Sender: rfc822; 0@zitro.id, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Volodymyr Vriukalo <0@zitro.id>
To: git@vger.kernel.org
Cc: Volodymyr Vriukalo <0@zitro.id>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Glen Choo <glencbz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 2/2] branch: allow recursion with no tracking name
Date: Sat, 22 Aug 2026 01:01:42 +0200
Message-ID: <20260822-vv-branch-recurse-no-start-ref-v1-2-46dc140acaa8@zitro.id>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4779; i=0@zitro.id; h=from:subject:message-id; bh=/b7ULMG8w38YPlVctPS+7y6SQscY1UuArm9YWpek2Tw=; b=owGbwMvMwCXWv3ZB/MVrrO8ZT6slMWR1XM/Wu3T22YU7i6tWSDlfP2nxzOOfgUhb+bXJ/9gXf C0pSwtJ7ihlYRDjYpAVU2Rx9Z2dn8nWO0tj5sFtMHNYmUCGMHBxCsBE9C8y/K+KqTZPXxWSE/pb Ve5o5wL+tX+vb7VwZI1/mZFn9rXt2lGG/y5bp6Z9U/MSTnzcklA3+fxd443lXHOqsm0sC78ysTa vYwAA
X-Developer-Key: i=0@zitro.id; a=openpgp; fpr=23DE306A7F9E54C26627EF2975B69E8242090518
Content-Transfer-Encoding: 8bit

Creating a branch across submodules from a commit that no ref points
  at fails, with the helper's usage text reprinted as an error:

    submodule 'sub': usage: git submodule--helper create-branch [...]
    fatal: submodule 'sub': cannot create branch 'branch-a'

`submodule_create_branch()` runs the helper in a child process because
  `install_branch_config_multiple_remotes()` cannot write config into a
  submodule, and passes the branch name, the start oid and the tracking
  name as three positionals.
`dwim_branch_start()` leaves the tracking name NULL where the start
  point named no ref, and `strvec_pushl()` stops at the first NULL, so
  the child receives two positionals.
`module_create_branch()` requires exactly three and prints its usage.

Make the third positional optional, since a start point that named no
  ref has no tracking name to give and the recursion has nothing to
  track in the submodule either.
Push it separately in the caller too: relying on `strvec_pushl()` to
  stop early leaves the argument dropped by accident rather than by
  intent, and a reader has to know where the terminator falls to see
  that it can go missing at all.

961b130d20 (branch: add --recurse-submodules option for branch
  creation, 2022-01-28) introduced both sides.

This is the same NULL tracking name as the previous patch, reached one
  step earlier: the dry-run pass over the submodules runs before the
  superproject's own `setup_tracking()` call, so with a submodule
  present this failure hides the abort that patch removes.
The new test therefore needs that patch under it.

Assisted-by: An LLM.
Signed-off-by: Volodymyr Vriukalo <0@zitro.id>
---
 branch.c                    | 10 +++++++++-
 builtin/submodule--helper.c |  7 ++++---
 t/t3207-branch-submodule.sh | 13 +++++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 182fc4a3dd..2dab1f1e35 100644
--- a/branch.c
+++ b/branch.c
@@ -726,7 +726,15 @@ static int submodule_create_branch(struct repository *r,
 		break;
 	}
 
-	strvec_pushl(&child.args, name, start_oid, tracking_name, NULL);
+	/*
+	 * The tracking name is absent when the start point named no ref.
+	 * Push it separately: strvec_pushl() stops at the first NULL, so
+	 * passing it inline would drop the argument by accident rather
+	 * than by intent.
+	 */
+	strvec_pushl(&child.args, name, start_oid, NULL);
+	if (tracking_name)
+		strvec_push(&child.args, tracking_name);
 
 	if ((ret = start_command(&child)))
 		return ret;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1cc82a134d..6895216712 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3335,7 +3335,7 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> <start-name>"),
+		N_("git submodule--helper create-branch [-f|--force] [--create-reflog] [-q|--quiet] [-t|--track] [-n|--dry-run] <name> <start-oid> [<start-name>]"),
 		NULL
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
@@ -3344,13 +3344,14 @@ static int module_create_branch(int argc, const char **argv, const char *prefix,
 	track = cfg->branch_track;
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
-	if (argc != 3)
+	if (argc < 2 || argc > 3)
 		usage_with_options(usage, options);
 
 	if (!quiet && !dry_run)
 		printf_ln(_("creating branch '%s'"), argv[0]);
 
-	create_branches_recursively(the_repository, argv[0], argv[1], argv[2],
+	create_branches_recursively(the_repository, argv[0], argv[1],
+				    argc > 2 ? argv[2] : NULL,
 				    force, reflog, quiet, track, dry_run);
 	return 0;
 }
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index 54f7caeb2f..c56cea31cb 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -115,6 +115,19 @@ test_expect_success 'should move a branch to a start point that names no ref' '
 	)
 '
 
+test_expect_success 'should recurse into submodules from a start point that names no ref' '
+	test_when_finished "reset_test" &&
+	(
+		cd super &&
+		oid=$(git rev-parse HEAD) &&
+		git branch --recurse-submodules branch-a "$oid" &&
+		git rev-parse branch-a &&
+		git -C sub rev-parse branch-a &&
+		git -C sub/sub-sub rev-parse branch-a &&
+		git -C second/sub rev-parse branch-a
+	)
+'
+
 test_expect_success 'should ignore submodule.recurse when not creating branches' '
 	test_when_finished "reset_test" &&
 	(

-- 
2.55.0.2.g927b4b9963

