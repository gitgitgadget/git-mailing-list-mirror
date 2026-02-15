Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F9245012
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186724; cv=none; b=Zlh1aG5MlyvJ8x++UKcWEFgy422d+MyhZCllpf89P1HXCtAnebzKNP/XI2bcmkvh+iEDmgD2TMpVipq2Z0iDElUcWAiAqrHt26tE5glKDM3/g1ztl4Q70H5NkGLMbMExVTjyqwo+i/ku23t6p/ndZ0a9XZLh/Cz6tle3uKgntow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186724; c=relaxed/simple;
	bh=WfZvzMheGw2WbDuCp0g+u0sRLCOOe5T4LS7E17sgqBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lw87/uUS3HIYLUEaHXQYU9IdeRtGybGzvdsO/wcZwyJF0JNROuIRlDyeG7Vm4uuC/2VSnmvLW34xy9apl71hHj1FPv3NBCBdFYmhcQ8EOb/TFXvgrbmHrpDRWFrUnlO/XfFPOJo3B4kY0pjXjgveJ4NKS4QvRN8YlSakQr0YbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=Kq2fyIfF; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="Kq2fyIfF"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZe-008AnL-E6; Sun, 15 Feb 2026 21:18:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From;
	bh=P7iRXqz6DkAh+Yxj/Y1Ncp1sTBGCKjX3ZfvEeD/Hj8A=; b=Kq2fyIfFjYm0LCVndna9QMKbVK
	vSINFEKhUJNtaDeG60J4E4dFTQf++68iryVza3VqroPdj3HeSfXNXThtDk6iqNr0MTb54Li9u+etV
	CRGpD8+u5EH72i/jCAdWlWJh2I7vtsVEi1tPM1fA9bKTFhMShGOt14wpu9uHhHx+lbmTFfoFBfE7X
	+0127ulIeKe6urrEtypMRcbml5uWhjCqRCosJsambngbe3J2EnbCLYl+F35Nt9TswQhIwz76Uh+YK
	2oQuGR0hEYdE7lCg4jCMVdWO7r2mn6PtLvFAUz1PDSM+TK/LY6UyaRuWA28ahFW8uTRkGD9MR5EGm
	/InsGKUA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZd-0001Ch-Rb; Sun, 15 Feb 2026 21:18:34 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vriZN-00E3Gq-JF; Sun, 15 Feb 2026 21:18:18 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Christian Heusel <christian@heusel.eu>,
	george@mail.dietrich.pub
Cc: Colin Stagner <ask+git@howdoi.land>,
	Christian Hesse <list@eworm.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] contrib/subtree: reduce recursion during split
Date: Sun, 15 Feb 2026 14:17:42 -0600
Message-ID: <20260215201748.889866-1-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

* cs/subtree-split-recursion: when processing large history
  graphs on Debian or Ubuntu, "git subtree" can die with a
  "recursion depth reached" error. Reduce recursion.

On Debian's POSIX sh, shell recursion is artificially limited
to 1000 calls. You can check if your sh has limited recursion
with:

    #!/bin/sh
    recurse() {
        r=$(( r + 1 ))
        test "$r" -le 1000 || { echo OK; exit; }
        recurse
    } && r=0 && recurse

Depending on the history graph, subtree split can recurse deeply
enough to encounter this limit. Rewrite the rejoin-deepening
algorithm to reduce recursive calls.

Colin Stagner (3):
  contrib/subtree: reduce function side-effects
  contrib/subtree: functionalize split traversal
  contrib/subtree: reduce recursion during split

 contrib/subtree/git-subtree.sh | 95 +++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 7 deletions(-)


base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
-- 
2.43.0

