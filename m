Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5D67214
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Z45AaP0z"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d9ac148ca3so72762a34.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592664; x=1703197464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9z4Ks2WyJoTkeVpY3qX4VmXVrOs2KVewpxKx1HUbyG0=;
        b=Z45AaP0z7coqYs9IgJ+gSNId6pfpXuh4AbcjEuiI9RUT2fBAnuhpW5JVJ2VdWrr+o5
         /1/iqYGKiljw9GgnCAr9VCCFoJ2HPMb2ozgx61jkjP6aK3aczQ2J/bc5CXofPfvmb5Xq
         WBECK03oXLsDuN5RYiAtDyi/a8JWt2BaJ6ocf8tdnxjb3S+EF/u3QvoSlHQRJrfO7iIB
         pDcr4LOu/5etwOIXvAvtf17nkCrullKLwsTNOIqyOXJaRvtAVOlJtM22eoOwMPlm/ppi
         aLmaMMPYWqevz+TrgjJ+5d6DCI2PMbv2ff4WKw+Ko5nG3MX5GLIv9i+sH/KG4thwzBMa
         20uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592664; x=1703197464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z4Ks2WyJoTkeVpY3qX4VmXVrOs2KVewpxKx1HUbyG0=;
        b=JxVGmGtYuYn1Zx6wBcDjVtcj7DHP4ZnF/3hF7vbm982gQ0Ct7EAk+RYu2filBCEvbo
         mlZ/Ej2gjkPy0dsWRWjIEyaLfLT71oT6Vjdfbi/pkmBgZ7krtZYx9l2RHwUoace4cZaw
         ApfTFapkRfmbs7gpM2AEfq6F4vS/KFn+XCuIVYhouogSDnGnt0OjUtDOr4jmq/cngXzr
         acOF3MPBP5OQ5TQASIkREiV5Uup1C0M3F+4IIGyT7K41wMkUn9W8c2DMr4XbHz8LZemJ
         OSRPmX4y/Z4VjACwmjQYrmKjlJQfZXcFilQlyR6V+CktbAFID6sizEnwU/dL2++9NO5X
         bsNA==
X-Gm-Message-State: AOJu0YyKVat5CCQElLYJn05pC5oyJM/JyqiiHBvUJg4bvLpr4jt+QSOd
	EKmRlF6Y2vIwdGf/uLDqXr1r9f/596PJeuO2C0QxcQ==
X-Google-Smtp-Source: AGHT+IHO9t3GhQzMC9bRekJDhJepjxv7G3lJFwTon2QTZHTMeKMXtFY82VSR9B7iAN5ptHnyqsVjxA==
X-Received: by 2002:a05:6870:71c2:b0:203:5dc1:2e14 with SMTP id p2-20020a05687071c200b002035dc12e14mr745366oag.85.1702592663819;
        Thu, 14 Dec 2023 14:24:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r9-20020a056870e8c900b001fb25872d59sm4760930oan.2.2023.12.14.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:23 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/26] git-compat-util.h: implement checked size_t to
 uint32_t conversion
Message-ID: <6ede9e060332a0850269fe69a7a3a15ac229344b.1702592604.git.me@ttaylorr.com>
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

In a similar fashion as other checked cast functions in this header
(such as `cast_size_t_to_ulong()` and `cast_size_t_to_int()`), implement
a checked cast function for going from a size_t to a uint32_t value.

This function will be utilized in a future commit which needs to make
such a conversion.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 git-compat-util.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff..c3b6c2c226 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1013,6 +1013,15 @@ static inline unsigned long cast_size_t_to_ulong(size_t a)
 	return (unsigned long)a;
 }
 
+static inline uint32_t cast_size_t_to_uint32_t(size_t a)
+{
+	if (a != (uint32_t)a)
+		die("object too large to read on this platform: %"
+		    PRIuMAX" is cut off to %u",
+		    (uintmax_t)a, (uint32_t)a);
+	return (uint32_t)a;
+}
+
 static inline int cast_size_t_to_int(size_t a)
 {
 	if (a > INT_MAX)
-- 
2.43.0.102.ga31d690331.dirty

