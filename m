Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33158C4332D
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC5123602
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbhANCF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbhAMWao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:30:44 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73736C0617A2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l14so1572164qvh.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3JyToQNJRRcX0bUp7cyz8WZnPu5hTqqWdIFOgT0w0M=;
        b=c0XkOBJNXaWZrvFTV+QZ9QU8X/HDw3ABO5VL+IRuYr6Bp7Yo2Y8t6RM9beYOsbThhr
         WhPsyzEqkQ9CIZPjHPo9Ku/LwyMEMyuAJTGghmgYcMlNx05wyEDNUrAwzKh7VKeGGZe/
         J4oLmOyWRSZfO4w6yh5ibEB3+xLHPFtyfo21oM/ZNJ3jmUXIooNtyrSR7aMaR+MG6VKJ
         HMVzcHwnoqKvynbc45JOLp7jTIwst6hm0+cvB7/3tus5xhkcQpY5eEsoJEn28Tsc7pqZ
         iSD9BumZDFh0ZQ+cM/buhiL6fJmw4xg+uKTzMOeoPaqWaJ44add4nuIFmUJ6Rfc5l1xB
         w+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3JyToQNJRRcX0bUp7cyz8WZnPu5hTqqWdIFOgT0w0M=;
        b=UDNaPbjOv8Ri4Q0/pxsUEej5PXukbpxWQDR4H0zaIGPOBPO3pvdDAwz0Y7Ebamhk0s
         EScydoEN6/tUC5G96GNqLxDlpZ3dydeoOxk0qhh4dVt8WkZs17qn74N8rwiPBHnz1dyW
         Aw79udsALrxxycd1lnzdfiKK+9rE5Ci1KtfwvCAmV1ZmHVGzBL3HcSKNvY3aWgROY1/t
         E3sbfYdA6KyHufzeA4SUks5OdiKVNJqf9s/KA+uw2MukawGnPlm7cS+omdiUGhYtxN7W
         7DeYYoggBE/Pacu8RrOAfHJSf3LXgF0V5L/rQxb2EqIBS4LM/1WLV7rgBJlwVqxVImYq
         lBXA==
X-Gm-Message-State: AOAM530726w119rWiMX9Y+yKOlcy5evN3YufdvW06/bdi0dWSH5A3kzx
        z6bA+4TyrhpMIm5XLOp7aqVtzlhIFBMKJQ==
X-Google-Smtp-Source: ABdhPJx7ForC1aWbDfysAOppX5ByeRsA1FFGYEwdd30tXCmuEBJjGXoNFy/XxuyWKtBcYMPrlPT6uQ==
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr4513597qvb.28.1610576902498;
        Wed, 13 Jan 2021 14:28:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id m13sm1822787qtu.93.2021.01.13.14.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:21 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 4/8] builtin/pack-objects.c: respect
 'pack.writeReverseIndex'
Message-ID: <68bde3ea972f5b3753d7e9063d0490c67c74709b.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576805.git.me@ttaylorr.com>
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

