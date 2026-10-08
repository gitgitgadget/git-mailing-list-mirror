Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590D497B62
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461812; cv=none; b=iYd0R8JvcG6bHU3m7PShpTT7vigRa5xp9xgNz5y6ynN5llsZaWyqOoUD/vGNeVpM1V2OqxWH0+t7/u1z1ITZJk2Ygndq68MBGgcwvZ1t/7JN0O0F/1zywYWWs9BKkztNRM1DoiK8qWuqs0RDNZdsGdYymlUlt66cFfnjhNedlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461812; c=relaxed/simple;
	bh=++mLwYYdEQ+aYtPwYyCzFziLHa243FP5geJ8PmmtsMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcXs5obeUprLV+GVdnMd1HGLBoo00hfm9pBNut1a1gpJ1vlqTFpWxgD+C1WBRb3j66z58DTc6t3FwFbESjf5kIDbrraBvFB43LtOwlopWLJIKnt1NtiaoXj5rhWwoKoe/tDn5R0aW87qm+m62MblyIydudi0UMkVcoE+h3VI12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hWa9/lmT; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hWa9/lmT"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AaCoZ3bKLZFksYl/pPxwq1cXVtDtMWQn6fQL0oFyI/I=;
	b=hWa9/lmTFxOgQKLr9l6qUk9L+15aM8l4l9BxrIFiOBiS99v4WEckju5J99kKFYRLTgQ1m5
	RWYuHDD6a3kv4PsGsqybEADRz/zaYJGN7Y0KvOL33/KJl/zMTqE2vt3ShhKKrj0MpgDNzZ
	XXYvTJcwUR+rF83YqLZ8sTPy1DbDOYIjQKul2DzWBZcgylNaLvLwK+rA/QZH4KjqC80DcK
	mQ7A3u3QuobaEQM+/EinVJYqHMgM7/lc5P1h87SKt53pIRXhtAZ74NbTWAuOL5j7wVqwQL
	aeeaAMy/i23VXSomCfRdfAhVMh75elQ9vKHkP+tcstjHZflvsJxxPpA3Ingtwg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [RFC PATCH 0/6] Introduce precious files
Date: Thu,  8 Oct 2026 14:06:56 +0200
Message-ID: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=mroik@delayed.space; h=from:subject:message-id; bh=++mLwYYdEQ+aYtPwYyCzFziLHa243FP5geJ8PmmtsMI=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqx4dgu8lTA8Xko2PXYU3LNYEufjQZ4iczqto/U GNaJc4J5ZaJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaseHYAAKCRBIeX6hnBm+ 0dpfD/4lzED1iqsFOaF4uSr0ocj8uPHSYs6ofzqd7gw0M/o0z8xcA/808vkC50xa8fqjHxOt7Vj 248jbxqtg68kMO52XAjJZwnb23T2SRdJnDsLvQR/sYEq9G9t1KKZCNRo6b9fs5+kXl87k8NlHjI NRw1zGuql5TiijByoKbeqfJdTt/vTjwJk8Rqfdv4iXgKI1a5D5y1Mm3FoFYH5OQoFCn7zL3SpRh PCfgV0sPayH4FhuY9wcB7fNHmx83yDAJm8fy/sUMbGDv8xcv7vG60S9eM0gE33kNtzgasr6OrIV xJwDY2rygefmD9iITa1z7oR+gwtPgCal6V1THmPdNuF8XQMXy5cP2/xT0+iowFyMkxxOx+cO2m/ DPlHch7VTcMF3zyLZxQve4/4lTIrIyEhXy/ZzMDuUBNFDxS4TDergylvudhwP0i56bkE3kQAuOA dutdOBft/MrEc8yyrUd131ND+NitoSy4Pc/RLR3sKgoQ50o0drco6iSbp+RiFruCOkK7+xi7ZXb xjGNmtJccMhxmx2W7CUmGKOLyFkjbH0eO6RjjjDY7lfoKSz/hx2yVhc49H2ql7/yC+zO7QdChyp hgeOzvL64a/SkzN/9SPmKiEWBKYC7W1BjwCCTLWpMyd9FKj/pwM7YGxSpnOnpNAgBtfefuBOLkN FR34U+PrT
 q7p9Fw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Introduce precious files based on Elijah Newren's document [1].

With this series documentation is not updated yet but I wanted some feedback
before polishing and moving on to implement the changes for "git clean".

[1] https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmail.com/

[1/6] precious-files.txt: new document proposing new precious file type (Elijah Newren)
[2/6] dir.h: replace pattern macros with enum in attr.h (Mirko Faina)
[3/6] dir.c: teach parse_path_pattern() precious files (Mirko Faina)
[4/6] dir.c: teach add_pattern() reject precious pattern (Mirko Faina)
[5/6] unpack-trees: teach check_ok_to_remove() precious (Mirko Faina)
[6/6] builtin/ls-files.c: support for precious files (Mirko Faina)

 Documentation/technical/precious-files.txt | 540 +++++++++++++++++++++
 attr.c                                     |   8 +-
 attr.h                                     |  10 +-
 builtin/check-ignore.c                     |   1 +
 builtin/clean.c                            |   4 +-
 builtin/ls-files.c                         |  75 ++-
 builtin/sparse-checkout.c                  |  16 +-
 dir.c                                      | 144 +++++-
 dir.h                                      |  51 +-
 t/helper/test-path-walk.c                  |   2 +-
 t/t1091-sparse-checkout-builtin.sh         |   8 +
 t/t2205-add-worktree-config.sh             |   2 +-
 t/t3001-ls-files-others-exclude.sh         |  27 ++
 t/t7508-status.sh                          |   9 +
 unpack-trees.c                             |   7 +-
 15 files changed, 849 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/technical/precious-files.txt

-- 
2.56.0

