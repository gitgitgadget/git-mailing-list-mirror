Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2D67208
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AosW+pcm"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58e256505f7so55345eaf.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592640; x=1703197440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=295UZYPZbV1wJAB8tzl5D02ZNn0sA5tomkIqFAKeBtw=;
        b=AosW+pcmwBWo61EGodvDBHlIO/9wuUxPt7epPmWvkwKnZw7IbrWUVFrtZLFhxxaIcf
         UWO9I3B/gY311XpsfA/8JYNKzPADMniPDhWOLbDnkzPJ1UBS2f1FLw/Je6KEZWXb0HiX
         M9a/RoTG8ChGoYCNUe4qpnLp+1vKgMGEBR0nAYbY84ivBKzWjI161J8WkJH+A4zSB6/N
         LduaoKABKRcYiafCw6JdMQqXyAIeA/J4+2ToZ/RlvkKXgyZSHgRPkzjaOxBzI81UoP+Y
         j6VzRp0xqlYMo9hvlqBkeS/9vbSFuL+ItOF1TAGfR5cR+91YgOMZtXSON2snAn/ISfYR
         SCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592640; x=1703197440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=295UZYPZbV1wJAB8tzl5D02ZNn0sA5tomkIqFAKeBtw=;
        b=EwZoe3Q81y2LzwX7LKft3JWOWskclt+H+X3jrplsmLU1qrJFjlwgLpWEM9KZzZdFYU
         rSRzdtTWJDgggml0YtDBuBNuZ5seX5ZfDSp8N677wnVPHgKGcNRhZ65i1V4c6s0Jshen
         eQdO1oEwrm3DxadJXOqZ15vW8DTPhBmmNRvS4yjxsm//T7g7a4a7RTNnPZ25F+kxa6sQ
         oOjXrb2ow6TcZbwgCyZHJbfuoXPzJEOx+bejjYAvAcRgh5pzlF25hrikkI1GJWkxgaoj
         ZJTxozdrjOAC6Bj5/hdVL5koXwkoQzAbM05rAIguAt9+8fmcc9fWHuoyNdzP75QRsM9W
         CpMw==
X-Gm-Message-State: AOJu0YyK8Wh92zv9ZSVjHVizU4tGLIdryzQRBIPQQfDg0mNb3eVbyfn5
	TC1kViJ/KmJTpswV+DLwSQ/xqRuWXPSHXeNG3Y94Zw==
X-Google-Smtp-Source: AGHT+IFdL7sGkj9ZtjanbR7a31e2f7sxAkUjOIy/Eotr201Xim6RDeoHh+hRCgfX8mjCPlP951SFdw==
X-Received: by 2002:a4a:1d86:0:b0:58e:1c47:879b with SMTP id 128-20020a4a1d86000000b0058e1c47879bmr7574223oog.16.1702592640295;
        Thu, 14 Dec 2023 14:24:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l26-20020a4a855a000000b0058d1f2e1c8csm3692368ooh.40.2023.12.14.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:00 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:59 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/26] ewah: implement `bitmap_is_empty()`
Message-ID: <595b3b698615cd341cef49623523c0d3ea1b6802.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

In a future commit, we will want to check whether or not a bitmap has
any bits set in any of its words. The best way to do this (prior to the
existence of this patch) is to call `bitmap_popcount()` and check
whether the result is non-zero.

But this is semi-wasteful, since we do not need to know the exact number
of bits set, only whether or not there is at least one of them.

Implement a new helper function to check just that.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 9 +++++++++
 ewah/ewok.h   | 1 +
 2 files changed, 10 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 7b525b1ecd..ac7e0af622 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -169,6 +169,15 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }
 
+int bitmap_is_empty(struct bitmap *self)
+{
+	size_t i;
+	for (i = 0; i < self->word_alloc; i++)
+		if (self->words[i])
+			return 0;
+	return 1;
+}
+
 int bitmap_equals(struct bitmap *self, struct bitmap *other)
 {
 	struct bitmap *big, *small;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 7eb8b9b630..c11d76c6f3 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -189,5 +189,6 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
 void bitmap_or(struct bitmap *self, const struct bitmap *other);
 
 size_t bitmap_popcount(struct bitmap *self);
+int bitmap_is_empty(struct bitmap *self);
 
 #endif
-- 
2.43.0.102.ga31d690331.dirty

