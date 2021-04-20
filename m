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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F0C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD862613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhDTMWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhDTMWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74FC06138B
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so37366067wrw.10
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vhkn8aNMXvudUAyFYl3RRxpym/GXdxGrK9Z5x1F/uk4=;
        b=PKnkXQTJv111A7ZogV7D6baRjtcKF3KsZ57TNocwllM1Ks5cwioRgr6TuVd8BXLJbB
         /a5+QVG6bwcgOlYN7GUOfRQu24YGYLwm8opLw+wXFkPCp/soj1Y06PmNPTt6Ouzgc5xc
         AdVpuYNy9gXP7xP+Oi53QUrfSOo51sQGNO2TQk3OC7b3acI70hY/SgKn8aagaCyvacem
         bjnXBd/Cl5VRjcv/iE6NPUu98HDRqIhp6kkU0SOEps0xq2W3hDvdePEapvE16xd57/0S
         nrsbsIq7i8Mu4JZFr31fLuYfddBOuN7Oxuk+yA0JiyzjyMMptO4d0irdIGP56CEQrnK4
         QL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vhkn8aNMXvudUAyFYl3RRxpym/GXdxGrK9Z5x1F/uk4=;
        b=bnGakllZsDvwkCfMxoW+NIl2VMFMuWen7eIjRDLAyUW9DAIcID7Y3yss+vtLF/gByA
         Bb44jPyKkE5KW2vXjScgr0xklwZ3mrd4CcS5mUNLJkKuSE6GCmHxKs6u0Qw8Gn7LWAdZ
         VMC2d2KlxDZKJn5rQ0a40J74+JH8MS2Bk70bRXuIlBG32DCCzrOzPQ8U6jYgC8iVU3sB
         4GQj9hAR06rUEqve9XZmh9kJoR2lPFC2R69if149n4wT5zEePmYtbo1nNHYbFaD8bddJ
         8docMImPMaDwfWv3GVuAW18V62I1b7qkhwpXClA+jHcqEFJLh209a0eoaqQYXm/8NKx5
         AvkQ==
X-Gm-Message-State: AOAM533Em2CBsyOomLMM6C5maMjzvFKymJWK7bzsw62TwnVvfVwVgnl+
        p+OACNrxeNDhahf05K2s7nXUAeCnD1yQfw==
X-Google-Smtp-Source: ABdhPJz5nqeb88LhLQRGUZMQraxjn2YnIuzus0rx7+HNWKmFDVxol7M0+cdGLNcDZbexc7RGQHimXw==
X-Received: by 2002:a5d:400d:: with SMTP id n13mr20088954wrp.372.1618921331598;
        Tue, 20 Apr 2021 05:22:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/12] test-lib-functions: document test_commit --no-tag
Date:   Tue, 20 Apr 2021 14:21:56 +0200
Message-Id: <patch-05.12-c916d648e4-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 76b8b8d05c (test-lib functions: document arguments to test_commit,
2021-01-12) I added missing documentation to test_commit, but in less
than a month later in 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09) we got another undocumented option. Let's fix
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d169fb2f59..d0f4f3885d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -177,6 +177,8 @@ debug () {
 #	Invoke "git commit" with --signoff
 #   --author <author>
 #	Invoke "git commit" with --author <author>
+#   --no-tag
+#	Do not tag the resulting commit
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.31.1.723.gf6bad1b9ba1

