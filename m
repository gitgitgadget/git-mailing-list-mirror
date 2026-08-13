Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1E12E1DC
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647926; cv=none; b=BVpPL+Kh6wF10ltpCw97d8+DoJgrTHuaEvs4ALp+sbcWkaevxnsEP/QKnWT45+qt7jwIIJb8akFgtwZ7QZLfVT8W+m4zICHSzhZCS13KvJ2ClowgjDyIp4lFG0tGuPxCQVl4TLuhasLAfuv/UwJNzcRhXqosBbcY2AAviQcOCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647926; c=relaxed/simple;
	bh=k0Al38aWFlAUDFL/Z4cgu36mw5faZoG0gx1oICBLLHk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=U1LIEbm3E6N9xye/ict4r17bd/9ZgBD2A7OLiGWoVGcBXu5j2+Zi2tJdH/yJ2mCwQ2eF86hFHVJKh8WMNuRloAIYDi01VHp+Dnp/h/ks9Dmvm2efBl5b8maEis9c+dsRmMXQRJ4KeEAN+qvlxIISgVuupOipN6GkZCDUbeUIOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYs5YAXm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYs5YAXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5885D1F000E9;
	Thu, 13 Aug 2026 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647925;
	bh=DR6DLM19EwjE6yUx0cgfa+x1aN/G9f7mjBlZNdUfm/s=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc;
	b=HYs5YAXmgXsuYXsT3YkmYcL8RvMdtIOqI4RjPV124xgiLHqgEtTblTo1dFGSVUzqA
	 T6sjQ38QCXYV35/sBGrGh+NMt1FkVcSAxwCATVtAnQUCO0iwuYl9t6SF/8DTjmLmmd
	 jp38+GvY/c/dqsLZQFsiY5EiSyQjl3mRDXJJG6PYyPRlC6D9HSb6JM91e01zfjY6WR
	 YdaDeBdAfYHac+QeZyG3w3p/0pOo5SpluTCVc1G39MoK3mwYyFz17xJAlQ7lxlnjnw
	 G6ZnxbzybjrSPGxHsF7TxbKaCKIGF4uGDNTHULfK/vwUA+u4p25PSP4vcpO02GLPaa
	 Pf0yNBHjAbCtg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v3 0/4] completion: add support for 'git history'
Date: Thu, 13 Aug 2026 21:05:01 +0200
Message-Id: <20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBCF4auQrq2ZjtCiK+9hjME6hUakpMVGQ
 7i7hbjQhXH5T/K+GVkgbymwXTYyT9EG67oUm1XGdFN1NXF7Sc0QUEIJOW9sGJx/nqr74LS79S0
 NacLLXCJoNGUBwNK492TsY4EPx9Tv2fInivn6l4yCCy6NyoutMWep1P5KvqN27XzNZjPipyN/O
 siBK5JgCqyERvhypml6Acn4pXUFAQAA
X-Change-ID: 20260804-history_autocompletion-84620c2f8500
In-Reply-To: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Ben Knoble <ben.knoble@gmail.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4579; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=k0Al38aWFlAUDFL/Z4cgu36mw5faZoG0gx1oICBLLHk=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFl1onlbr8SqXZuQFaY701a7/sfVHeGRfBZtc+6bilre9
 Hnw5t7zjoksDGJcDJZiiizLyjm5FToKvcMO/bWEmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 gQwdIwYuTgGY6vrdjAwfraZe5nfZ3uj89UHBr30PxO595LhxuYN3u/z873d9C9ijGf5nJZWmRrt
 ctE3hOnHdSHBO/wp56wjnTsGFC5j37HaZ1skOAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This series adds Bash completion for the subcommands of "git history"
and their options.

Patch #1 adds the basic subcommand and options completion. Patch #2 and

options. Finally, Patch #4 adds completion for pathspecs accepted by
"split".

For each of the completions, add a set of relevant test cases.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - Ignore the split "<option> <value>" syntax for options that take
    arguments. This simplifies revision detection and avoids hard-coding
    option names.
  - Test that options are not completed before a subcommand.

Link to v2: https://lore.kernel.org/r/20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org

Changes in v2:

  - Complete exactly one required revision and leave subsequent
    arguments to subcommand-specific completion.
  - Do not complete options after "--".
  - Complete values for "--empty" and "--update-refs".
  - Complete pathspecs for "git history split".
  - Expand the test coverage for options, revisions, and pathspecs.

Link to v1: https://lore.kernel.org/r/20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org

---
Vincent Mailhol (4):
      completion: add 'git history' subcommands
      completion: complete 'git history --empty' values
      completion: complete 'git history --update-refs' values
      completion: complete 'git history split' pathspecs

 contrib/completion/git-completion.bash | 65 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh                  | 50 ++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

Range-diff versus v2:

1:  529ecbe28c ! 1:  5764875d09 completion: add 'git history' subcommands
    @@ Commit message
     
         Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
         ---
    +    Changes in v3:
    +
    +      - Ignore the split "<option> <value>" syntax for options that take
    +        arguments. This simplifies revision detection and avoids hard-coding
    +        option names.
    +      - Test that options are not completed before a subcommand.
    +
         Changes in v2:
     
           - Test options before and after revisions.
           - Do not complete options after "--".
    -      - Stop revision completion after the first required
    +      - Stop revision completion after the first required revision.
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_help ()
    @@ contrib/completion/git-completion.bash: _git_help ()
     +
     +	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
     +		case "${words[i]}" in
    -+		--empty|--update-refs)
    -+			((i++))
    -+			;;
     +		-*)
     +			;;
     +		*)
    @@ t/t9902-completion.sh: test_expect_success 'git clone --config= - value' '
      '
      
     +test_expect_success 'git history subcommands' '
    -+	test_completion "git history " <<-\EOF
    ++	test_completion "git history " <<-\EOF &&
     +	drop Z
     +	fixup Z
     +	reword Z
     +	split Z
     +	EOF
    ++	test_completion "git history --" ""
     +'
     +
     +test_expect_success 'git history subcommand options' '
    @@ t/t9902-completion.sh: test_expect_success 'git clone --config= - value' '
     +
     +test_expect_success 'git history revisions' '
     +	test_completion "git history split ma" "main " &&
    -+	test_completion "git history split --update-refs head ma" "main " &&
    -+	test_completion "git history fixup --empty drop ma" "main " &&
    ++	test_completion "git history split --update-refs=head ma" "main " &&
    ++	test_completion "git history fixup --empty=drop ma" "main " &&
     +	test_completion "git history reword main m" ""
     +'
     +
2:  691965330f < -:  ---------- completion: complete 'git history --empty' values
3:  02303a7762 < -:  ---------- completion: complete 'git history --update-refs' values
-:  ---------- > 2:  224fb8dc32 completion: complete 'git history --empty' values
-:  ---------- > 3:  60a54d5a8b completion: complete 'git history --update-refs' values
4:  39823df359 ! 4:  c895589110 completion: complete 'git history split' pathspecs
    @@ Commit message
     
         Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
         ---
    +    Changes in v3:
    +
    +      - No changes.
    +
         Changes in v2:
     
           - New patch.

---
base-commit: 4f2b99511996c64e58c74e2b8bd3d7ec33452a47
change-id: 20260804-history_autocompletion-84620c2f8500

