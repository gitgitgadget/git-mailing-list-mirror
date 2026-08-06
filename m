Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B004DBD96
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048067; cv=none; b=H/zv8kcPXwHiObVAVqmB4KzEr5cURqIJVUrd2J1JYZsCJ5BmNJ44K9e4XiFm8lisVeRLVmpXplblHSbNaiJmynurzh79l+c3BEfuEVd1NfH7a9oPt3zH8WlComTpLnW7AbIB9vPUd0E75L8EtcOLuxDUZPoryd/Cjyl8IftZoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048067; c=relaxed/simple;
	bh=Cn5yXc2BM6it8ADcHTSTNV9IxGxGNQJZlk6OEtsx9OU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JODf4xXix2zt26oIX5mh2rbF1/TP78yTj38Fe2IrEh5acX9NwiKZ8lhxWrwtV24kx8Z2cVt/B8DlfzUWTYT5r5P8S1YvRbtsybutGGVwCez+9OhB0DgFF3ocDXuT91CZRPBMNj3SbSIoIW4bsaHiIAhg2DCD2YxwgeTTiDO5gXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyO0eBkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyO0eBkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A031F00A3A;
	Thu,  6 Aug 2026 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048066;
	bh=bJQ0r+9Qde0KTa2lJf1Q6ZAb8h1qmtbvlwsBtP8HBgc=;
	h=From:Subject:Date:To:Cc;
	b=AyO0eBkBzYy0tEQzyCtvWPkcQXKPwXeqHA5tAw6fVUm1+ME4H4MRBwMYFiX8X9c/o
	 6kMFBZIKunOvqNRx6B3fwmVXqVs7mXn4VKhAOt4+55jfWfQyR6MoCDLT6lo2wV8vYe
	 nd2l8SRe99QLO6NKR1FulQUbNb+oPtAd1r7zgXmb8UtmBlsArkPzBsMuprBBpmxp0j
	 Y/GxlWXBxAfzldijacr0MGhoQUCHujJZYDS+AWHi6k8jApgcuAM26C2a8fcPQWfhoe
	 MwuK5Sm81hPbL2x6C5dsOgP1QeApztU4YDe3y6npFzHFibpHnbEztlyymA0G+5bssd
	 IHsASvvJNJkQg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 0/4] completion: add support for 'git history'
Date: Thu, 06 Aug 2026 22:27:35 +0200
Message-Id: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ7CIBQFr9L8tRhKKKAr72EaU/HTEis0gETTc
 Hexce9yXjLzVogYLEY4NisEzDZa7yqwXQN6GtyIxN4qA6NMUEU5mWxMPrwvwzN57R/LjKkqRHH
 BqGZGdZRClZeAxr628Lmv/NO2n9x+17/J3JKWCCN5dzDmKqQ83TE4nPc+jNCXUj7Q3O3ivQAAA
 A==
X-Change-ID: 20260804-history_autocompletion-84620c2f8500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Philippe Blain <levraiphilippeblain@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5332; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Cn5yXc2BM6it8ADcHTSTNV9IxGxGNQJZlk6OEtsx9OU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFkl7+xF79o8cLoc33GqcM0+sfIifq5jM5OL0xrO6Snr6
 Kf0bz3aMZGFQYyLwVJMkWVZOSe3Qkehd9ihv5Ywc1iZQIZIizQwAAELA19uYl6pkY6Rnqm2oZ4h
 kKFjxMDFKQBTHcjOyLD5XGuc1mnv/qQtC+e7f18xO1hl3zd3hp9yX/VWis4pyA9lZNj49sizQDV
 d39ftuqkBHulX/F2F2m6d/uO04vDVhZFfCvgA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

This series adds Bash completion for the subcommands of "git history"
and their options.

Patch #1 adds the basic subcommand and options completion. Patch #2
and #3 take care of the value of the --empty and --update-refs options.
Finally, Patch #4 adds completion for pathspecs accepted by "split".

For each of the completions, add a set of relevant test cases.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
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

 contrib/completion/git-completion.bash | 68 ++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh                  | 49 ++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

Range-diff versus v1:

1:  d0574dca8c ! 1:  6625c7ac29 completion: add 'git history' subcommands
    @@ Metadata
      ## Commit message ##
         completion: add 'git history' subcommands
     
    -    Use the parse-options completion helpers for the "git history"
    -    subcommands and their options. Complete positional arguments as
    -    revisions, and add coverage for each kind of completion.
    +    Use the parse-options completion helpers for the
    +
    +      git history
    +
    +    subcommands and their options. All current history subcommands take a
    +    revision as their first positional argument, so complete that argument
    +    as a revision.
    +
    +    Once the revision is present, leave any further positional arguments to
    +    subcommand-specific completion. This allows a subcommand to complete
    +    another kind of argument, such as the pathspec accepted by
    +
    +      git history split
    +
    +    or another revision if a future subcommand accepts one.
     
         Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
    +    ---
    +    Changes in v2:
    +
    +      - Test options before and after revisions.
    +      - Do not complete options after "--".
    +      - Stop revision completion after the first required
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: _git_help ()
      	fi
      }
      
    ++__git_history_has_revision ()
    ++{
    ++	local i
    ++
    ++	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
    ++		case "${words[i]}" in
    ++		--empty|--update-refs)
    ++			((i++))
    ++			;;
    ++		-*)
    ++			;;
    ++		*)
    ++			return 0
    ++			;;
    ++		esac
    ++	done
    ++	return 1
    ++}
    ++
     +_git_history ()
     +{
     +	local subcommands subcommand
    @@ contrib/completion/git-completion.bash: _git_help ()
     +		return
     +	fi
     +
    -+	case "$cur" in
    -+	--*)
    -+		__gitcomp_builtin "history_$subcommand"
    -+		;;
    -+	*)
    ++	if ! __git_has_doubledash; then
    ++		case "$cur" in
    ++		--*)
    ++			__gitcomp_builtin "history_$subcommand"
    ++			return
    ++			;;
    ++		esac
    ++	fi
    ++
    ++	if ! __git_history_has_revision; then
     +		__git_complete_refs
    -+		;;
    -+	esac
    ++		return
    ++	fi
     +}
     +
      _git_init ()
    @@ t/t9902-completion.sh: test_expect_success 'git clone --config= - value' '
     +'
     +
     +test_expect_success 'git history subcommand options' '
    -+	test_completion "git history fixup --upd" "--update-refs="
    ++	test_completion "git history split main --" <<-\EOF &&
    ++	--update-refs=Z
    ++	--dry-run Z
    ++	--no-dry-run Z
    ++	EOF
    ++	test_completion "git history fixup --upd" "--update-refs=" &&
    ++	test_completion "git history fixup --ree" "--reedit-message " &&
    ++	test_completion "git history split --upd" "--update-refs=" &&
    ++	test_completion "git history split main --dry" "--dry-run " &&
    ++	test_completion "git history reword main -- --d" ""
     +'
     +
     +test_expect_success 'git history revisions' '
    -+	test_completion "git history split ma" "main "
    ++	test_completion "git history split ma" "main " &&
    ++	test_completion "git history split --update-refs head ma" "main " &&
    ++	test_completion "git history fixup --empty drop ma" "main " &&
    ++	test_completion "git history reword main m" ""
     +'
     +
      test_expect_success 'git reflog show' '
-:  ---------- > 2:  f618f35153 completion: complete 'git history --empty' values
-:  ---------- > 3:  abae09f208 completion: complete 'git history --update-refs' values
-:  ---------- > 4:  7bfb6664dc completion: complete 'git history split' pathspecs

---
base-commit: c56d675cccfbcf71406c4a6806c7745e4a756294
change-id: 20260804-history_autocompletion-84620c2f8500

