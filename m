Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB03C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379209AbhK2Sa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349561AbhK2S24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:28:56 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD30EC12B682
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:50:58 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so17087551wme.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fX+7pmfF68GwvUTjKJDJWQ96e4EK5Lr4vLKPVgjr938=;
        b=oJnD0kaUco3NAgkIvoU3hlsJoiKoVPeQlAzlXFjcGcpXue5W+YPi+GfhIYHEdax5yX
         1Kd5UZ4nNa6+6TpVBUqs/L7hLBioiTA8R1vkS0b0JXewYra2x8F6RHDG/oAeZkjNfGES
         MLSc/OOizPknJCVSDuPd1W06jegFhMnQUK4ygfeQvr30wrys8GtzYM9L/o3jK/NCB/1d
         z5RqYVHThG49HBJnf5vPQ6upPn+293TWZlEZJiBrbnxquKhFTxKxPzVnYLkn4NLTuPZh
         eO4h/vnxajDQ+vBRtGDzY1G/LaTFRRnuxgUuPJz9WTmSJWiQbCbgZtv3SZKDCCxvGe90
         7qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fX+7pmfF68GwvUTjKJDJWQ96e4EK5Lr4vLKPVgjr938=;
        b=txTVVpiREY7qR6uy/bsam7BcEhz4PBQhK6iydEdGHSvtkfCfDXni4fSlX55ACxHQDR
         hJkdKBcKe9SeCK6d2YcS60hwJEzMzSAAGYMSc0HTQ9nzPEfBgP7ppLjTm0EwLxV3i7Cy
         9GIc0zlmDDUXdvLAQ5LqajLHIGK8vw5h0g0EpR4quaYY8vTKTnUZyH50W6rlJzlDKmVK
         qhICkzc9f6pEvz05eT3RcM3Rw/Of6FWVQMn058T1ZcE+kp4xNJxf0din6U/QYoR61tSu
         5e/K8iFlr4U1Q25fJXJZJ1BFHEWD3nXkggxxwyueuZZucpHzoZKembL3HGC+Vjwm+NNo
         +paQ==
X-Gm-Message-State: AOAM531FE0b/QbRR9ryVSkRCYlDt5TVK+fvEsLawnfUzV05xm0dkHTaW
        fBsETAPVqO4MRWA4zHuzej85qQu1+Zu3sg==
X-Google-Smtp-Source: ABdhPJzwELWAWUoBMmgBnNd6v8Nf7l4ovClIRzVi6LJrs6Sh/bDiEMkqlzZd8PNbuXb+OLrKmMCQ9A==
X-Received: by 2002:a05:600c:4e4a:: with SMTP id e10mr35487905wmq.176.1638197457263;
        Mon, 29 Nov 2021 06:50:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:50:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/7] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Mon, 29 Nov 2021 15:50:47 +0100
Message-Id: <patch-v3-1.7-71ff51cb3c9-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.1.841.gf15fb7e6f34

