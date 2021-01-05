Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DFC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6671D22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbhAEToN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbhAEToJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF3C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c124so583041wma.5
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TE/H6ocKosx2Jp2qItIeJhggW3gbgKvO2QtcAZMksw0=;
        b=sTR6KONyUTZuW205gtlbinmr31e3YujpjR5c2z7lA8ZkhIYrbdPRf2rupZqNjR0ChY
         /hw1anoaNF64JfniGvkVIxQKqO4SIZQ4ye3gyy3jimvuloRZn+J5nh8RuEIFIk9nTrlN
         +A4YEvij9dW40tjarWYBDvOL+wttVFHvu2VJd4N+JgBZC/wrjKyUL0W9NzjdMFXTqUE5
         0jGCpj49tLK/IIpJSuMeMHebq1TO6430PSK7grih0+7wMEXRv1zdCULGOToC8xwKp88J
         YqDGLSWM5ItOXci7vXyo/562BT8NIS+p1WhGNrcR3hLf1a3VWjJZeO5PVry3NWgvKP3S
         FLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TE/H6ocKosx2Jp2qItIeJhggW3gbgKvO2QtcAZMksw0=;
        b=Pmds81cr05NEjrCHMQsX3zSUYAQsqkc8Ba9MqSH8wKabgR9K4R07ptVx3N8GIJANmE
         +uZDdpkS41o3le4vpb+P5qhrfIYVNQPcZa+31zrN0vtvpwd4B0arJIMRXZmvLaXL/lxX
         7fdqx1U4qWSSnQ6H+2vmbB3yaToRml7PJXDe1Tv88ApZff95XOqZtlPrC8OcjjRZfyEs
         n61ZMKIfatq9Qd9e4smHPwCHefqzMPCynIcLdEiyOi4b6PZE6WcBw+4MxDH7Pm4btwkE
         ZkZc/awdFrbPtWP4tehfL3aBg6KlK4bqIReOBLKpCndDdChLM8rk5SBgkx9uzxNOOMeG
         50nw==
X-Gm-Message-State: AOAM530k6SNZldTuUILNTQl5/LJoOM7ixjgcMjI91a4MG+JO9R74Sb0F
        gfZn9bPFXnz9hu/GdFl/ixUXWBElJvkIfw==
X-Google-Smtp-Source: ABdhPJxFszPTBl9QUuVnYhjHZZ7h5RH9DtqXNy8hykdtKZrSA5J6s1nEyL1Qy3PVbCIHJasBMxRqsQ==
X-Received: by 2002:a1c:6205:: with SMTP id w5mr661583wmb.26.1609875807833;
        Tue, 05 Jan 2021 11:43:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/23] mktag doc: say <hash> not <sha1>
Date:   Tue,  5 Jan 2021 20:42:30 +0100
Message-Id: <20210105194252.627-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "mktag" documentation to refer to the input hash as just
"hash", not "sha1". This command has supported SHA-256 for a while
now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index fa6a7561236..a158428eb9f 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -23,7 +23,7 @@ Tag Format
 A tag signature file, to be fed to this command's standard input,
 has a very simple fixed format: four lines of
 
-  object <sha1>
+  object <hash>
   type <typename>
   tag <tagname>
   tagger <tagger>
-- 
2.29.2.222.g5d2a92d10f8

