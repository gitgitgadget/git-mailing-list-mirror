Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B06C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D24608FC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhHDF3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhHDF3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEED3C06179A
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so787703wrx.9
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ocAYG7LI9ZJ5Q9vn7EBNmwUoD2Zydm/6oCxK8dKtyoA=;
        b=iDjhB3Q2epvXaWKDmb8PPKbbAC9yRLoUkhymT8uyNVh6epJjI3V+p0p/BdjoIXWirQ
         O+57GBGempKddlre3x+rAqyNKiDp0uyBtd7rOOSMTiLhzqElNaJ1tlPIwn296ZWllSvv
         oj2ieWiRw1+9whzlLdkkXASUt65R79jF5RN5RbUvg1QjSfw3J794KAMD/jxMiwWyAAHt
         LpLE3AgOp07X+Qv4uYaHatgUA7nfLP2ZPPjgaQkOubg/SZFWlxGO7aw4H3lINH4nqP+k
         v2glvX9Q7lz39Sp1/L2tTrZa2RLRlgz4XyofNOcSQugLOhm1A9ndUG7H3295ZK7INxJV
         Mtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ocAYG7LI9ZJ5Q9vn7EBNmwUoD2Zydm/6oCxK8dKtyoA=;
        b=U6pcycwCRiwWzjIxSiz8UJUNlolfpaJqzoZ5qR7EqyQWbi/prE6v69up9VI7fddAkL
         AqVa95yaTD3CsB2c1dpuuTYNqSSzNOoYHVy1OeihwIkDljngD8DOaw5cZnbMKwV2tFIz
         MeFMwIcXiNFsvjB8tr0tvkq+hAFKNB839IgAas1EdIls+HNb+N0wORAw2UgFu1fX6J4O
         5bKnYxUOazTplyR2L49AnAOxt4lBco2NkaRlrNcdkeqonILl1dA9i1eb8Enm8JSLY3U/
         tJEc0YDhHg37ylRlUUgXmNdy2Os0PLkUwe4ZJ7RHutydtAyoMZM5Mqmd2Wza+cD+vRrH
         lLsA==
X-Gm-Message-State: AOAM530SCByfuHbiVtJOR/6mXVzNGEiz5ORQiZGiJo1o8Skti+TPxI0C
        GjW11c3gOYa++D/uykaia3eFNFQgq7w=
X-Google-Smtp-Source: ABdhPJxJW2C4ZemUyc5+5bs2FQKOZAO8LjcyCNqEjN4Blg+Knw8jGRvDrkv7QIeEGls6GVNs5WWq4w==
X-Received: by 2002:adf:ea4b:: with SMTP id j11mr26705553wrn.156.1628054941526;
        Tue, 03 Aug 2021 22:29:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16sm1100150wru.40.2021.08.03.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:01 -0700 (PDT)
Message-Id: <44101062e0e0bfb55a476e91037464738fcb6f70.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:51 +0000
Subject: [PATCH v2 06/10] merge-strategies.txt: avoid giving special
 preference to patience algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We already have diff-algorithm that explains why there are special diff
algorithms, so we do not need to re-explain patience.  patience exists
as its own toplevel option for historical reasons, but there's no reason
to give it special preference or document it again and suggest it's more
important than other diff algorithms, so just refer to it as a
deprecated shorthand for `diff-algorithm=patience`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index e2988124581..b54bcf68f2d 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -37,11 +37,7 @@ theirs;;
 	no 'theirs' merge strategy to confuse this merge option with.
 
 patience;;
-	With this option, 'merge-recursive' spends a little extra time
-	to avoid mismerges that sometimes occur due to unimportant
-	matching lines (e.g., braces from distinct functions).  Use
-	this when the branches to be merged have diverged wildly.
-	See also linkgit:git-diff[1] `--patience`.
+	Deprecated synonym for `diff-algorithm=patience`.
 
 diff-algorithm=[patience|minimal|histogram|myers];;
 	Use a different diff algorithm while merging, which can help
-- 
gitgitgadget

