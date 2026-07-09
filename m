Received: from mta203-ab1.mtasv.net (mta203-ab1.mtasv.net [50.31.205.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A66347506
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.31.205.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640359; cv=none; b=J4/Fctw9lv90bkK6g7q6abm+T5FZR5KpBCkpUJvx1Kvs9KMNBHrng4pzD2OA13bGR5Wcp9+6QwP23O8byly7rVxQpQM72/08ZnZLv/YkcNYSIbkuVRCYyOAsBzMxbWHeA2ZnhbHo1xaHuzLoxSqijgF9LjshdJEgeGj8HjvRwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640359; c=relaxed/simple;
	bh=8qtPuREdKbEp7tbF27klMIxKspMsPpfcuMeuc5YN1n4=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=j6ruuVgunfIGxf00eZIK7/4xLW11rVPPFEmXEDjQXPUl8474M1HRap9+kmy/tqbshiX5b4yUJplqXJmnLum+HDzN6A44+uHJ7gcWusq6bd1ahgs6D6ovClJ0wEctNg50FeTUzH0r97rOS134lQx8FtyWSG1wPuHe7xnDb6CkIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=hu60/dlb; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=SB10IaNH; arc=none smtp.client-ip=50.31.205.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="hu60/dlb";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="SB10IaNH"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=wx3SXdi2kSncxG2NhDh579yP8uxFpOSL7YichOK7ZvA=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1783640168; x=1784244968;
	b=hu60/dlbNS7XWyfHhXmfD6UFOR38SE9BjHFxc4AA1V040UxhEd5JfSbkMeDxPaFMcv3rL3Qwz
	MmGMT1JxmfU2JAjX4p7zBbqbIA30q/dc5CW00zSttrB/rvozOQr0PSTDQ4pweMXTr1tsjkat3KR
	WMI66RW927E9cfRvPXx04xc9sjzm8iyBPwFnESUF8Xll2k0Sd3B+MBzyIkMuk0VMJCxkYNp+mw9
	6ZV76w7/yHB9MA+ELB6Ds9s1oJ/XXTxjajcaQf+o4j6WDAWnBatXb9wUUmKUdJ5Vv6wcwb4qe/S
	ijcR97PpK/DSQBMIjn/wZLPri7SOK+ZPxim2V9Hydy6A==;
Received: from ip-172-26-33-226.us-east-2.compute.internal (172.26.33.226)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.243.75) 
  with ESMTP id f613a7967bee11f1a75e02d3e4132017 for <git@vger.kernel.org>;
  Thu, 9 Jul 2026 23:36:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1783640168; x=1783812968;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:feedback-id:mime-version:content-type:content-transfer-encoding;
	bh=wx3SXdi2kSncxG2NhDh579yP8uxFpOSL7YichOK7ZvA=;
	b=SB10IaNHLHEkZZC+n9nUYas/yplTy7gH+8CzQzkuaYPOd31OFRB3SuWg/xYEJHbtil4F02fUPUv
	zks7isDCAjiNMIVogQLZ49zWbHYSaQbHzjqku3wvKLQ7e7F0ypaKvXaaP2LYdN4CEZVIlH30c7rBE
	7cCIDXEXSzoUsltVdcs=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Thu, 09 Jul 2026 23:36:08 +0000
Subject: [PATCH v1 0/3] worktree: add post-worktree-add and
 post-worktree-remove hooks
Message-Id: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
X-Mailer: git-send-email 2.54.0
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.Zz8_B0qptAz0vL6JBGIeZA.7x9lMUb4f0KWExh9R9ywZ7ggXeoAGbw0dPp0fMQxMdyQOCOO4Og-vVuBaDwMjWVpwXP9AmbOp-dXf470V38bP6N79zJBDSTwLGvOhcGWer9QHD_Oh1HoGx67UegsAbXwaf75ba1AXTUbOHJOR4-Bzm822T805ZzbUw7vhUg1DinMeusLklr3I9uhkfnPv8pc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: mta203-ab1
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I maintain devenv, a developer environment manager, and lately the
workflow we see most is people letting AI coding agents loose on a
repository, one linked worktree per task, created and discarded at a
pace no human would type. Each of those worktrees expects a working
environment: processes, sockets, and stateful services such as a
database seeded from a dump.

Today there is no reliable trigger to set that up when a worktree
appears: post-checkout does not fire for --no-checkout or --orphan
and cannot be told apart from a plain checkout. Nothing at all fires
when a worktree goes away, so stale databases and services pile up
after "git worktree remove" or a manual rm followed by "git worktree
prune". Wrapping the worktree commands only helps when every tool,
human or agent, goes through the wrapper.

Patch 1 adds a post-worktree-add hook that fires after the working
tree is fully set up. Patch 2 adds post-worktree-remove for "git
worktree remove". Patch 3 extends it to "git worktree prune" so that
manually deleted worktrees are also observed.

Two design points I would especially appreciate feedback on:

 * post-worktree-add runs after post-checkout and is skipped when
   post-checkout fails. An argument could be made that it should run
   whenever the worktree was created, regardless of the earlier
   hook's exit status, since tooling registering worktrees would
   otherwise miss one that does exist.

 * for entries pruned because their gitdir file points to a location
   that no longer exists, the hook receives the recorded path; when
   the path cannot be determined at all (missing or corrupt gitdir
   file) it receives an empty string.

Thanks,
Domen

Domen Ko=C5=BEar (3):
  worktree: add post-worktree-add hook
  worktree: add post-worktree-remove hook
  worktree: run post-worktree-remove hook when pruning

 Documentation/githooks.adoc |  41 +++++++++++++
 builtin/worktree.c          |  73 ++++++++++++++++++-----
 t/t2400-worktree-add.sh     | 113 ++++++++++++++++++++++++++++++++++++
 t/t2401-worktree-prune.sh   |  88 ++++++++++++++++++++++++++++
 t/t2403-worktree-move.sh    |  44 ++++++++++++++
 worktree.c                  |   1 -
 worktree.h                  |   6 +-
 7 files changed, 347 insertions(+), 19 deletions(-)


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
--=20
2.54.0
