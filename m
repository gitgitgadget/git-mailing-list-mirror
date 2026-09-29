Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360D3CE4B5
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692514; cv=none; b=CbvBzUPGIfEpDh5jhINwlFewfs4+y1Vgyko9u2oPm6H6unwMB4Ss/JVzM7kHEON4q/khnwHh/4mNj+G1UQk/oePiGoHskIEEzPv/AOQ929JRGwgQ+0mq38qOw++cIS0o/b9IF5qiGXPIztlqOGVRjx4G1x5ot1cCYE5yUA63AWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692514; c=relaxed/simple;
	bh=DNI6AWAhI2swquakPBCm4UActAZbqZAO+pMFxLtncr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6GSPXgqvv2GKzOg7gfFUdmzFK4j/IYU+1OUBOK5l2FkVL04Ugy2SJhb8/KxmmMYPFgrodc9/uTTXYdYzfAZx1OHrd55KcBqWftdRrLPCz9GO02o4hdXfNDIZP6XrOTtmxmPe/NDLuBF9frTL7+tOdMSknre5PsOcE+SOjTChGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=locati.it; spf=pass smtp.mailfrom=locati.it; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=bLq/iFU2; arc=none smtp.client-ip=62.149.156.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=locati.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locati.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="bLq/iFU2"
Received: from HP-PCD-007.progesoft.local ([95.227.74.73])
	by Aruba SMTP with ESMTPSA
	id BYs6xsTwthEseBYs8x7d2O; Tue, 29 Sep 2026 16:31:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790692318; bh=DNI6AWAhI2swquakPBCm4UActAZbqZAO+pMFxLtncr0=;
	h=From:To:Subject:Date:MIME-Version;
	b=bLq/iFU23E/SXKuPF1MqnyYsMkC29wgyB46NTNKgBRmxNJHee2/i5mIg2F8yLj2Q7
	 Jr/6V0/m+G6EEzMXiYL/CKEoBrsPrcBo1SKT4SLEI3sqG0jm4DV+SP4aJ/v+7grVlb
	 9GZFt31VsnidML91SOltULItDvKc3iHcgu7mS779OYqODzTBf/2ibD1oOBsSm4J6Zy
	 x4TYj6kuOlcAsRcsMtkwJpKwM2Q3u4auvYOuYwMIbw8ya06UoGLKfz++qR8O/s927C
	 7Z4Q8CtZV2gLBZqYUo+B1XJsVPgkiNbEO5E5m4Q7DMTphGkUXubxLcE5+oLI1fsYeV
	 QePMwGZqJIWhQ==
From: Michele Locati <michele@locati.it>
To: dev@grantmoyer.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	gitster@pobox.com
Subject: Re: [PATCH] fiter-branch: fix commit map init from state branch
Date: Tue, 29 Sep 2026 16:31:50 +0200
Message-ID: <20260929143150.2420-1-michele@locati.it>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801033127.10606-1-dev@grantmoyer.com>
References: <20260801033127.10606-1-dev@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKYJTO7UwXqNiS8OI1bAsW66IuyBnKBfeMqQQIMHvBs//KP6rpod03c54MduVR5BZjw1yacsmbmbrTL2Ak9gb1jbnAYd9I2y+MZXIbLMochNzOOMD3Xi
 kBAXf7fG5aErb07WqE8VlnErCixg2Mf/cB/7xnNCFlqUI6mN0hPSdCrtasEL/eTxtINIbLwT+h+XuO6wZzc9xh2gfLoes7lvpjapaq5hhelGkF4481sJLjqR
 7ceLeX66JbHGB+FECDzseIzIVWd88z/F8QYekK6sI2ODGEmlEnrZuzATgW+otle6

Hi Grant,

thanks for this patch: I hit the same bug, and I was about to report it.

Cc'ing Patrick and Junio, since the problem was introduced by
f6d855091e (filter-branch: stop depending on Perl, 2025-04-16),
released in 2.50.0.

I tested your fix with git 2.56.0, running filter-branch incrementally
with --state-branch, --prune-empty and --subdirectory-filter:

- without the fix, the new commits are attached to the original
  parents instead of the rewritten ones, and swapped entries are saved
  back to the state branch;
- with the fix, the parents are the rewritten commits and the state
  is saved correctly.

Tested-by: Michele Locati <michele@locati.it>

We know that the use of filter-branch is not recommended, but we rely
on --state-branch to split a repository incrementally, that is,
processing only the new commits instead of the whole history at every
run.

It would be great to have this fix merged.

A minor note: there's a typo in the subject ("fiter-branch").

Thanks,
Michele
