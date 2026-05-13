Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C45368D7F
	for <git@vger.kernel.org>; Wed, 13 May 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659736; cv=none; b=gP+PtoxU/1ncsRSI26n88xQCXJCzYXdL02ac1ivpECp25edZ+ycqmLJTxI5jzUYQtPfV8QMpqTBOlHMAIIVRMYH6Di7vhGwBRlkdbobOmACdS2Lnl3BIkYSrTZW26olI8phfI91EqnC7Fi8FT+q+ZKu/vbvVgSYqAvf1ntIg72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659736; c=relaxed/simple;
	bh=bbMfNOcsXSiZIgD1VMa7qXLSXzdS+bvBNWvJyJ0pnLw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c5cKgS9sb9UHsMgT0/JXYs4Cp0zKsMtrMVSDK+Lz0IdaTxL6iRemCD2w9iFkmq6EPhft9/Qb6cDmBIKqu9z2817YTKzgS5JV/WRQz3xbMoJiwDiXQT4g3ZsGRHEgY55CckqKPXSFlHqBo4dB6cYvZwYxqbELJ0dbeJxlk+xorvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdhGXPsh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdhGXPsh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1BB3C2BCB7;
	Wed, 13 May 2026 08:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778659735;
	bh=bbMfNOcsXSiZIgD1VMa7qXLSXzdS+bvBNWvJyJ0pnLw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AdhGXPshkbI0HdV8wzGmmlZSmBkq3zxaZChFpmy1JzkMkf8UF7HuR1Q1SNgVELtji
	 TfIFQCwK6V2O4MG0hTVBKr27HnWBcU9uU92JyZFklq9he/g+eZiKyZ3xu9AtIZLq3r
	 72GIlfrOWq9XQmCCIlQfLNbgdiKkVu4QL9lGlQAqIatzllM9WttSDMFzeI4F/3yz1/
	 3ngWIsSXdxUgd8gmKDF/8o7XCFri84jTezBrXIHmHM99IgY5zqYsannrtgJqK1WxqR
	 f+C6ng9L/rk2N51VKCFJM4Ma/uH58SlXwb+7B+AGoQ2c+S22kFBYT6ASN0bB+/DyBE
	 2hBOzLQBK3VKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE63BCD4F24;
	Wed, 13 May 2026 08:08:55 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v4 0/2] includeIf: add "worktree" condition for matching
 working tree path
Date: Wed, 13 May 2026 16:08:16 +0800
Message-Id: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAxBGoC/33NTQ6CMBCG4auQrq3pDxTqynsYF7SdSoMppsWqI
 dzdwooY4vL9knlmQhGCg4hOxYQCJBfd4HOUhwLprvU3wM7kRowwQUpCsfP6/jTgLH4NoR8DALZ
 aiVJWxFjVonz4CGDde0Uv19ydi+MQPuuPRJf1L5coJlgSYZSQlulantW91T02EPuj9mghE9syb
 JdhmeECOJeqkY2p9xi+ZfguwzNDidRQ1Q1ThP8y8zx/AT0B2wRGAQAA
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Chen Linxuan <me@black-desk.cn>, Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=bbMfNOcsXSiZIgD1VMa7qXLSXzdS+bvBNWvJyJ0pnLw=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqBDF+VJdhN8laiueYnD/2/KfIFISfFLx7NsJNK
 33C+RNobumJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCagQxfgAKCRB2HuYUOZmu
 i5EeD/42Vw2YFsOSLe20nHuFt/DsZ2w2C8mABSRY31mYO57J8uaaI26aLb0mJN2HE4a/eiVbeG/
 KlepAi+Q/x8k93wm6MzGhMTiDvl3sYeUpv4taRK65V4JGXhtMjEFUBXxgBylrLVMiM093WY+xMz
 bIyjyykePPeS/v52qMecDsjS6EoH3QXbmeGpt06AInBDxA2F6ccPxl4ulLMMzQ+mo7ocOKxqt71
 gwIFLq81tsmrhNJQuy1AhIdtPcgFpX8ZRNWpzH9IZ4TxN+r/tSPRFHh6bkzuYHrvzj4CKxZ37of
 N34CCyPUo/3MTMgJzVRa8oHLkUJ/YqMdPz4A37f6UOurYAEKxJRTb+oPF6lbTznT5f4PJgqT4Hm
 QGlgL5amjBp34qVvzyZ3PLyGP4fSjpscSykEl3GUYrnOJT2dNHlQsvljbSn15DfTH2mCj+l9+ma
 AecvJratCRua2uXkZSzAG53SZuXIZFYLRQ1dpY+JWwhucQ0Q6S3ZQ/LdAgdN3vkXJFcalnri/FV
 bLtozOHK6qRo67+Loc27966xpafkXchA7qcg3/k44cOmCRznNMQAMywmzqnOwAxL432nSVRFpjg
 YJmorDsHexh1zd2hkHQA3brQAWAGsv0uhV1VE4k4s4TepA1ssZQWIa2OpL11+qTU9J7ejlIa77i
 pukllX0Ru/on+Yw==
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

 Documentation/config.adoc |  48 ++++++++++++++++++++
 config.c                  |  25 +++++-----
 t/t1305-config-include.sh | 113 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 11 deletions(-)
---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260401-includeif-worktree-fcb64950dfba

Best regards,
-- 
Chen Linxuan <me@black-desk.cn>


