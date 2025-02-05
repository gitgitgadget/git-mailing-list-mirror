Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804461519AB
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774056; cv=none; b=spM1k9QjFOphS/UQhsIUR3+3inbQ8Dm11BJJhhdUe8v8jtbcPTK6xsN/hPKaJ2yYl/OxrfGBaFpeC4LEvgWW/b6wOSl/KfKMdQS1O1HlFqf/BPezHx+CeMTmK/HTrMXrh21cKzC1mIje4CkLMaUvvXcJUjaRKoC4swo+f+q1WPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774056; c=relaxed/simple;
	bh=1NtTbDGACWEe8LRd1nCGHtgpl+Oltf8oYOj/ChO1dqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Gph8Gmn+Dmbxumy88EZdgPUJj7qZ6dHIPDRD3Fg4pZeLyUm/oAjGMT2UMSmIpzh8O5AWznorjZA60jC4NhxN3S/AxUXhZfoI59PF2Zm4ubKrtQzglZpk4yludoHrQF82YZaYMhMpWmMjO6n493f6gkmRQdZkfVetaBXsBRDKZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=KL7mcY1C; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="KL7mcY1C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738774047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4zO0vUfUzKZz6bl/tNSWfgQbrut22ErVthtyp/bGC4=;
	b=KL7mcY1C4cXMijCkiWg0T4BeTKirJcMmSFr370dJ1wAZxQvrjEyYTmo23MQ6veXbSmj/SO
	woyRQq/uGWgzwW1WGphQ3Tu0hbRPi+HVjMqMIBiOFAsDjpnuN0tmV9aLPwqyEw3gWgI+2y
	UG6JJAIST91KWFpXIGvJyOJHV90Pems=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v6 0/7] Enable doing a shallow clone of a specific git
 revision
Date: Wed, 05 Feb 2025 17:47:15 +0100
Message-Id: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOWo2cC/23NS2rDMBgE4KsEravwvxRLXfUeoQshS40gtYplT
 EPw3asY2lAnyxn4Zq6qxjHHql53VzXGOddchhYOLzsVTn74iDr3LSsCEkRyeipl0OFchqjHmKr
 2PR+Iu46SI9XUV2vz97p4fG/5lOtUxst6MOOtXbfAUQfWCNs9AoIwaly333KZwnkfyqe68Zn+y
 NP7mZrrg5eAzrNB2Hq+e8InnptHsZJ89Axgt15+vQFkfPSiQZOXlKxBcTZtvbl7Ann0pnnuIot
 PZDn8+1+W5QeZthuHoQEAAA==
X-Change-ID: 20241129-toon-clone-refs-ad3623772f92
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
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

 Documentation/git-clone.txt |  27 +++-
 builtin/clone.c             | 350 +++++++++++++++++++++++++-------------------
 builtin/replay.c            |   7 +-
 parse-options.h             |   9 ++
 remote.c                    |   2 +-
 remote.h                    |   5 +
 t/meson.build               |   1 +
 t/t5621-clone-revision.sh   | 123 ++++++++++++++++
 8 files changed, 359 insertions(+), 165 deletions(-)
---

Range-diff versus v5:

1:  fa3f2f1f03 = 1:  7d4d3bcc70 clone: cut down on global variables in clone.c
2:  f88780b503 ! 2:  284f2fc20f clone: make it possible to specify --tags
    @@ Documentation/git-clone.txt: corresponding `--mirror` and `--no-tags` options in
      
     -`--no-tags`::
     -	Don't clone any tags, and set
    +-	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
    +-	that future `git pull` and `git fetch` operations won't follow
    +-	any tags. Subsequent explicit tag fetches will still work,
    +-	(see linkgit:git-fetch[1]).
     +`--[no-]tags`::
    -+	With `--no-tags`, no tags are cloned, and set
    - 	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
    - 	that future `git pull` and `git fetch` operations won't follow
    - 	any tags. Subsequent explicit tag fetches will still work,
    - 	(see linkgit:git-fetch[1]).
    -+	By default tags are cloned, and passing `--tags` doesn't change that.
    ++	Control whether or not tags will be cloned. When `--no-tags` is
    ++	given, the option will be become permanent by setting the
    ++	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
    ++	future `git pull` and `git fetch` won't follow any tags. Subsequent
    ++	explicit tag fetches will still work (see linkgit:git-fetch[1]).
    ++
    ++	By default, tags are cloned and passing `--tags` is thus typically a
    ++	no-op, unless it cancels out a previous `--no-tags`.
      +
      Can be used in conjunction with `--single-branch` to clone and
      maintain a branch with no references other than a single cloned
3:  1289437661 = 3:  9114e6123d clone: refactor wanted_peer_refs()
4:  9687626855 ! 4:  52807dfdba clone: add tags refspec earlier to fetch refspec
    @@ builtin/clone.c: int cmd_clone(int argc,
     +	if (option_tags || option_branch)
     +		/*
     +		 * Add tags refspec when user asked for tags (implicitly) or
    -+		 * specified --branch, which argument might be a tag.
    ++		 * specified --branch, whose argument might be a tag.
     +		 */
     +		refspec_append(&remote->fetch, TAG_REFSPEC);
     +
5:  c95f9d4f1b = 5:  3a80a479a6 clone: introduce struct clone_opts in builtin/clone.c
6:  96f92993fd ! 6:  5ef027f7a1 parse-options: introduce die_for_incompatible_opt2()
    @@ Commit message
     
      ## builtin/replay.c ##
     @@ builtin/replay.c: static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
    + 	get_ref_information(cmd_info, &rinfo);
      	if (!rinfo.positive_refexprs)
      		die(_("need some commits to replay"));
    - 	if (onto_name && *advance_name)
    +-	if (onto_name && *advance_name)
     -		die(_("--onto and --advance are incompatible"));
    -+		die_for_incompatible_opt2(!!onto_name, "--onto",
    -+					  !!*advance_name, "--advance");
    - 	else if (onto_name) {
    +-	else if (onto_name) {
    ++
    ++	die_for_incompatible_opt2(!!onto_name, "--onto",
    ++				  !!*advance_name, "--advance");
    ++	if (onto_name) {
      		*onto = peel_committish(onto_name);
      		if (rinfo.positive_refexprs <
    + 		    strset_get_size(&rinfo.positive_refs))
     
      ## parse-options.h ##
     @@ parse-options.h: static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
7:  9163c9bc85 = 7:  2eaae62e16 builtin/clone: teach git-clone(1) the --revision= option


---

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20241129-toon-clone-refs-ad3623772f92

Thanks
--
Toon

