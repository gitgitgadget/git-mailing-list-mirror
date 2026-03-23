Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D73C13FE
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285080; cv=none; b=Fct+k0mKfgkRAE5ESKBuPkUt2y6gamL+f4yrFFwmYGVLv0IflMww+I0LJte07br2VrXNahXEi8/sUCVbwObbSoc1vnNdUJnvq1Kac/+8cri1tRlE5b4TmXp1qGtAZ31pwDRI0PSh6re6VUJqeOhQRKYIv98nY9+3845d8UDd2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285080; c=relaxed/simple;
	bh=iq2rrxG9LhH/mvdsnW8V8PQ2bYlt2Jmlhokp1RQIH3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4JobhlVIsWV01RuPeT5/klBdEJeAbRn7iLMtphlaDVV1uxw2OsQJSJlVb72hwg4DpvJub1LEfRdsmFwm/ItU3zcQ4r4RPAOFFbN8vuCHcVpV7e4qRtFcwOJRLIiyklw9VsoDw0x8MWYcaQWAvWoyeQoUptUdDzvgTTlLh+CQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=FZWOIlC/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="FZWOIlC/"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75ZykMlGmTlBSX5YaizavngyDVqlHSgYF6PxiTEujFc=;
	b=FZWOIlC/lNMaWZNsO2OgeTON+eaVpRws1MnuU29ILA5pt5MTU9ujoE3oQkxDCha12nO4NQ
	ClLo6u7L3XD48zG54liWq6aaSJLde/aIkVbnjGA3LWwfF0MYKHuXzAc55Ejqnat6Qu3HyV
	Wrsqd/XHdqwB8wbaZ9jybaXPiHrXJF9paq5uaRECHTHDVV2a4RyMP6+VIXe6gfgUOl0T9+
	I343yttSu5AtLarqMU58nEGasRxHVi3qyXxWCjq9QVUWFbcopfHzW7G+Ekka7awWw78Bpc
	XtxLaVo61BSrQsdp8P9HdVaB4cSPrx76K8mhhNlLkzE0LDH4/DAmvgKyJlBrYw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 4/8] docs/pretty-formats: add %(count) and %(total)
Date: Mon, 23 Mar 2026 17:57:31 +0100
Message-ID: <ce7d1bd1fefc63bf625eb88a1b9d73d77af4c4ae.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=mroik@delayed.space; h=from:subject:message-id; bh=iq2rrxG9LhH/mvdsnW8V8PQ2bYlt2Jmlhokp1RQIH3c=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXDze0AnOcw9aDbsV4h5z6kdW5kUhP+tO9kOf hF2VIsF02+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw8wAKCRBIeX6hnBm+ 0XcJEACQEdm/Pl3zGReC7aQU2p3VeottWbs2uSmPZR6tWtEuloVRDA8chNMwMvW6EpSa05iV3YU MfPM3HmSN0MQmrlr+ntTfNY5EQ3Tu1luAiW8NTZGg7O0ghjM7inZuSk+2+HIHMa0T9Nb0NtpIXv TXVmTD9n3dFVnpCIcpwgakwpO1UWl7HAtJKKD74Lh68vxRA0ZfDHv02B23sNkP1EPFSQJX7Y8G3 /iR7ZfbZLTiLruN/FBSmUsP6JzKgGsW7QyDhoAMWTMec0ac6YYJVfMWYHeJohevU8LDXgmtdoPA S1jf9QcCGsqZs4E6SKnE8cJI8Ng8BR2TO1Mn0n9DdabBYZX/2sguATS2vNFcydBeu/5YzfWVErF wk3MGDYHKNuoTY/Uql3hl3ltktzSraBSQrBJQ2aOdHu88xRisvYzKFSCdtqbLYV/z+eQ6driR5g r+UoakKtP1DawUWfHcd/jS1s4U1wknQaYamaTAcKBiGAnM8jgV/epDxUhl2o5z1oeeQcWlLYizD 93XSHQwBtDKXzIA3JVFdM1q89G2bVyZaxRr4tc2y2GCoZe4RkLkP4iRsAc8hpzNXBqBsuFS53ED JtB5vEu2tyo/02Z6nM0pJxuGTOBSIG/MgpQf7KGLm+moSO4gjDi9bYC0WlOT98sTgkHK4EwcOSD WW+2r2Mjn
 g2438g==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

When --commit-list-format was introduced to format-patch, two new
placeholders were added to the PRETTY FORMATS code without being
documented. Do so now.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/pretty-formats.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 5405e57a60..2ae0eb11a9 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -253,6 +253,10 @@ The placeholders are:
 	linkgit:git-rev-list[1])
 +%d+:: ref names, like the --decorate option of linkgit:git-log[1]
 +%D+:: ref names without the " (", ")" wrapping.
++%(count)+:: the number of a patch within a patch series. Used only in
+	`--commit-list-format` in `format-patch`
++%(total)+:: the total number of patches in a patch series. Used only in
+	`--commit-list-format` in `format-patch`
 ++%(decorate++`[:<option>,...]`++)++::
 ref names with custom decorations. The `decorate` string may be followed by a
 colon and zero or more comma-separated options. Option values may contain
-- 
2.53.0.1118.gaef5881109

