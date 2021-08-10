Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8AC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 06:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FB560E97
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 06:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhHJGQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhHJGQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 02:16:42 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4AFC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 23:16:20 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e1so8070848qvs.13
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M8Y8Ty6aqzP6atPzXFHRIUW0KrYEAAZMQwNUpt07EKw=;
        b=YQoBlyEVwMfLyrkM8quHgM1iaaXKDZhAykGnZ5r2mC8xfrUWslrqL6v49XnQG2ynM6
         c1OzgyC5BhSsXwePh8i6yRkh8JY7mZAE9bc+ziX4bG++1PDb9I4ruE1xI7WjrG3u1l1b
         orTFV4aEWuK6fJoFVFTaCbzwtq45QFnSp2JwDEcPEUC5nqAk8Bn898tRX7gcmZuG8h6Z
         2P2ZwKCubkme0/OlwAcpkoDMnqeA6AY5RF3YAACALEzsfJ53AE+WNQIyuWXGFRtSDVzf
         qmG2jAbeoYHw2r066Tu0svkiiLwmq7cM34JDFCGuKQspzmfgqqIRRg8YwJi+6qMWfp4G
         uXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M8Y8Ty6aqzP6atPzXFHRIUW0KrYEAAZMQwNUpt07EKw=;
        b=mB9+WcxuNlHkJwtwadwVlKgQINrsKPh5jkRhOImtH+xJ09lmmKAhmgGeUP2cHU0FB2
         RvgnKpGatcqG7JpUqjTSSFq/+QcGQXDwfa8zTZWEAHjmrQ98qMMchYQkm+pc0lYhdFHD
         pOgGDXV0DIcolwiwuo6kCue0tKxJ6ursTMthtXt6dqT7OqW4w9WcFye+XH99Uyg7Zy6D
         l2TzmxlmfCqBj/qOpq2meCeT0qAwkyCVxjWud8i4iRvAzj78LKHscCtmSCiRu47ZygpG
         YzXzw1Wm0EVZay3De5m3fjEKEwqTlr5KG5vqjzYW1oEi0aNC8JWAr6rWjMUs6cAJ7TYm
         +GGA==
X-Gm-Message-State: AOAM530Yyoj81c4KO7WesvAfm/ZhgLAztgT7TvO3l7aZb5p9eFCQg+FC
        7ximLZS+YWTJCTFfAIwPV8A=
X-Google-Smtp-Source: ABdhPJzCug9vSWsfa/4YXJItzN95xFvUDcdzIkkGWUR0U2GpkjuqRBapfj3zmD1/1EN6Uj1SkSlHZA==
X-Received: by 2002:a0c:e7cd:: with SMTP id c13mr352831qvo.37.1628576179854;
        Mon, 09 Aug 2021 23:16:19 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j5sm10592631qki.80.2021.08.09.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:16:19 -0700 (PDT)
Date:   Mon, 9 Aug 2021 23:16:16 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, e@80x24.org, l.s.r@web.de
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
Message-ID: <YRIZsOaguDW0HaeI@carlos-mbp.lan>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <xmqqtujyftzx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtujyftzx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks,

in the discussion above René[1] proposed a fix for UBsan issues that were
reported and that it is still missing.

my version of it didn't require the extra 4 bytes or showed issues with
notes so is probably incomplete and should be replaced from the original
if possible, but follows below:

Carlo

[1] https://lore.kernel.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de/

+CC René for advise 
--- >8 ---
Date: Sun, 8 Aug 2021 20:45:56 -0700
Subject: [PATCH] build: fixes for SANITIZE=undefined (WIP)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mostly from instructions/code provided by René in :

  https://lore.kernel.org/git/20210807224957.GA5068@dcvr/

tested with Xcode in macOS 11.5.1 (x86_64)
---
 hash.h        | 2 +-
 object-file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hash.h b/hash.h
index 27a180248f..3127ba1ef8 100644
--- a/hash.h
+++ b/hash.h
@@ -115,7 +115,7 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *s
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;
+	uint8_t algo;
 };
 
 /* A suitably aligned type for stack allocations of hash contexts. */
diff --git a/object-file.c b/object-file.c
index 374f3c26bf..2fa282a9b4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2406,7 +2406,7 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 	struct strbuf buf = STRBUF_INIT;
 	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
-	size_t mask = 1 << (subdir_nr % word_bits);
+	size_t mask = 1U << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-- 
2.33.0.rc1.379.g2890ef5eb6

