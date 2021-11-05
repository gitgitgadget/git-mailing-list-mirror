Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82228C433FE
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614DE611EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhKEOK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhKEOKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70CBC061208
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i5so13970543wrb.2
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRZm/at5iGOJf0oQhG1GWx8xFWrOZi/Q89gc/btS3rM=;
        b=BTNhsCKVT/X4kIx/lWuBtr4CscUTdZRyccYN2tKMgALOyax2kFu3w95ot6hBjuLLMh
         cwYLCDScK5Mt6ZfKNPowpH16GNdAHGk8o+R8McAkHFdAGRETVmTwhmfuvjaenmSKAMJh
         81qwH1tcQxySsj2mIA+iP/kxd5tqa4bYXg4Vab5yoHTRD0i5Ld/ev6d6dtM5udNKIf8v
         MMyKKbghFDBYlq0h7b19vLtMeyST0Iy+ZSolLTPACxa3YBTXKR+bqaDANbhtPpe9s0Ul
         z9U9WXUhpxLbFpNGdDesD4N5T4l+ADq3XH6kXEvu1lA4H2QqQg3rb4Tqfx48YN5uRrfk
         Y4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRZm/at5iGOJf0oQhG1GWx8xFWrOZi/Q89gc/btS3rM=;
        b=5d8xQelmyu056WMsDFJRgoP3kng1A9lRvdwFrKuDvcJVhijXRAuUny7gNuLVBKrH0M
         An/6uDEWnFgeLHpOcD8+fKoYZgGcHcbI4xfSevnw1oF0JaAUvlrE9hwbPiDQHwfVY2jZ
         YtXHf2PR3UpfBUToeoZ6JZ/ygSF/UozSn3I8iqC5jQenoZ6+kAggOjHbaKWC70LwOYe3
         7Vc5NRaIXlaKAgoKYsUrPyZMJ8cEqaVolzObQWVm+QsT4MmMdthLzxTcM8Bd1/1WSMAJ
         +oqMESwf6uyDWZq/TRX5pVQQnOyQc+YMsMtcIZWq9l/zWK83LSaU3DL+ew/9k52qeD+Z
         QrJA==
X-Gm-Message-State: AOAM53361fvhEBbobGmVXPEBvn+U8lE77muHILH8R4PBPkioC6zmAds5
        cWWXidbDwCvtKMq1LmnCxYWcYeYvs07EdA==
X-Google-Smtp-Source: ABdhPJxRfgKHX2ob9uoCx2YeK/7NGrlQT/52UGecp733FtQtaOgQRrFQAXPXPuHrA91qqibxclwYDg==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr18652130wri.348.1636121292278;
        Fri, 05 Nov 2021 07:08:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] generate-cmdlist.sh: trivial whitespace change
Date:   Fri,  5 Nov 2021 15:08:00 +0100
Message-Id: <patch-v3-02.10-b4b4c3aa135-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add " " before a "|" at the end of a line in generate-cmdlist.sh for
consistency with other code in the file. Some of the surrounding code
will be modified in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9dbbb08e70a..5114f46680a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -10,7 +10,7 @@ command_list () {
 }
 
 get_categories () {
-	tr ' ' '\012'|
+	tr ' ' '\012' |
 	grep -v '^$' |
 	sort |
 	uniq
-- 
2.34.0.rc1.721.ga0c1db665bc

