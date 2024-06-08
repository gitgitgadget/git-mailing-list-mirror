Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570631CAB9
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871887; cv=none; b=eDeLut06v3SpBs69VCtapeEkWEExeWjaEveJBQEn5DsbSS0fgkgQJ0Nny9SRpPcOGW+LeqlkgGjOK1p8AGfU2BVWiB6mcKCNjMDZ46nO64e+XvWXR8tzBGLAWbIY2E4C/buA07ek82J0HLWB2zkAaeCYBNdHQLeYkZgcuEWBK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871887; c=relaxed/simple;
	bh=jf6tOsW6mpj1Rz9S1Y+UVFK/4j3K7rBSX8Tk2mTq/Cw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLq4aZeco3SVBKSywNV3ePHaIyIwHfFhAtniO+x1NCBJsuMDEvaqHtpC7A0zqCRKS/Edg1j6HsgvxuQfZ2C+h81ieyDMOgzPOAOOxnW8PkhvJgkfa3Cf7sNU3hjgbEOdD7C6rBa1eMWTYR+Jk4Zme3niyAMw1HL5mWl+wdGV/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x+C5kyp9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x+C5kyp9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AC28209A9;
	Sat,  8 Jun 2024 14:37:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=jf6tOsW6mpj1Rz9S1Y+UVFK/4
	j3K7rBSX8Tk2mTq/Cw=; b=x+C5kyp9O2ywt7YMk0OG9iVtTi2o0NOMBKNGZ4OC7
	l7HrBBuLZl1fPnrGbuKU//eyiKoKbmhIMwXIrvU4tLeFmyFGNPGSRuWXIXVt+2QY
	HNgrtFHp+1XLJHdGqbPQBp0Q4FBS1Yk514kbD5ynSWtHWhm5ztKah3R7ZgNa4QNc
	+8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4334F209A8;
	Sat,  8 Jun 2024 14:37:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7996209A7;
	Sat,  8 Jun 2024 14:37:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] __attribute__: add a few missing format attributes
Date: Sat,  8 Jun 2024 11:37:47 -0700
Message-ID: <20240608183747.2084294-5-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-445-g1b76f06508
In-Reply-To: <20240608183747.2084294-1-gitster@pobox.com>
References: <20240608183747.2084294-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3A805E46-25C6-11EF-8C85-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

A public function mem_pool_strfmt() takes printf like parameters,
but is not given an attribute as such.  Also a few file-scope static
functions were missing their format attribute.

Add them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mem-pool.h  | 1 +
 scalar.c    | 1 +
 wt-status.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/mem-pool.h b/mem-pool.h
index d1c66413ec..321d86a63c 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -50,6 +50,7 @@ char *mem_pool_strndup(struct mem_pool *pool, const cha=
r *str, size_t len);
 /*
  * Allocate memory from the memory pool and format a string into it.
  */
+__attribute__((format (printf, 2, 3)))
 char *mem_pool_strfmt(struct mem_pool *pool, const char *fmt, ...);
=20
 /*
diff --git a/scalar.c b/scalar.c
index 62dd77aaec..a8318078c9 100644
--- a/scalar.c
+++ b/scalar.c
@@ -289,6 +289,7 @@ static int unregister_dir(void)
 }
=20
 /* printf-style interface, expects `<key>=3D<value>` argument */
+__attribute__((format (printf, 1, 2)))
 static int set_config(const char *fmt, ...)
 {
 	struct strbuf buf =3D STRBUF_INIT;
diff --git a/wt-status.c b/wt-status.c
index ff4be071ca..c4dac01999 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -126,6 +126,7 @@ void status_printf(struct wt_status *s, const char *c=
olor,
 	va_end(ap);
 }
=20
+__attribute__((format (printf, 3, 4)))
 static void status_printf_more(struct wt_status *s, const char *color,
 			       const char *fmt, ...)
 {
--=20
2.45.2-445-g1b76f06508

