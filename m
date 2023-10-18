Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AA42BF3
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NhuY969x"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFE114
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d122f6294so46170716d6.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653974; x=1698258774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+AG7bOM8F80vJ4PI/4QI9mBLxDX4rK3zxcNpcIjko8=;
        b=NhuY969xVE4CPlmtdpBpuVSlxgTj/zNE+dLMl3OMQ574WUqSUlNPHeSSiBdP9vj3AR
         S5jmWEZkAfBw9g9MvrHB+T2Kg40vMRJ7PL1vrAEa/Qt/zL6OCmnvADwT5kuSkI50V3KX
         SCGcuFTyJBXm8cval+Nb+SROnjVZjxYMhpi4kQdvopU+X6UsWH+bKHvlETOJDDnplAPB
         spzc3Kha1HKH9Jnz3xY7eXAbAxNrCvi/uPToX28FBq7eP6iWthZum9BIj5OtT++K5Bm4
         3u8PFSRDvStALYkA0f6OHgOteRrVWkiGf5d/YUc9eDbADqP0Hlrk0VHy3ml5+qCM5iWf
         /7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653974; x=1698258774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+AG7bOM8F80vJ4PI/4QI9mBLxDX4rK3zxcNpcIjko8=;
        b=Z5s7Jtenv3kQzjGFr4Gl0mkE3Df2Q69Z/vpUn3VvbAkeAgy42hL8z5AR59NGVV5YCq
         6Gky8y9oMGGORA58Fcx8i71X/jBNnonMfSjPS5ZhASsvuZlIRIseRKqwsnNGWbpFj4rI
         GH7yANq/oAaGbyZb3DdyjrJ0jDM9OoVS4TZ+tSnLWC9/+nlmhAT6wsxqheuYR0hQhu4q
         eVqtvEA6N55RlTR5qCG5QgNDwgqfuaq6fpbCjSIH9APyiWMKbCUTWgTVF3dngZTg2ie7
         HDOo3V6yzkaa5A5qu+ZjVDyWmhE1LH3BqBOddMM78NEbs+oHvQVB+It91kXujIJuIxN/
         Ps1A==
X-Gm-Message-State: AOJu0YwUlT+M7cUZu5i8Otz8mhFPcaJ5sxkes3tZtkyijb4y++PONCbU
	nkNp7+xt5Jrjv3IQ/53955B9Eax1O2AKvodM0L/JFQ==
X-Google-Smtp-Source: AGHT+IFynILJbg1N/XAbR8KWL+ZPxaugS7S7ukZqoBNhK3UULos9iF7Yz/H57WKgkSGlS24WLbooiw==
X-Received: by 2002:a05:6214:21e8:b0:66d:a4d:84f7 with SMTP id p8-20020a05621421e800b0066d0a4d84f7mr70900qvj.28.1697653974355;
        Wed, 18 Oct 2023 11:32:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ml10-20020a056214584a00b0065d1380dd17sm150175qvb.61.2023.10.18.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:32:54 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:32:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 08/17] t4216: test changed path filters with high bit paths
Message-ID: <cef2aac8ba01051ebc6194a5dea28964f76a5243.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jonathan Tan <jonathantanmy@google.com>

Subsequent commits will teach Git another version of changed path
filter that has different behavior with paths that contain at least
one character with its high bit set, so test the existing behavior as
a baseline.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 2ea5e90955..400dce2193 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -484,4 +484,55 @@ test_expect_success 'merge graph layers with incompatible Bloom settings' '
 	test_must_be_empty err
 '
 
+get_first_changed_path_filter () {
+	test-tool read-graph bloom-filters >filters.dat &&
+	head -n 1 filters.dat
+}
+
+# chosen to be the same under all Unicode normalization forms
+CENT=$(printf "\302\242")
+
+test_expect_success 'set up repo with high bit path, version 1 changed-path' '
+	git init highbit1 &&
+	test_commit -C highbit1 c1 "$CENT" &&
+	git -C highbit1 commit-graph write --reachable --changed-paths
+'
+
+test_expect_success 'setup check value of version 1 changed-path' '
+	(
+		cd highbit1 &&
+		echo "52a9" >expect &&
+		get_first_changed_path_filter >actual
+	)
+'
+
+# expect will not match actual if char is unsigned by default. Write the test
+# in this way, so that a user running this test script can still see if the two
+# files match. (It will appear as an ordinary success if they match, and a skip
+# if not.)
+if test_cmp highbit1/expect highbit1/actual
+then
+	test_set_prereq SIGNED_CHAR_BY_DEFAULT
+fi
+test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
+	# Only the prereq matters for this test.
+	true
+'
+
+test_expect_success 'setup make another commit' '
+	# "git log" does not use Bloom filters for root commits - see how, in
+	# revision.c, rev_compare_tree() (the only code path that eventually calls
+	# get_bloom_filter()) is only called by try_to_simplify_commit() when the commit
+	# has one parent. Therefore, make another commit so that we perform the tests on
+	# a non-root commit.
+	test_commit -C highbit1 anotherc1 "another$CENT"
+'
+
+test_expect_success 'version 1 changed-path used when version 1 requested' '
+	(
+		cd highbit1 &&
+		test_bloom_filters_used "-- another$CENT"
+	)
+'
+
 test_done
-- 
2.42.0.415.g8942f205c8

