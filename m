Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AB26ED33
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048427; cv=none; b=HQaCiDqUAtVv/qgi8fhvcHg3OMTvNGyUdaJAH2aNZDjigvq7+9E159Sk2KsLnXRxfeNpZY7g8xWgJ3LwolYTuVyYSCNY/Bsbo7sIG9AMay1Iz+fz4m9AenGaolfqPqrEn+HJ/R8s+lWvRM/E8n6BtZW/PgbdEUDowUjdmEE++P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048427; c=relaxed/simple;
	bh=srt1rc2zixmmVAlprY6nwCXBccVgmX6AJVS0VWVd9i0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bnWzlamy+h1GReLkyUj4j8jre7sOrcBpecABWGTp0sXn/5ArXcezAll78s45ek1jovX90aEI7c/a7saRZuQG1C4kMXOsSFmlV+kxK9Ww4njXOo+bYGKhSifoYqt4srkBwscrMZJul59oME7PsGidLcDlPJ+hhLjQXpO/EHu2gic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2FEOUsm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2FEOUsm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12113C19425;
	Fri,  3 Jul 2026 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783048427;
	bh=srt1rc2zixmmVAlprY6nwCXBccVgmX6AJVS0VWVd9i0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N2FEOUsmdcZlNq73rJcSiFMzPLQ3/wGqWth7DNWUPrI6uwdnPd1xaFiGV9pmjHtQr
	 mmMqy+5CIJgvx8TZykcoOcXQysbyh88KQjKoz5iMH2+l86jHu9etIhvNez+VZhBGGI
	 zFuNnuQR705Pj3zmD8JZIQOb393wwQ8xgB7RgG7gdDulDS0wrRkRncRt5m9JV4aIQ6
	 rQA2r9SqXwOXl/gj7cF+4KQd9DE1IyxVKXNkW7vUpbW/OZY8ntlsBPYP8JNIyzAVzh
	 x25V+mV/gRl+FtCzVan1riDgh39f6mAEd2k7fp5cDGI5FRRimLP2plcG+KhyptUzgV
	 /OndIkeoYxDdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E176DC43458;
	Fri,  3 Jul 2026 03:13:46 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v6 0/2] includeIf: add "worktree" condition for matching
 working tree path
Date: Fri, 03 Jul 2026 11:13:16 +0800
Message-Id: <20260703-includeif-worktree-v6-0-a13893ad9a7f@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwoR2oC/33QwU7DMAwG4FeZcibIcZq04cR7IA5N4rCoU4uSU
 UBT3x13FyoRcfxt+bPlm6hUMlXxdLqJQmuueZk52IeTCOdxfiOZI2eBgBY6UDLP4fIRKSf5uZT
 pWohkCt52zkBMfhQ8+F4o5a87+vLK+ZzrdSnf9x2r2qv/cquSIB3Y6K1LGHr37C9jmGSkOj2GW
 ezkikcGmwwyoy1p7fzghti3GH1kdJPRzChwgUw/oAfdYrpfxqg20zGTBrKoMCp+VIsxBwZNkzH
 7NZSI+xHQ/GG2bfsBK1CJWdQBAAA=
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3324; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=srt1rc2zixmmVAlprY6nwCXBccVgmX6AJVS0VWVd9i0=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqRyjVB+5fVsJcBdtNixvdfXIBoMdgSVP1H+FDH
 O4zU0v3x4aJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCakco1QAKCRB2HuYUOZmu
 i5WYD/wJUJB+1ymfyiXBDJpqDJT7DKWN0P2ZiYZuIvxjUtwZj6DwbQ7yHT5MAnuEH5hiT3YMtM0
 rMiQLAjSGzaYCDZrHENWmoEenTEnprS6FX4ei9vQnjL/QDtqv8Baki4Io8ix2J6TVnPNFKjmhwj
 a5TMXCKx4z5n03b4E+VAIFVf7Vi3l7GkLgIdmxEnEQOYwhEWM5e3NlwmUeWFszvik8kdoK9Dojv
 dMyrzcQ7j3f1226+4KPmu8+LXbw8zjS4sL3K0AZDFDZyD1U1j8I5nz4FT5ZlfYgWMNlt3FBhe/+
 rL+tWiKesrt5Ny/iDyCZWefXCaGcb0i0cuZKPAJG2f3d0dMMQuuXWWwXt/hXc4UE0Sgh/nBOdX7
 d3FiI+0Rg8+xCLFRIAB9jzoEvUndEHUhBcj1kScy8Ais4vN4QDreQPdgIw5GWZUp9U1/Jg/1Unh
 EDj6wjNCi0BGx3BoafyhE0ewhE5XJC7EESvwTsHvq8oMhxZ1YnX7Rr/K1mXxtkzoXkOV26v5y7n
 B06VA4K8gnlXZIzL+I8RDBWeB4Pn3+Q3GCblZakCbpoz/oClIPd7CV/rMhtQf+y0NH0Kxt9Y0mF
 Zmci1Y6NjGT0JN03GwsQ8VFVzGt/jv8TEMarbCyKmiShEkzVZaLuSxGS1yeWMVOBtogmev4LX59
 4JzBXCDSD3E1h7g==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

The `includeIf` mechanism already supports matching on the `.git`
directory path (`gitdir`) and the currently checked out branch
(`onbranch`).  But in multi-worktree setups the `.git` directory of a
linked worktree points into the main repository's `.git/worktrees/`
area, which makes `gitdir` patterns cumbersome when one wants to
include config based on the working tree's checkout path instead.

Introduce two new condition keywords:

  - `worktree:<pattern>` matches the realpath of the current worktree's
    working directory against a glob pattern.
  - `worktree/i:<pattern>` is the case-insensitive variant.

Supported pattern features: glob wildcards, `**/` and `/**`, `~`
expansion, `./` relative paths, and trailing-`/` prefix matching.
The condition never matches in a bare repository.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
Changes in v6:
- Rebase onto current `master` at Git 2.55.
- Add an in-code comment explaining why the non-repository worktree
  tests use the loose `**.path` pattern (suggested by Junio C Hamano).
- Link to v5: https://lore.kernel.org/r/20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn

Changes in v5:
- Fix Windows CI failure: use `**` glob pattern instead of `/` in the
  "worktree without repository" tests, since `/` as a path pattern is
  Unix-specific and does not match Windows paths.
  Github CI pass: https://github.com/black-desk/git/actions/runs/26380466288
- Add a test verifying case-sensitive matching by default, with the
  `!CASE_INSENSITIVE_FS` prerequisite (suggested by Patrick Steinhardt).
- Link to v4: https://lore.kernel.org/r/20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn

Changes in v4:
- Deduplicate the worktree pattern documentation by referencing the
  gitdir syntax instead of repeating the full pattern description
  (suggested by Patrick Steinhardt).
- Add documentation comparing includeIf "worktree:" with
  extensions.worktreeConfig, including a concrete use case example
  (suggested by Phillip Wood, Junio C Hamano).
- Add a test verifying that the worktree condition does not match
  during early config reading (suggested by Patrick Steinhardt).
- Add tests for the non-repository (nongit) scenario (suggested by
  Patrick Steinhardt).
- Add a test for the case-insensitive "worktree/i" variant
- Link to v3: https://lore.kernel.org/r/20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn

Changes in v3:
- Apply Junio's suggestion.
- Link to v2: https://lore.kernel.org/r/20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn

Changes in v2:

- Add missing signed-off-by lines.
- Link to v1: https://lore.kernel.org/r/20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn

---
Chen Linxuan (2):
      config: refactor include_by_gitdir() into include_by_path()
      config: add "worktree" and "worktree/i" includeIf conditions

 Documentation/config.adoc |  48 +++++++++++++++++
 config.c                  |  25 +++++----
 t/t1305-config-include.sh | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 11 deletions(-)
---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260401-includeif-worktree-fcb64950dfba

Best regards,
-- 
Chen Linxuan <me@black-desk.cn>


