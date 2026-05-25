Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049726FA6F
	for <git@vger.kernel.org>; Mon, 25 May 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779679228; cv=none; b=QSB93ez8GCx41LlzIMu4gaKvc9oNScw0N/pzKKirmk6m4ikOdMlye30ovKOfDzBmNgPRnkYsntcTGxHTSkbKamT8WbOnXFXigPUG+0Dl3bD+Za+XWrIzZBUdT7aOu0mFn3XIJaNlkMC2FZ2jVxnMmSu5WqVGTaoefJPFmiewwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779679228; c=relaxed/simple;
	bh=2PpbGKOFrg4dLIvLUnoHgnONdgQmeCgpBQyBhuvFDo0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cg9A8/SipyOuArIfbwxN7MZuduFQpZcJNBcsVmP8h6bw1Q+DusDOYUN23Q08JtndOzQHbis7cbI8gAiA5hHr47f2HkIaxulpQcskOhvBcKaaN/K+W4sM2+ruenEZUEI4dhSxhRhW5rylPn3/cLXyz7yRXm8IV4m2EeeirF+m4yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgi7Bvsc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgi7Bvsc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99735C2BCB3;
	Mon, 25 May 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779679228;
	bh=2PpbGKOFrg4dLIvLUnoHgnONdgQmeCgpBQyBhuvFDo0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mgi7BvscKFvqW1atL68SChKVMZPlNC5NFYL+ebDv4NVbUbMme97tHj/k7n2HBKWrF
	 FhEUsUGzkiVPa54NhPKqv0asY/NCj3+dfJMbtVJo24fOxC+mKcD8H+N7Ig9mb5ckS7
	 hBVwWx0F/AbtOwywBk3Cs9dw0rHNVn2bT6uD3AfhPOi/8G0h7IpvudhOPeJMUE+vPK
	 KYJ1K7OH53zlIPSnQF4RdXZHDQqzT6cqWVLm5h4s7zz/aD84l5CvsI7OnwBZMYbRl6
	 j6xb1ns8U+e+Wd0S1gEYaoMil5RykldZh2b0lrDOJQVFPt68p4BjUK3wwasw2z0SRz
	 c51XjWNFDQy3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805ADCD5BC0;
	Mon, 25 May 2026 03:20:28 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v5 0/2] includeIf: add "worktree" condition for matching
 working tree path
Date: Mon, 25 May 2026 11:20:07 +0800
Message-Id: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOe/E2oC/33QwQ7CIAyA4VdZOIuBsrHhyfcwHgYUJVs2A3Nql
 r276EVjiMe/Sb8mXUjE4DGSXbGQgLOPfhxSVJuCmHM7nJB6m5oAA8lKxqkfTH+16B29jaGbAiJ
 1RstSVcw63ZK0eAno/P2NHo6pzz5OY3i8b8z8Nf3LzZwyqpi0WioHplZ73bemoxZjtzUDeZEzf
 DOQZSAxQqIQSjeqsXWOEd+MyDIiMZwpg1XdgGYix5QfpuJ5pkyMa1ACB8vTo36ZdV2f4V4z940
 BAAA=
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=2PpbGKOFrg4dLIvLUnoHgnONdgQmeCgpBQyBhuvFDo0=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqE7/sHurlLhu/yNImoVPP+yVkOCdEEQAaPbERw
 LDgllgpwgmJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCahO/7AAKCRB2HuYUOZmu
 izoWD/wNB5S9GN9B4yILszyEe25Dw+2kQ6Mmu/Lbnk1lOU4n2ZSCeHDhZzBmy1mEodcr0mTfiWJ
 sypRUPkdYTdzbllD0GbPAByWR42Da6ba66YqjBgGw3z1kybPGZHyu+gkkLyVvkHl4GQ74hXyu3D
 2cqLAOO0JpposEYfPo2cC4kjMGGnz9b9+MN9nQqMo1FeUT2W59x6CoPmxjMXq1fahn2UJH7NZgn
 YfK+ihINC3N7nEMU++rpCfrsqg0ZLRJGyb7RfeTTcuGmxNfdKSBmoKBSJrCQJHCcAbB6Ta+2hpc
 PIF2bKLFylK7QBbYCME8xXET74bM4adU5vn+UK7Di+ixCINhdzCgrNRWwwYTcCkpjXR2jgJHUmW
 ih4trpRRrr7ICjuXajdXLVBlr1gvavp9AJI2Gv2YoZnEvXPW9jDQ76gIgM9+vLb5ut5TVSC0iH7
 VMnoD91yuZeSjGtblVsjSb1sKuGGj7D45TDDMxoWOvj2pBG7d7Ii8MmoOhHX79bZZ12EcNp8s3x
 i1B33mKD6AHyZkJJBSLCWH+5kyJ2ltFZ+lYMcwMLQhpjtvBbJ0hOXdtzmd0PS5uuzG0SdBAWbvd
 r0saPGQr3nCU9f5TCj7Z+vh8NqZhb+JEzvgE9QSGeiw1LDe5SIv0LUKDfT1H0Gmz68bFDks5nww
 XnulBp02Gdm5z+Q==
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

 Documentation/config.adoc |  48 ++++++++++++++++++
 config.c                  |  25 +++++----
 t/t1305-config-include.sh | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 11 deletions(-)
---
base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
change-id: 20260401-includeif-worktree-fcb64950dfba

Best regards,
-- 
Chen Linxuan <me@black-desk.cn>


