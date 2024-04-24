Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1F8156F4D
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995430; cv=none; b=uT5JpTpfnxZRk/1Wouk1RHOsmitWK53qOpUTvfHP7xyL2hK3phjiVUfDYH+tMvenkL/ob5bZH5s7OTeTkTuKC2sFNjNP8jxMciI8VAkoPvrURqDPv0YMu/KVgMx4azt8Mpn+sM/qzsHDPUBo55hknMnIzI6cSR3ajtTOBTxloag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995430; c=relaxed/simple;
	bh=KcewbNlfJn2fU84Xv+Iqwq22sOUg9sU0pJrAb/gfMiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8SSro45EnjZ8AQ13pyZEVS3HHVEnOcCbYBWyhpBUn49auIbn2ufOHEdLSC3irqHoxwdOAo13A7shNlJQOWHwHRE2o99uw3/vnhnDqItPo7h+y5O2/42tzvLR1REhSJhpA8Z1rl8VvtJPMJz788qH5F0BlNNo3FSDXqivS9naUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkVV-0003FD-UN; Wed, 24 Apr 2024 23:50:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkVV-00E9HA-BO; Wed, 24 Apr 2024 23:50:25 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkVV-0017qx-0y;
	Wed, 24 Apr 2024 23:50:25 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] completion: add docs on how to add subcommand completions
Date: Wed, 24 Apr 2024 23:50:18 +0200
Message-Id: <20240424215019.268208-2-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424215019.268208-1-rhi@pengutronix.de>
References: <20240424215019.268208-1-rhi@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

It took me more than a few tries and a good lecture of __git_main to
understand that the two paragraphs above really only refer to adding
completion functions for executables that are not called through git's
subcommand magic. Add a few sentences for that case.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
PATCH v2:
 - fix typo and superfluous "-my"

PATCH v1: https://lore.kernel.org/git/20240424210549.256256-2-rhi@pengutronix.de/
---
 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffcc55484bcd..603181d53a90 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,13 @@
 #
 #   __git_complete gk gitk
 #
+# To add completion for git subcommands that live in external scripts,
+# define a function of the form '_git_${subcommand}' while replacing all dashes
+# with underscores, and the main git completion will make use of it.
+# For example, to add completion after 'git do-stuff' (which could e.g. live
+# in /usr/bin/git-do-stuff), name the completion function '_git_do_stuff'.
+# See _git_show, _git_bisect etc. below for more examples.
+#
 # Compatible with bash 3.2.57.
 #
 # You can set the following environment variables to influence the behavior of
-- 
2.39.2

