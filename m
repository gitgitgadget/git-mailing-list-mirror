Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2B16E861
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962118; cv=none; b=tlaT1mTCQnhaUAj+FwZRnYkajmlIJ3dIG/cYVgkmUVJCGtulrgVR1Zjb+50K/U8bCUvu1RjdtrUcRz1wWZjTHnbKDx+uiujg0dinsnuGCHSucXOF7JrhnU1jkArBzKSshPcxu+QRq8X604guAQaqwEftUZZch58G9dowm4NwwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962118; c=relaxed/simple;
	bh=5ZHjYM1ZHsp2bnDct75YeHibmfV+NHI8xWz8mZwrQ7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2GfhDFWLo3DrlyoDzVzWzhUQtlw3iyt8bjlON77w02Sas8my0OTp7MlLITGcgc46R9rqjrh0vvAT9M1IFLjRxF3ZPyQwssymbm6Ew9CfpF5JBD6X9PsRjixNO+9GpcmJAncYnj2uzZS22yMg3IcNVy1uBWhKhheTzkEcsvxWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hx+ODuxJ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hx+ODuxJ"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6F42BA073F
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=U8xGVJJsCfrmMSaVSObf7bM6Z8N6x79Luf32EXbfvu0=; b=
	hx+ODuxJ/D++FSsI1guK2ETpjAkA9+PmO/YKDJhx9A/lReCG2jx1PxKJ8Unnfvex
	Kp/Iu6NVN5eAQ+XCXNv4ja4Na75ZaI4pzP5sujgFMq2Yfb16OM5eTVfIC/0lWuOh
	Fh40AYPBasE2Yj0EWNnhqq9nqTrDj8RF8laRtfPvY5ya/9xXuU29tz137eB58nFS
	jZZMkkNc/yaUorlzJSWIPIv4YL2KtMNc5z9+EPx1SjK4fUGftiZpX5wij3mo8UeY
	3L/tf6KZTpIW1xTm+BALUE06LcK7q8NpS4Gmq/LcYP6vujuS+RrBOrbwdb9UjJiu
	+2IMXn+ZJPHghNxBjQogQ3wYxK4bZFmUP+owilEs452+Uxo+QpqUdukDS3rISmhQ
	evdpFpcwb1QDgfi2w5eWEwlFEBTuoob57eiopO7lt+mEzrGIASAe+uoMg4+JgF0p
	pD33+Lp3VKvEG32GkwhueQ5k99WGG916KzrmW+BC9OUAxq7SwX33Un5G7LEOKCsf
	FuBOn70wgIOSlFTbCBJqeORGqBJ7WqCN6+ZjcdCE5kqenS4jcCvnUvwEo6Iymfma
	OkC9MlKIHF6Fc8Auwa0Sb4QEJ86POl2FV/AJ6lRo+RY+R4xK2gcszBdma9T98Z0F
	pWJObeFzQbJjTmghSEH1vfvzq8z4wJwkM/Q+a46kAjw=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <git@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH resend] git-send-email: Use sanitized address when reading mbox body
Date: Fri, 21 Jun 2024 11:27:22 +0200
Message-ID: <20240621092721.2980939-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.45.2.437.gf7de8c0566
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1718962059;VERSION=7972;MC=37261361;ID=1067371;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B546C7567

Commas and other punctuation marks in 'Cc: ', 'Signed-off-by: '
etc. lines mess with git-send-email. In parsing the mbox headers,
this is handled by calling `sanitize_address()`. This function
is called when parsing the message body as well, but was only
used for comparing it to $author. Now we add it to @cc too.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f0be4b4560..72044e5ef3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1847,9 +1847,9 @@ sub pre_process_file {
 					$what, $_) unless $quiet;
 				next;
 			}
-			push @cc, $c;
+			push @cc, $sc;
 			printf(__("(body) Adding cc: %s from line '%s'\n"),
-				$c, $_) unless $quiet;
+				$sc, $_) unless $quiet;
 		}
 	}
 	close $fh;
-- 
2.34.1


