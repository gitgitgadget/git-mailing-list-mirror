Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86A19BBA
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823634; cv=none; b=kv0ABsqfjVlzt6UDfnhHO3qNG+5SS1MLIuBmAfwExlWbcNLXzff/5i08yx8j80TCNQBMK9AANt9t/TDt/GtNn4oZZEKYpq4IFYjSxYJOq/CpVuIIuyx8lE81C3+qFKu+Mx6mgNN9VHr2V4h7x2LTuDgCLle3pNF1/T2UQUvx+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823634; c=relaxed/simple;
	bh=sx+GFGWVUK29BiZ7d4mdYorLs9qqGiJ3TjcLKcurIxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Y+fHuR8PgPzaLTehUBaIxVu0sDrE5P+anwSwiqv7h+baWuB2UqT22XZziViwILrgXHrF/GyKv7q9pyDi2EnXqf25sf6fMJFinc6oLAOp3iyuKZYLWfS//Bz2c3mOaw9noQvo0buu2MprHGScRQI234Z/mecONZVIb5O7tWChQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=P5kF+oP5; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="P5kF+oP5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7rxnwKIi6f0W+Ua3z7ZF0CRim0QKCZotuBSI5Ac9zQ=;
	b=P5kF+oP5ZX9Oer5OJ4tAbbB6Id5VTZwUeb3c7d4DmMrzAfOVNntlSkAEpESvAzPCgUMQkr
	NB8ROXnftY6zt4ToV+sBunRuV/Skq44X9JcSpxTba6T36rsM4A7H30MEICrLpa0HjkTGQ6
	uy+E5fHXUipTkOOUq29m0qvJjMNnu9M=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v7 0/7] Enable doing a shallow clone of a specific git
 revision
Date: Thu, 06 Feb 2025 07:33:28 +0100
Message-Id: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALhXpGcC/23NS2rDMBgE4KsEravwv2RLXfUepQtFlhpBagXbm
 Jbgu1cxtAlxljPwzVzUGIccR/W6u6ghznnMpa+hfdmpcPT9Z9S5q1kRkCCS01MpvQ6n0kc9xDR
 q33FD3LaUHKmqzrXN3+vi+0fNxzxOZfhZD2a8tusWOGrBGmG7R0AQRo3r9lsuUzjtQ/lSVz7TP
 3l6P1N1XfAS0Hk2CI+eb57wiefqUawkHz0D2Ecvf94AMm69aNDkJSVrUJxNj97cPIFsvame28j
 iE1kOm//m3putb6qHwyHY2HTWpe7eL8vyCzsEkX7hAQAA
X-Change-ID: 20241129-toon-clone-refs-ad3623772f92
In-Reply-To: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
References: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The goal of this series is to add an option `--revision` to
git-clone(1).

This series starts with a handful of preparatory refactoring commits
that make it more straight-forward to add this new option. In the last
commit we're actually adding the feature.

This series sets an example on how I think we can further refactor
builtin/clone.c to increase the maintainability of the code.

---
Changes in v7:
- Further enhance documentation of option --revision on git-clone(1).
- Indentation fix in builtin/clone.c.
- Link to v6: https://lore.kernel.org/r/20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com

Changes in v6:
- Rewrite the documentation for git-clone(1) --[no-]tags.
- Remove unneeded conditional around die_for_incompatible_opt2() in
  builtin/replay.c.
- Fix typo in code comment in builtin/clone.c.
- Link to v5: https://lore.kernel.org/r/20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com

Changes in v5:
- Add separate commit to introduce die_for_incompatible_opt2()
- Small tweaks in documentation about `--[no-]tags` and `--revision`.
- Better explain the refactoring of wanted_peer_refs() in the commit
  message.
- Change type from `int` to `size_t` in wanted_peer_refs().
- Use lookup_commit_or_die() instead lookup_commit_reference() to avoid
  checking the result ourself.
- Add a few code comments to explain some things.
- Stylish cleanups like removal of unneeded empty lines, commented out
  test-code and remarks.
- Link to v4: https://lore.kernel.org/r/20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com

Changes in v4:
- Introduce a new commit to reduce the use of global variables.
- Introduce a new commit to invert the flag --no-tags to --tags.
- Introduce a new commit to refactor wanted_peer_refs() in
  builtin/clone.c.
- Introduce a new commit to shuffle the handling of tags refspec.
- Introduce a new commit to introduce a `struct clone_opts`.
- Link to v3: https://lore.kernel.org/r/20241219-toon-clone-refs-v3-1-1484faea3008@iotcl.com

Changes in v3:
- Fail early when the revision was not found on the remote, instead of
  creating a clone that's in an invalid state.
- State more clearly in the commit message adding this option is useful
  for a not uncommon use-case.
- Be explicit in the documentation the ref needs to peel down to a
  commit.
- Die in case we try to update_head() to an object that's not a commit.
- Allow combining `--revision` with `--bare`.
- Add die_for_incompatible_opt2() to parse-options.h and use it for the
  options that are not compatible with the new `--revision` option.
- Small tweaks to the added tests.
- Small touchups on commit messages.
- Link to v2: https://lore.kernel.org/r/20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com

---
Toon Claes (7):
      clone: cut down on global variables in clone.c
      clone: make it possible to specify --tags
      clone: refactor wanted_peer_refs()
      clone: add tags refspec earlier to fetch refspec
      clone: introduce struct clone_opts in builtin/clone.c
      parse-options: introduce die_for_incompatible_opt2()
      builtin/clone: teach git-clone(1) the --revision= option

 Documentation/git-clone.txt |  26 +++-
 builtin/clone.c             | 350 +++++++++++++++++++++++++-------------------
 builtin/replay.c            |   7 +-
 parse-options.h             |   9 ++
 remote.c                    |   2 +-
 remote.h                    |   5 +
 t/meson.build               |   1 +
 t/t5621-clone-revision.sh   | 123 ++++++++++++++++
 8 files changed, 358 insertions(+), 165 deletions(-)
---

Range-diff versus v6:

1:  14e4210ef9 = 1:  e9d0d1bb4e clone: cut down on global variables in clone.c
2:  f85beed07e = 2:  5c570e08f6 clone: make it possible to specify --tags
3:  92b998a173 = 3:  bb5d206ee6 clone: refactor wanted_peer_refs()
4:  3fb2766728 = 4:  344a2f143c clone: add tags refspec earlier to fetch refspec
5:  d0341cad24 = 5:  93d074d17e clone: introduce struct clone_opts in builtin/clone.c
6:  d42f291e48 = 6:  457f21943e parse-options: introduce die_for_incompatible_opt2()
7:  3f332971dc ! 7:  fb4f05547e builtin/clone: teach git-clone(1) the --revision= option
    @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
     +`--revision=<rev>`::
     +	Create a new repository, and fetch the history leading to the given
     +	revision _<rev>_ (and nothing else), without making any remote-tracking
    -+	branch, and without making any local branch, and point `HEAD` to
    -+	_<rev>_. When creating a non-bare repository, the revision is checked
    -+	out on a detached `HEAD`. The argument can be a ref name
    -+	(e.g. `refs/heads/main` or `refs/tags/v1.0`) that peels down to a
    -+	commit, or a hexadecimal object name.
    ++	branch, and without making any local branch, and detach `HEAD` to
    ++	_<rev>_. The argument can be a ref name (e.g. `refs/heads/main` or
    ++	`refs/tags/v1.0`) that peels down to a commit, or a hexadecimal object
    ++	name.
     +	This option is incompatible with `--branch` and `--mirror`.
     +
      `-u` _<upload-pack>_::
    @@ builtin/clone.c: static void update_head(const struct ref *our, const struct ref
     -		struct commit *c = lookup_commit_reference(the_repository,
     -							   &our->old_oid);
     +		struct commit *c = lookup_commit_or_die(&our->old_oid,
    -+						        our->name);
    ++							our->name);
     +
      		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
      		refs_update_ref(get_main_ref_store(the_repository), msg,


---

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20241129-toon-clone-refs-ad3623772f92

Thanks
--
Toon

