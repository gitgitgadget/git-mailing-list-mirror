Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F1C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2652F20708
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbhAYXjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732898AbhAYXii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:38:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5226C061788
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:33 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id j13so1735075qvu.10
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3JyToQNJRRcX0bUp7cyz8WZnPu5hTqqWdIFOgT0w0M=;
        b=UIgwCvvDgTAG1mkL4U40pJPsA1X5QNMYztdlZomClikFFoTLt2df6+5q6ork9j69hH
         c44866hGjw/27AEpigu5YQvS/jq1FDagdiEJlBO1/zufhLpxwT8eLBQJFV9UZpiMqQmJ
         B5/i/QrdJGFzpra+XLbYX4WBRgmjyGFsEWfoA7augQnKZYcMiVlAUpqxJzjv2+XKnv8M
         rRhmwQAz0df8fG+HkZmt44JzfgIRxD6Rm2Arhps/wXJZ0y20VlsUJx8a7pLA6oi+5RDd
         QhmyQvtcqADLih/ZQ4a9dn70Mckq/XFjuatVeUDXfrIpQezPnobXxAS+yuIvUAGas56U
         cvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3JyToQNJRRcX0bUp7cyz8WZnPu5hTqqWdIFOgT0w0M=;
        b=cWT9+Wmxqtp5yPp77iDrFv0PXzw+LmSPZLn72dh/RALp6AK8p4ozofsW4oghn52bqo
         mMWZi0yMsl5cawdJcwGfMJN2lYeTs7tlGRhRlwhUY2fUCNu1g3IyDtR7pscls1wpaZo4
         cEHf6ThnvfKXgsS3rOOTM90k8qB64YlkKrM65sTLxA1TFB2A0jv+s2Y78lcP1lHKWJCy
         krfbVpHTwhlCd2S5hl1WCOLQlLAXZDw+wCMplp2IyRqoUlY2cTn7A76Od8aNkvd7xTdj
         3FYu1HbBqaBHBwAEGQ5wnF4ddoJ/dCd8DmtBjN0dEwDfLobJ309BJ0ZMqi3u2aRVWj3R
         9JzQ==
X-Gm-Message-State: AOAM530ZCVM96Oi/syYXiIe1o8/4zIVd2BKRRULyiMokTB2cZOVesI7i
        zd6t2SuwOXczIEN94vmXNaNNYK6GY1nbYg==
X-Google-Smtp-Source: ABdhPJxI7Suhsc7fYKIeN0xYhoSY59WhRqLpdqa8DnTy9KSPsMEZkPVxfCbtTAz/lFAm8nu5omqZXA==
X-Received: by 2002:a0c:fd47:: with SMTP id j7mr3135223qvs.22.1611617852705;
        Mon, 25 Jan 2021 15:37:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id p128sm12891892qkb.101.2021.01.25.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:32 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 05/10] builtin/pack-objects.c: respect
 'pack.writeReverseIndex'
Message-ID: <5bebe05a166bbebbf29347dea377ce0c8d15c344.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have an implementation that can write the new reverse index
format, enable writing a .rev file in 'git pack-objects' by consulting
the pack.writeReverseIndex configuration variable.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c   |  7 +++++++
 t/t5325-reverse-index.sh | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5b0c4489e2..d784569200 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2955,6 +2955,13 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 			    pack_idx_opts.version);
 		return 0;
 	}
+	if (!strcmp(k, "pack.writereverseindex")) {
+		if (git_config_bool(k, v))
+			pack_idx_opts.flags |= WRITE_REV;
+		else
+			pack_idx_opts.flags &= ~WRITE_REV;
+		return 0;
+	}
 	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
 		struct configured_exclusion *ex = xmalloc(sizeof(*ex));
 		const char *oid_end, *pack_end;
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 2dae213126..87040263b7 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -68,4 +68,17 @@ test_expect_success 'index-pack infers reverse index name with -o' '
 	test_path_is_file other.rev
 '
 
+test_expect_success 'pack-objects respects pack.writeReverseIndex' '
+	test_when_finished "rm -fr pack-1-*" &&
+
+	git -c pack.writeReverseIndex= pack-objects --all pack-1 &&
+	test_path_is_missing pack-1-*.rev &&
+
+	git -c pack.writeReverseIndex=false pack-objects --all pack-1 &&
+	test_path_is_missing pack-1-*.rev &&
+
+	git -c pack.writeReverseIndex=true pack-objects --all pack-1 &&
+	test_path_is_file pack-1-*.rev
+'
+
 test_done
-- 
2.30.0.138.g6d7191ea01

