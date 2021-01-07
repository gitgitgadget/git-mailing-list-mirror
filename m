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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBDFC43381
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34820233FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbhAGQc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbhAGQc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:32:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F5C0612F9
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y23so6081623wmi.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F5mr/fFvRdXYRRCHVaEtFFWbeGwbu/OPMWpaJOKG0T0=;
        b=JD2s5A4wYI9V+u/X2B/z+iP66px6YaegPv6JrpqoVNY9i02PfjcUaU20VrlnT7akme
         PU4LjyqRNcBvEXq6bFVq2x0GN165+ano0eEMynTqlfY4Eh7KaY0fSvEP1k7TJMpq51UX
         DlbJ+qKfv3xRF54mu9gujVoqUN2ptKvEqYRNJOkv0keBVjQa2+JbrtePhjmOROxbdGk2
         8xqcAJCWEfxKX+DDuFasFcr+Jfac+ThRqo937mBtv+779n9t+Rl7fUQchzzEInKlMPzJ
         VQ5g1Ad/cptovBIVZQ+XcLcwkPLDXaf3esUzYhEgzNokmKgwa95EJGzJv3c0TdAua2He
         GVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F5mr/fFvRdXYRRCHVaEtFFWbeGwbu/OPMWpaJOKG0T0=;
        b=IXvUthSR2BCSVXfTD2pWsHB5qdvhccJlNM2i0xfB/vLb96DFBBgtADO7XMD1bz7L6E
         xduZEtzJM7oYyYUhNu/RVcEa+lV13gF/vl3AbSrc0qrALRQ3JCs0elJ9DI8D9N6ma92N
         lecsEybAtrBd08KQFvnspnz46IU2S+84ptWy96kQAYq4vNNRQ+oQ50zgJ+hTt7JCjHLF
         +sH5Kd+9O6L+xUQY5+LXZ+QKN00XuySjlUxJkPq17BPDNMrVYZnTScvmAgPp0ehPFvW4
         dFsStr+ElQZLGaXZ2n7CrNKA5ZwgU3Mh3e9owvEGfHXSS8p7UErlhe334KJqaFkmH+tz
         F7vA==
X-Gm-Message-State: AOAM532TF6UpYj2+FgeQHFFoTQryFh4TMh7++Y8tvuXXwHIJ+f1Vc9h5
        pHxfmPtk3Qp/kfaSrrXH90BN72eRbGI=
X-Google-Smtp-Source: ABdhPJy1DN/25RzGuRfnnfyLx5fGgPmlajqZkch6OhFx6EIrZWJJZRM5qr19u6pkAnEO/ou96nxGHw==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr8856493wmg.135.1610037137257;
        Thu, 07 Jan 2021 08:32:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm8710592wmd.6.2021.01.07.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:16 -0800 (PST)
Message-Id: <1d8a797ee2650e8c815281b0c672301c7f24a724.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:05 +0000
Subject: [PATCH v3 04/10] cache-tree: trace regions for I/O
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we write or read the cached tree index extension, it can be good to
isolate how much of the file I/O time is spent constructing this
in-memory tree from the existing index or writing it out again to the
new index file. Use trace2 regions to indicate that we are spending time
on this operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9efb6748662..45fb57b17f3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -494,7 +494,9 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 
 void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 {
+	trace2_region_enter("cache_tree", "write", the_repository);
 	write_one(sb, root, "", 0);
+	trace2_region_leave("cache_tree", "write", the_repository);
 }
 
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
@@ -583,9 +585,16 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
 {
+	struct cache_tree *result;
+
 	if (buffer[0])
 		return NULL; /* not the whole tree */
-	return read_one(&buffer, &size);
+
+	trace2_region_enter("cache_tree", "read", the_repository);
+	result = read_one(&buffer, &size);
+	trace2_region_leave("cache_tree", "read", the_repository);
+
+	return result;
 }
 
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
-- 
gitgitgadget

