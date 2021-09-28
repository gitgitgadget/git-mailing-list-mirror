Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665EDC4332F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F76F61139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbhI1NQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbhI1NQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B13C061604
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t18so58045904wrb.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mlWwAd9DdLnQL5m8pL8Kr/zuypj9LecLwbSXk/gHB0=;
        b=Ze/7XgJiBuNMTuZqIzc/y9nDo3dkwEqdh4Jx9y0ER0iH9nzSDM79LHcx16BPU6LiIF
         lVFAT0ijTLvJks2oJIPpJuBOIuuVhKEax7A+flES1BgqD11XDLg7w+BZlHseyBzbYS1C
         rD0lAoLf5HdyLmBnOvaqBa0vNF+r4HlVmZfRmF5aesHBzH3YOPRQlw27MZDWztHkIc2G
         n9gYcsGUVp/79BcmHvSIcf28zDh/WGsZK1fws0EUgcB/OqT676aduCy/vlYau3TiSM0d
         GyJV1DvdrKVM4ST8PlXL9mIOzyo/onW7Eu0wl13lzPxyXPDPHxEFYS2gPtXipmTJjfjp
         HSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mlWwAd9DdLnQL5m8pL8Kr/zuypj9LecLwbSXk/gHB0=;
        b=Yp90INgB9pf1bBuUP7e/MDnSVnr6qFgAtTkT3Mn5IIGUXOI3FtAkTWO6MgrgX+aKmq
         ZK+J4myCJOO25zwlCGeH681AdmnVuhP5ojynZEEQ4fC/OSZAOerajdmOShEAeNgVLekg
         LlDhTdmYtrjY967K4YxFRxiZ2wxmpTsPgpb1QR4KYrs0TdkHDnWlB12wNJU0nLqdMQ1P
         a84DME0FRLalygFJfIZaclAsG8jFYAeJJVX/C5I6Pd7OKTwry76gKetunkvfTV/PYVF8
         erxDaJ4Q2nQB7KwsLmgteulheuWlRDNSBZ1MjPKR7NNCpYtSokx954RQNr4ju8YglcJn
         Aw0g==
X-Gm-Message-State: AOAM532khZImhsqCkizi0GlAOlicEEVoy7hV9191IKVt0Zp1xbgl9eDi
        4H5rCn+ryI9HNmYc18urWBbZ6pHNDF0fFw==
X-Google-Smtp-Source: ABdhPJymSEoV9husUV9cHbsQY75025aGmYUf54Sb1wsS3UAtfSkdJSIA+Xz8splF4sYhYkYJUpPtmg==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr1748374wrq.162.1632834880566;
        Tue, 28 Sep 2021 06:14:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] parse-options.h: make the "flags" in "struct option" an enum
Date:   Tue, 28 Sep 2021 15:14:26 +0200
Message-Id: <patch-05.10-697e432c012-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "flags" members of "struct option" to refer to their
corresponding "enum" defined earlier in the file.

The benefit of changing this to an enum isn't as great as with some
"enum parse_opt_type" as we'll always check this as a bitfield, so we
can't rely on the compiler checking "case" arms for us. But let's do
it for consistency with the rest of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index a1c7c86ad30..74b66ba6e93 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -134,7 +134,7 @@ struct option {
 	const char *argh;
 	const char *help;
 
-	int flags;
+	enum parse_opt_option_flags flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
 	parse_opt_ll_cb *ll_callback;
-- 
2.33.0.1340.ge9f77250f2b

