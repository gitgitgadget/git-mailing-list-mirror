Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBF1D7E50
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651986; cv=none; b=X0ttkVN9OkRtFVkDmc7pCJ0Lrfgqp+ZaVXXXZUsLr7RDe7Xmo0LsemHe5h4NG/deGEI9szjzdM6BM7ZJ9AxGTyJXWFowj7uYdwxd0NJzGUcK4acBcRT8h/AhFpQkqTbCqJZ2wX7as5piSdvimhXhqExfsTjmB2dcY4zofsQ8lF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651986; c=relaxed/simple;
	bh=dtoSOlGFMHm0mz7xjUdjLIAgL4WkMFG9XSludvUfv8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+AkCCwLV07S8/BNvYOZzhcwH+QcUozPT2cP8kOkVlCj3JTNIlm+xTi/B0eRmcMzGGZwSM9h6YZJkWqt9I1zKbOtx36CnR6E5MLuehI0J4qv9jROwbqhQdnYg8fOBoCtgk+IszacKl4LXc6kF8Pah/bKzAGrmko2RQhCFV4K6iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cK42F/K+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cK42F/K+"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e04196b7603so2670999276.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651983; x=1726256783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7hfH8hHEPqjQiI0mja4fwzPLpEdUPZT7sveUu4qSCU=;
        b=cK42F/K+uo1jI7rwde+vHCgwZLvioNcIaWg/1LE1Ro62Uz398n9/evb9zu5NFQYrwk
         XPXsi46oECZM66FKCu0uH4BSx+XrU/K8P1AbJp1FIlP0o+7oaVzZ4fqPiU0a9gM8OFd0
         NEqc60mb9fbHDHHxWQVsCVKoIqG+mLGE5EjtTQk0E6BWOqX8NJabah9sDY0TfWnIDv+U
         oCVJkAJdhas0PCij2BZ/iXt6gDrKbHTyEZmsPD1ImkHZ+IZtalyaOupdJ5DrsA+XN7vd
         qwrQMccCl1mtZIDoB7sQXYmZHD4Ka5Zc46cUx/9FrsRGPwSRbzJajg5oMv9v/iscIhv1
         lnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651983; x=1726256783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7hfH8hHEPqjQiI0mja4fwzPLpEdUPZT7sveUu4qSCU=;
        b=vM0FnNIzJBUvkjpMqsMK046Vq27Mxzy+H+ro7n1Y5a/a99cp0cG/K/Nd36eqNCoJkV
         BZ2NSJlDYPmBzE/MFD6MIH+ZMWpoyaOcJiFpdSggG1GgxH4SNdP2Onu5xWzK06z7cmFZ
         QUPI4wUqIwFHhQJJAKQQaQnrMLUAxazLfsuThAcGTBV6Sep/ID9xIyLoND7UTg51f+gi
         qZsX72qz08FNcw19YCJnWqFHq+UZCAOC0RxUcA6QLV1sb4tVb2GnweYce4D+3thMyIxo
         gus+yDzgUHoKdGYZJQVNcSUQ4sTWFL0mETYVqf5/J/xz9a84qY3bbgK++EhxmEapjPPH
         iSkA==
X-Gm-Message-State: AOJu0YxNMM+RWFb5q7Czt3KnR9t9q2b//NK80oIOK76uUCgJ7QUm51iI
	YTSDgOz83Ccwf6vMtjbVIJXDCTho7V29ovT/Q9zeIhY/dcaftrAKc0u2GkMlqGpJxjpVvbQwgJ1
	eoiU=
X-Google-Smtp-Source: AGHT+IH88zjvLc8omYy5jFujuz3luUhL7cghp1lczYuyiM6jUmn8uEn71AfSpRQ6vjxMwHvCwOZ8IA==
X-Received: by 2002:a05:6902:cc1:b0:e13:83fd:cf19 with SMTP id 3f1490d57ef6-e1d34a1e816mr4854294276.49.1725651983497;
        Fri, 06 Sep 2024 12:46:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1d43f741d9sm107185276.14.2024.09.06.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:23 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/9] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <22863d9f6dff5fec033f1de0faa93b0ec09d8e24.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

Our in-tree SHA-1 wrappers all define platform_SHA_CTX and related
macros to point at the opaque "context" type, init, update, and similar
functions for each specific implementation.

In hash.h, we use these platform_ variables to set up the function
pointers for, e.g., the_hash_algo->init_fn(), etc.

But while these header files have a header-specific macro that prevents
them declaring their structs / functions multiple times, they
unconditionally define the platform variables, making it impossible to
load multiple SHA-1 implementations at once.

As a prerequisite for loading a separate SHA-1 implementation for
non-cryptographic uses, only define the platform_ variables if they have
not already been defined.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 block-sha1/sha1.h | 2 ++
 sha1/openssl.h    | 2 ++
 sha1dc_git.h      | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index 9fb0441b988..47bb9166368 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -16,7 +16,9 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx);
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, size_t len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX	blk_SHA_CTX
 #define platform_SHA1_Init	blk_SHA1_Init
 #define platform_SHA1_Update	blk_SHA1_Update
 #define platform_SHA1_Final	blk_SHA1_Final
+#endif
diff --git a/sha1/openssl.h b/sha1/openssl.h
index 006c1f4ba54..1038af47daf 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -40,10 +40,12 @@ static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
 	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
 }
 
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX openssl_SHA1_CTX
 #define platform_SHA1_Init openssl_SHA1_Init
 #define platform_SHA1_Clone openssl_SHA1_Clone
 #define platform_SHA1_Update openssl_SHA1_Update
 #define platform_SHA1_Final openssl_SHA1_Final
+#endif
 
 #endif /* SHA1_OPENSSL_H */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 60e3ce84395..f6f880cabea 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -18,7 +18,10 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
 #define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
+
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
 #define platform_SHA1_Final git_SHA1DCFinal
+#endif
-- 
2.46.0.430.gca674632b70

