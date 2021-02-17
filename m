Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F298C4332D
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405DF64E4B
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbhBQToH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhBQTnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:43:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6CC061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n13so17742104ejx.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0Y5376mYDkm0kfh0PTB6AfYnPRC65zjm/zdaq1SuyY=;
        b=bGFAlTuSd+wRduBi6ahwKpgAtp5yPKuaji6dOdxlRGzQKWHe/695kvuS/md6fzBuRa
         WTkRgWpdzjn+5xTHJhPypa2efoRa+TtW1bKokNN7E7O/4E8iwjpaMBTv2g0UHE9TLgak
         BzQqKsMDqw3sA/g3iovPp4gLEuoWevMn602AtNKWFCK2qtYuE9G+lXXwV2pEOzLVvnRT
         M2tuzLl2fICOFP2VSHSzY90R11qxpa83+3xysR6/tRl7buaGk+lckfaKkYuHnm2l+cqc
         Hgk+t03BZWWUEETwQkn3dITnQk0sgpIqyklMLSv4AhD1yEN7ONATxa6gI6KMNt2h2yY8
         puyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0Y5376mYDkm0kfh0PTB6AfYnPRC65zjm/zdaq1SuyY=;
        b=UOtGNLjNlRqfAIWyndlEgxyc5EXdjuWDK15yduhrd08mqmW4M3RIjeQjF/GCMU0GoI
         1DskyRmyz9Pu8LOTZesWOQ4PBVJFvKOA2ZP28qfcPK9zhyxwVWDivpkGqvsqlTGmkJNE
         MjSXTzf8xE3fOko5qHobnJ+UmjTUwhu4pizNXj3Q7iaaVfB3P6+wo/+K1hBoko4Nrvgt
         XVP8suZhbQOLgkkDMRVo8x7g2sO148HtGtAua7FfdhhG6PvieqbGK3ZHnfFEPmxR8s1+
         ByR3reT2kKD1GTG6KwzvO9ULUk0RIsFSR6alZrfXpw83xcF/tZmnijxRrka2szVLNh0M
         8oeA==
X-Gm-Message-State: AOAM5313MXbiS7MysUjlKQd1SU2arUF+QnFWD6khh5QdFNgZS61RsMe/
        Eh+IQ/L/GUoTFxM/9CVKykVmsRoUfRgRag==
X-Google-Smtp-Source: ABdhPJzlFwDT2e7V1aqPl+83JVpDzli1Rx3mSME98goRkdPcf8nkrU/Uy3UZOfqeviRbJjbt8Ks/9A==
X-Received: by 2002:a17:906:3a13:: with SMTP id z19mr518458eje.317.1613590984081;
        Wed, 17 Feb 2021 11:43:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/14] fsck.h: indent arguments to of fsck_set_msg_type
Date:   Wed, 17 Feb 2021 20:42:33 +0100
Message-Id: <20210217194246.25342-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 423c467feb7..df0b64a2163 100644
--- a/fsck.h
+++ b/fsck.h
@@ -11,7 +11,7 @@ struct fsck_options;
 struct object;
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type);
+		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
-- 
2.30.0.284.gd98b1dd5eaa7

