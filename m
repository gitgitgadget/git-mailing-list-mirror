Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2F1AAE33
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911650; cv=none; b=Hoo2cfzaYHlulv4pOty9/xQVbw69/VxOlYqiwJgi7Cnl0g2dnoYacZ+eK4dIIRqPq7ySLXNHhzK4VLGUrcgXBXzYbo8dMH6DxR+KfKUt9ot7TbQDr8fk97MiI7b/8h2e/ZPgCdVV+9vJ82+j2YYps8D/C4wexBDkBDqZlbyNEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911650; c=relaxed/simple;
	bh=VX7g06Td4Fuol4cBbXT9o/fIiij88oNSCy+AW5dPhgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rhKVpfm6nqZrMJx2s+Lqh0AH3qwJapGTyiUHtRyf5lpTxbhVUMOlhciHxUoXGkaWvRsqSrIn1Pm7GDty9dbkevI6reHeXiw+5W/YEj6VeCw/xuQ+ogxBjtZosDjq+BWQO879ZAE/lLykgpsphpwUesVhLakc5qOlzQ6WnDw+i4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dvOUThLF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dvOUThLF"
Received: from localhost (CSAIL-SQUARED.MIT.EDU [18.9.64.19])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49EDDoVx002017;
	Mon, 14 Oct 2024 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728911632; bh=nUNAEvxUzh2GfpYM1mRfdxytU07jdWXVbjSamleAxuw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dvOUThLFevxNttyBLphDhPaCfdr/eKGGgRcZosyY2UtqFWBc5tz3EyQ4kQRo5Df2A
	 bnErlauZRCbX3Jx2FfK7lmqCFXOP3q0W9BDCnDduCD66qcKIicZtFNfNcfNQ+wmvWa
	 /wevf4CokeoQuc/rPXk7j4kmdVpUwn7xrJIHBEBjLCy3aiATFIuMRdBj1NDjFwR2Qv
	 sbqCg8vQxyNOzSqMVva0UpPeHAWsgITfUxJxQccs2/XRZBtQhCOTn+V9ZSwSRHn3qZ
	 nP1/f/H36WVNgWugZV6z476iC7Ij1dEbJhub6nJoNdBA9TXFpOUQs5v1eXa+q3Tw8U
	 c8bBKu/xmqTuw==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net, sunshine@sunshineco.com, asedeno@google.com,
        =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 0/2] Restore support for older libcurl and fix some typos
Date: Mon, 14 Oct 2024 09:13:44 -0400
Message-ID: <20241014131346.3556163-1-asedeno@mit.edu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the small patchset I've mentioned on a couple of threads
in the past few days [1, 2].

The first patch adds a version check for CURLOPT_PROXYHEADER in
git-curl-compat.h and uses it to wrap the one use of
CURLOPT_PROXYHEADER, replacing it with a translatable warning if it's
used on an older version of libcurl.

The second patch adjusts some typos I noticed in
git-curl-compat.h. These should be easily verifiable against curl's
docs/libcurl/symbols-in-version, which is the source of truth for
git-curl-compat.h.

This is presented as an alternative to the patch series from
brian m. carlson that bumps the minimum version of libcurl
to 7.61.0 [3].

-Alejandro

[1] https://lore.kernel.org/git/CAOO-Oz1KhFcyErVx1Qb142PtPJS=UpgSD-FacckqNS4_okAtFQ@mail.gmail.com/
[2] https://lore.kernel.org/git/20241011190812.2654837-1-asedeno@mit.edu/
[3] https://lore.kernel.org/git/20241010235621.738239-1-sandals@crustytoothpaste.net/


Alejandro R. Sedeño (2):
  Conditional use of CURLOPT_PROXYHEADER based on libcurl version
  Fix inconsistencies in git-curl-compat.h

 git-curl-compat.h | 11 +++++++++--
 http.c            |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.39.5

