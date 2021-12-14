Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A4BC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhLNBzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbhLNBzb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:31 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D5C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:30 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t83so15614335qke.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xtMowjcH9kIdYnLdb2LZFMrjUkwJVwMgrlKKUGywxo4=;
        b=PADQrfQoa+1+9IP738e0xBN43JOW51CDciMFik14pdH9bjtFCSu0J5WQ8m4sZ6sp36
         ooCujeR17JKsAvU2IcIcUqlIRy9Q0nCVHEcNIEeAnC2uzLpM7amkFXEWK5931Z+dSZI9
         2CljjV/Y4LapbKTnnN7KQtRIhwgJjC4qy/cBQx4SMTvEsRy9Sq/EHRGkIeddqOzg8T9w
         D58EBLHEs1Gw6+qmFxtL0Q58Db0gYL/AGU34oZmFSD6WwjriHKDVkEvtGsYWaCNk4iJt
         PbozmAbkf7jmUAmWyArQGv6snOKYqXECp5UM5B0FEv+LzyJBYNcAuCZrCyHoBIBni6Of
         AVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xtMowjcH9kIdYnLdb2LZFMrjUkwJVwMgrlKKUGywxo4=;
        b=z5DWQ1pxes5JHoP4BJxiUouPjjx5AdygsR5eLUwaGewbLy4o0T6hOjXD44bpAhfLld
         25UALYJ0MjV7uz4b6wT+sAvjgEqEKGjErVSoQMC/QUzLz/PwjZOZIS0FaKbjCxbv+oOd
         HAIYy54kOYt0jxVo7Erps5mTXju8W7gWT7ALDUgdjqgwlCBK/AKEkoUEjsIKZvqoZNeu
         f0Ao7rwzeufv4Kjs/G+Gr4Vwb9o3rQksUgMQttAAsRbwEOSj0jkmF+/6pKNLUx4VksHi
         rwPI4xPgQkrpxY2kU/85QoToJ2fHVf83S/ECJZwNZNDH2IQjoNgdnb/3n/m4lph/7Hvk
         /P5A==
X-Gm-Message-State: AOAM533VwvSAXh3nme0DougIcLSxIQulwza57DYpcqAgzdDtQcUtTOjG
        JZyOHtvRwy1I4V8g7MqjL8ciVYpY6cfp16BC
X-Google-Smtp-Source: ABdhPJwb5BGXVD+oTjyefSmmwSHxEu969Tu4pF10nVHh/Q0OJZ93WBmq93eGIAEkF/acg+OztmxAQw==
X-Received: by 2002:a05:620a:4452:: with SMTP id w18mr1743525qkp.625.1639446929801;
        Mon, 13 Dec 2021 17:55:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t11sm10893035qtx.48.2021.12.13.17.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:29 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 1/8] t5326: demonstrate bitmap corruption after permutation
Message-ID: <dfbac4bc608a3a7366a57ccaca5273cbc93045d6.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
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

