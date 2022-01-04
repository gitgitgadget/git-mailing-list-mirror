Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034AC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 18:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiADSPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiADSPn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 13:15:43 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E5C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 10:15:43 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id ke6so35148064qvb.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtMowjcH9kIdYnLdb2LZFMrjUkwJVwMgrlKKUGywxo4=;
        b=dZYzaGG9/FaqpdnqGMDHOYC25CZdvir+ltLuoUZ7iO9RAddr2+uYbumJ/CFMwIXaZe
         x3//By7H0uRSFnTNjCpU+jaw3yQULU4glVNWVB5CfRURmXGugfL22mLT+LLdmXZHPYPO
         WjYVIElGIMDxcdXp7jM4qAJJGzjc6dWd0aYXnaUYIFQ9hK2PjsYvYBMlmwI7grd7hWGc
         7NE8ZyqGPvPpGYgSo0vNcAHH/naXoodbEl0t0e1GNiBc9fg69GBdX24Of/lTrbNs1VhO
         pwQxZGtG1AF+84Wzk4gK7la74VSJxec+OA49moNbDVYyKEHEJSBKquvJI7jp5yhPdA2f
         BeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtMowjcH9kIdYnLdb2LZFMrjUkwJVwMgrlKKUGywxo4=;
        b=v7zuu0wkycaf9rKYMxQZj/K+gFM+7SBvyoV2g3s+EPq8Ls+lEv9A1M1nSXJ3sGvPwI
         s4kuP9aC0kqwLt41oxvkkjbARuwBpYkmudZ+C/rh4OvqfEWOkl2hpP7JrxRVg0HDfNDK
         WoRhlEB8DjMpJuHqWzS7rMwaWMNJoe+6ktSqjTN+FGeO46TbkmKwuuuYmWt9MYJu0wNz
         0t722eZxpn8//ZrRzSIB/EO+FTtnRFEtomFy0xRBXGCRVBiFEEgQxDBL8omC1zpey2gH
         Znxo7IXdVZRWpSv8Pu6Lw9URs3dk8NAupS4855oIpKz/Giq5t55grDjK/2e0T0STxj3V
         o8rA==
X-Gm-Message-State: AOAM532nFq22o7RJ0uX/0VYEpe69YzPJRt4AGQ67+moFcvpmaHplik+8
        iZg+TOZdNEtijIH9R9y4qKThkdwwlskno5fK
X-Google-Smtp-Source: ABdhPJzoqwwwlr0VODA8OnTcZMYx1ZSR4ZRNziOJaAdT4KH2EooYpy8EKMTzI3Kqq0p1bqAOmjKbpQ==
X-Received: by 2002:a05:6214:c4a:: with SMTP id r10mr44809561qvj.95.1641320142261;
        Tue, 04 Jan 2022 10:15:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x25sm29984100qkf.91.2022.01.04.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:15:41 -0800 (PST)
Date:   Tue, 4 Jan 2022 13:15:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com
Subject: [PATCH v3 1/9] t5326: demonstrate bitmap corruption after permutation
Message-ID: <babce7d29a85df0da54cb651433111bc33097a4e.1641320129.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1641320129.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1641320129.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch demonstrates a cause of bitmap corruption that can occur when
the contents of the multi-pack index does not change, but the underlying
object order does.

In this example, we have a MIDX containing two packs, each with a
distinct set of objects (pack A corresponds to the tree, blob, and
commit from the first patch, and pack B corresponds to the second
patch).

First, a MIDX is written where the 'A' pack is preferred. As expected,
the bitmaps generated there are in-tact. But then, we generate an
identical MIDX with a different object order: this time preferring pack
'B'.

Due to a bug which will be explained and fixed in the following commit,
the MIDX is updated, but the .rev file is not, causing the .bitmap file
to be read incorrectly. Specifically, the .bitmap file will contain
correct data, but the auxiliary object order in the .rev file is stale,
causing readers to get confused by reading the new bitmaps using the old
object order.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5326-multi-pack-bitmaps.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index e187f90f29..0ca2868b0b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -395,4 +395,35 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
 	)
 '
 
+test_expect_failure 'changing the preferred pack does not corrupt bitmaps' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+
+		git rev-list --objects --no-object-names HEAD^ >A.objects &&
+		git rev-list --objects --no-object-names HEAD^.. >B.objects &&
+
+		A=$(git pack-objects $objdir/pack/pack <A.objects) &&
+		B=$(git pack-objects $objdir/pack/pack <B.objects) &&
+
+		cat >indexes <<-EOF &&
+		pack-$A.idx
+		pack-$B.idx
+		EOF
+
+		git multi-pack-index write --bitmap --stdin-packs \
+			--preferred-pack=pack-$A.pack <indexes &&
+		git rev-list --test-bitmap A &&
+
+		git multi-pack-index write --bitmap --stdin-packs \
+			--preferred-pack=pack-$B.pack <indexes &&
+		git rev-list --test-bitmap A
+	)
+'
+
 test_done
-- 
2.34.1.25.gb3157a20e6

