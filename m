Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA524C47257
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999F52137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM9QiUuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgEAPaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgEAPaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5201C061A0E
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 188so75456wmc.2
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UwX7rpa/0dmihTdWuZokctG8o3dYHs2dPW7HrFPKabw=;
        b=AM9QiUuktcSXjzla712yjORr4mMuWPPG2tGe3svTDdxKTA1bySiCtlyEimneiUICru
         AdI7oLY0yQVd5oqPFMnCFJwj5YeCCi+4IFk4Dz9n7Xw48y0ly+Lwxk1pU06a/5URh9oI
         mRbD2SHyZVhabkSUtSsPum1Ef1RBz7/vZWQD0AeIHkqNANgFoesidaT+DDEJC74bJ9WK
         lecYxrgaN6R+yCf62SkzjvL+dGdP3rDlMy2Fvip36xWLBcMEBOe34bovmtEAs+/Qec45
         t3QEfYvO+Z8ZYHnNbQfV2oeKuSY3sKkppV3YPuncYsH8h6/NcUPAlaoJMdZf3/TfBQX5
         m/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UwX7rpa/0dmihTdWuZokctG8o3dYHs2dPW7HrFPKabw=;
        b=Rjun9F/hZFniicMUzLKThdnaYmqId4az+aP8UVTvelz+49Z9p/yyAjDqCLZSRJiIeK
         QU5glc6ewNkBgNM7r08JNjbCErPdGXQ3ydCRt7onEqbp5752LsSr7u73yzpLxEk77U0S
         WDtqaavec1Cc5xbqvTvOuGiDfKe8IhjeRE0yL/U0xXhQKkgVqDunIk7nlgFBm1AWObgD
         QNFkMrYk56SEuUY/1ssWnj1FYGgA3gBi3VE7wRJJ+goDzzrh5hLW/MRhMcYRg8ugJB9p
         cWE+Z8GqAaugqRzDDDTokn1wsAU0mEqmyxfUlFt/2cj3w6610pqTFWusybnhTBIa8yuX
         8Pqg==
X-Gm-Message-State: AGi0PubwqXT+NEQgJ1MHWQPezKK5HNN5HOFhb7JNUXJUCpIPl0XpSRgC
        Zkc7gzMWsFleKjurYbXt0s6+Awsr
X-Google-Smtp-Source: APiQypLns7HgvZO2HYZV6pINXWudu8w1JoDkhkMeKvNwAQ7kcB4QH77U/vPedMdkRqENpF0upcKqTw==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr86570wmi.69.1588347033160;
        Fri, 01 May 2020 08:30:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22sm5043294wre.84.2020.05.01.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:32 -0700 (PDT)
Message-Id: <03b2c84db36754b321dd15cd8a9e1a22b7c11c36.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:20 +0000
Subject: [PATCH 03/12] Documentation: changed-path Bloom filters use byte
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
Murmur3 hash algorithm causes issues with Big-Endian versus Little-
Endian machines. Thus, the hash algorithm was adapted to work on a
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

