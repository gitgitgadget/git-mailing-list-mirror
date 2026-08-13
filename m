Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94F41F5CC
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647928; cv=none; b=MYDbvvhgr1vTryl2vLe4VHVr83I0tKQ2rkJm49WMqP9FcXwKraVFfwz6Bg4MUDyMtGdR4/MBqeSnsU0GU7t0ydlJSBM9WQTnLWw2mjNZvGKXeJ4SIQZAw16hpknYUhjOZuMLCD76L2NXqNgOhsUk4vzexxC8RyTTuSAlqSAahCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647928; c=relaxed/simple;
	bh=iHfs42nyhVAuYi3aNlvqKe3qXo7Z0s+c3IPbBF09X8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTFb1ZwaJPk/RCUAMKuG5FbsHxdiNvaoBmUitqeMkSP+jb1H0LFNEwoOQnewCra2OAtjou0qBSe/Ojcj9nQ2dVhs6YWKGm64KE/a3R/aKHPqTiEJemOkZKeRJC+ijpbleueYM2lAR2x+z++9taIolmH4clXnlz80YK2MoYSNCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2pOi7FV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2pOi7FV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B55F1F00A3A;
	Thu, 13 Aug 2026 19:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647927;
	bh=+s9atkH3/yS+H8BUkJ1ySt/ZDylPs9/fH9vbc9kcNGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D2pOi7FVHSi1lGeLzqe2ISKBbfZ4quuU2fbhgtAbW3yVSdO/p8UbWFnzQ9gy/PMeS
	 XfWNUL6XclI81y1foVtF3WoQdmheyvnnhk9tiQVtEnnOumnXnWbOBtYkPnBbSJq5Id
	 EltYjlv4uuXtb7jqwu522fwoIT8MFBuznWGPtJ0Qil55wPrA+MOYaV9fJO+naCgMGi
	 3XsW1hCMRl2d+BgVW5DOvuNs5CfPvKVa2C8KKb0QU8Ldtkl+aaKV5Y4gk4wCcPXQH0
	 F0tdUSg5CcXBv28x2L2n4BWTUWcF8Izm/ghN7xLgX4zwXcy8r0S0WLvc3EcJ1h7Zq1
	 kbnAC5QmrJ5rA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 13 Aug 2026 21:05:02 +0200
Subject: [PATCH v3 1/4] completion: add 'git history' subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-history_autocompletion-v3-1-69eed1cea93a@kernel.org>
References: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
In-Reply-To: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3602; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=iHfs42nyhVAuYi3aNlvqKe3qXo7Z0s+c3IPbBF09X8s=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFl1okWsE1hVUySO2k9pKXlaeDnicN6VI+smzZ3EXTnnx
 MlPbAJ/OiayMIhxMViKKbIsK+fkVugo9A479NcSZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqjc9YvhnI853+nVn3mT/jN8PjjPNuCI6oUNvwQmXFfxbZ+2ZHyd+g5Hh1eUpbbm
 L5uz+tOHydkG7G7d6uvw0Di99Z+J70+eUp7wLPwA=
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
Changes in v3:

  - Ignore the split "<option> <value>" syntax for options that take
    arguments. This simplifies revision detection and avoids hard-coding
    option names.
  - Test that options are not completed before a subcommand.

Changes in v2:

  - Test options before and after revisions.
  - Do not complete options after "--".
  - Stop revision completion after the first required revision.
---
 contrib/completion/git-completion.bash | 45 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh                  | 30 +++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..1727768487 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2137,6 +2137,51 @@ _git_help ()
 	fi
 }
 
+__git_history_has_revision ()
+{
+	local i
+
+	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
+		case "${words[i]}" in
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
index 9ae3c48ebd..d0d8f2ba4a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3107,6 +3107,36 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'git history subcommands' '
+	test_completion "git history " <<-\EOF &&
+	drop Z
+	fixup Z
+	reword Z
+	split Z
+	EOF
+	test_completion "git history --" ""
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
+	test_completion "git history split --update-refs=head ma" "main " &&
+	test_completion "git history fixup --empty=drop ma" "main " &&
+	test_completion "git history reword main m" ""
+'
+
 test_expect_success 'git reflog show' '
 	test_when_finished "git checkout - && git branch -d shown" &&
 	git checkout -b shown &&

-- 
2.54.0

