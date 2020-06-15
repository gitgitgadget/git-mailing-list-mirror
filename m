Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A4C433E4
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784F4207DD
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJc/XAj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgFOUPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbgFOUPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:15:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so18470005wrp.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J/uB/z76jqtUk6HPuj0n2256DOcU3cQKE03S/1ECveg=;
        b=cJc/XAj/ZO18t3Hajp/8rkMFRdO9jBvh/GcZKpMQgyrZphj9G9kC5tv2DuuBXfyyPd
         XupVA4AIZYJ+DIQ+CWeCByOMWGftB0KMwgBU/7ywO/1M028GqwHrIn9E3bkDYXBlpb5j
         nqLBbNO5kpF3Oldo7wLASQu4wO+OA1MjZT/ZIN/UFfmCGfDH7VMB56uCNpTSsGAAM2Ia
         IwBcJeftN7NIX+tmh2e8CCpkCPRLu3AryUjKql8gFvbpitkSP2+7tQ4OIUKYsD5sRdGz
         5FqEuOVZsfa46C4tznv/DtdsyVoJZ8LxcV2aGM+yq+jpR/AeOnMdrvsfsihPOV0TJcU9
         2LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J/uB/z76jqtUk6HPuj0n2256DOcU3cQKE03S/1ECveg=;
        b=Q8ehyXaupG+OOp6YiwA411ciziyb9E0I+I7ccol7e8nxgSPem/Xu2nO/PfINJW/Fit
         ThDe8BJJZ/5wkoaPlWxQ96sRbF/mNJbWiEjMM1vGYZW5vyexraLc+KuamUp9dKNK2bEl
         gX33LRJmLydJ0MSq9Ss6+jIYrmpavm54hASoIpLv7Ejj2M2bGzkC8rR8a1NLvGEygcCX
         26M0AIkLvuLlc76a+igILu1waGf5467D1R4g32vBwEMlOTSLkVWm9ICQskYkCpZzRSXz
         zMkLUGBmWCdn4Tv7rpZrmCOFvUk5thcWjJ5gQJ8TGmG5cLcPs5g6An83XYRPrzjidZPy
         SCpg==
X-Gm-Message-State: AOAM531Q33YvUawA/L8ftJY7mTY817ykniBStlmRXHPusaA7ShmQVr4M
        dB+TCUc5GQ7xyQb3kyqezN/5995O
X-Google-Smtp-Source: ABdhPJwmzaY5Dxlwt7zOAcUS4uHvPKP6Bpt42BvdkYIhrgkInIRje3Bwv0rLrlmTHvVt6MCQecGE1Q==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr32781438wrn.217.1592252099774;
        Mon, 15 Jun 2020 13:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm25600960wre.28.2020.06.15.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:14:59 -0700 (PDT)
Message-Id: <2a5f1e1752869e54203d7db609b4510a75d8de74.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:51 +0000
Subject: [PATCH 6/8] bloom: enforce a minimum size of 8 bytes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The original design of changed-path Bloom filters included an 8-byte
block size for filter lengths. This was changed mid-way through the
submission process, and now the length stored in the commit-graph has
one-byte granularity.

This can cause some issues for very small filters. The analysis for
false positive rates assume large filters, so rounding errors become
less important at that scale. When there are only a few paths changed,
a filter that has size only a few bytes could have very different
behavior. In fact, this is evidenced in the Git repository due to the
code organization and careful patch creation that leads to many commits
with very small filters. These small filters frequently have
false-positive rates in the 8-10% range or higher.

The previous change improved the false-positive rate using multiple
Bloom keys when the path has multiple directory components. However,
that does not help at all for files at root. It is typical to have
several commits that change only the README at root, and those commits
would be likely to have these artificially high false-positive rates.

Correct this issue by creating a minimum filters size of 8 bytes. This
requires the very small commits (with fewer than six changes, including
non-root directories) to have a larger filter. In principle, this
violates the bits_per_entry value of struct bloom_filter_settings.
However, it does not actually create a functional problem.

As for compatibility, this only affects new versions writing filters for
commits that do not yet have a filter. Old version will write the
smaller filters and this version will persist and properly read that
data. Now, the new files will be generated slightly larger.

               Bytes before   Bytes after  Difference
  --------------------------------------------------
  git             4,021,078    4,275,311   +6.32%
  linux          72,212,101   73,909,286   +2.35%
  tensorflow      7,596,359    7,691,646   +1.25%

This has a measurable improvement in the false-positive rate and the
end-to-end run time for these repos. The table below compares the average
false-positive rate and runtime of

  git rev-list HEAD -- "$path"

before and after this change for 5000+ randomly* selected paths from
each repository:

                    Average false           Average        Average
                    positive rate           runtime        runtime
                  before     after     before     after   difference
  ------------------------------------------------------------------
  git             0.786%     0.227%    0.0387s    0.0289s -25.5%
  linux           0.0296%    0.0174%   0.0766s    0.0706s  -7.8%
  tensorflow      0.6977%    0.0268%   0.0420s    0.0384s  -8.5%

*Path selection was done with the following pipeline:

        git ls-tree -r --name-only HEAD | sort -R | head -n 5000

These relatively-small increases in file size appear to be a fair price
to pay for these performance improvements.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bloom.c b/bloom.c
index c38d1cff0c6..875e3853c2c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -258,6 +258,10 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 		}
 
 		filter->len = (hashmap_get_size(&pathmap) * settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
+
+		if (filter->len && filter->len < 8)
+			filter->len = 8;
+
 		filter->data = xcalloc(filter->len, sizeof(unsigned char));
 
 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
-- 
gitgitgadget

