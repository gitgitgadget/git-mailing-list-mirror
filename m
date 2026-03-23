Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879D372B53
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307249; cv=none; b=fr0HoptpNmOAJf7BMIQaNufJMz5K30ctMzpMP+7qsiMLUfXGCOkifUWpEN4q9f3mfsi/a5p8uSqqYAre88xnmgpoTNjuex43x6iJTgWDCkFm1ZreYlyVAHZ+jliq3KtUTszFNWlVBBLA9VcLt35CwjYBp9r8XA1DgrXewKV16IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307249; c=relaxed/simple;
	bh=szSb+jiGXEL3MPO9vHgHC6hTJlMQpL3yDsXCe9oVMDo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ljkfh/zxWoQd4QfrLuOlGbNJIfE+LGTkweyWLBTJx5xS9AFs6w8Dm0OB1Hqr/I5Hu+bbTSadPl/qREzNOkH4zTxbu0OP29bmTSXcVJcq/pYXeVEiRjDOfVfiP046y02su79TWuW7/OSINxhNHdA72UNdFcxS4LziJXBKi5GXTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director8.ghost.mail-out.ovh.net (unknown [10.110.37.133])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4ffpJ346Qlz5wgW
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 22:49:07 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-77wzd (unknown [10.108.54.44])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1FDC3C0134;
	Mon, 23 Mar 2026 22:49:06 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.102])
	by ghost-submission-7d8d68f679-77wzd with ESMTPSA
	id mhIMMGLDwWl78T0AiVxfvA
	(envelope-from <kernel@schlaraffenlan.de>); Mon, 23 Mar 2026 22:49:06 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R0041cfd1231-27c6-4102-81d9-9bb1e78f158d,
                    CF5F45155CC526890A7B96C462E82A48810857C8) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Subject: [PATCH v2 0/2] Avoid hardcoded "good"/"bad" bisect terms
Date: Mon, 23 Mar 2026 23:48:58 +0100
Message-Id: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2ppSXsGV/2FYlDKVMVhIpxIN4
 d9tcW1mdW7uPbMBoydkuGQbeFyJaXYR1CkDM2p3R0FDZFBS1bJQUvTEaIII6J8smpjVdROvNRA
 ni0dL70N3637Mr/4RB8mRGiNxmP3n+LfmqfdHveYiF6aQpq1KWZVKX9mMk/baWnSTducBodv3/
 QvLvsm5wgAAAA==
X-Change-ID: 20260320-bisect-terms-76036676769c
To: git@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Jeff King <peff@peff.net>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 14079096863422120835
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFcRZ73sADwnUlQ9eaSvXAzTPZVrM6zPUzO6OrEIdx9zX/brm87DI/i4r4P7XhpHRWj9vlDu6ByuW+p165eUis+QkWKB/vgbljFGgP/BXD9re7Zsotq0MyFDpmm1wNbbGAvzUSidVINV9cVNyf/qjHio5if5F49EosSg1O/WNGv7M8RQj9bLG5jciepTfycgeaSVeprb+cS1pFSovcmOG6Srb/nWj7KzMdaRl92Mh15kmDlhhUhsxCsR0gyk+5PF3nqrtUX29LRsaV9r0IzY1fPZD8DEt2IQIpwMx1VlwAIRCadVWNk1tbRhkm3jeokLMUtymHqWTPYwDnGVzykK0I/eR9b+re7vBepG12RL8GMLtmcL9lUgPLXJ33AaxxDX26RMpytu/bo80n8I2n7xNOwQyCsSSFgWBWJp/yAUTuozYDH7ha/9i07aLg0KTqVj/ohFZa2WdBJoTRUAYHtHbnwCMp8+/VMUt40qlgVIxwaKaguRNNIP70f03vp6bk/uJOvR9ZHuTsK5QObZsQMp9m63k8sFcgvAUWFilxw7JFEumY23kT120oaaubIsA/HwGuEYx8lL32jk+YstQaxlgOeBGS2b5EWmnLJByXimzGfJWiBx0Z7zjpBafqbxt2Rw8VhlvF9H8XG9oaAKS0+feQmWLVEkRfn+U+ZxgcH9WZHuw

While checking whether all output messages of git bisect where covered
by [PATCH 1/2] bisect: use selected alternate terms in status output
I found hardcoded good/bad refs leading to incompatibility of git
rev-parse --bisect with alternate bisect run terms. This is addressed
by [PATCH 2/2] rev-parse: use selected alternate terms too look up refs

Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
Changes in v2:
- Improve commit message
- Add tests
- Include second patch for hardcoded good/bad in rev-parse
- Link to v1: https://lore.kernel.org/r/20260320-bisect-terms-v1-1-c30c9540542a@schlaraffenlan.de

---
Jonas Rebmann (2):
      bisect: use selected alternate terms in status output
      rev-parse: use selected alternate terms too look up refs

 builtin/bisect.c            | 23 +++++++++++++----------
 builtin/rev-parse.c         |  8 ++++++--
 t/t6030-bisect-porcelain.sh | 16 ++++++++++++++--
 3 files changed, 33 insertions(+), 14 deletions(-)
---
base-commit: 1eceb487f285f1efa78465e6208770318f9f4892
change-id: 20260320-bisect-terms-76036676769c

Best regards,
--  
Jonas Rebmann <kernel@schlaraffenlan.de>

