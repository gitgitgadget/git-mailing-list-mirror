Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487E6C54E4B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22829206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdEMXV2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgEKL4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728531AbgEKL40 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB9C05BD09
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so18869369wmh.3
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kkT1mID5+IML20nKK0y2PulT3nfJQNhS9TLz8gftUAQ=;
        b=PdEMXV2ykzuo67GUC9ddFkb5EPDwhLnAC8ZCEJLc+boqdCobbHTOP4vk2FUS1Gjh31
         zTAYygOQ5tpkporfw/n4bqL9gr5EoACXxEojjS4t9jmbOAzJb4TACJgJrtLJouitxySS
         DfVXabq11zYYTE27OY/0/MayggOQFWBDQFZpkwv8hXBcdhFuN1f88B2AJwhtrFxESEwN
         frPW8LR4ShZI3D8QjDxhJ3plX5GUZRXYf951jvW7conPhFtjZu9eBQInneExwOouLmH4
         iCzxv3BKro8HU3jHmlddOSzM5xNmReAEFPmGN/il2s4XtVw+cON82z1csHEZ8pupbr6s
         Memw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kkT1mID5+IML20nKK0y2PulT3nfJQNhS9TLz8gftUAQ=;
        b=izV1VbMD585Bbb3mhFMaqgntmQ3y0SSvTck+Pk4JDBmIdOsD88UTPSjID+6FGyFq86
         3JDakPgwGb+q/Qzm76przqj5OoZd1n7tmh+9lvcbBGPZFm2XeHy2jkIdkYQtk70CVZvi
         2ttjcjFZRG8LSvqfG8TwYKM5xtEyhRakCAU3CVRM9GgBWEYEs8UtcPV3y6tVmRirQawS
         hqxPh8nbq16foa1Il9jGuwsPR8a+mNlx0ht8J5NFUUklhZv2LfFRt9WVOP4+jWQJXTeB
         K+llBGPvVAq093xNg27lebvrjMCj6bWDlAgOjpvLUieOibBxbXIOD1Wa5lRdXwbQgkzE
         CJPA==
X-Gm-Message-State: AGi0Pua9xoItOWNwHgFVfQgj7aFFa6I62bNPdY+ho8QaBbXxElNjbC0t
        CXfiteTWrtX1yu6YxnrVKxqX+89E
X-Google-Smtp-Source: APiQypKGx0Ckg2165xvRSlEHZUSokqvuvmPcAq70hbIAO1EbN+I5Al5zhriem4m0NLGKxpO0j4QbZw==
X-Received: by 2002:a05:600c:2614:: with SMTP id h20mr7056008wma.155.1589198184596;
        Mon, 11 May 2020 04:56:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm173332wme.21.2020.05.11.04.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:24 -0700 (PDT)
Message-Id: <61f78a2b0dd7d8e8ca04ce2e1681bd14ba81c1b9.1589198180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
        <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:11 +0000
Subject: [PATCH v2 04/12] Documentation: changed-path Bloom filters use byte
 words
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In Documentation/technical/commit-graph-format.txt, the definition
of the BIDX chunk specifies the length is a number of 8-byte words.
During development we discovered that using 8-byte words in the
Murmur3 hash algorithm causes issues with big-endian versus little-
endian machines. Thus, the hash algorithm was adapted to work on a
byte-by-byte basis. However, this caused a change in the definition
of a "word" in bloom.h. Now, a "word" is a single byte, which allows
filters to be as small as two bytes. These length-two filters are
demonstrated in t0095-bloom.sh, and a larger filter of length 25 is
demonstrated as well.

The original point of using 8-byte words was for alignment reasons.
It also presented opportunities for extremely sparse Bloom filters
when there were a small number of changes at a commit, creating a
very low false-positive rate. However, modifying the format at this
point is unlikely to be a valuable exercise. Also, this use of
single-byte granularity does present opportunities to save space.
It is unclear if 8-byte alignment of the filters would present any
meaningful performance benefits.

Modify the format document to reflect reality.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph-format.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index de56f9f1efd..1beef171822 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -97,10 +97,10 @@ CHUNK DATA:
       bit on. The other bits correspond to the position of the last parent.
 
   Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
-    * The ith entry, BIDX[i], stores the number of 8-byte word blocks in all
-      Bloom filters from commit 0 to commit i (inclusive) in lexicographic
-      order. The Bloom filter for the i-th commit spans from BIDX[i-1] to
-      BIDX[i] (plus header length), where BIDX[-1] is 0.
+    * The ith entry, BIDX[i], stores the number of bytes in all Bloom filters
+      from commit 0 to commit i (inclusive) in lexicographic order. The Bloom
+      filter for the i-th commit spans from BIDX[i-1] to BIDX[i] (plus header
+      length), where BIDX[-1] is 0.
     * The BIDX chunk is ignored if the BDAT chunk is not present.
 
   Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
-- 
gitgitgadget

