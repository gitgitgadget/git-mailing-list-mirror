Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB1C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4249C20776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvBAVGLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgE2IvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgE2IvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAC4C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r9so2317009wmh.2
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0KsrOctfKXYg5G9FZKB2N4Z6/V+Ve9RekzoVrZUBgk=;
        b=YvBAVGLsAgBJcCvb0c3IlVTrxVnlU3Nl3vmxit9ssTvaRgmPmLj2GQrsC0UVn8PGhj
         8YU1Pp/lrG/VFcOsM5FJRbKGMHaL4sk3QXmnpJ0JD/LZS2pOS6nJ0niYsB1olqKuxI1o
         zEwR9E+bVe0MHsbE31XMx+PDDK5YpBmXT2F3BOpjc1h5LI6fDveEZ5xr0v5nR2ONm1jR
         xBFe4e7bcaIDTrCR9mgMPILsvKthTOg/vi8ro/sEacOyw9+sg70DJvmJSqkjN8bHYiIK
         hxHdRHrAmfHF4YK0RS0FDkxook3IT4w1OulUWyAzuLstTIX9/uIMKAuIC1Vaq4fjswor
         TtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0KsrOctfKXYg5G9FZKB2N4Z6/V+Ve9RekzoVrZUBgk=;
        b=D4iPJd3+U6C42L/pAMueOuytRsM0WsmqxG/9Eb9Qt9OCLk/ga3JksI5KM1zAg2G0Uo
         DQStxFMmIhy2QofrUPRNq0Af1X0OhqjfmBq714Iq4BPbPOquZR5ZCSC/Uk9GS0DTYWmr
         nBw4jnGBRfmttMZGRkomSQWygO9UIDNMn8S5a4XGQJhStq/CLxuhuOQPyVZk/OBQ2+Ix
         b4cCuOhE/efQ9eJFs3NbrNXTpeg73BLlOQ52u6O4nBBaKjjYUBdV5DzV+lV1i+LaGkJ/
         PdSpOS6YdBclcDjogwhnCOhBg3cXL0SkNdNumiqOBMeStXRCMGXcA6seZsnUfLqvxk26
         J/aA==
X-Gm-Message-State: AOAM532CpD1QQ9s4pr9hlVVsB2Jli2NJEKyaIgmZDyeAKzDGW4ARn/O8
        BF4TXfxL1KyrhSHUqKANGsqOEgnu
X-Google-Smtp-Source: ABdhPJzZPKmqV+e+vCKdHzziRWkOcwc9bNvI4HrSCyo7E+ylEL9F4vVhgHSOz8z+urjvY4hlv3lwWQ==
X-Received: by 2002:a1c:a5ce:: with SMTP id o197mr221696wme.85.1590742281110;
        Fri, 29 May 2020 01:51:21 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 16/34] Add a generic and minimal Bloom filter implementation
Date:   Fri, 29 May 2020 10:50:20 +0200
Message-Id: <20200529085038.26008-17-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll use Bloom filters to store the paths modified between each
commit and one of its parents.  This means many small Bloom filters,
which puts some constraints on the hashing scheme, as discussed in the
previous commit.  However, Bloom filters might turn out to be useful
in other parts of Git as well, where they might be free from those
constraints.  So add a Bloom filter implementation that is fairly
generic, and copes only with allocation, initialization and release of
the filter and with manipulating the bits in its bit array, but leaves
all the hashing to the user of the filter.

Unfortunately, it's still somewhat specific, though, in how it maps
the hashes to specific bits in memory, i.e. how it maps the hashes to
array indices and how the bit array is indexed.  We'll see how that
will pan out...
---
 Makefile       |  1 +
 bloom-filter.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 bloom-filter.h | 47 ++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 bloom-filter.c
 create mode 100644 bloom-filter.h

diff --git a/Makefile b/Makefile
index 09f98b777c..a9db1e8d9b 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,7 @@ LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
+LIB_OBJS += bloom-filter.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
 LIB_OBJS += bundle.o
diff --git a/bloom-filter.c b/bloom-filter.c
new file mode 100644
index 0000000000..919da26462
--- /dev/null
+++ b/bloom-filter.c
@@ -0,0 +1,91 @@
+#include "bloom-filter.h"
+
+void bloom_filter_init(struct bloom_filter *bf, unsigned int nr_hashes,
+		       uint32_t nr_elements)
+{
+	/* n * k / ln(2) ≈ n * k / 0.69315 ≈ n * k * 10 / 7 */
+	uint32_t nr_bits = st_mult(st_mult(nr_elements, nr_hashes), 10) / 7;
+	uint32_t nr_bytes = st_add(nr_bits, 7) / 8;
+	/*
+	 * But we round up to fully utilize all bytes, thus lowering the
+	 * probability of false positives a bit.
+	 */
+	bf->nr_bits = nr_bytes * 8;
+	bf->bits = xcalloc(nr_bytes, sizeof(*(bf->bits)));
+}
+
+void bloom_filter_init_with_size(struct bloom_filter *bf, uint32_t nr_bits)
+{
+	uint32_t nr_bytes = st_add(nr_bits, 7) / 8;
+	bf->nr_bits = nr_bits;
+	bf->bits = xcalloc(nr_bytes, sizeof(*(bf->bits)));
+}
+
+void bloom_filter_free(struct bloom_filter *bf)
+{
+	FREE_AND_NULL(bf->bits);
+	bf->nr_bits = 0;
+}
+
+uint32_t bloom_filter_bytes(struct bloom_filter *bf)
+{
+	return (bf->nr_bits + 7) / 8;
+}
+
+void bloom_filter_clear_all_bits(struct bloom_filter *bf)
+{
+	memset(bf->bits, 0, bloom_filter_bytes(bf));
+}
+
+void bloom_filter_set_all_bits(struct bloom_filter *bf)
+{
+	memset(bf->bits, 0xff, bloom_filter_bytes(bf));
+}
+
+static inline uint32_t bit_offset(uint32_t nr_bits, uint32_t hash)
+{
+	return hash % nr_bits;
+}
+
+static inline uint32_t byte_offset(uint32_t nr_bits, uint32_t bit_offset)
+{
+	return (nr_bits - 1) / 8 - bit_offset / 8;
+}
+
+static inline uint8_t byte_mask(uint32_t bit_offset)
+{
+	return 1 << (bit_offset % 8);
+}
+
+static inline void bloom_filter_set_one_bit(struct bloom_filter *bf,
+					    uint32_t hash)
+{
+	uint32_t offset = bit_offset(bf->nr_bits, hash);
+	bf->bits[byte_offset(bf->nr_bits, offset)] |= byte_mask(offset);
+}
+
+void bloom_filter_set_bits(struct bloom_filter *bf, const uint32_t *hashes,
+			   unsigned int nr_hashes)
+{
+	unsigned int i;
+	for (i = 0; i < nr_hashes; i++)
+		bloom_filter_set_one_bit(bf, hashes[i]);
+}
+
+static inline int bloom_filter_check_one_bit(struct bloom_filter *bf,
+					     uint32_t hash)
+{
+	uint32_t offset = bit_offset(bf->nr_bits, hash);
+	return bf->bits[byte_offset(bf->nr_bits, offset)] & byte_mask(offset);
+}
+
+enum bloom_result bloom_filter_check_bits(struct bloom_filter *bf,
+					  const uint32_t *hashes,
+					  unsigned int nr_hashes)
+{
+	unsigned int i;
+	for (i = 0; i < nr_hashes; i++)
+		if (!bloom_filter_check_one_bit(bf, hashes[i]))
+			return BLOOM_DEFINITELY_NOT;
+	return BLOOM_POSSIBLY_YES;
+}
diff --git a/bloom-filter.h b/bloom-filter.h
new file mode 100644
index 0000000000..2fcd4a2c19
--- /dev/null
+++ b/bloom-filter.h
@@ -0,0 +1,47 @@
+#ifndef BLOOM_FILTER_H
+#define BLOOM_FILTER_H
+
+#include "git-compat-util.h"
+
+enum bloom_result {
+	/*
+	 * BLOOM_CANT_TELL is a value that a caller can use to report that
+	 * a Bloom filter is not available; bloom_filter_check_bits() will
+	 * never return it.
+	 */
+	BLOOM_CANT_TELL = -1,
+	BLOOM_DEFINITELY_NOT = 0,
+	BLOOM_POSSIBLY_YES = 1
+};
+
+struct bloom_filter {
+	uint32_t nr_bits;
+	uint8_t *bits;
+};
+
+/*
+ * Initialize a Bloom filter with the number of bits that is (close to)
+ * optimal to hold the given number of elements using the given number
+ * of hashes per element.
+ */
+void bloom_filter_init(struct bloom_filter *bf, uint32_t nr_hashes,
+		       uint32_t nr_elements);
+
+/* Initialize a Bloom filter with the given number of bits */
+void bloom_filter_init_with_size(struct bloom_filter *bf, uint32_t nr_bits);
+
+void bloom_filter_free(struct bloom_filter *bf);
+
+/* Return the size of the Bloom filter's bit array in bytes */
+uint32_t bloom_filter_bytes(struct bloom_filter *bf);
+
+void bloom_filter_clear_all_bits(struct bloom_filter *bf);
+void bloom_filter_set_all_bits(struct bloom_filter *bf);
+
+void bloom_filter_set_bits(struct bloom_filter *bf, const uint32_t *hashes,
+			   unsigned int nr_hashes);
+enum bloom_result bloom_filter_check_bits(struct bloom_filter *bf,
+					  const uint32_t *hashes,
+					  unsigned int nr_hashes);
+
+#endif
-- 
2.27.0.rc1.431.g5c813f95dc

