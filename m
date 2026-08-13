Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FE41D200
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647935; cv=none; b=hQSaDlQ2OSf7+d2wHIagH+X4SgqKBEtU8u9NIFCMCuNxJCinhJxVSVHvyYNLOdle3BcMTKZftrtGdhSOKpJQTECks1Mb5oAWwiulagBI5o7g93E0K0QylhdBF7XpF97yinfxfCuIxVB7J0sWFxHSA62JJFSfLKHwitt/E81Vg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647935; c=relaxed/simple;
	bh=f8d02eEPJiX07iXfsggiZW0Xd8C39kAnKLAZ/YkemrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KW31gZ0iVYwkLjEPzYIlS39m5mSAljB5Xb5JgztFmheOLg3zUWwPczdob7F+2PT/SP8JuswntX54Yq7JvSJe7QfBm+Oo5iNUMw2WsJ2ThJBFiRwbmcSI0IfUYMhmJKPssESNIvxohlG4rD9ujHqSrNjvyb1z5e8I0QoRRleq6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNkdQ0aD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNkdQ0aD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A064D1F000E9;
	Thu, 13 Aug 2026 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647934;
	bh=b3sPK48AJeF5tWjV+A8fvX4bLTI12DqXIiKuIEuW62g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KNkdQ0aDP//xRIFQu2EoPkSsfstIk+VSTzF7V09ii9WpETIzn74gT2JyEIOLNG57G
	 6RVkCoR/KzlfON2+0NOOFbiSmyPOMUHiH0w1nEmz2pITX0cGmxanHEyk5t6dMVfHy/
	 bXRpZXSzQnn0+pul2qr+S2TgGTbyam1ff+aHsoaEs3Cb19b8tQlovyu5JKMPDzCKi5
	 ZeqY+Ho/YMNg7bJFRoH+2ze1V66TljRszjlmmAe8HQVdgpxuKOhqJd9Zy7/N6WZHhN
	 F9lBVTvl3uKcl9D+qfw4+AqJK+KUY+BAMCAb+3LAjpJTLnWMBu9nR91rfdayO7pvPI
	 Djj6bpRwVV3sw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 13 Aug 2026 21:05:05 +0200
Subject: [PATCH v3 4/4] completion: complete 'git history split' pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-history_autocompletion-v3-4-69eed1cea93a@kernel.org>
References: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
In-Reply-To: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=f8d02eEPJiX07iXfsggiZW0Xd8C39kAnKLAZ/YkemrA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFl1okXrOdeqTvgjsdW/IYbD+mmE7/f7c9h1mSe4PbjXX
 qDd+mt+x0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBMdXEHw//Urc/fLNzpxXt4cSb77EeHWY+mfOj3+SnHsy2/Y+/9BdZHGf7X36n4sak
 i2ujips1bdlzl8earPj2jilOyv+Ttt32isk7sAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Arguments following the required revision of "git history split" are
pathspecs. Complete them from tracked paths, including after an explicit
"--".

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - No changes.

Changes in v2:

  - New patch.
---
 contrib/completion/git-completion.bash |  6 ++++++
 t/t9902-completion.sh                  | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 19600940dc..6172b6182f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2194,6 +2194,12 @@ _git_history ()
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
index b225dd3800..194bca8d6c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3144,6 +3144,19 @@ test_expect_success 'git history revisions' '
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

