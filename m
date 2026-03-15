Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664287080D
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 03:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773546555; cv=none; b=CxsIG86Do/l7IqNAeaoG2gIcQZutarC0XgLdwKz0mtqQqsgmWWBiVcpyrLPFO1PstXMx4tK6VTNPb6fwc1OdUWOWGXGVo2Smnh8TWCc7ynDj2PqhhPl9LRXuLqK2nI22rD2rJ3kLbtBGMJoeDwsKOQf4s/Xd7UMnzoMjMKKFU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773546555; c=relaxed/simple;
	bh=4MeiCKp2+QOV9AbC1iboL+PN7l950reI+1lu/fUe5YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C87QM1tTPab8By/snYFYGmvv1tI+5eUbpTu7+XvN1H/nfVo2QKp2sPyv+F04F9V7CeVDI31gCckJpdKxIPKQ3eZNEs72+hvNhLO5mx9Y3ezeSQAdiyJUYPfa0v5YgEQGZtHWMJvX9z+l5pkZDiv8LnKqXATZ0XHm99OZ/YmEvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=A2beaBlY; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="A2beaBlY"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773546551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Du8E9JnQpeTMs09sbKOqgFOuPHXO1nvZmDxi0fxdd2s=;
	b=A2beaBlY3Z5Gso2EzscYEbt4QRjAIa9/COdq4C2UA7CYqsQ4MuyBxNWhVQLobL6FTjYuCy
	tOtH4pLRWcyhF3pXtPuN3byNZJVgYwOoGlMQxEJE0q7+4OzIK/N9wR+9pesJxyrIh4fpcO
	mkYOKskO9neWOSx/GwTkLVzFaLvOKwFhMoMIHYVUhBIVzn2JAQ2p8y7UwqB0ca2uruwtM6
	EQmkuiaRBQXRmmtL7/PjGkbM4lpgDMy1axz82EFsAi7+DQLGhV12/lrNEC7ueOoFNoEhct
	nkSqZuD4aFEafQ1jvK/bKGGnDgCUVNE5O0qW8JEO6f/AV6J5BPfrd1j/kJyTBw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH] t0008: fix "large exclude file ignored in tree"
Date: Sun, 15 Mar 2026 04:48:50 +0100
Message-ID: <20260315034851.2261530-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=mroik@delayed.space; h=from:subject; bh=4MeiCKp2+QOV9AbC1iboL+PN7l950reI+1lu/fUe5YA=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptiwEGxNtJjaS0QikDYaAetbnaoWmGXZIbqAyq znNfD7FEACJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabYsBAAKCRBIeX6hnBm+ 0dLBD/973a+2+tr+u/uhyxx9mAcTY8MSEYVstKuw3Qr48/rRk+khI2U66o0r5btHSzNWhXlmK7Y 3VSqhSMKTUfhfW7qPiHRjNa4cxKTGcxLfT/r2l0NDj9AX+HblPkrdVRw9rVFyE96A1WduD+GeCr fL23Wm1M0toEjuap7LJ82MZdHzgleubvyeUzuZjCVcH8m5SP22mYanmlDHlk4XTkk9daWag0d/u 7MxlKzE3J94qEjlaBobN4/og6ioQYSCQWyQTXK8lhZLuPOjCGj66bsqrNxT5ksrcGMJV2XkBL0h HlzoEw+pc4fXuDq0pjb71vcurC2gD4UDCqqDMf/F/wKx5vvByTvCdM4hBhiPn8tU4jGLqtsw+mS HhutlrAvpkFkR2foNt1WmXy38J6hI8nM0l0TjJ1+BgGNoJCMO7yrxBvCVZqLSOnW5CicFB0PGGE 9Xk2IIZFunkWA1Bw6pxsVuGXArRxyGGDGTmqNhWNpDau1rw0Le3pnQ6daDYUI4xyaXjujkqMcP1 m/BRhiX8p6xUlIsS1abwzmnoIBzLIuCV1t0OofzBNsSFey+jSd+GbwQ8I7WExBVHjfhqvFFqH73 pINeXzKuUjixW54cBvGKMY8Jws+0Mx9g/yeOnEq49UqCCnUAr5eGQoP+tnCSSLnWX1uugLfGzRq 5dm9OtR2Of8m/Rw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Add cleanup to previous test for file that is unrequired to test the
size of the ignored exclude file.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 t/t0008-ignores.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index db8bde280e..18e048ee8c 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -946,7 +946,7 @@ test_expect_success SYMLINKS 'symlinks respected in info/exclude' '
 '
 
 test_expect_success SYMLINKS 'symlinks not respected in-tree' '
-	test_when_finished "rm .gitignore" &&
+	test_when_finished "rm -rf subdir .gitignore" &&
 	ln -s ignore .gitignore &&
 	mkdir subdir &&
 	ln -s ignore subdir/.gitignore &&
-- 
2.53.0.959.g497ff81fa9

