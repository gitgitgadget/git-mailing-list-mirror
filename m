Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D31A9FB4
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994226; cv=none; b=CtbbjECClRXbUN8Gec4348QAULV+uX28qYniCilUrveVukdp1CxeMzjjO8likHk/vZGFpno4XWnGC8eeKh7IJsJGei3ifqAP4nPFMmoj9HKIn+ES0+fX5KXEru8qaZY+dfyaoBWkGt2Wd8m+ONAoDQmwosO58FAyo+FxxP23EeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994226; c=relaxed/simple;
	bh=c3wV6HN346g7eTkwRoI2sJ1oaZUoVxoSMWE03qfucec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsR6jMVgfslcZgEEcwTl3QZxBVk5v0Zf581XuTRzzL4m7ru9w+zWFipmbbZW5dFFz7c1jZJPq+Ez+Fw/C8oDkguQluvlMAdRJvFF2pLfcyY9YWd/BdrdLUc0Vd+ITiD9uTBERv7dQZUZAfXomYJh79We4q+1o/uKcdRT8bC8xb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=s2Wtuguh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="s2Wtuguh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994222; x=1768599022; i=l.s.r@web.de;
	bh=cuMV+PfZKFOJBGrhfFrnjQXtyb/l6TyLW0TZyDqzVQU=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s2WtuguhgaHi8ACpOYN9wYfeGGv4cs7WboVwG9hQCbSoJ9opSIZLgm52VXdjPB/c
	 zYXUoUlVONzKDzKBZDOSMQhT2a6Fy3gahM5ZUZqaht48MSdlgFQmu1cdSW+jnoEPE
	 UoX52JunauBAEnAK5lsasEi08F38+RiLf8mw6bUoAytpcS5RaF6v7MDJ/8VDTQcJV
	 QQHWsHahMM7UX66OltyeFoPX1CT5jZKGRSJmrDoc5xmRQYKiuzYtNkTKLgptG7nTm
	 DpyyQj5lqP2ul6dR9PwS9Fc7jZylZoQyshw/kxnspDMP6vgNU3lFDzBuH5MZqe9jq
	 WXMqqcyFY673x7dBug==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M9IOj-1vk55l2Lv5-00DirH for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 04/10] bloom: use repo_parse_tree()
Date: Fri,  9 Jan 2026 22:30:15 +0100
Message-ID: <20260109213021.2546-5-l.s.r@web.de>
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
X-Provags-ID: V03:K1:26+l+RAlk9/Ip+vT/+MKQUvLqDznVHeMFDOURIfA5FQKUfS8dJj
 PJa3A6CMJDZZfTZbtCEOtnNoFZSl5tUREVRTzEOCwtcW4Xr1L6ZIfsqNxARl6OoiAe16S5Q
 NHa/ZhKK/+/H6KQ2vdbZlekm7OjjmUsQslXfZdkCD3pvhVhk7+1Q0w2FGkJF/US3AKoqXDS
 6Ljfv+AEIMnom7w7DhOUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QpmKyBfeROs=;VGHuYJhcpKMsU5RZqANsHvBbXCW
 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
 cUAmg9HE/kXOyemy1ehf+15AP6PRKtz8jyHXHa

Use the passed in repository instead of the implicit the_repository when
parsing the tree.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bloom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bloom.c b/bloom.c
index 2d7b951e5bf..77a6fddf720 100644
=2D-- a/bloom.c
+++ b/bloom.c
@@ -354,7 +354,7 @@ static void init_truncated_large_filter(struct bloom_f=
ilter *filter,
=20
 static int has_entries_with_high_bit(struct repository *r, struct tree *t=
)
 {
-	if (parse_tree(t))
+	if (repo_parse_tree(r, t))
 		return 1;
=20
 	if (!(t->object.flags & VISITED)) {
=2D-=20
2.52.0

