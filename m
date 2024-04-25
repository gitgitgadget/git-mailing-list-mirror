Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9DA83A1D
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040336; cv=none; b=R3UPIXAijiYt9BWS/xOtOpZKk2Fki6Ie087vHZi+Hewku7srEwXwt+e/GaUz2CH+l2Jon/Fo6cQAPVj4QWhD2JvbSGU7pe37I7x7A7OuTelRQY3fUOWZ6h/HjusAAaG6GWhGkx9ix1PRZvCpj8aP7tgTfTuAEP+H8UbeLHK1SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040336; c=relaxed/simple;
	bh=gVsw5IPMVDykcUpjgurCUDOtPHZqMJ0FKOXQhQUyu3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YcKSnncgd/F2nfzwZz/ZEt5FRRAydFNGabr1JThj4p/48Ai029mfqwIaOp1O+JNRqFRnXokRPvVXF3iaeKjo2AUgGZrtHW1qfydK1jVMixDN51a6rPRVACD8jjDMAEeHdKwHJFU4Zn8AMQgSiX+nSjLN5qIswTH4r2lYRp3PGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBn-0005rV-Ch; Thu, 25 Apr 2024 12:18:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBm-00EFFH-7k; Thu, 25 Apr 2024 12:18:50 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzwBm-002yLV-0c;
	Thu, 25 Apr 2024 12:18:50 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] completion: improve docs for using __git_complete
Date: Thu, 25 Apr 2024 12:18:43 +0200
Message-Id: <20240425101845.708554-2-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240425101845.708554-1-rhi@pengutronix.de>
References: <20240425101845.708554-1-rhi@pengutronix.de>
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
understand that the two paragraphs really only refer to adding
completion functions for executables that are not called through git's
subcommand magic. Improve the docs and be more specific.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
PATCH v3: new in v3, based on feedback from Junio C Hamano
---
 contrib/completion/git-completion.bash | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4d63fb6eeaf7..566f32d412ce 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -31,15 +31,22 @@
 # Note that "git" is optional --- '!f() { : commit; ...}; f' would complete
 # just like the 'git commit' command.
 #
-# If you have a command that is not part of git, but you would still
-# like completion, you can use __git_complete:
+# If you have a shell command that is not part of git (and is not called as a
+# git subcommand), but you would still like git-style completion for it, use
+# __git_complete. For example, to use the same completion as for 'git log' also
+# for the 'gl' command:
 #
 #   __git_complete gl git_log
 #
-# Or if it's a main command (i.e. git or gitk):
+# Or if the 'gk' command should be completed the same as 'gitk':
 #
 #   __git_complete gk gitk
 #
+# The second parameter of __git_complete gives the completion function; it is
+# resolved as a function named "$2", or "__$2_main", or "_$2" in that order.
+# In the examples above, the actual functions used for completion will be
+# _git_log and __gitk_main.
+#
 # Compatible with bash 3.2.57.
 #
 # You can set the following environment variables to influence the behavior of
-- 
2.39.2

