Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520D1DE88A
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027320; cv=none; b=iXFAuw31VLRV4aviFtfFoP2rBGTKXABQOoiIvLzj1fVUVDAFs/EZxKYZ2GdGPJvo/rGhWYanNyLoaevwy7CcUy2nOuX8cQcma9oOjLMMLtXR27r6zUIAfIse6Kzk7M/ph2Iz/hjP5aobfDPzZ39Cq+wFVlpD/ftg0x2Jpj4K6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027320; c=relaxed/simple;
	bh=E1DMnM5IRNdyQnMHIUSxSwpllBmkbgs35wlsAYkQMdI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iLdhbyr2rJ7QbvobVcKf7A94cd9Rtfo37/Tedq+wpeCSV2ZY8lqc9NfhcrAvPkNLQJUucWo1SxsrJfsbBOtlvVLPb8jcA83mivziGNhxekt2d+bvAo+ava3Ft8Uk96AMbEllSFTK9YG2D3SerDYSWim0VlvljMnULqaFyI9eirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIxeobcF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIxeobcF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CDB4C4CEE3;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737027319;
	bh=E1DMnM5IRNdyQnMHIUSxSwpllBmkbgs35wlsAYkQMdI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aIxeobcFbJz0P3tBPivyxBY0eBplxy8HdWL8+JPsSz3D6ewluIYu7enOldmeKMffe
	 LcR1iqri7C29Ax+z1D4cvMpniZsmOdM04f1yG9xh1x9nui1qOQdxjckPryPyPDu3P/
	 6s/VbKXHDz2Y+8tCNhr7iFed+Z9poJ+BWgF7dMJunMfDvgfil7RaGKVMb99YUcvUpP
	 diVOU5DbNgGOu1B+CbMXshZnfQ908g6Iol0GivPSXShrc8uruvvCghc3iHJ1d1sUsz
	 VnDJpVkFyzu+DR8A6/83Ph1TC2fj8J57FsdAFKNfIsh+j0LntcYFkdVkSv2pmwbpJN
	 xkxzFI9ai+E/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F3BC02180;
	Thu, 16 Jan 2025 11:35:19 +0000 (UTC)
From: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Subject: [PATCH 0/5] pack-write: cleanup usage of global variables
Date: Thu, 16 Jan 2025 12:35:12 +0100
Message-Id: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDuiGcC/x3MQQqAIBBA0avErBtQmzZdJVqITTkUJloRSHdPW
 r7F/wUyJ+EMQ1Mg8S1ZjlCh2wact2FllLkajDK90lrhFvD0jInjgW5nG66IRJposWRm10EtY+J
 Fnv86Tu/7AQJjq8FlAAAA
X-Change-ID: 20250110-kn-the-repo-cleanup-44144fa42dc3
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=E1DMnM5IRNdyQnMHIUSxSwpllBmkbgs35wlsAYkQMdI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeI7vRH8Nxxn9h6WXyhncoNrHat+S7Jj/TP4
 dWpDSsHZk7izYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniO70AAoJED7VnySO
 Rox/gycL/AqSkEEhm1yjQG7fqB98QfAX2oDfskUNLOoLspvaPUxI5MCrnNEZNFtWTzcjgQnxHo7
 fu4ZWdMZGucRQChjh4X7OesFCUQv3sCnzKczcQ2WlFFeGkcJtrxoW0sv7KjpLvV7S/GOzZNA/xI
 /eOtDdx68b4nRJxLs+VO87jAYfmbcK1gZbSFDibLWfI7v5zPLBV5m0LBoPdvlEcHyjMmIVVGyUT
 0HPOLI7ylwUdLaSGD6QRpRykyCU3hlFmkTfxJd60/AF/5eR7c2Xz1cT+fmeIHljRL+Mof4nbhsH
 9Jk66dvWaqxPCmOjJynstGVuSpL936dQ7pOXO+WoUiFjq13zJLzkHaMA6UX+JgIVRNPGI7/4BYm
 jTjtlC4z0Qx8NSc1fPRZXv8GvnyoO93aCp6NbkFuw61SXjJ/LgxEejHLvtZ/PIXqvBsFShQ+Uu0
 9cWg5U4/LNZDPcD1Jz1xX+Bl7MJMMHVwMFnyoDKcmJqBkxEc9wixP7KYwi71HlndMPgTe9xvrB6
 bA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F
X-Endpoint-Received: by B4 Relay for karthik.188@gmail.com/default with
 auth_id=276
X-Original-From: Karthik Nayak <karthik.188@gmail.com>
Reply-To: karthik.188@gmail.com

This is a small series to remove global variable usage from
`pack-write.c`. Mostly it bubble's up the usage of global variables to
upper layers. The only exception is in `write-midx.c`, which was cleaned
of global variable usage, so there, we use the repo that is in available
in the context.

This series is based on fbe8d3079d (Git 2.48, 2025-01-10) with
'ps/more-sign-compare' and 'ps/the-repository' merged in.

There are no conflicts with topics in 'next', however there is a
conflict with 'tb/incremental-midx-part-2' in 'seen', the fix is simple
but happy to merge that in too if necessary.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Karthik Nayak (5):
      pack-write: pass hash_algo to `fixup_pack_header_footer()`
      pack-write: pass repository to `index_pack_lockfile()`
      pack-write: pass hash_algo to `write_idx_file()`
      pack-write: pass hash_algo to `write_rev_file()`
      pack-write: pass hash_algo to `write_rev_*()`

 builtin/fast-import.c  | 11 +++---
 builtin/index-pack.c   | 11 +++---
 builtin/pack-objects.c | 12 +++---
 builtin/receive-pack.c |  2 +-
 bulk-checkin.c         |  7 ++--
 fetch-pack.c           |  4 +-
 midx-write.c           |  4 +-
 pack-write.c           | 99 +++++++++++++++++++++++++++-----------------------
 pack.h                 | 30 ++++++++++++---
 9 files changed, 106 insertions(+), 74 deletions(-)
---



---

base-commit: 8b2efc058aaa3d1437678616bccf7c5f7ce1f92b
change-id: 20250110-kn-the-repo-cleanup-44144fa42dc3

Thanks
- Karthik


