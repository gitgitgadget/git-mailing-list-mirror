Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7D2111
	for <git@vger.kernel.org>; Sun, 11 May 2025 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746924031; cv=none; b=KC0IbhuybEEREhu+kwKVnDWo/b5CuggvoNxl2vx9ZiW2sqkKgMP/uJS2jn7dMuMoJBOCLrJthLWpCLtyZUFCAH3oLEUKVXc/+lbD8Gi2vipgENmWwsxw+VL2XBskv/jfZ54piOzTRyDUYvn3KTdBjveODneGLWVEWyYatJvTQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746924031; c=relaxed/simple;
	bh=PfG6ur8Mv7ij3Mhgd/EWWQh85626+3JSwz3lRaHyXcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRewx2LHN8iKZt5NQaWd3iuPGzCHG4nCCsjivjWWulFPc5SwYq6cFmZZb8jzAvGzMCiVv40N9dQCkMxM1iAlNzHQBlCyyqLl6PdKI/7Qfl2umMlg5fP1kQKovFNSOUNXbsSg+3S0fJ99u5hG1Qu8r32GffFCZvlUqdPfbsTGXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=oLkdtvHa; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="oLkdtvHa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746924023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQzqMBfRXULFVKTTyPFaD2pgSgGX+NCeD6SktqG21HI=;
	b=oLkdtvHaEmftp0Z2WV5UlQCdbYDZaI/SPS9eyaLHZ/8qaK9AOyKEKr3quAaLp4j000/+De
	asanRMcNvc43xcwCdI5QvcLxXvY/omjEPlGJZ27m3NjuAfIc7IqJ3ymPUOvgytu6BEDc/p
	Vaoz91mM9FKPVL/9QZGf3BoYeYkAcE0=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jason Cho <jason11choca@proton.me>,
	"aclopte@gmail.com" <aclopte@gmail.com>,
	Ryan Hodges <rhodges@cisco.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>
Subject: [PATCH 0/5] apply: fix apply --intent-to-add
Date: Sat, 10 May 2025 20:36:43 -0400
Message-ID: <20250511003955.242889-1-ray@ameretat.dev>
In-Reply-To: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
References: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series fixes the -N/--intent-to-add flag for git apply, which
has not worked properly since its introduction in Git 2.19.

In particular, the index is properly initialized, and not touched except
to add the requested intents to add.

Loosely based on the patch from Johannes Altmanninger, message-id
<20211106114202.3486969-1-aclopte@gmail.com>, but that patch turned out to
be incorrect.

Raymond E. Pasco (5):
  apply: error on --intent-to-add outside gitdir
  apply: read in the index in --intent-to-add mode
  apply: only write intents to add for new files
  t4140: test apply --intent-to-add interactions
  apply docs: clarify wording for --intent-to-add

 Documentation/git-apply.adoc |  8 ++++----
 apply.c                      | 12 ++++++++----
 t/t4140-apply-ita.sh         | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.49.0.1106.gc0efa3ba58

