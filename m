Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A01394462
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750540; cv=none; b=ZMTPaozz3U4Ikqml+N4m5pLvI5sO6Tq0+5A3WbbwfILoZVS0uz61tFVY/3LP/CteIaIiBFWet4YgvMc20xtcjMaGyef0Mvy7To8l9PQuXurq03qxzgBYlVIQwOUzuZZfysOBg0X59S4evsNX5gQXtEXtXjRxIyssuKoYlb8buR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750540; c=relaxed/simple;
	bh=Ct+Gl92WHTnU20ki2JG/w6dVveIMkFA8AjRyk15hp1I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aTCCGqz3imPPCh/yuKzvY8BNaGNn0fd5lGpqLoK0HpsE6bEZthecqEBwYzkbJdv/MPkDqYYFArQlvkL7HZ4stVpRhquc/x6ZZ7NfJRfIhkjIkFARIW4HndJa2Oet/RFXhPHbngE2hdq2tB9tltcRY8LsOVTSZ5pCXipzUqVjAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=188.165.56.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director3.ghost.mail-out.ovh.net (unknown [10.110.54.21])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4gGPbd1dT4z67jB
	for <git@vger.kernel.org>; Thu, 14 May 2026 09:07:09 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-d4cxr (unknown [10.110.113.233])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B70F3C03F4;
	Thu, 14 May 2026 09:07:08 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.114])
	by ghost-submission-7d8d68f679-d4cxr with ESMTPSA
	id kOqGG7yQBWrumSQAmZP82g
	(envelope-from <kernel@schlaraffenlan.de>); Thu, 14 May 2026 09:07:08 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008fa7b10df-b21a-42f0-a1e0-35e1c494d49d,
                    C39F0B467605CB235B8620DBAA124B5209E80D88) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Subject: [PATCH v4 0/3] Avoid hardcoded "good"/"bad" bisect terms
Date: Thu, 14 May 2026 11:07:03 +0200
Message-Id: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBAF4KuQrq3pH6248h7GRWmnUqNgWiQaw
 t1tcaEhklm9yZtvRhQheIhoX4wowOCj79oUxKZAptHtGbC3KSNGmCScEVz7CKbHPYRbxCrtpFR
 pKoPSyT2A88+ZO54+OT7qSzrIRm40PvZdeM3/Bpp7K/RAMcWGE1OVgpSC6UM0zVUH7Ry0V91uL
 aD8YmC/CF8gDBO8s7K2NTOVUbCG8C8iqFogPCFWlpXTpVBM0n/INE1vvyBkYEwBAAA=
X-Change-ID: 20260320-bisect-terms-76036676769c
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 10429492313691292449
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTECXprAC4D/D0NrfNKYsKxxQ3pgk87hzOByYwCekwGoB/tQi+Fp3knUS37dp6XgphTCpPkfV2eAx674LB/V44CbI3ZBzw9QGF9dj8WVX9NSPKEmFc/Y9lZL1zJ4ujtJAeF3kq84CR+wZg43bnkkB6Jh+OJxeTPiv2cU1/DtXeHCWpCjZj8+ViRBPIbTcL+1uBZiQI2VqtQJksUGeeM4mqY2kPq59hPtvIE8UAeNpDVZpjc2XVg69odEYwZXPblqZkyNs6jMqjnmUvNPPvVW+dUoSGH8Q1gJbX92q3oln0wgdtMxgMg53FT2QVYFhl5JckUS8Wa3ew/pV462vwc/086qCd/C2TQK5ixpqsoFq/eAwg2D4xnVbSbNf/KOrcg9CjiXuzLxg0z60omQruqw+2R3grD8odCkzjrS/s/nHta9ZVjjl0mcHzZCieS5EJbMrZMU+Sj0skQhT3g3EVo/3tHve3vBT0kJORplItnRLCnKOo3cu98vIOm6Usf6Cz1nICORFUz1eDRyrtaQo2Del52cbQoKMCchHt1B+DahlkhR7VvBlyDcJoBtnvvd/vsyKot8fgDtsmbNkggkMe6iMslIZ8N5+y2uqfTkNN5mVWiL6bPDF32dnCQD+XAWB3YUiXfM6ZJVXUQhuBAc9aM9bf7WbFH/DRpRi+/2dM5/qSo3ug

While checking whether all output messages of git bisect were covered by
[PATCH 1/3] bisect: use selected alternate terms in status output I
found hardcoded good/bad refs leading to incompatibility of git
rev-parse --bisect with alternate bisect run terms. This is addressed by
[PATCH 3/3] rev-parse: use selected alternate terms to look up refs

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
Changes in v4:
- Always print bisect terms in single quote (Thanks, Junio)
- Split out quoting of bisect terms into separate commit
- Link to v3: https://patch.msgid.link/20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de

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
Jonas Rebmann (3):
      bisect: use selected alternate terms in status output
      bisect: print bisect terms in single quotes
      rev-parse: use selected alternate terms to look up refs

 bisect.c                    |  16 +++---
 builtin/bisect.c            |  31 ++++++-----
 builtin/rev-parse.c         |  15 +++++-
 t/t1500-rev-parse.sh        |  25 +++++++++
 t/t6030-bisect-porcelain.sh | 124 ++++++++++++++++++++++++--------------------
 5 files changed, 131 insertions(+), 80 deletions(-)
---
base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
change-id: 20260320-bisect-terms-76036676769c

Best regards,
--  
Jonas Rebmann <kernel@schlaraffenlan.de>

