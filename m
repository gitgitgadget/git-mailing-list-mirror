Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63C1E8836
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766945462; cv=none; b=gPf0Lp4/d7rZ/4LP+pLdSToZrXwqVpiy9FSykmmr4B+JxBUIDtQDQ7ZpRa/rlYPKKOxHP+E1UawqXfLGK6/Pz8q085bKdyc3AQ76F3Lf8V6guXsA6Hd0d8YfXAplmVfr4icvYK8jjRwHA0fKFTkotT3dp1bfY0IKZ4rWB9QY90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766945462; c=relaxed/simple;
	bh=X4hlF7xYzR03M1UAk4NF2Nj6U7fKgm2fKyjbJyNQJZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpYUagECwZUASmThtYGZmwbmxvRPeZfkV8YJGiAKIO2a8u+fdgHhcGIb5A3nJiOu3OqwqEkATu8srQgPjVS5bEVFlLSdbGaXHm9mzNM/z4jZsrztUVCgpZgePcFAJ+7mBGCZIAx+HRYAIbSUypy7ZF8EFkkZI7qxlIQjSeG2K0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=dYZeydh7; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="dYZeydh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766945451; x=1767550251; i=l.s.r@web.de;
	bh=ow12y2m7hDkRs9Nh4LeTAEBUB1UX6/zwPQ5mHt8/1HU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dYZeydh7sMVuVnCpuz9YOOpyaGotN3jzSwEG+ujkh9DC3FVZ6NHcRtmvSrN/zmVd
	 JpuRDrlsClw7ryJA9DI4szvAJN+krS44rLcffnGs0T9VnWS2cio9QeczcuR6Vv7iV
	 xEB2BIbPFpklyllE97mHADAuM3SWEVZv+rRu0ypHLoDJ/0bKjULNG8wKQBlM7tszG
	 FopIhxHl67+hfFhCi/3OIzx5YE0H2274cKbmRVAjZ+yBN+MAaOkg6VBs/WZMdv5TE
	 zrXAzMB8ORIF1+15qoj1bt0Gk7Qwu0iIkf3jVE120BF3eBjeM2oJxU3gKrFcDP8Y7
	 aIl+lCWm+o+BBEu/Mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.18.156]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MiuOW-1w5wb931NM-00dud7 for <git@vger.kernel.org>; Sun, 28 Dec 2025 19:10:51
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 1/4] tag: use algo of repo parameter in parse_tag_buffer()
Date: Sun, 28 Dec 2025 19:10:48 +0100
Message-ID: <20251228181051.68724-2-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228181051.68724-1-l.s.r@web.de>
References: <20251228181051.68724-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HW7YZCCM9iYtwtJhRIXjUjPdDeyf9L+7TdlLvB6PDsOYOPjazdo
 c9MlK0k4JcN3DvfGXfcjAHMGCJxPAnEwOo+IZCzRHwYVZmo/1MdvWsBv4Yzv/N/fT9VD3xl
 qdjTPP4l6Q2qaeu8VL8GlJVt90SA97Z0Y7bMP6rRqzWIiIJPcGFFhidMOPo9ch7ocaBuEbI
 A7rdOvLeUR2Ss/EHW7m1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7wx9rucmils=;pbqpeutH5wkY4xjQ0Y45MQEXYBI
 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
 tHTj1F4Ro9lIGs45P8/6Q7q+ctzBfte4bCY3ns

Stop using "the_hash_algo" explicitly and implictly via parse_oid_hex()
and instead use the "hash_algo" member of the passed in repository,
which is more correct.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tag.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index f5c232d2f1..dec5ea8eb0 100644
=2D-- a/tag.c
+++ b/tag.c
@@ -148,9 +148,11 @@ int parse_tag_buffer(struct repository *r, struct tag=
 *item, const void *data, u
 		FREE_AND_NULL(item->tag);
 	}
=20
-	if (size < the_hash_algo->hexsz + 24)
+	if (size < r->hash_algo->hexsz + 24)
 		return -1;
-	if (memcmp("object ", bufptr, 7) || parse_oid_hex(bufptr + 7, &oid, &buf=
ptr) || *bufptr++ !=3D '\n')
+	if (memcmp("object ", bufptr, 7) ||
+	    parse_oid_hex_algop(bufptr + 7, &oid, &bufptr, r->hash_algo) ||
+	    *bufptr++ !=3D '\n')
 		return -1;
=20
 	if (!starts_with(bufptr, "type "))
=2D-=20
2.52.0

