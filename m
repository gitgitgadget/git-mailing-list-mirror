Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DC671E8
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ALvmIvgN"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6da1b71a085so48266a34.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592688; x=1703197488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WO7jHHA81HsziybRHje3jIUVkg0779cnJFsesAoqDpc=;
        b=ALvmIvgNxxKondmlaxXalGet04lSBK3ohZ0aovhwe8FJ6+akVFlnU3AwL0TtVfe4wu
         YdUSu3O/Eg4RUmTVICh3ATzT8WZQ5frkF6HZ7dmvxLSFhOPydc8xqgHpMKngEKZcgyBq
         aq/nlvObXCB7DEZlyOodiu+gtYm20bTLwukfLjcYJR7wxxYt6xmAVNX8d4OzOGKcveMp
         nnjh+vDb9C00q9aiIzs1JE2TFIynIiaAOm/l41KCRv3GMOe8ruVQdzQd06MJ/IPLMGHm
         AN7X3yHVDmUitpCA0XcOiqn1bStwnhdDGt/SiuNi5c6RG1lgg58Ovk96GrGl4LNsCMM7
         43tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592688; x=1703197488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO7jHHA81HsziybRHje3jIUVkg0779cnJFsesAoqDpc=;
        b=OP1WjMNG8EDQsEMeLZNuCxq5itUClb/S/Gmw/V3fP9OfoOWjd6BtDwRfYD9S81L8Kw
         3dPlO9VT+Z/l2N8HIKL6KeJOF50A5SfHjjuw4gna/XQBtz9rdZeN8ioMkPS8+1xU5ACj
         Yn4LgBleUZl6zgtJa134RrhrS9AGUEP/o4lEF+IKiz8U6ieEiQUb46W8TZXpAXXt0Ozl
         Aiv1cZrf0ISknHFFcu5frw9dnGxzuUCXooKYXGqhVXPTGRteyBDaK9t1SIl8yEevBjyG
         65l8KACe6GfqBPPfzT8DNTMINIs/WNrl8jqdK2Ek9xuoxYR8auCgzGY7OZSOUXLugNHl
         +hKA==
X-Gm-Message-State: AOJu0YxblFwPrBdaE/70gf0nsyfJTpaSNXuYnV0iVBRG92VNUREIV4za
	Zl2RA8/6FY5wfOdAFqYuNvLyNQB5N4qojMivgibU0w==
X-Google-Smtp-Source: AGHT+IERGBvQ2y9xKwNU4auQn/K0v/wV2kIXr4ZhWtuclsY6iwltDqAIOuCulOefv4/4bdNaQcX8ZA==
X-Received: by 2002:a9d:6f85:0:b0:6d8:7a7a:2d7f with SMTP id h5-20020a9d6f85000000b006d87a7a2d7fmr6422041otq.41.1702592688302;
        Thu, 14 Dec 2023 14:24:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a25-20020a056830009900b006d7f3e00bc2sm3349472oto.52.2023.12.14.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:48 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 26/26] t/perf: add performance tests for multi-pack reuse
Message-ID: <94e5ae4cf6e0f53d4141fc486f32d73d168cf993.1702592604.git.me@ttaylorr.com>
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

To ensure that we don't regress either the size or runtime performance
of multi-pack reuse, add a performance test to measure both of these.

The test partitions the objects in GIT_TEST_PERF_LARGE_REPO into 1, 10,
and 100 packs, and then tries to perform a "clone" at each stage with
both single- and multi-pack reuse enabled.

Note that the `repack_into_n_chunks()` function in this new test script
differs from the existing `repack_into_n()`. The former partitions the
repository into N equal-sized chunks, while the latter produces N packs
of five commits each (plus their objects), and then another pack with
the remainder.

On git.git, I can produce the following results on my machine:

    Test                                                            this tree
    --------------------------------------------------------------------------------
    5332.3: clone for 1-pack scenario (single-pack reuse)           1.57(2.99+0.15)
    5332.4: clone size for 1-pack scenario (single-pack reuse)               231.8M
    5332.5: clone for 1-pack scenario (multi-pack reuse)            1.79(2.96+0.21)
    5332.6: clone size for 1-pack scenario (multi-pack reuse)                231.7M
    5332.9: clone for 10-pack scenario (single-pack reuse)          3.89(16.75+0.35)
    5332.10: clone size for 10-pack scenario (single-pack reuse)             209.9M
    5332.11: clone for 10-pack scenario (multi-pack reuse)          1.56(2.99+0.17)
    5332.12: clone size for 10-pack scenario (multi-pack reuse)              224.4M
    5332.15: clone for 100-pack scenario (single-pack reuse)        8.24(54.31+0.59)
    5332.16: clone size for 100-pack scenario (single-pack reuse)            278.3M
    5332.17: clone for 100-pack scenario (multi-pack reuse)         2.13(2.44+0.33)
    5332.18: clone size for 100-pack scenario (multi-pack reuse)             357.9M

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5332-multi-pack-reuse.sh | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 t/perf/p5332-multi-pack-reuse.sh

diff --git a/t/perf/p5332-multi-pack-reuse.sh b/t/perf/p5332-multi-pack-reuse.sh
new file mode 100755
index 0000000000..5c6c575d62
--- /dev/null
+++ b/t/perf/p5332-multi-pack-reuse.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='tests pack performance with multi-pack reuse'
+
+. ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-pack.sh"
+
+packdir=.git/objects/pack
+
+test_perf_large_repo
+
+find_pack () {
+	for idx in $packdir/pack-*.idx
+	do
+		if git show-index <$idx | grep -q "$1"
+		then
+			basename $idx
+		fi || return 1
+	done
+}
+
+repack_into_n_chunks () {
+	git repack -adk &&
+
+	test "$1" -eq 1 && return ||
+
+	find $packdir -type f | sort >packs.before &&
+
+	# partition the repository into $1 chunks of consecutive commits, and
+	# then create $1 packs with the objects reachable from each chunk
+	# (excluding any objects reachable from the previous chunks)
+	sz="$(($(git rev-list --count --all) / $1))"
+	for rev in $(git rev-list --all | awk "NR % $sz == 0" | tac)
+	do
+		pack="$(echo "$rev" | git pack-objects --revs \
+			--honor-pack-keep --delta-base-offset $packdir/pack)" &&
+		touch $packdir/pack-$pack.keep || return 1
+	done
+
+	# grab any remaining objects not packed by the previous step(s)
+	git pack-objects --revs --all --honor-pack-keep --delta-base-offset \
+		$packdir/pack &&
+
+	find $packdir -type f | sort >packs.after &&
+
+	# and install the whole thing
+	for f in $(comm -12 packs.before packs.after)
+	do
+		rm -f "$f" || return 1
+	done
+	rm -fr $packdir/*.keep
+}
+
+for nr_packs in 1 10 100
+do
+	test_expect_success "create $nr_packs-pack scenario" '
+		repack_into_n_chunks $nr_packs
+	'
+
+	test_expect_success "setup bitmaps for $nr_packs-pack scenario" '
+		find $packdir -type f -name "*.idx" | sed -e "s/.*\/\(.*\)$/+\1/g" |
+		git multi-pack-index write --stdin-packs --bitmap \
+			--preferred-pack="$(find_pack $(git rev-parse HEAD))"
+	'
+
+	for reuse in single multi
+	do
+		test_perf "clone for $nr_packs-pack scenario ($reuse-pack reuse)" "
+			git for-each-ref --format='%(objectname)' refs/heads refs/tags >in &&
+			git -c pack.allowPackReuse=$reuse pack-objects \
+				--revs --delta-base-offset --use-bitmap-index \
+				--stdout <in >result
+		"
+
+		test_size "clone size for $nr_packs-pack scenario ($reuse-pack reuse)" '
+			wc -c <result
+		'
+	done
+done
+
+test_done
-- 
2.43.0.102.ga31d690331.dirty
