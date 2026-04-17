Received: from 19.mo583.mail-out.ovh.net (19.mo583.mail-out.ovh.net [46.105.35.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29B27CB35
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.35.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449280; cv=none; b=offXBK8fZDahHti3HCpLNOddh2yOcau81RYVgi2DN5DzAoDgbh1eDhKg/2HprX9nCrx+SB4iKBqgIEG8d7HIwpGk602i3ONHkt2oGEwxL7a8sM31cmkgxyw9c6p1WENKMKB7Ji+Xzm5ohjhehSHXaqfNgUVj4Bs1Ht0ZsIEXJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449280; c=relaxed/simple;
	bh=airb3qEviiwXS/jZPWEU2Iw3q8V5sz0KgLWh9C9Nap8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WNMyhQtIteu/a+u1ayBGkqnUdoWlRGFphOC6U2LOhLTk9YCLuNSpybpUemcHlJg/jzv6w6wcn7OsWcTw0tQyKVU0g48IjqTbeSmatt9IPSJhSf8lRqQp2pAcwlzD272Ywe6ROM11NrsCQDUEsFmHX7kiptO7TKPftYzMa9EdSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.35.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.254.168])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4fy16j4rcsz5y8P
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 16:48:45 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-7kq2m (unknown [10.110.188.214])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DACCCC0FEC;
	Fri, 17 Apr 2026 16:48:43 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.102])
	by ghost-submission-7d8d68f679-7kq2m with ESMTPSA
	id qjjuJGtk4mn7tAwAN7lZ4w
	(envelope-from <kernel@schlaraffenlan.de>); Fri, 17 Apr 2026 16:48:43 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R00432dd1fc0-92a6-40e7-874a-54564724a454,
                    B7C68D824A8F199700666F34D4E97AF0708B992A) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:185.104.138.163
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Subject: [PATCH v3 0/2] Avoid hardcoded "good"/"bad" bisect terms
Date: Fri, 17 Apr 2026 18:48:29 +0200
Message-Id: <20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ7CIBBFr9KwFkOhpdaV9zAuYJhaTKUGKtE0v
 btQN8ZoZvUm/78/k4DeYiD7YiYeow12dAnEpiDQK3dGak1iwhmXTHBGtQ0IE53QXwNt0k/KJl0
 LJFVuHjv7WHXH05vDXV9SITtyordhGv1z3Ytlzv1Rx5KWFASDtq5YXXF1CNAPyquuQzcotzVI8
 kTknxLxJeGU0Z2R2mgOLTT4S7IsywsI6It6BwEAAA==
X-Change-ID: 20260320-bisect-terms-76036676769c
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 7236440177676026847
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEhX1M7RtfAYFBNISmpRXbM1aYCpdxtpl03qmn81sFdy7//RQBZjmT8CkYbAgpwisUkrqOtjvJP9MGlkZaR9fACTTQR6znP/p/obmvVh7qM0m8Kd9T2W6a8V5T1RW6NsbRGEJTKaov2/FbSkpL7jy/6ybDmh1Djxnk3UJ+Kx6TC4eukyXGI483oJuWX18b1Mbeu86D0jHeruAv3qqLfsE51sKq13lcfm7XN5CtEkpatqLmhgIj4V6Y917bIPcyXeLyUeYM/DNWUySGeT7Vpzi3sLPGyp/EUGL/39Nst1Q4ZBsdAubGdQ1HBBqUwooyyz++SwcsKXCUWtNeSj8iJCA3JMHZdgbUB99nShZTtXOwEylVhxBqUmv8ZenY01wc+G5Oz97GG/I/mPHx2+Sq7coCqNxVrgWxkjLH8Nduo3fGfa6NrMubfgJ0b/LNypiMnxSexg91iy7YyfF+W59BEQIDyMbUIOQc6bGtbnmI8BGY5uTiHIM6qVkAHgYuEZ3rwqWRlOLnEsvsId7XNEsfu+X639e83xxYxpSGmEwWHACHf1nBSqQN6cyafP+e1msoCSspdkLT43Ru121Y/H2O5xCbEUPJvKr7B3NU7yA55hac44Am2RaQ94BhQP3n+5Cp7Gcqj1uX8a7+IlBn5O51WAZ9d//Al5xqCGvNOnVRK3FfU2Q

While checking whether all output messages of git bisect were covered by
[PATCH 1/2] bisect: use selected alternate terms in status output I
found hardcoded good/bad refs leading to incompatibility of git
rev-parse --bisect with alternate bisect run terms. This is addressed by
[PATCH 2/2] rev-parse: use selected alternate terms to look up refs

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
Changes in v3:
- when referencing newly introduced terms, reference them in single
  quotes (Thanks, Phillip)
- Prefer test_grep over grep in updated Tests (Thanks, Phillip)
- Improve commit messages (Thanks, Phillip)
- Don't leak memory after read_bisect_terms() (Thanks, Phillip)
- Don't leak memory after xstrfmt() (Thanks, Junio)
- Add test case to patch 2/2
- Link to v2: https://patch.msgid.link/20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de

Changes in v2:
- Improve commit message
- Add tests
- Include second patch for hardcoded good/bad in rev-parse
- Link to v1: https://lore.kernel.org/r/20260320-bisect-terms-v1-1-c30c9540542a@schlaraffenlan.de

---
Jonas Rebmann (2):
      bisect: use selected alternate terms in status output
      rev-parse: use selected alternate terms to look up refs

 builtin/bisect.c            | 23 +++++++++++++----------
 builtin/rev-parse.c         | 15 +++++++++++++--
 t/t1500-rev-parse.sh        | 25 +++++++++++++++++++++++++
 t/t6030-bisect-porcelain.sh | 38 +++++++++++++++++++++++++-------------
 4 files changed, 76 insertions(+), 25 deletions(-)
---
base-commit: 1b296b0f55885fa8fc649c4b31c37f3d86f3f9cf
change-id: 20260320-bisect-terms-76036676769c

Best regards,
--  
Jonas Rebmann <kernel@schlaraffenlan.de>

