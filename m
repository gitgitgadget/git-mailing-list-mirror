Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E835D27E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994238; cv=none; b=YMtOoyux+dWL3kHh46CE/wnU6eJ85rlyriDA1dpd+l+D0BjkuyOfdpYQS0eXKfbx8YIfzaesjgujZIhPc+0H5/g2JeWRs1hcnUVoAkSRrSFecKMMTL8Dr0nEuV+yFN1PhPSBwvZnxTO8RecU95by0g53jVwIjVWDmkbZV1KzM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994238; c=relaxed/simple;
	bh=7KxuX6uDJyKkJkyeJgJZp/N9TuoQayPX9LViRCOetqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjBzQ32ZTeYdbbd8qFCrAoCWVU0ZCRqn4HWmjw+s2fhedQr7u6SSjQl92kZpeb3KuUB6evc1dTgRvS4zswe579H1taiA7Z/pxuvd/0mQaCoPqDCKgmxs4dIOM900hPe2n+c5nAQv/tdSnE1QwBZLIM34xtoscXVDghMNW7pUc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YASqzgbq; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YASqzgbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994223; x=1768599023; i=l.s.r@web.de;
	bh=Qm5Cr3Wxq6rBQ4FRkPh1ECkhT1h+CF/FkzAn2yY/zSw=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YASqzgbqeFDguiTlMAEyKYIXdkeP1DsquZ8F+FJU73Mm3YmrczlGYioDsCo2WNkr
	 +M5RuJmnc7LkrNZdX68biUqAeo0Lo7DPlVA5AOZgeYG631QL5qsNt2Dp53CfxVaLM
	 VT75L07B3YfzwUA+9RZfF7JuDfZhind3e8vxpHmNs3sZf6M/4CHwws4Q/3vLs/w/1
	 m8Yzv9XPyHswND0Rss7LKpA2Iz2SLjV6s481VQmOak7Q3okVYhhCzIzUptiTVMw9M
	 R9aPo/jgDgbySZCOGzkUXAcFQFGOA/X2Q9bf3/uInREuTS0l/giOc4xEV2UE3bh5z
	 TmuczYmzkotyN9pqXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MJWsc-1vOrZe3cFc-00URay for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 06/10] pack-bitmap-write: use repo_parse_tree()
Date: Fri,  9 Jan 2026 22:30:17 +0100
Message-ID: <20260109213021.2546-7-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UKSpdVv08IzXZ5rfwfZ/xmOhv8wHSLAMMx5rU3XQf9wpcxK2gOs
 Md8Getrtxv1zpDbzZZ0EZMeZ3Xz/KqE0OZ9GuX1cGg7/LxgtsFVo+AypLGwPwvBr8Yrj5u9
 934JH5GrF1eDaHjO2P3l0N1jNLeXHYdgUx5VA13FkCV0RYUrmt/LoRhrsMoIKWNiIk4nvKQ
 BREc2Y7/ZY2Q2ti7DWs3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IlesiIi7Ypg=;Fs27OXJnOgIVBwStoaeKzeRYQCl
 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
 7NUPtHcyoTBcpWvV0=

1a6768d1dd (pack-bitmap-write: stop depending on `the_repository`,
2025-03-10) replaced explicit uses of the_repository.  parse_tree() uses
it internally, though, so call repo_parse_tree() instead and hand it the
correct repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pack-bitmap-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 4404921521c..d38de772c6c 100644
=2D-- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -478,7 +478,7 @@ static int fill_bitmap_tree(struct bitmap_writer *writ=
er,
 		return 0;
 	bitmap_set(bitmap, pos);
=20
-	if (parse_tree(tree) < 0)
+	if (repo_parse_tree(writer->repo, tree) < 0)
 		die("unable to load tree object %s",
 		    oid_to_hex(&tree->object.oid));
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
=2D-=20
2.52.0

