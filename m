Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA63537FD
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098733; cv=none; b=T+uEL3xClr6KwYk5sr8BMA+YLYj3AR2Y53QbllmBueIAOWWqORcliCwmpIw/fy2zPTx1XviieOSI+4M78PcqC4rwKRJsnU8gS4O+8/AVt9D/XcUf5P5d8+K6tQ0j7nnvWSMDJ69A6+TJmeUUXtjcPDznXNxCA+oI4AQD/F9SkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098733; c=relaxed/simple;
	bh=Q8VmkXQvpMBDCjFQlGFLOrNMmWMHiShvAqOXZB4T/lI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IIb3MMNU08ByWo5QMMRTx6KHqQT/TcirOSAa4X9RMiGJs+4tHi2K5ZsSCT3DHi91oNpg2hlAYhGva2BYORmrL5HKInuuWKJO61AqYoz8SAAHbmsMJcMM76QprG2O852xB3AifVvuZVm7+HV5FtV2F5OEblwCPwiaH8zcrejn9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY05/j0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY05/j0J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98290C4CEF7;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098732;
	bh=Q8VmkXQvpMBDCjFQlGFLOrNMmWMHiShvAqOXZB4T/lI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oY05/j0JavPJqQwIsVtX9Q1V9m5L9nHbY/RaAcmAVNT2FDPBZ8o3ICOhNtmrpKQrO
	 HQiXpItnGOkEtnLBn4c0oCiBfeqsHOJ8595K5Wuj1N5dQYhczheE6fUYTtcT0w3Xv2
	 YzjqtF5+wfBbwCUw0lzYmKdKZxPcuEaOeI9g8RSbzg6NQ1m6Eto4oexw+JtpaSFFb5
	 xweYW+VP9pMHu4nZYGj65k1C6HXyKGrtKpwpbl8QzFfK8ZrSF9FWctTwanRIV/0gEb
	 4HbLCHs96mlrnxQuy4kw0yauLSn526okrozPwk/GfjrYCuQ0SqHCiixJI9eUaVBmQ9
	 /qFCJT/WqnyaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654F111227C;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v2 0/3] includeIf: add "worktree" condition for matching
 working tree path
Date: Thu, 02 Apr 2026 10:58:44 +0800
Message-Id: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTbzWkC/32NTQ6CMBBGr0Jm7ZjSYE1deQ/Doj9TmZQU0yJqC
 He3cgCX7yXf+1YolJkKXJoVMi1ceEoV5KEBN5h0J2RfGaSQSnSiRU5ufHrigK8pxzkTYXBWdfo
 kfLAG6vCRKfB7j976ygOXecqf/WNpf/ZvbmlRoBbKW6WDdGd9taNxET2VeHQJ+m3bvmuBZsK4A
 AAA
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=Q8VmkXQvpMBDCjFQlGFLOrNMmWMHiShvAqOXZB4T/lI=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzdtnewW4nd/lVM3hzyBmw6A9EXI4BwHybc6G4
 a4caHiK3NSJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCac3bZwAKCRB2HuYUOZmu
 i8HWD/9FlkQ3qnQDjiH3UyGRtgBCot2vnKUNOgQIzgsGbY/AKfU/9DDNSHPoqY2Q2vNzfwllQkS
 Ce8pL8WHv7DWdEcF7TBrhcrzNjVGZh7nCqD+oZKAiTprZrg7SZuJt3sNOKYaUxwT92s+DbN/nge
 inWW0D2TUb7I3RMUL0MIktrIR/NJhjXkx5FU6f0tKS2uUsiuFi2eXS3redxROi4hljVnI3Uy5KY
 tw6vXYvWclv56bJtnGPFFrKz6hMH80dYkOZuQlCmocZOcxDKEYCS02yIrl39wkYyWHnZFxR8R3n
 mnc6LiDo2sb0qZRxCZiIiLvh+yH7cJv2dufDtbocBcH+oH/dw0S0q/eF1Wt/9rPXABdmYNHCEun
 ivw4dkEQlADxfDeyy5No3J7L58+jfDt5il3quemZZd8THjmBIqFHsShi5kq+ANph7yBrdHyFkS9
 bgbzGHpA6xf7KLiBh4V/0oOWJ/kKhicld6V5s143vDkuM9MpUaAC8qcKPmQxiI+3I73Ev8FmPVh
 tiv5meg0DdODVlN2UjxfYSbF970Iju9yihzn2a+kjcjWFPIASD6oQX7amYLnJWBM1AzxEyy4n6y
 MnjSXZAglzfLhlZiaTer4eGm1w0A1UEWRZ/dGKM9QyaN/w68t6QOeu78J7DgGjAQM6V+/eDQXbk
 Po/CPumiWs/1lDw==
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
Changes in v2:

- Add missing signed-off-by lines.
- Link to v1: https://lore.kernel.org/r/20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn

---
Chen Linxuan (3):
      config: add "worktree" and "worktree/i" includeIf conditions
      Documentation/config: add includeIf "worktree"
      t1305: add tests for includeIf "worktree"

 Documentation/config.adoc | 50 +++++++++++++++++++++++++++++++++++
 config.c                  | 25 ++++++++++--------
 t/t1305-config-include.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 11 deletions(-)
---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260401-includeif-worktree-fcb64950dfba

Best regards,
-- 
Chen Linxuan <me@black-desk.cn>


