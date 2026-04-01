Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6A38C42E
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076923; cv=none; b=X2EiI6YMRhmsBdw/yt+E/QVUdbYNSI7bZU36iH91OGc93VBsUUL0DgvvZ0PKWpkfO3TanAPDMk6nqKL5LnsZDOO0LyOa4p6TXNd9M/gQHSCCvr59NoTkfPxvfoPi4WKg6hogtLvrvwWAuvz47u10gL5+u7xlqW8fgRY5KQXCStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076923; c=relaxed/simple;
	bh=oyrEZHo1urILisPwsQKSYbnJ2bMkZdXLAEGB3xMefQI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=dNQDKFkKZvLT0IVi7Ui9QmpC+xhw/QpgbobVY/49OFegSWJsEEDGi1+K5EcAWCVkJXAj5KcewgenhtZXIp21tDFjvE4zH0HXJMgjRCrPdaveOqHrHVAnFU2+wyZPjsbLw+hPZ1IlXkhfuK2H4mUaGm6DaFuOS1KlqGJOcF2NvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=47IjCqWp; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="47IjCqWp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775076917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZisosPiiAp5acy1WB67Xj2yaRXDPba6zidmH7tqQ7U=;
	b=47IjCqWpGw8h7IwlCk9Dt5y/sIN33mjSjxjivd+HMEHKgSEkiBR+ezIUM38UR+QbRKcQTg
	SxO84oeFxv711cHqJuOOEU26QL+IXCKnGVdCs+kfjAbUw8lTSD9YT4V5Z+6fKr6Nx6Svep
	cxyHBwBjLnMK52YPRsA0un9q0XWE1T0=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v3 0/3] Add option --ref to git-replay(1)
Date: Wed, 01 Apr 2026 22:55:09 +0200
Message-Id: <20260401-toon-replay-arbitrary-ref-v3-0-a0b4fabb34b3@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ7CIBhEr9KwFsNPKK0r72Fc0E+wmFoaQGLT9
 O5C3ejGuHyTmTcLCtpbHdChWpDXyQbrxgx8VyHo1XjV2F4yI0ZYTTjjODo3Yq+nQc1Y+c5Gr/y
 cA4OFaqgRppU1SJT3Uw7tc3Ofzm8Oj+6mIRZhafQ2ROfn7TzR0vvnJ1FMsABJJTO1FBqO1kUY9
 uDuqPwk9mkSv0ysmAQnvJGEQftlWtf1BZNDaNceAQAA
X-Change-ID: 20260323-toon-replay-arbitrary-ref-5a81f5f976c7
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
References: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In a previous RFC[1] I suggested to implement subcommands into
git-replay(1). While it would be arguable nice to have subcommands for
the different modes, because git-replay(1) is a plumbing commands, it's
fine to keep a status quo.

This series takes one thing for that RFC though: adding option --ref.
This new option is useful if you want to have full control over which
ref is being updated, and not want to rely on the refs that are using
in the <revision-range> or as the value for --advance and --revert.

These changes answer the needs expressed in[2].

This series is based on Siddharth's series[3] to add '--revert' to
git-replay(1) (sa/replay-revert @ ba5c0d03d3).

[1]: https://lore.kernel.org/git/20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com/
[2]: https://lore.kernel.org/git/CAHTeOx-SMLh_idKhGczPKzZNOKy04uYXmUhL8Z79yRuNpmE4eA@mail.gmail.com/
[3]: https://lore.kernel.org/git/20260313054035.26605-1-siddharthasthana31@gmail.com/

---
Changes in v3:
- In the docs, clarify --ref requires a fully qualified ref, not just a
  branch name.
- Fix crash by initializing merge_opt to `{ 0 }`.
- Link to v2: https://patch.msgid.link/20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com

Changes in v2:
- Dropped the test-only consistency patch.
- Separated commit to mark options as not negatable.
- Modified git-replay(1) docs to everywhere use stuck form.
- Added code and test ensure the revision range has a single tip when
  both --onto and --ref are given.
- Rephrased some comments and docs.
- Link to v1: https://patch.msgid.link/20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com

---
Toon Claes (3):
      builtin/replay: mark options as not negatable
      replay: use stuck form in documentation and help message
      replay: allow to specify a ref with option --ref

 Documentation/git-replay.adoc | 45 +++++++++++++++++++++--------
 builtin/replay.c              | 38 ++++++++++++++++---------
 replay.c                      | 35 +++++++++++++++++------
 replay.h                      |  7 +++++
 t/t3650-replay-basics.sh      | 66 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+), 34 deletions(-)

Range-diff versus v2:

1:  260dff6c82 = 1:  dd46a0efd5 builtin/replay: mark options as not negatable
2:  eca4dffa18 ! 2:  b290493bd0 replay: use stuck form in documentation and help message
    @@ Documentation/git-replay.adoc: git-replay - EXPERIMENTAL: Replay commits on a ne
      SYNOPSIS
      --------
      [verse]
    --(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
    +-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>
     +(EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
     +			     [--ref-action=<mode>] <revision-range>
      
    @@ Documentation/git-replay.adoc: The default mode can be configured via the `repla
      
      <revision-range>::
      	Range of commits to replay; see "Specifying Ranges" in
    --	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
    -+	linkgit:git-rev-parse[1]. In `--advance=<branch>` mode, the
    - 	range should have a single tip, so that it's clear to which tip the
    - 	advanced <branch> should point. Any commits in the range whose
    - 	changes are already present in the branch the commits are being
    +-	linkgit:git-rev-parse[1]. In `--advance <branch>` or
    +-	`--revert <branch>` mode, the range should have a single tip,
    ++	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
    ++	`--revert=<branch>` mode, the range should have a single tip,
    + 	so that it's clear to which tip the advanced or reverted
    + 	<branch> should point. Any commits in the range whose changes
    + 	are already present in the branch the commits are being
     @@ Documentation/git-replay.adoc: EXAMPLES
      To simply rebase `mybranch` onto `target`:
      
    @@ builtin/replay.c: int cmd_replay(int argc,
      	const char *const replay_usage[] = {
      		N_("(EXPERIMENTAL!) git replay "
     -		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
    --		   "[--ref-action[=<mode>]] <revision-range>..."),
    +-		   "[--ref-action[=<mode>]] <revision-range>"),
     +		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
     +		   "[--ref-action=<mode>] <revision-range>"),
      		NULL
3:  2676c2ae78 ! 3:  44e825d9e6 replay: allow to specify a ref with option --ref
    @@ Commit message
         using option '--ref', the refs described above are left untouched and
         instead the argument of this option is updated instead.
     
    +    Because this introduces code paths in replay.c that jump to `out` before
    +    init_basic_merge_options() is called on `merge_opt`, zero-initialize the
    +    struct.
    +
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## Documentation/git-replay.adoc ##
    @@ Documentation/git-replay.adoc: SYNOPSIS
      [verse]
      (EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
     -			     [--ref-action=<mode>] <revision-range>
    -+			     [--ref=<branch>] [--ref-action=<mode>] <revision-range>
    ++			     [--ref=<ref>] [--ref-action=<mode>] <revision-range>
      
      DESCRIPTION
      -----------
    @@ Documentation/git-replay.adoc: incompatible with `--contained` (which is a modif
      	Update all branches that point at commits in
      	<revision-range>. Requires `--onto`.
      
    -+--ref=<branch>::
    ++--ref=<ref>::
     +	Override which reference is updated with the result of the replay.
    ++	The ref must be fully qualified.
     +	When used with `--onto`, the `<revision-range>` should have a
     +	single tip and only the specified reference is updated instead of
     +	inferring refs from the revision range.
     +	When used with `--advance` or `--revert`, the specified reference is
    -+	updated instead of the branch given to those options. This option is
    -+	incompatible with `--contained`.
    ++	updated instead of the branch given to those options.
    ++	This option is incompatible with `--contained`.
     +
      --ref-action[=<mode>]::
      	Control how references are updated. The mode can be:
    @@ builtin/replay.c: int cmd_replay(int argc,
      		N_("(EXPERIMENTAL!) git replay "
      		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
     -		   "[--ref-action=<mode>] <revision-range>"),
    -+		   "[--ref=<branch>] [--ref-action=<mode>] <revision-range>"),
    ++		   "[--ref=<ref>] [--ref-action=<mode>] <revision-range>"),
      		NULL
      	};
      	struct option replay_options[] = {
    @@ builtin/replay.c: int cmd_replay(int argc,
      			     N_("mode"),
      			     N_("control ref update behavior (update|print)"),
     @@ builtin/replay.c: int cmd_replay(int argc,
    - 	die_for_incompatible_opt3(!!opts.onto, "--onto",
    - 				  !!opts.advance, "--advance",
    - 				  !!opts.revert, "--revert");
    + 				  opts.contained, "--contained");
    + 	die_for_incompatible_opt2(!!opts.revert, "--revert",
    + 				  opts.contained, "--contained");
     +	die_for_incompatible_opt2(!!opts.ref, "--ref",
     +				  !!opts.contained, "--contained");
    - 	if (opts.contained && !opts.onto)
    - 		die(_("--contained requires --onto"));
      
    + 	/* Parse ref action mode from command line or config */
    + 	ref_mode = get_ref_action_mode(repo, ref_action);
     
      ## replay.c ##
     @@ replay.c: int replay_revisions(struct rev_info *revs,
    + 	struct commit *last_commit = NULL;
    + 	struct commit *commit;
    + 	struct commit *onto = NULL;
    +-	struct merge_options merge_opt;
    ++	struct merge_options merge_opt = { 0 };
    + 	struct merge_result result = {
    + 		.clean = 1,
    + 	};
      	bool detached_head;
      	char *advance;
      	char *revert;


---
base-commit: 2760ee49834953c0860fa5d7983a6af4d27cb6a9
change-id: 20260323-toon-replay-arbitrary-ref-5a81f5f976c7

