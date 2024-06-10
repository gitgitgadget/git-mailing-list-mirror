Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F17E767
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022089; cv=none; b=pf1FpnvNkdfpmSPfXClGtHhHiRs8e7uD1MuJbhWD9ub8po7yvYKfDS532wroGbq1VlAHxEeoecQaE4E5bg/ALSTzic4h7aFLWMpVPltRW8KCwal68P633Am12s++eoHIIRIrrbbDwCIi9S9la/276PxVIxy+z5EYVYP228sO4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022089; c=relaxed/simple;
	bh=5ZHjYM1ZHsp2bnDct75YeHibmfV+NHI8xWz8mZwrQ7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z5JtUnVoUP/C191IkmhPdYQY799lCrom2+dXxFCKOD3BJXu0C+lMzWsds1pVtZuTGNNkJWJ7k4xHbdDvNZ6sFyJlOZVhUntA9C2+WY9D5UjlM+8bfQ7KsPK4USjJau00dmWOpU6na1aEQZqW3zkf30c/m2UOlliGtgI1jDfSDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ttofgVHh; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ttofgVHh"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 021F8A079B
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 14:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=U8xGVJJsCfrmMSaVSObf7bM6Z8N6x79Luf32EXbfvu0=; b=
	ttofgVHhv5dlOp2ml+NH0r1SsynTwHzKhETL/MYjkWhfm49tZDwOmK/VRNSBbXNl
	lIOunRl9an1TfBx2mFjNYj9+PVFZiC6KKLZZ1h6VS2scNEIlYIifYIB8Yq2nikXe
	5YtoHuoNyv+OaKaOOjI41cJnWq/JWm5JQmAau/Eg2rENIAyLB0Q+Z+rxe34Bl+wU
	5IYU3vRvnXpHiYpIgqdh5EMAaHlT5OCGnhrumfVtB/gltZwTK9Q8zGWfCwIQhGd3
	/Zdv05k+u9etM7xeY/CDtDBNJjyUz5G+g6BxA+Yg2fSzgxj6PNxW6OhAXIYaGrNG
	nQxXsi3cCz+cCUw5d0tfhHGIt5u/LndJVNloIvyy0537YbLM1JcE2MW+h1an0XX2
	eodVpefz7Y3MW5P2Jjx7Ryeiks6toCUO/LzdQZH04gHwN8RBIPEBs4RkT21ZA/Ev
	Ac4zOPux9341W6q0ZTiDYZm7l0EG4y+dkrd27P1ZtBU04BRa3Vq0rILJ+iIDoW4K
	m/xJ//VFiywvCnqCVj7aSWsfEIqKN7PX9ujQglbc/Blm0OPctXKrV8PYB5hTmpjk
	0dVG7NEMiXMGjy5DHwGkwvUI6qKRc2AcVTC0prwT3HtOS5E+vdbQ17wpyn4oNXgL
	b/VP8It3nFCFk16zdGYMmwO4c6YIWAe73Xe35z9e/hQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <git@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH] git-send-email: Use sanitized address when reading mbox body
Date: Mon, 10 Jun 2024 14:20:36 +0200
Message-ID: <20240610122034.656108-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.45.2.437.gf7de8c0566
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1718022075;VERSION=7972;MC=2819180457;ID=498332;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B54627D61

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


