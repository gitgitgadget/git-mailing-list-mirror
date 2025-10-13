Received: from mail.lohmann.sh (mail.lohmann.sh [23.88.42.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8A2F9DB2
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.42.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391996; cv=none; b=Q7B2qFkjN9Qb5NivKAhy2gp76EF+/Kc0KHJhml0KzO2042oBQKysOQ2gPK3eal5/zc8bXzxbuNJeI50wY60SnHL6kHKuiF5HMoV/MiAOkJAt4eEbBrNxlnn20xbXkoLPfyzcsshcHly7zBt2hlRXsu6hDDcAvwEKDxw23PbTIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391996; c=relaxed/simple;
	bh=efHIAksGHjkbS9wBN+JGIMFqMTIeuBiT6WK/K2OB4cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5f/krsOj9Xo+eHMY4XmEwga1g85NO3vJPZbFfhBES2OxKi/KJAqnlQvufu9ocPvW7x9aSy8qwRCbRGr6oJTCOxhNirCh81bHEra05WKUSRoQ+K4gEkbV5zlBiogVmC8lJlSqkU06KMybgn6oKoyPXI4kuzz61rn7UwU1jFO71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh; spf=pass smtp.mailfrom=lohmann.sh; dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b=ZN0BAcmg; arc=none smtp.client-ip=23.88.42.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lohmann.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lohmann.sh header.i=@lohmann.sh header.b="ZN0BAcmg"
From: Michael Lohmann <git@lohmann.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lohmann.sh; s=mail3;
	t=1760391988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMFP307gM6VjgWcxoa1YtpC55cBe07oD6RXkvaoNcwQ=;
	b=ZN0BAcmgQWZbl1CEaTy6AG0DOGpjhwem4h9gdblEQUf8A0tiKCZI9JZasYSgJ4Ocg7tXtO
	OuuARsKwTGt2fYwnzoP//3I4+7C9pGmeVyG1Vv2yMY6TLaXBOL/jQxZpDYFA88AARqp006
	s/KQ4eb9B+7cz6REC1B7re81Z2hP6j3c3OEGGa8f2o9rOkYpEnNldUITHmsDMt5J4+N7Kl
	kKVZyjEaUBaMax5sBgaQ0TJ/OVLKHQiF8xDVdvzfNyejiJER1MgMJfxkFE9iBMnk6LNdEv
	CV++T0TDK1EPupYFE6LWIvJTy61Ojp3vh669D47Y2/rxPukPCJir/dnQGY+j+w==
To: ben.knoble@gmail.com
Cc: git@lohmann.sh,
	git@vger.kernel.org
Subject: [PATCH v2 0/5] Apply comments of D. Ben Knoble
Date: Mon, 13 Oct 2025 23:46:03 +0200
Message-ID: <20251013214608.33581-1-git@lohmann.sh>
In-Reply-To: <CALnO6CBLr2iL0r+ywM4Vjw0=J2DNFv9Nhhq_PHuxt4eK=Z95ww@mail.gmail.com>
References: <CALnO6CBLr2iL0r+ywM4Vjw0=J2DNFv9Nhhq_PHuxt4eK=Z95ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks!

Michael Lohmann (5):
  setup: rename `ensure_safe_repository()` for clarity
  setup: rename `die_upon_assumed_unsafe_repo()` to align with check
  setup: refactor `ensure_safe_repository()` testing priorities
  setup: allow temporary bypass of `ensure_safe_repository()` checks
  setup: allow not marking self owned repos as safe in
    `ensure_safe_repository()`

 Documentation/config/safe.adoc    |  9 ++++
 Documentation/git.adoc            | 25 +++++++++++
 builtin/clone.c                   |  2 +-
 environment.h                     |  2 +
 git.c                             |  9 ++++
 path.c                            |  4 +-
 setup.c                           | 45 ++++++++++++++------
 setup.h                           |  2 +-
 t/meson.build                     |  1 +
 t/t0036-allow-unsafe-directory.sh | 70 +++++++++++++++++++++++++++++++
 10 files changed, 153 insertions(+), 16 deletions(-)
 create mode 100755 t/t0036-allow-unsafe-directory.sh

Range-diff against v1:
1:  3f8805eb96 = 1:  3f8805eb96 setup: rename `ensure_safe_repository()` for clarity
2:  aa09159dec = 2:  aa09159dec setup: rename `die_upon_assumed_unsafe_repo()` to align with check
3:  ad4f64fdb8 = 3:  ad4f64fdb8 setup: refactor `ensure_safe_repository()` testing priorities
4:  db31fdef4e = 4:  db31fdef4e setup: allow temporary bypass of `ensure_safe_repository()` checks
5:  f65fd1c4fa ! 5:  6f710af1da setup: allow not marking self owned repos as safe in `ensure_safe_repository()`
    @@ Documentation/config/safe.adoc: which id the original user has.
     +safe.assumeUnsafe::
     +	Boolean to indicate that the ownership of a repository should not
     +	be taken into account when checking if the repository is safe. It
    -+	will prevent against accidental arbitrariy code execution
    ++	will prevent against accidental arbitrary code execution.
     ++
     +To temporarily allow git execution in case of an assumed unsafe repository,
     +run the command with `--allow-unsafe`. To permanently trust this path, add
    @@ Documentation/git.adoc: If you just want to run git as if it was started in `<pa
     +	Prevent arbitrary code execution by hooks or configuration if not
     +	executed in a "safe.directory". With setting this, filesystem ownership
     +	of the repository in question no longer satisfies to mark it as safe.
    -+	Equivalent to setting `GIT_ASSUME_UNSAFE=1`. This is overwritten if
    ++	Equivalent to setting `GIT_ASSUME_UNSAFE=1`. This is overridden if
     +	`--allow-unsafe` is passed as well.
     +
      GIT COMMANDS
    @@ Documentation/git.adoc: Git so take care if using a foreign front-end.
     +`GIT_ASSUME_UNSAFE`::
     +	This Boolean environment variable can be set to true enforce
     +	explicit "safe.directory" configuration for the repository. This
    -+	can be overwritten by setting `GIT_ALLOW_UNSAFE`.
    ++	can be overridden by setting `GIT_ALLOW_UNSAFE`.
     +
      `GIT_INDEX_FILE`::
      	This environment variable specifies an alternate
    @@ t/t0036-allow-unsafe-directory.sh: test_expect_success 'GIT_ALLOW_UNSAFE bool al
     +	grep "dubious ownership" err
     +'
     +
    -+test_expect_success 'allow-unsafe must overwrite assume-unsafe' '
    ++test_expect_success 'allow-unsafe must override assume-unsafe' '
     +	env GIT_ASSUME_UNSAFE=1 git --allow-unsafe status
     +'
     +
-- 
2.50.1 (Apple Git-155)

