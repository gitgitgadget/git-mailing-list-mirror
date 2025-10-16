Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38A238150
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641092; cv=none; b=ZIw+h5xytGGYi3ZHtuFTFpITWEa16uPMxQkWpRFe73Bxw7SsFNazb31NN17e1Sat38wXossOik2vCCXAGRJ/albBUNPSsnwq9S4E0MkPvhMksrgm4ql7G3iDQaU9dakeJo4+NJUm8QL/sezpyr6t0SyO+EFnXj1hUzNBO9CRTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641092; c=relaxed/simple;
	bh=kPD8fJl5KaqRm9FTHQz+aXs+nMUtWJ5LjPMVmOfTnv4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SOMvN8RGiPeauUDSrkOayMKEh5nKfCCVK/WISe4uSuQW2k5oYPRl+FkkcyPhJ176Go1djK8/Qrzp5hGovO0fInxHJeiTT2D9scwyVav+nDooYAtu20zxaupCq8VsJJI6OExKO3qNUMUVpnbn0WiXcCW2aCS1ik8vLUz8+v2LZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pVrRKwII; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pVrRKwII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1760641089;
	bh=kPD8fJl5KaqRm9FTHQz+aXs+nMUtWJ5LjPMVmOfTnv4=;
	h=From:To:Subject:Date:Message-ID:From;
	b=pVrRKwIIJT3W+ooyiJzSyC9F8FdwMWnPTNNoJawNLT/G6gXRF2OTU5e8HGgCI0J/C
	 WjLY0M3NE7c5Jgg+fwfpxtEbCJ/7BVXPTG96U+QjRdxWh9MZwxkwEMnaXVO4JOPi2/
	 pKk4v17SNcgmupnlJrtAo9LOdrAEYJ/8BDR51+dQ=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id F2AA31C01EF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:58:08 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] add a message-id header to git
Date: Thu, 16 Oct 2025 14:57:55 -0400
Message-ID: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There has been some debate in the kernel community about how to link
commits back to email, which is the basis of a lot of scripting we do

https://lore.kernel.org/ksummit/a7878386f3546ba475cdf7250ab4f5a6af2a1676.camel@HansenPartnership.com/

However, this problem is one that goes beyond the kernel, so having
git always track the message-id of the email used to create the commit
will be useful beyond our tools as well.  The design of this
message-id header is that it never shows up except in --pretty=raw
output, so it will never be ordinarily visible, but can be extracted
by scripts.  Some projects use the -m flag of git-am to add the
Message-Id to the trailers and for backwards compatibility, this
functionality is not changed although it is hoped that it is now
redundant.

Regards,

James

---

James Bottomley (3):
  mailinfo.c: always collect the message-id
  builtin/am.c: add a message-id commit header
  t4150-am: add a test for message-id header collection

 builtin/am.c  | 15 ++++++++++++++-
 mailinfo.c    |  5 ++---
 t/t4150-am.sh | 20 +++++++++++++++++++-
 3 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.51.0

