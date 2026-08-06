Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D74DB553
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048075; cv=none; b=G9VUJ1OY/rKBkBbMsKLxXg5WY4KDyyUi6S0dwNLA7hVr4YxpfobNI3Cg2zDZqyMytROCGwtUZ/ntv78Az1v38jwEik59gTo3M5l+mvyf6JGl/fbDUVIIpnzZOOUNp2tCk32pbom97EnmQIjHXZzbiVpXT2KxetqPicAlhc8ilGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048075; c=relaxed/simple;
	bh=76QUlLnwfuxuid8HTbfzR4+1xgtxBb3iHjDyA0OLtNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p12ydvjE617xnkOf9NCwlvMyb5rkAkxtG4qCUFXcCEFQG2UY9Qt+BiP9bSXA1Yj3z/W7TBrzomx6dmBHQnz9BVKunFLOhb+R+oNOCwAomcgri4oCbQeTIwgSX0wrO6d55E8LWAAQxH7pmqaF40SteUcJl4NSJi+ywzNnGrVjl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+sz7d4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+sz7d4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F1A1F00A3A;
	Thu,  6 Aug 2026 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048074;
	bh=09ClMznuQs7ZH7xI+5IujaloIxgWd+sZjXwoRsUOjgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=H+sz7d4oaX9F98qqanguolElRB3EoWI4tQ5G//Kpimfix52EZi1T1+/Km1v4eDu2V
	 K010bWxMHxZsIGKDPWYuMMRL2xCDzZGZCEP8BZ2w7/irR5oDff7IEdZcyJdsWqrxby
	 U8KHkn6cxY7PR66mlFArekfSiKPI8W7585Ly+PL8cTtoTaJHlmoIqaMaMXZKzc0vkI
	 iabTpuAoML8vlEOcsWv/68muB50jiVGfLndzDm4887y2YM7inpIdfAqS9ZVn4SUPq9
	 x1xxIOmzKQr4FjHzjYEh8UO0D8qoxDJehqFVbD57JLMy0yQrtMhCYlIDxHr3h3hHYi
	 coOYKE6tGsOEA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 06 Aug 2026 22:27:39 +0200
Subject: [PATCH v2 4/4] completion: complete 'git history split' pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-history_autocompletion-v2-4-7e60f52a1c20@kernel.org>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
In-Reply-To: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=76QUlLnwfuxuid8HTbfzR4+1xgtxBb3iHjDyA0OLtNI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkl7xyOPvnadW/zqa+nVmxdm5A2aWNv17NudwVe3Uu7U
 s4cuGLm1TGRhUGMi8FSTJFlWTknt0JHoXfYob+WMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChY8TAxSkAU71GieGfwgbXcsETvYw67Oquk04+PvI2ddZPXbOVfvJdQcwWgSI3GP5XKsduXb7
 GVvLqmnvva+bxfN47x0+yootdMKeUN7XD0pEZAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Arguments following the required revision of "git history split" are
pathspecs. Complete them from tracked paths, including after an explicit
"--".

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - New patch.
---
 contrib/completion/git-completion.bash |  6 ++++++
 t/t9902-completion.sh                  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6f1ba96763..d313780d8b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2197,6 +2197,12 @@ _git_history ()
 		__git_complete_refs
 		return
 	fi
+
+	case "$subcommand" in
+	split)
+		__git_complete_index_file "--cached"
+		;;
+	esac
 }
 
 _git_init ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ea86ecc08f..391cc849a8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3143,6 +3143,19 @@ test_expect_success 'git history revisions' '
 	test_completion "git history reword main m" ""
 '
 
+test_expect_success 'git history split pathspecs' '
+	test_completion "git history split main -- --update-refs=h" "" &&
+	test_completion "git history split main -- --update-refs h" "" &&
+	test_completion "git history split --dry-run main file" <<-\EOF &&
+	file1Z
+	file2Z
+	EOF
+	test_completion "git history split main -- file" <<-\EOF
+	file1Z
+	file2Z
+	EOF
+'
+
 test_expect_success 'git reflog show' '
 	test_when_finished "git checkout - && git branch -d shown" &&
 	git checkout -b shown &&

-- 
2.54.0

