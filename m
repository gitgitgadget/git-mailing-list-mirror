Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D314A2E21
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873402; cv=none; b=lyjaFMmdWFtNhd/5mrUvXADvqmeicgWgRdOLpVBmFR9BMtl8I9g3Xxm5i+tFGvEDg1Q8Au2K92Pylj2AVseJ62dJRp0kbYMgeaRfCXLZTKozzlg51Qp2VBF5rSRG+mekXQQgd7I9qK5fr+NIRJyr8n3Wa9ZRNAjsp4WCVuCEnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873402; c=relaxed/simple;
	bh=mAxEkk8AMzjfGyw+D+g0xnAGGiFa9nkTuzS/uKymg2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=myDWn8bCQQA3OT+AV6OQUri6bgDpf0wmGkVgwgqSYP97KTydOwdSEIt6JQaYLl/eholur2vWP/2Lk31xyM9rxDIIcq/pT9C8j3vd7Mws/AKkGMqbxnzR4+LhGJwd3tERSSUE+tpqikIwGjSd7m+HyhDWr78IOoEvNQqHTvESWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4y/0DCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4y/0DCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6961F000E9;
	Tue,  4 Aug 2026 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873401;
	bh=JyF/CSxap8UXjzVw0PooJGP/i3+qMDCzHZNS6clcN9c=;
	h=From:Date:Subject:To:Cc;
	b=C4y/0DCrYTIjU4BqH0baCNRJya+95z5WpsDxi3SNphKHKAjUzYdFudraoV4sNgndf
	 XKSg9zKP3ClbnU0LOdMmb3kRciYp++GlL1HtlkOvVnS59aUmLEXSC7DbE5B6+53D61
	 OPSRhHW1/dA2RyqrKviREbHPgIB7FYceE+RbYs+ml4TwTSs8I4q+yiDuwOcbCPVoEH
	 Q53pErewOKzKpMtwz1jlxryj2k3GMnElqgFnFSNmEliTxZzda5LMW0M5BFCKnE8St2
	 WwmdveOv+uVgnEgmBvAMNVzMamxJ6P8xvKK2F4zodR6kwGvmCadm1ADgEIqpxD2EfG
	 P2ksLR6kZ0PNg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 04 Aug 2026 21:56:32 +0200
Subject: [PATCH] completion: add 'git history' subcommands
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBMmKZGuEhFiYw1UhloU0d2Tl
 n/x/gORAlOEtngg0MmR/ZajKguws9kmEjzmBolSocZazByTD/dgjuStX/eFUiZC10qilU43iJD
 xHsjx9Y+7/n0/v26JTmgAAAA=
X-Change-ID: 20260804-history_autocompletion-84620c2f8500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mAxEkk8AMzjfGyw+D+g0xnAGGiFa9nkTuzS/uKymg2A=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlFzt/bT555M0es+Wnd9cQnore4227a5BitmvpS82z81
 C8/btyU6ZjIwiDGxWAppsiyrJyTW6Gj0Dvs0F9LmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMWLg4hSAqfbKYWR4/Cjq3YrXr8Wm689O+L3b2U533YcXp1tuqe7Zc4g1UHLOP4b/aQHlC7/
 fkrJnWrQsdZnk9pMxxwvVuQ2UGeQVGeb+mFrLBwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Use the parse-options completion helpers for the "git history"
subcommands and their options. Complete positional arguments as
revisions, and add coverage for each kind of completion.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 contrib/completion/git-completion.bash | 24 ++++++++++++++++++++++++
 t/t9902-completion.sh                  | 17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..f10813c8d7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2137,6 +2137,30 @@ _git_help ()
 	fi
 }
 
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
+	case "$cur" in
+	--*)
+		__gitcomp_builtin "history_$subcommand"
+		;;
+	*)
+		__git_complete_refs
+		;;
+	esac
+}
+
 _git_init ()
 {
 	case "$cur" in
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9ae3c48ebd..08ecf682ed 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3107,6 +3107,23 @@ test_expect_success 'git clone --config= - value' '
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
+	test_completion "git history fixup --upd" "--update-refs="
+'
+
+test_expect_success 'git history revisions' '
+	test_completion "git history split ma" "main "
+'
+
 test_expect_success 'git reflog show' '
 	test_when_finished "git checkout - && git branch -d shown" &&
 	git checkout -b shown &&

---
base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
change-id: 20260804-history_autocompletion-84620c2f8500

