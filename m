Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072A2C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83E823A7D
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbhAHSVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAHSVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:21:01 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1618C0612FE
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:15 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id et9so4703810qvb.10
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C4E7i9lQf/Y1JGFO8SDD0QiIPuB2ZBV9sZCrcfvUxxM=;
        b=NfFBwB4O6/okA/QVKccIih1zdBgf5OuCwJpS4DnRGqHetoElkwPd6Pueq5y6Mry1wh
         hDuE1ODXluL0q7L3fFXrgUYy48pMPFfOaVe2KPMlmOZIapd1/IpMcqNrQeRk0dH3BoQ4
         irOspkHgxW9XplWcwmF/ZpL1W+Bwvq1l5hY8nQkOLvNyFE4+FV7I94Zpzb32bzdd8CzR
         ks/gbKDvHTa/65+rwX33S6L6LbeAbrRE6DR1r0eyp94/sLEp3IYuxG/rMQ0JbfKy8aW1
         kgmJSI4RiEj6FvmcFktCMkuqga6/HcZrB3WBqvvVfCBwV8IkQFsm8jFhd+ogMM8wI3/W
         pXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4E7i9lQf/Y1JGFO8SDD0QiIPuB2ZBV9sZCrcfvUxxM=;
        b=EbcSNge/fEcL2CB8i0WYNUupZIzoUxUUGYGClHPMPb0wwbj6lWNkNxnqZsZ9cfvWUA
         ziRU1KRcbBzVeJVuNyUfmmm4jpyWW3wxlcdE36eVyt3Zj8tgHw2idRci2XQbbSRvfvhd
         g4zKcqJAJfpgB1yOXdUJVxPXzJ0GipH+Wf0rqlCSKm1onElR6UfOJlNXDuOWpUsN0RPO
         ExqjL0o/9ZnOwGDEtgzIuNqkyry1N8tBNQ9hDWxF0jGvY5vCO1KEWCQSSp/2Wi76i4FP
         2sUzWGRVOAg8KBbfIHhaS1UiVx2m2pjR73fFIW5jOAQ/ywOHW6WFYKSotrVVYqZxmRAC
         EYcA==
X-Gm-Message-State: AOAM533CfrNElKzZdtMB5G6HT4Ea+289KkT2Z1MxtQYTerNsKMndwKUB
        BBwjpw3Y4u0PQPo46iXWi9LBSRxdkU2ZZQ==
X-Google-Smtp-Source: ABdhPJzIghdJQZ08PANbjK6xljVkUD/kHRwwjd0s15ReJNp5bB85gD/ZDdSGZRQtl+CfOzABhaM9Zw==
X-Received: by 2002:ad4:4643:: with SMTP id y3mr4816619qvv.3.1610130014279;
        Fri, 08 Jan 2021 10:20:14 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id p75sm5290221qka.72.2021.01.08.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:13 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 4/8] builtin/pack-objects.c: respect 'pack.writeReverseIndex'
Message-ID: <e297a31875a1135ba17743aa57c24e2991bf8148.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
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
index a193cdaf2f..80adce154a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2951,6 +2951,13 @@ static int git_pack_config(const char *k, const char *v, void *cb)
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
index f9afa698dc..431699ade2 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -66,4 +66,17 @@ test_expect_success 'index-pack infers reverse index name with -o' '
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

