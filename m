Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363E185939
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102893; cv=none; b=iSeT+cVEgqRc1vilz8uEJ4VBTQ5gSclMxGZIBaS4sw52NKGVgmoBbIr9khaUVgbTl2zk0yaFUhU1nvQl7K8/8xpLosFjZKazddZQ+YPP3vXKlbV1JGoy0HjtNnbkCtCbkIgmuOoZnRr9ObV6YhZ/fpGF++ihwwV+m9mMI0lwLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102893; c=relaxed/simple;
	bh=M6LhSgFbA4SW+73OR5G+PyeskLP2uvO6nkNGCZReywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAbz5gd03LkiOhdLsa/Xw1KLrYN/6eRUcpwbLDhemOZepryz/mduMjHCINwrJKZP6t/qEXWbmScsibG8fqzYl8fuxT2c3scdejG07NqSTMpZGN795ghKKbwpghc4GvFx8eiL3JytWCZYkIQKVtwyW8tjsKypMo6piUrGMDmjgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=mb7nZVSz; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="mb7nZVSz"
From: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729102888;
	bh=M6LhSgFbA4SW+73OR5G+PyeskLP2uvO6nkNGCZReywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=mb7nZVSzTHWVxzp7IWKEuEvSiLMnlIfEGuO5GYMUTZAMjFDvI2JGRZMHN8gGNY/z1
	 vBo//RXKfn348n2m9whmTfhDJ7nMWqHjmJ3AAg+tVCT0MK5TkiamlpISlIR2uZ3CJl
	 5VRbPyNH59rawWwbOlXSCRVUi1Z9NCpr43uYSyi0LNPqT8C6NaX+VGnp9320h1NNSb
	 T5kyU4KFVoYljjP83tYpruRP5G46lL4OT0z/MtfftDi8KKk52PQ3ITiz94Xft5jnrA
	 aB7xJuaHopZbSj3Ewvqh1KzDXXOpiKfnuLaoYSx3ID7S02aHV06mNLV17K0ezHoo6f
	 0xetuO4X1Lvkg==
To: git@vger.kernel.org
Cc: =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [PATCH v3 0/2] builtin/shortlog: explicitly set hash algo when there is no repo
Date: Wed, 16 Oct 2024 20:21:22 +0200
Message-ID: <20241016182124.48148-1-wolf@oriole.systems>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011183445.229228-1-wolf@oriole.systems>
References: <20241011183445.229228-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here's v3 of this series. CI should now pass as the code has been moved
below any declarations. The regression test has been simplified, thanks
to Eric's input.

I added another commit with a test for git-shortlog(1) that makes sure
it can process logs obtained from a repo with --object-format=sha256.
Thanks to Patrick for the suggestion and pointers.

Wolfgang Müller (2):
  builtin/shortlog: explicitly set hash algo when there is no repo
  shortlog: Test reading a log from a SHA256 repo in a non-git directory

 builtin/shortlog.c  | 12 ++++++++++++
 t/t4201-shortlog.sh | 12 ++++++++++++
 2 files changed, 24 insertions(+)

Range-diff against v2:
1:  d3047a0291 ! 1:  4813b458ac builtin/shortlog: explicitly set hash algo when there is no repo
    @@ Commit message
         add a regression test for the segfault.
     
         Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
    +    Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
     
      ## builtin/shortlog.c ##
     @@ builtin/shortlog.c: int cmd_shortlog(int argc,
    - 	struct rev_info rev;
    - 	int nongit = !startup_info->have_repository;
    + 
    + 	struct parse_opt_ctx_t ctx;
      
     +	/*
     +	 * NEEDSWORK: Later on we'll call parse_revision_opt which relies on
    @@ builtin/shortlog.c: int cmd_shortlog(int argc,
     +	if (nongit && !the_hash_algo)
     +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
     +
    - 	const struct option options[] = {
    - 		OPT_BIT('c', "committer", &log.groups,
    - 			N_("group by committer rather than author"),
    + 	git_config(git_default_config, NULL);
    + 	shortlog_init(&log);
    + 	repo_init_revisions(the_repository, &rev, prefix);
     
      ## t/t4201-shortlog.sh ##
     @@ t/t4201-shortlog.sh: fuzz()
    @@ t/t4201-shortlog.sh: fuzz()
      '
      
     +test_expect_success 'shortlog --author from non-git directory does not segfault' '
    -+	git log --no-expand-tabs HEAD >log &&
    -+	env GIT_DIR=non-existing git shortlog --author=author <log 2>out
    ++	echo | nongit git shortlog --author=author
     +'
     +
      test_expect_success 'shortlog should add newline when input line matches wraplen' '
-:  ---------- > 2:  9dfdc7510f shortlog: Test reading a log from a SHA256 repo in a non-git directory
-- 
2.47.0

