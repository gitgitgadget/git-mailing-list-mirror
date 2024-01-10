Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49504D5A4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0aLS7oiW"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78104f6f692so359624785a.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704909335; x=1705514135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6SeAM3pmHZUNXyHKrPaR6yrgE2UjSNVt5yWi9JQboY=;
        b=0aLS7oiWk3WBJmhcWLCOzDIO2y3SlKM0EvqTIJt+wZh4fzKMSyZoyXCfkn9qacbpzD
         i7ESJX3+D/SqfLnvBz+JSTxRvkpUXF+rWj1x71rlBbp/jjBVhlor2WoZ/sFv6x9iB9Am
         Nw4yRRkhyLI+RPRwmlDrSUUdp4H7F8OxvJnVhUt1jXQ0Uba1PJX0hfODrdtvNUbZX27V
         8gmTRu/32nVDdRpKJ3R87ccihRmGtIIOwLkdUb2qeZnZlaRyLRuKUUMFXwbToeG73Rdx
         HDttkCPH++F3jL3v7OrJKpL9eCo3iAo6H/TllrAqP0JQ7kcdw/08oeIelGBoktmTpMBx
         VlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909335; x=1705514135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6SeAM3pmHZUNXyHKrPaR6yrgE2UjSNVt5yWi9JQboY=;
        b=M2QXqnyQzAExcdVHJNrBOmOhbkquh330wAbPBdqNjLTY/6V4UT/Qgc+0Hrbx1wkb5M
         VpBg7Xgzsk2NAWDIV4fJYr9QIHTY+cULvxA8MLgf12nMjCMO/7fP94T95wjDn6s+SktY
         SF28csg3esSCCBvsfF0kcNwuauYMDUc2kKizS2nmw1ux+wq5v2yZVTJkBxNkBCgABXoV
         94UnkKOrLb5f0Zxum0lw0iqWWQz3MdXaxNzi+nMVoo2PMwI2xo/Hrdwrzos9l6u4iBqh
         wcV8XH3ZpwX92vG7bDhp49m8pudLu2yB0BxNcXfYcXaiYqoqDm9M3R5Nq5wV0HvAf2EY
         fLRg==
X-Gm-Message-State: AOJu0YzLmJIZ0IG/hKRXJp3+8mz1TCGYbE9/NSC1PsZU7Quzdwzbv9Es
	taKOWJyhwxlXOr/ZKAaOR84h8mzLtstC1Bq1JCg8QQTbmUoCEQ==
X-Google-Smtp-Source: AGHT+IEvbU+axw3E+Rkyoxoee6rkZesB/YXZpTA9Vx7uVa41lOXaSZIfWUYdRAMYdUUX9UbUxGpoVA==
X-Received: by 2002:a05:620a:2984:b0:781:6821:2737 with SMTP id r4-20020a05620a298400b0078168212737mr781087qkp.53.1704909335124;
        Wed, 10 Jan 2024 09:55:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15-20020a05620a02ef00b0078325452a32sm1772512qko.28.2024.01.10.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:55:34 -0800 (PST)
Date: Wed, 10 Jan 2024 12:55:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] t5302: run expected-to-fail `index-pack`s with
 `--threads=1`
Message-ID: <c581719053dd3d3a4c60f5c841091ea0ab122f75.1704909216.git.me@ttaylorr.com>
References: <ZZ7VEVXSg1T8ZkIK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZ7VEVXSg1T8ZkIK@nand.local>

For identical reasons as in the previous commit, apply the same
treatment to expected-to-fail `index-pack` invocations in t5302 with
`--threads=1`.

(Note that this treatment only needs to be applied in tests which are
expected to pass when built with the leak-checker enabled).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5302-pack-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index d88e6f1691..fdbcd80f89 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -290,7 +290,7 @@ test_expect_success 'too-large packs report the breach' '
 	pack=$(git pack-objects --all pack </dev/null) &&
 	sz="$(test_file_size pack-$pack.pack)" &&
 	test "$sz" -gt 20 &&
-	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
+	test_must_fail git index-pack --threads=1 --max-input-size=20 pack-$pack.pack 2>err &&
 	grep "maximum allowed size (20 bytes)" err
 '
 
-- 
2.43.0.288.g906e6a084d

