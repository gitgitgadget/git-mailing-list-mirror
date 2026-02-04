Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1F12556E
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226448; cv=pass; b=IOPNb5lxMG9bbg5be1hylLzWNRiVNEwR7YME1H+C+AOE5Eg0CqsX6Ae/Jr7SDiSENwes3lu82uTjlwHsE/bqxmt7apaRjEncnaeDZ6u9zbOmV4S+m7eIRzlKJZXzZk+JRyb0s4cF4jH+p1p1g/enThqEr8QKRFR1blqFkITAabw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226448; c=relaxed/simple;
	bh=NwuSpYj1Gt8pxbO8NxrG7+L7a52RShqJKGfIiSN/H8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTWpUOjlao5fzZRcnck6MejI4tJkv03Hz+ibEqrz2Phv3VZkFccwITKzLKKDoOH7FBk7+8U5TFDH3a1ndaxjudZpQQe1V0NNnd45dWXyrnKMGEAnCmkxffUnH88FW3q8fVFWAdmbasY6/Sqv8qs2My1AIL5zaaZjn6bL0o9noxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XoczUkZm; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XoczUkZm"
ARC-Seal: i=1; a=rsa-sha256; t=1770226435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TFEYhtONaUH/AOvxWj0YJOSiosC3P0wQ6GDptyZnHbUqV2aY80pvzlCCxqp19lVxbZHpyv0qbJwdHrOdNy78burcc0ObIGJYFfnYEl5gKMwK+G1l2HrAWrIG7FwLJak9oJGKrPej5Wz3A4lRbLQQ/lM0DCMNL/FpiAmSdA3xsZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770226435; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fSIKayg6nXAoV58TO4VuvBCX//UnO0b40FfquzwFelE=; 
	b=JKpdmfqpGKlnI9vWsP2N9OowoDzqZ4Ks3tMBGn92A2fQFs1gssd52YD4yBpb4PxXPS8do9dHX22+ivcNlOBzDiLM5YAUNFLm56BsRqH0fuKkhRg+eJQHwKJvu7PKEUx/yH+flUrWefFOa7BOH97WT62fTkOpChea7pEitTdbqkc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770226435;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fSIKayg6nXAoV58TO4VuvBCX//UnO0b40FfquzwFelE=;
	b=XoczUkZmPtef4XtHgW2M4bhO2EZg+MUaXXViDflvudckoMuZy216Nrijig4bXzpe
	uhJ+XhsnOZsgDDcIxrE8i3q6JXGRCg3CFbb1os6qmIN3Oi6HS3xmXFrOcP3QJ0aflZC
	9PkvVrVSFhfm1Dfn3TrsiOtVykSVADQVlxrYbf2o=
Received: by mx.zohomail.com with SMTPS id 1770226432197165.27706670566135;
	Wed, 4 Feb 2026 09:33:52 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 0/4] Run hooks in parallel
Date: Wed,  4 Feb 2026 19:33:24 +0200
Message-ID: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This enables running hook commands in parallel and is based on the patch
series enabling config hooks [1], which added the ability to run a list
of hooks for each hook event.

For context, hooks used to run sequentially due to hardcoded .jobs == 1
in hook.c, leading to .processes == 1 in run-command.c. We're removing
that restriction for hooks known to be safe to parallelize.

The parallelism enabled here is to run multiple hook commands/scripts
in parallel for a single event, for example the pre-push event might
trigger linters / spell checkers / unit tests to run at the same time.

Another kind of parallelism is to split the hook input to multiple
child processes, running the same command in parallel on subsets of
the hook input. This series does not do that. It might be a future
addition on top of this, since it's kind of a lower-level parallelism.

The pre-push hook is special because it is the only known hook to break
backward compatibility when running in parallel, due to run-command
collating its outputs via a pipe, so I added an extension for it.
Users can opt-in to this extension with a runtime config.

Suggestions for alternative solutions to the extension are welcome.

Again, this is based on the latest v1 config hooks series [1] which
has not yet landed in next or master.

Branch pushed to GitHub containing all dependency patches: [2]
Successful CI run: [3]

Many thanks to all who contributed to this effort up to now, including
Emily, AEvar, Junio, Patrick, Peff and many others.

Thank you,
Adrian

1: https://lore.kernel.org/git/20260204165126.1548805-1-adrian.ratiu@collabora.com/T/#mdb138a39d332f234bc9068b7f4e05b10c400e572
2: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/parallel-hooks-v1
3: https://github.com/10ne1/git/actions/runs/21680184456

Adrian Ratiu (3):
  config: add a repo_config_get_uint() helper
  hook: introduce extensions.hookStdoutToStderr
  hook: allow runtime enabling extensions.hookStdoutToStderr

Emily Shaffer (1):
  hook: allow parallel hook execution

 Documentation/config/extensions.adoc |  15 ++
 Documentation/config/hook.adoc       |  14 ++
 Documentation/git-hook.adoc          |  14 +-
 builtin/am.c                         |  10 +-
 builtin/checkout.c                   |  13 +-
 builtin/clone.c                      |   6 +-
 builtin/hook.c                       |   7 +-
 builtin/receive-pack.c               |   9 +-
 builtin/worktree.c                   |   2 +-
 commit.c                             |   2 +-
 config.c                             |  28 +++
 config.h                             |  13 ++
 hook.c                               |  51 ++++-
 hook.h                               |  20 +-
 parse.c                              |   9 +
 parse.h                              |   1 +
 refs.c                               |   2 +-
 repository.c                         |   1 +
 repository.h                         |   1 +
 sequencer.c                          |   4 +-
 setup.c                              |  17 ++
 setup.h                              |   1 +
 t/t1800-hook.sh                      | 270 ++++++++++++++++++++++++++-
 transport.c                          |   9 +-
 24 files changed, 476 insertions(+), 43 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

