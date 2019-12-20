Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85046C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C662146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u77WK7cH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfLTWF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35527 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfLTWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so9859028edv.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nAlSjZATuzpSGNPDUtmJz/VIFttWV/K0yn7P/eWBBak=;
        b=u77WK7cH/lO5zUMiRK+NouwTk9pe7D67/2JnZw7BWnkiS9cYTNbzh9v5I5rIKLRRQ0
         88YHTGjD3xmsMNn7VrISLtUELsuHYwk7JlFs21kWyZlmv2HOQXSDez4RSkNxBBkmdduT
         dNFzzcYK2Qx7FKqZvqYEaKIfFXVg2zjNTQIf0dj2FJY45hggGku+4SBnF5dEZBcBuq6S
         1H2rtaQnleqt9GwlU2KnET/wqlVhhVJIASBzgfPtP0Iyh2GjnUOek4aqERgaG2KvMqV2
         vuQsodpBqGmWUC8xrCzXmE+atMEb8BZBIFSLohKNvRBGHWki7RfJZeO9h5wOficda+FY
         YSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nAlSjZATuzpSGNPDUtmJz/VIFttWV/K0yn7P/eWBBak=;
        b=qbd4jzyClmT176+1OX81gKdp1KFwsfktyOfPPRXjXnfOOKn/tfBassf6RyHJXjpww+
         DSsBqKCwsssY659tcB+jQ6ceCJT0OsR7Dx+21JyZQ67nZxdf4D8z8sl8Gu5h7MSlbHqD
         YmeDLhG/twZ6GsiuYp10dB8LjW8Bhn7pc1RD9y52umzt8S/XWivcAY7GTHy6S+L0l6vc
         2Z/Ppe/fhdUjpdVbwK+yrAGpyfGBZEzJC9Zy30CmGSuKJPqkSvMvgP+tgxNhOlO05ZM1
         2FJB5NEND9f4h3lVEO1TkL259W1aVDwZE39qO/SJ+IoOrxIaS7IY5jJX+B74L3N0w5iM
         EM8A==
X-Gm-Message-State: APjAAAWK2z4FcXZpKFq+YKV2s2flRVO6Yo500pL4YufdxtVpy5TGEoj2
        QQoC8i+RlNIfHePBgUURbF4UWhIk
X-Google-Smtp-Source: APXvYqyLbV0+ckuhJdeqi1GUIs4ibMuvu5v9IVQlauqQR5c+pJr2lUi6RXh6/AWYorVIYVsnmBah0Q==
X-Received: by 2002:a17:906:3798:: with SMTP id n24mr18642547ejc.15.1576879525747;
        Fri, 20 Dec 2019 14:05:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm1115208edm.84.2019.12.20.14.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:25 -0800 (PST)
Message-Id: <3182a11f7c07af834ba71dc7861742458754eb91.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:15 +0000
Subject: [PATCH 4/9] commit-graph: document bloom filter format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Update the technical documentation for commit-graph-format with BIDX
and BDAT chunk information.

RFC Notes:
1. [Call for advice] We specifically mention that we are using bloom
   filters in this technical document. Should this document also be
   made open to other data structures in the future, with versioning
   information?

2. [Call for advice] We are also not describing the explicit nature
   of how we store the bloom filter binary data. Would it be useful
   to document details about the hash algorithm, the number of hashes
   and the specific seed values we are using in a separate document,
   or perhaps in a separate section in this document?

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Documentation/technical/commit-graph-format.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index a4f17441ae..6497f19f08 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -17,6 +17,9 @@ metadata, including:
 - The parents of the commit, stored using positional references within
   the graph file.
 
+- The bloom filter of the commit carrying the paths that were changed between
+  the commit and it's first parent.
+
 These positional references are stored as unsigned 32-bit integers
 corresponding to the array position within the list of commit OIDs. Due
 to some special constants we use to track parents, we can store at most
@@ -93,6 +96,20 @@ CHUNK DATA:
       positions for the parents until reaching a value with the most-significant
       bit on. The other bits correspond to the position of the last parent.
 
+  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) [Optional]
+      For each commit we store the offset of its bloom filter in the BDAT chunk
+      as follows:
+      BIDX[i] = number of 8-byte words in all the bloom filters from commit 0 to
+		commit i (inclusive)
+
+  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
+      * It starts with three 32 bit integers for the
+	    - version of the hash algorithm being used
+	    - the number of hashes used in the computation
+	    - the number of bits per entry
+	  * The rest of the chunk is the concatenation of all the computed bloom 
+	  filters for the commits in lexicographic order.
+
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
-- 
gitgitgadget

