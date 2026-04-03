Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CD309DB5
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199779; cv=none; b=mFUTYRHk2OAswdwOxo31eoRNhQYHOWO7a+dECGWZxqdRx0R9Pm3ae2Br3cbxjR+gHs4I/bl2rmjZShkOKPI+5YEIsZcizUo3y2MEDqbeMmrFfbcLIVlIu7zV/6TPDqK1NAHhy0nMCigtLdE+spdEXDghuC2FLh+Zo814p3RhGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199779; c=relaxed/simple;
	bh=DwuWlMFbXxtvcS8zVCluFfVC0Tr1mn0qvPjokUo9tWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JBXll9nDljFgZHG7tiqFM1wmG5mX8YGAH/x1i4eynAVK46hpdDWEMhUhRVaSSxVviZ6vij3kj995jb9l9/1o+9w/lE97OWNod5y73X/C8gvrvmQtYtTdnGPbIEVKrmI+c6iCzwoa3ht5NLa3KY/grbjxVZ5W31kBrKtVzka+uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWIdB1fY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWIdB1fY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CF5CC4CEF7;
	Fri,  3 Apr 2026 07:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775199779;
	bh=DwuWlMFbXxtvcS8zVCluFfVC0Tr1mn0qvPjokUo9tWM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AWIdB1fYx6dk5RJRBICzQZlbdZzZYyReOsw+ReCtfAnzNwQCzKzjKe3yqERsIBUG7
	 8T9s0gYgziy7Qbi7kMZdsFDkYy2pRUvYUdeYrHb0uWtdos4f4cBo4x8JgR0g+cqdK4
	 FebPSw5zqiJE1maGCrMh6ZP9Jp44MD00omOYF4KJkJBssmdUymWlNHx6pkeQ9uGf8Y
	 Hza5JNmOdzcakkmjjy6XuT2iROjjHNABieUmQIfnBUihhmnvae9KrPZIQ9ORWDBF9z
	 7OC09Yz3qsT2iqdJw7jVdWltvg2zURe0OCyw/gffevRJXk6X9P3yBPFfLsnc8xGSBv
	 1mt4Ia5XVHKhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB4D730AF;
	Fri,  3 Apr 2026 07:02:59 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: [PATCH v3 0/2] includeIf: add "worktree" condition for matching
 working tree path
Date: Fri, 03 Apr 2026 15:02:27 +0800
Message-Id: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANmz2kC/33NQQ7CIBCF4as0rMVQqLS48h7GRYHBTtpQAxU1T
 e8u7coY4/J/yXwzkwgBIZJjMZMACSOOPofYFcR0rb8CRZubcMYlq1hJ0ZvhbgEdfYyhnwIAdUb
 LSh2Ydbol+fAWwOFzQ8+X3B3GaQyv7Ucq1/Uvl0rKqGLSaqkcN7U66aE1PbUQ+73xZCUT/2T4T
 4ZnRkgQQulGNbb+ZpZleQMUHPLu/wAAAA==
X-Change-ID: 20260401-includeif-worktree-fcb64950dfba
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=DwuWlMFbXxtvcS8zVCluFfVC0Tr1mn0qvPjokUo9tWM=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpz2YJPPZ4A3xF8wmZB0AhVUv2D2hLbFhIl/u9c
 zwOJwVKOXeJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCac9mCQAKCRB2HuYUOZmu
 i/yzEACi1xs2EkXHith7arXWLLea04+1eHyTgUwYJPj1hKcYnhf83QNNPe/uK7Qts1/nsaQSgiI
 Q61FYxt++T2e4YZrcGCRJvjzWQjSWV1cTL7GbtAnOHeRSc7VfR8NoFcEmsJzv9zAf/0IDhaZZ2M
 OUC3PoluuaAg17WbDQLv4RN/4kvFKTGSvKv1oLFSfOee+Y8ciIlp746p/Oka1tjv+wEWAK5A2u8
 DtsjfgK9mNPjselTpdqZ01V5CBkzH9ISAkB5duZhTeRxa0H7cVKl8eIHQM4NjVI0njo22aw1Sq6
 nD5UKrCMOSq9r3QSCb6NPFi0GFbsbMMcukvvSlrOFJYiy6K11kWkcuFTCGqxIhXLP9scacx5XnL
 T4180azjwfloPB9JSVogc5BtyexzEwHISNWWVyHuePQMans0jpC6WA6a+Ic7Odpm0eOA4CWNKA9
 t4V8De8liUGjE0cvAS9h0fy4MsscVhHJoXjb0GeIJLJfz9e6x2w/EBis+lTeFbyVuamev72DM9E
 Z3gztGCXwC86qIv5iKEqCWo6RS54AHBLj79Zm7L8J395e4uKKnmviPhMREJQxT+WtkLPaqWHySd
 dZqAoljiPMySg9iebeOBg6H81ucJ/oIuZ1jIytO1szpiMS+ngMEH1AkMOsgPsuURJxkMXSyI9kb
 aJc/oIZfKAtzw/g==
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


