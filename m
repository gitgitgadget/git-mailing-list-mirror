Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267F745CB
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992763; cv=none; b=tWwwW1WSi0kdav6D1zvxgrLsQDCoAmEl5md+r7/mt+7cLbIa6jc8QohRe+QdLgILDA5d1Zfx8HeYSii35Gf1ous+Z8kOxNXhYeW5RqArlBgXnON0CUt0RdDWoBSbCt0s3A+LIaF0amCZMULfyPN/NVtYlrGcmBemBS+/TCdQJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992763; c=relaxed/simple;
	bh=cIV9zCXSXsuAHCWGIhbT+BVo+GhG8bnfaoordIP0v7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mThIvKBaJCsUg1XIwXDpOof5N7UAZfdlY4Z23qEWpRQXHrtlAIi/ah2ubCzeoZEnsN4DJGdXeablsfxWDbJNlbzfxTH+yfrY/l5aH0cKqyltmojg38TEgu+ANYAzKyTKnjxAp5gok6u9fWHkYjuK4Qwo8T0LErBUrln82dNa11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjoU-0004eC-I0; Wed, 24 Apr 2024 23:05:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjoU-00E9Am-3n; Wed, 24 Apr 2024 23:05:58 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzjoU-0014hM-0C;
	Wed, 24 Apr 2024 23:05:58 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] completion: add docs on how to add subcommand completions
Date: Wed, 24 Apr 2024 23:05:48 +0200
Message-Id: <20240424210549.256256-2-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424210549.256256-1-rhi@pengutronix.de>
References: <20240424210549.256256-1-rhi@pengutronix.de>
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
 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffcc55484bcd..f0c8353c1cdb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,13 @@
 #
 #   __git_complete gk gitk
 #
+# To add completion for git subcommands that live in external scripts,
+# define a function of the form '_git_${subcommand}' while replacing all dashes
+# with underscores, and the main git completion will make use of it.
+# For example, to add completeion after 'git do-my-stuff' (which could e.g. live
+# in /usr/bin/git-do-stuff), name the completion function '_git_do_stuff'.
+# See _git_show, _git_bisect etc. below for more examples.
+#
 # Compatible with bash 3.2.57.
 #
 # You can set the following environment variables to influence the behavior of
-- 
2.39.2

