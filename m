Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96408C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiAYWlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiAYWlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:03 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A1C061744
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s18so9011377ioa.12
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RgbdycumHqWnnl9hAccesVciZWCuvbgdTKIe5MwvKgc=;
        b=i/SHJzynpK4ftCWIMfvFAoIyau7lDNkX3EdWGCFT4Y4Yb4VEybH9NvKe28iEk4mt1B
         CC9a/YPIzFG3VTm0KBKCdUd0u+Fr/flofo6Wmfif2OzwrhHYGAB9hHdB/lYmweRqXHOP
         mENw+v2zMCDl+46ThqzuQLUIycpS6EGy1yMQ1Tjs32PMsnBSbG+zXdQkdl4gnLhNWZra
         fYpdWxyj0QfZh9aGfZfuWvKzFKB0htiKTaq4g6GGLxOtBx7OFYhGxNZzIr5pncZTmMhB
         AD8fSMeVGaZ9K3XBNSDq8FDFsKTr7RDVo20EvZXJY3qINVDhgqUoj3k4TZynhlPL/AnA
         g+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RgbdycumHqWnnl9hAccesVciZWCuvbgdTKIe5MwvKgc=;
        b=z1M5YLDLNDNHGXe6k+d6r6IQNv6xwmO9mfzTnlQCTFwU4KwaCYSUtDtvhO4hOzSRvQ
         J47CXPu2LoJ4Nl/0onIVwrqpfn7YEvNVcRqF5l0EGhi3mMBuWxiaWMSFHIRkrAFvr3tQ
         B8CrVMydrPyTdoKmSRM9cEoi6dd8BTOwweQKfRZxNiSef4dgQSsK+UGXfN1KxiPMcNes
         062l1cXQxzXBEV9w9Lmi2HYZCp4QYQAhUCq5tzO8kX/wBuIWt/27tbIh91CyCayh2Slb
         7IwdJNSrsCl6s+UWDDv61cw60MbXZHcG7SpnH8VjtyNYAr7uW4XlYFNHfEDJsjDKIPDi
         qB0Q==
X-Gm-Message-State: AOAM530l1QwgH1mq0g7PchVOoOvKs2FZoBA/+XRYpxgAG6OpnoBEjBFM
        0Tof8x7HBGfVOM5X8i5jbuKSGDZVPNM7iQ==
X-Google-Smtp-Source: ABdhPJxHg5R0xgg4yNUUhpTMAHgKqklTSaJvyhnCh0IYBlNhNhguTLM4rGfqs6JVPyCa2KzT/a/nAw==
X-Received: by 2002:a05:6638:381e:: with SMTP id i30mr6085773jav.289.1643150461926;
        Tue, 25 Jan 2022 14:41:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p11sm9528239iov.38.2022.01.25.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:01 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 1/9] t5326: demonstrate bitmap corruption after permutation
Message-ID: <7ea9cced8ec79a8e39948a5e4b8dde6e9b54695a.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
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
2.34.1.455.gd6eb6fd089

