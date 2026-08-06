Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131434E74D
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048069; cv=none; b=Ir2fTfFV3QJSpMADJJWEQi7KwOW4i03rCi3dgtKtJglDPbjFTd2JDEaYSOeO+9DXKgJD+Kub2/X4xKpurvBcPo21Y63zSGfpOW712RQ3wcc4sUbrznUAtrWWdk/LQePob1LblOkm3y3piwUq+0sya8oAhCsAJHJhjXsqNdPyDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048069; c=relaxed/simple;
	bh=dwnqq1rjTciXBEDWkfKV+3XkZhDLmsc9cAFchOLO4YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tyE3lHuRUEU3BYIWNkUj8Ds/LSrCG5yiumiSCzaVnERWfFFy6ntJ03BLg2mZ4t0WdUtcoHcLZyFVynGBG9MsGGw9m7nK4laClqa+lHmhV5y6goSgP38O33gFVettF99eVOZSis7CN/5DpiuzM3Bl7TliGn9jzrSEKDZwTfF9gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clD99Sde; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clD99Sde"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3731F00A3D;
	Thu,  6 Aug 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048068;
	bh=qpzWlltdYf4m89VKPRbgqqqwYQqnY5+2NIgP1ESYF+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=clD99SdevkhNHYb6mb06w2TB3nVU6FOT2RKMPxQkDTQ+7AQFgxS+rYhTbZY/Wodql
	 6MPHeBl/PATE7Wq17YUomXz85xyHk2v2ozwen3NsPx1IjIh9u3w58KqSyVwgexi5xx
	 92b0j/uJ2KZVLOLLJ5ogGZiBmx1aJ+vZSrLN4pyzRwBMj+Z3WGHzC1XWWcvOc3kB0d
	 3V1rsA+HiYQM/XkyL6gPwsZP+iJ5Tc4h7pNWfsm7uy1uVfA6sc7v3dZ4bn8mcz3Zot
	 HgUfDXc3l06CcrDueGzyee90VXTMnZpeACTYuyNUereIXapopLCmpxnANOQMteUIg4
	 L4N6FrodgImjQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 06 Aug 2026 22:27:36 +0200
Subject: [PATCH v2 1/4] completion: add 'git history' subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3350; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=dwnqq1rjTciXBEDWkfKV+3XkZhDLmsc9cAFchOLO4YI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkl7xwU36/IDfp3NOzK/f3PDbdX93kG/2Lftq5pndH9j
 o07DOMPdkxkYRDjYrAUU2RZVs7JrdBR6B126K8lzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGDFwcQrAVN+TZPhfW+oUOmV56/E1mSxcKlure7S+fmh5X8rZ+fug//F3GWc/MfzhOWkw7+E
 L1cPtObaBm+UP1687kar8+YL1hfdbekQvtjexAQA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Use the parse-options completion helpers for the

  git history

subcommands and their options. All current history subcommands take a
revision as their first positional argument, so complete that argument
as a revision.

Once the revision is present, leave any further positional arguments to
subcommand-specific completion. This allows a subcommand to complete
another kind of argument, such as the pathspec accepted by

  git history split

or another revision if a future subcommand accepts one.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - Test options before and after revisions.
  - Do not complete options after "--".
  - Stop revision completion after the first required
---
 contrib/completion/git-completion.bash | 48 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh                  | 29 ++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..7372e2919b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2137,6 +2137,54 @@ _git_help ()
 	fi
 }
 
+__git_history_has_revision ()
+{
+	local i
+
+	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
+		case "${words[i]}" in
+		--empty|--update-refs)
+			((i++))
+			;;
+		-*)
+			;;
+		*)
+			return 0
+			;;
+		esac
+	done
+	return 1
+}
+
+_git_history ()
+{
+	local subcommands subcommand
+
+	__git_resolve_builtins "history"
+
+	subcommands="$___git_resolved_builtins"
+	subcommand="$(__git_find_subcommand "$subcommands")"
+
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+		return
+	fi
+
+	if ! __git_has_doubledash; then
+		case "$cur" in
+		--*)
+			__gitcomp_builtin "history_$subcommand"
+			return
+			;;
+		esac
+	fi
+
+	if ! __git_history_has_revision; then
+		__git_complete_refs
+		return
+	fi
+}
+
 _git_init ()
 {
 	case "$cur" in
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9ae3c48ebd..5ccb38c751 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3107,6 +3107,35 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'git history subcommands' '
+	test_completion "git history " <<-\EOF
+	drop Z
+	fixup Z
+	reword Z
+	split Z
+	EOF
+'
+
+test_expect_success 'git history subcommand options' '
+	test_completion "git history split main --" <<-\EOF &&
+	--update-refs=Z
+	--dry-run Z
+	--no-dry-run Z
+	EOF
+	test_completion "git history fixup --upd" "--update-refs=" &&
+	test_completion "git history fixup --ree" "--reedit-message " &&
+	test_completion "git history split --upd" "--update-refs=" &&
+	test_completion "git history split main --dry" "--dry-run " &&
+	test_completion "git history reword main -- --d" ""
+'
+
+test_expect_success 'git history revisions' '
+	test_completion "git history split ma" "main " &&
+	test_completion "git history split --update-refs head ma" "main " &&
+	test_completion "git history fixup --empty drop ma" "main " &&
+	test_completion "git history reword main m" ""
+'
+
 test_expect_success 'git reflog show' '
 	test_when_finished "git checkout - && git branch -d shown" &&
 	git checkout -b shown &&

-- 
2.54.0

