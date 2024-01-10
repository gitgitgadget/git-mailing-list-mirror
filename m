Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721A4E1D5
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eHzcweNH"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so45296807b3.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704909341; x=1705514141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld0lXnybPOa+fO1nd5leKrxwaScb8pVs0NekyPyU4rc=;
        b=eHzcweNHqw8bukIVLIYhA5YnQPL6ut6Ervj3r5kdsXSEPhmkZrbdvTHQ/5uhhWO4re
         mWBIEFbXUfiz4tDGT3tQ/LDHgd/t8GSszrOOBLstxUQWYsfYdwFLzrkkCtuysH8VbtUi
         D3ux0I2fT8CIMuTF7LuUDSC1Ay4yY4A70c1tjUJxqGW7V/xpVBDmdbTyKJ76Uj1Xp1Kn
         Uyx6hqMEvWVEYcDPb3SVSS5vdgdwe8LeaqJ5IItrsvPxeOaJqahgqLMVxjO9yzG8DH2q
         u+Yb5E/+daA1Kg8FoxHEeXPka2JkXnKO8a8qAlW1WRR/jzXfLk9gLKW65J3IFJ5PR8t8
         /HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909341; x=1705514141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld0lXnybPOa+fO1nd5leKrxwaScb8pVs0NekyPyU4rc=;
        b=MevVuSaDK8FKVaP3xNcEplwhiy7kHyPqEZtL0b8tggy/jTFgYWdY8v1uwZEafrMmUk
         uEWhvIeYSQSB7rkTHDno+q3u5ZYeCtzewFKZWExsozsPSarfbhQey8Ihv6bsMA3de3Rd
         kXbMKdcfqSvvNhXdfs+Fv7NN7I/+x/qEjeoKVuJcbdzxywSt/l3DlEQKWfBWDYLBcKvs
         zGEwk/vAryDOdEHd9j84XgoX3rAqbBjAYsinVGWJ4BdwOjharFPVmH+OEUmbRKG34zhM
         /95J9Cg2BG7oyBc5muq8+Wj1Z9LIdXRQp5lgehpzqc1bJZukvnZlYHv4QlgszF3q6NBT
         kYBg==
X-Gm-Message-State: AOJu0YwxjjWLJz+yxFb9pT0JQax7NYAcvw4rEa3oEpl8GoFLe3WGi5oK
	AZCzVBkFMKzBWUJgpALTuCrc7O/n8DkWs9/XSX0dZ/NNrnz/ag==
X-Google-Smtp-Source: AGHT+IHi1HEyWMw8bgkg7W522H+bZODCsvMX8ggbc+w/2GI7rBBJVlcqzTvCK/NsiqZ2M8vxlphQ0Q==
X-Received: by 2002:a0d:df82:0:b0:5e7:b0e9:625 with SMTP id i124-20020a0ddf82000000b005e7b0e90625mr1398881ywe.47.1704909341023;
        Wed, 10 Jan 2024 09:55:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pe30-20020a05620a851e00b00781baa4db60sm1755824qkn.66.2024.01.10.09.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:55:40 -0800 (PST)
Date: Wed, 10 Jan 2024 12:55:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] t5313: run expected-to-fail `index-pack`s with
 `--threads=1`
Message-ID: <4477fc49b0e7ca9a1d973ff156d267676716bd8a.1704909216.git.me@ttaylorr.com>
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
treatment to expected-to-fail `index-pack` invocations in t5313 with
`--threads=1`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5313-pack-bounds-checks.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index ceaa6700a2..e9829b6ef3 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -91,7 +91,7 @@ test_expect_success 'pack/index object count mismatch' '
 
 	# ...and make sure that index-pack --verify, which has its
 	# own reading routines, does not segfault.
-	test_must_fail git index-pack --verify $pack
+	test_must_fail git index-pack --threads=1 --verify $pack
 '
 
 test_expect_success 'matched bogus object count' '
@@ -111,7 +111,7 @@ test_expect_success 'matched bogus object count' '
 	git cat-file blob $object >actual &&
 	test_cmp file actual &&
 
-	test_must_fail git index-pack --verify $pack
+	test_must_fail git index-pack --threads=1 --verify $pack
 '
 
 # Note that we cannot check the fallback case for these
@@ -128,7 +128,7 @@ test_expect_success 'bogus object offset (v1)' '
 	munge $idx $((4 * 256)) "\377\0\0\0" &&
 	clear_base &&
 	test_must_fail git cat-file blob $object &&
-	test_must_fail git index-pack --verify $pack
+	test_must_fail git index-pack --threads=1 --verify $pack
 '
 
 test_expect_success 'bogus object offset (v2, no msb)' '
@@ -136,7 +136,7 @@ test_expect_success 'bogus object offset (v2, no msb)' '
 	munge $idx $(ofs_table 1) "\0\377\0\0" &&
 	clear_base &&
 	test_must_fail git cat-file blob $object &&
-	test_must_fail git index-pack --verify $pack
+	test_must_fail git index-pack --threads=1 --verify $pack
 '
 
 test_expect_success 'bogus offset into v2 extended table' '
@@ -144,7 +144,7 @@ test_expect_success 'bogus offset into v2 extended table' '
 	munge $idx $(ofs_table 1) "\377\0\0\0" &&
 	clear_base &&
 	test_must_fail git cat-file blob $object &&
-	test_must_fail git index-pack --verify $pack
+	test_must_fail git index-pack --threads=1 --verify $pack
 '
 
 test_expect_success 'bogus offset inside v2 extended table' '
@@ -169,7 +169,7 @@ test_expect_success 'bogus offset inside v2 extended table' '
 	mv tmp "$idx" &&
 	clear_base &&
 	test_must_fail git cat-file blob $object &&
-	test_must_fail git index-pack --verify $pack
+	test_must_fail git index-pack --threads=1 --verify $pack
 '
 
 test_expect_success 'bogus OFS_DELTA in packfile' '
-- 
2.43.0.288.g906e6a084d

