Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF08EC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7EB61442
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhDUKQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbhDUKP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:15:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A081C06138C
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c4so1831649wrt.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTnZ6X2+0iPrYckHE9EeYAhoEq/P48sO9wrgGeovRaI=;
        b=aAQimyZI1MxCcZk527k74fxLJJ+TE4gDrjla651QliLPDX9JWLsBYwAj7dGUmCyp4N
         YbcGWWTijLEHc5WXa25aAbfba5ZsnEPkzdjlE+B4yHZwKdjK+EMwqw63p0zIp1RBEd+C
         twh/anG8OXnwn7cWxwuXUc7ctskl++0f4Zv+SSF5HjCJfowWwfbT4G1k2jOWLCheFvAO
         IHYMW0bIZ5jfIeIbXyTToTWnkS5pbepjNwJlRsWi2iwdSZRcEwAk5g++UDQ7pyAg8c95
         2B4KzklcnNIzsTfjxNJg3uretNQGAwMnJzYgmpkxfrqwbERyprW05941Kr99KINb7+kB
         UcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTnZ6X2+0iPrYckHE9EeYAhoEq/P48sO9wrgGeovRaI=;
        b=LgWYcjTHc6eIDAOGx8mML81Hb1eur8bSsamSoNyo0TXqSOQ9bGyEe+cWEEDiq3oxBo
         Wmxlo2a+ZKgm8HA1EX6jGgxU4PjCjqdVxqJV1jJD8DShB4qDmlMRwYkEHtZ+jq7Hj6b1
         CWZy5V1qyE1BDSk/XAZaFVey3y1EvGuv07EduaUmXvCersrHtkSVo39fmXQYoQN8NOVE
         RtgmowAWBNYEkp0veyOSlFR85KdueIRQFV2VnuqVepDcpXOQVSnhZrN7F8canH7JCKL3
         oqqhrYs4p7WPypGq5n0gmaXwdf4jW+9BLnVW5zLR+FPFfeyMXpiT1B91z1ixWJD8WgIv
         +Z6A==
X-Gm-Message-State: AOAM533vU70kTZYd8Pk6FLSpJ/bu7ojVtq2KXb7N8Pt2xFS6/KLGPn0Y
        SmLPSMOh+ZShnqlOVNzfxOkztmtZxVf+Qg==
X-Google-Smtp-Source: ABdhPJxKWx2ONTMm2LZaiz2fCojcDuuBCmfMsjHu9OLjfEkIzIEE6SUFWJwUwFFb4bzBFBLMlF71CA==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr26476294wrn.6.1619000122605;
        Wed, 21 Apr 2021 03:15:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:22 -0700 (PDT)
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
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/11] test-lib-functions: document test_commit --no-tag
Date:   Wed, 21 Apr 2021 12:15:09 +0200
Message-Id: <patch-04.11-b67654334e-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
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
2.31.1.721.gbeb6a21927

