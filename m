Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2672C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712A9207B7
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbhAYXmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732933AbhAYXjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:39:10 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8512C0617AA
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:54 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id a7so7490058qkb.13
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8yImmY2Z96Av4YSFbGMs3JZi69az+jUCKJcfKv9Q4NQ=;
        b=NHnePevhtMMp7LD+Suw0ZYH/7gTrCGgCDEVsSEotYNblnZfYpHxECU+AXhRpbhyY2a
         Q94Hm8iRRBtlrKBsCG0s7km6/Mo/2N6N7sy6n6C906Ix2UVMH1Vq2JidgURPf+KMJbv8
         In/nj8WiyF7Uri4tLbHKgmazWeOAF52vDY/yI7eX5WTDU8qCgdSIDs8dsA8+4B8XaljE
         1Q6H3i4uetRyxAQ1XAaLmX8FDknltxfQ7PWCNqXolIfhmDwMocsSWmQuHiMXIZkTXDzf
         9rp12TSuzDWwhU1UOAvVRndJEZAILJ3TBKupBzmVOHymYsiOhHYe0Vdun1XbeM9/1MBH
         EKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yImmY2Z96Av4YSFbGMs3JZi69az+jUCKJcfKv9Q4NQ=;
        b=h3534UkzF85tvZ4WX9INN8zASzdmUFPMVIvA+UFXPBGNG6PE1v12moW14UXELyuhaT
         qvqlhEAHcUVJHiRibFDQEsWTFUFCYKsAnhBHru9bpV3pwHk+jTBCJL6Z+lWBz2Kcvvks
         5KuypEF6GjDhPLZ/YX74SRcegXMiOiOwDsIRPqr6/EXGs4s6CqDX8V3/ol0GBP8bwLlT
         hhoy1T7q6tzMVjTH/qPMRGQUW1psFpMbByO+hAk67ZUBiPPcGTRgxsWj5AkVYAOZ2MBH
         yklMWnJpP0J0rI1fzLQiM8SV5s7vGbm9ERE9j9pSm1a2Kq8Xbmj9iDFZodjYh1Y21LSd
         PuVg==
X-Gm-Message-State: AOAM5331dWGQS3vDI5AUHwQyb7pecvY3PoK+wtMPdDhWpdMrwALeWC8u
        e0MG6IEnFnL8PvjyAeBA7ek7lBk5Sqpu0Q==
X-Google-Smtp-Source: ABdhPJxeJRWZOIvET2aSvKw8tdJgL9vjUToqSBX7o9u0MaHsANjRZQJfMBae2VpT0RuAdOVVrKxoNw==
X-Received: by 2002:a05:620a:12fa:: with SMTP id f26mr3224717qkl.327.1611617873777;
        Mon, 25 Jan 2021 15:37:53 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id k5sm12891137qtb.49.2021.01.25.15.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:53 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 10/10] t5325: check both on-disk and in-memory reverse
 index
Message-ID: <38c8afabf25a7f5e144850938cf00b53e9cf25fd.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now, the test suite can be run with 'GIT_TEST_WRITE_REV_INDEX=1'
in the environment, which causes all operations which write a pack to
also write a .rev file.

To prepare for when that eventually becomes the default, we should
continue to test the in-memory reverse index, too, in order to avoid
losing existing coverage. Unfortuantely, explicit existing coverage is
rather sparse, so only a basic test is added.

The new test is parameterized over whether or not the .rev file should
be written, and is run in both modes by t5325 (without having to touch
GIT_TEST_WRITE_REV_INDEX).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5325-reverse-index.sh | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index a344b18d7e..b1dd726d0e 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -94,4 +94,49 @@ test_expect_success 'reverse index is not generated when available on disk' '
 		--batch-check="%(objectsize:disk)" <tip
 '
 
+revindex_tests () {
+	on_disk="$1"
+
+	test_expect_success "setup revindex tests (on_disk=$on_disk)" "
+		test_oid_cache <<-EOF &&
+		disklen sha1:47
+		disklen sha256:59
+		EOF
+
+		git init repo &&
+		(
+			cd repo &&
+
+			if test ztrue = \"z$on_disk\"
+			then
+				git config pack.writeReverseIndex true
+			fi &&
+
+			test_commit commit &&
+			git repack -ad
+		)
+
+	"
+
+	test_expect_success "check objectsize:disk (on_disk=$on_disk)" '
+		(
+			cd repo &&
+			git rev-parse HEAD^{tree} >tree &&
+			git cat-file --batch-check="%(objectsize:disk)" <tree >actual &&
+
+			git cat-file -p HEAD^{tree} &&
+
+			printf "%s\n" "$(test_oid disklen)" >expect &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "cleanup revindex tests (on_disk=$on_disk)" '
+		rm -fr repo
+	'
+}
+
+revindex_tests "true"
+revindex_tests "false"
+
 test_done
-- 
2.30.0.138.g6d7191ea01
