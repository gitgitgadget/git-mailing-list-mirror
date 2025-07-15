Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D311FF1B4
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590115; cv=none; b=bzsGUoZWfKKHKRQGCZXQFx7V89jfYB1DuoLjmehgBZSPg8DbS1/pNmkdK3s5PNv2eN0VIAX8lizMxmRMifc8Rbj/nPip6/O66R4WbYN69yFY+Gmm+p+rJkowDYdksPqAFZiFihvwxcPsD43+g4aB1PaERz1HzxMVccWp88lpciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590115; c=relaxed/simple;
	bh=aRf+eDv3xmwKe3dgzxe/z5hLJygclds01qytS0Nxxh0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NhcA2SWo0SK48OjET0tY9NnMkKH/T14P3baoRe3/6+yDbLwVmsFfG2BsqrRP3sVrSYWlKoV/JmDNEw36pg1B8PZuqQIhcvA+QLDTFUYySzjdgzlN+eZV9cwC5ffX/vXayDANpBkRXxReTbQrYOvy0JcrswcP6eoULtnGD9eQUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ceww1Xv4; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ceww1Xv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752590110; x=1753194910; i=l.s.r@web.de;
	bh=7DY0SpAK1w7HPya1bia/0zZP/c2cUjidaw/s33iWPv0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ceww1Xv4qFptZ2jynBLj055q36QhfAEGlognH0lCNhuhjGkH9jOXF2tyBX5Gzmad
	 U5MYy/1ki9JwJ3m45aaX07MR66HTnaxmGhRxbF3bmEFmSmm1n+27HmdvjDUQR9Kr+
	 NwSdX55Le1uKSaoURdLXCcff1KF+sADbqC0bYnlxF4V0SAM7AqLzjdZQWy4vf1LD4
	 fePRNMCfGnGRiNa15eb3l5MEw3UBOtTjbRjOrmbVCPAb+aD8NPSrQZHRdV2hCPr/1
	 6a4/bWnRolpp+Dk1C2Zgy1Qdb04Xuh30Wzm1iATsiYmS4iFThACvpujDvtWlSQcID
	 fiFLwlfm1MHlqHkI5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1un0PF0uvx-00xzv8; Tue, 15
 Jul 2025 16:35:08 +0200
Message-ID: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
Date: Tue, 15 Jul 2025 16:35:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] commit: convert pop_most_recent_commit() to prio_queue
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U+fxJDrbBf4Sar1UVw2mJgBMLjaGvyirgHCGZM4DYmTLuWNcpMc
 kOShMi7RbtUqay3EAXLGhDFV0ACyWzfMhrQnRctdqzchCQCxbHlKegjrFys+v30nqJXbu0p
 nP6JHkPdVOfelj53cr1ljk/9F2q2Mp8RICwuJ0lQ7oIqisjEPDeBKT9kGE3FfekDfNHzEAj
 jUSx5enaHXDZtOd6oPkYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3SvnYj3a1J4=;8JoNlmIStHxE3E+999HI/SgRnXV
 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
 iw==

Use prio_queue to improve worst-case performance at the cost of slightly
worse best-case performance.  Then add and use prio_queue_replace() to
recover that loss.

  commit: convert pop_most_recent_commit() to prio_queue
  prio-queue: add prio_queue_replace()
  commit: use prio_queue_replace() in pop_most_recent_commit()

 commit.c                          | 14 ++++++--
 commit.h                          |  8 ++---
 fetch-pack.c                      | 13 +++++---
 object-name.c                     | 10 +++---
 prio-queue.c                      | 45 +++++++++++++++++--------
 prio-queue.h                      |  8 +++++
 t/perf/p1501-rev-parse-oneline.sh | 55 +++++++++++++++++++++++++++++++
 t/unit-tests/u-prio-queue.c       | 23 +++++++++++++
 walker.c                          | 11 ++++---
 9 files changed, 153 insertions(+), 34 deletions(-)
 create mode 100755 t/perf/p1501-rev-parse-oneline.sh

=2D-=20
2.50.1
