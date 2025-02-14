Received: from dalaran.tastycake.net (dalaran.tastycake.net [185.73.44.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CA1C8623
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.73.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570302; cv=none; b=FsLrIaGd4LaVlRixa/A5j5rLO2tt3XjjJTTyvGSDkEiL9THfzsoIndNefDum9L+KKH53YV+JwfqSaFqHlzNnck7ZmQRg9M+TWVSuYmBNKdJ/16DdKaD4PjTq5gkB8Eg18M9PWY58e42wUzk1ylT8fB7AwrQvAdk7EuR6rv1AvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570302; c=relaxed/simple;
	bh=+NdGYhaP94Qx2SgOQb2GmjfU3qRgWIEvg7go9AkqxzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siuZGYBzlfIzUUL4bl/e+Rv055Rw3rI0JP5LItN0RkHoEHDb+wXQY4XK8/6xrHXuaE+bsKTAXKzfwiq6wJ3zhzvEv/60Uyl4KKbRYi+hQvwAMbn5mBrgXoxAufTbN9faFFqV0aKF3up9G01GUsddxp2ohQPPRRVSF21wY9NsHWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; arc=none smtp.client-ip=185.73.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Received: from 2.a.4.3.0.0.d.8.9.e.5.6.7.e.2.d.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:d2e7:65e9:8d00:34a2] helo=hex.dinwoodie.org)
	by dalaran.tastycake.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <adam@dinwoodie.org>)
	id 1tj3hN-003F7L-TX;
	Fri, 14 Feb 2025 21:58:13 +0000
Received: by hex.dinwoodie.org (Postfix, from userid 1000)
	id 51333A5C958; Fri, 14 Feb 2025 21:57:43 +0000 (GMT)
From: Adam Dinwoodie <adam@dinwoodie.org>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] Makefile: correct default docs build target
Date: Fri, 14 Feb 2025 21:52:55 +0000
Message-ID: <20250214215717.2854453-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the "all" target definition near the top of Documentation/Makefile,
so that attempts to run make in the documentation directory actually
build the documentation.

This seems like the expected behaviour, and was the behaviour up until
a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06).  That commit added some config files as build targets, and
put the configuration in a sensible place, but unfortunately that
sensible place was above any other build target definitions, meaning the
default goal changed to being those configuration files only.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

Sending with my apologies to anyone who receives this twice; I made an
error with my sendmail configuration, meaning servers checking the DMARC
records would have rejected the previous patch.

 Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index aedfe99d1d..31f40b6f37 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,6 +3,8 @@ include ../shared.mak
 
 .PHONY: FORCE
 
+all: html man
+
 # Guard against environment variables
 MAN1_TXT =
 MAN5_TXT =
@@ -238,8 +240,6 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
-all: html man
-
 html: $(DOC_HTML)
 
 man: man1 man5 man7
-- 
2.47.0

