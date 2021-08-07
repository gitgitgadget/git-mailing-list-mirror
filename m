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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D4C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F6960F0F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhHGHR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhHGHRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B926DC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:17:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a8so20034059pjk.4
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bC3LVEeg6ZqTUnpofrbrencrwjSmmnhJTnEsJIT6aqw=;
        b=gvNirxZfcgRkZFynvBfciuv++Kq53b96JgRrnUmrbZcMN41bnT7jjhsytvRg2R/kVV
         X5QyifWC6/fyBsGn7Da1ZMyZoXCtJ6jVkelNk4qlUX+YBrlmx8oatFxZh2iMut6HGULj
         GFURLljQJh6O5C2gVh0V0G4TO9KGU0Zsv8/Yo9dzkC52OHXwupdz4PoRpXhHi1cRXvGI
         99dufatIl/kByPz6d3c6YZZWq8jV8+StjBQXPnl2QL4oZ9kEj8oAniy504FtvhCINoPo
         fzrF3G08oFxsWopkz5G7fx7Lo1M7UllcPufBDUQmvqV7h4HuWHaRZZFVqWetmlg34lzb
         0/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bC3LVEeg6ZqTUnpofrbrencrwjSmmnhJTnEsJIT6aqw=;
        b=VAuOtJV91MIgGtPw862SW0PrMzlKswZRXKfvGVHKpgcxS/UfUklCOcE7zCx1IWsj9c
         GhIBAsPsiHTEywnJlWR3J0nj+eduzpgsSWXxs3nhPA6daFTAF6C3JRiNJk6N0uiQaXEH
         mz6YR/8muYvfS6aM24/iElao2LBHpHI2pUmloTOPbVx0JruMxfEaAgUYIZrEDGGeqHgR
         iNhCjeIxInFbk8Es6DrGtctrl2qxtIxsF6uKD83HM+LDLA0Ide0ni92Olrw3MMEl/MpS
         x/6JAB000hdDVTKt2IpTQEUJNRH1aruNQ7XO4d3ho8j/7902VY6bOz/Bfodsrsed43P7
         00pg==
X-Gm-Message-State: AOAM5339UdgQRgoHHa3nkAJPGrfKguHTX3h1KHg2M1m5R6fOQ4nnHs6b
        obN4S8Fup6wg6+rt/9b4R+E=
X-Google-Smtp-Source: ABdhPJzxrLEGsM7K1mcbu1ZIGBX+ZqXhsMOIpc0Ym69y6hXbx6GZaJ7QNA9oFinV6hRSxnv09A9K7w==
X-Received: by 2002:a63:e14c:: with SMTP id h12mr183778pgk.431.1628320625383;
        Sat, 07 Aug 2021 00:17:05 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.17.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:17:05 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 3/8] submodule--helper: remove repeated code in sync_submodule()
Date:   Sat,  7 Aug 2021 12:46:08 +0530
Message-Id: <20210807071613.99610-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This part of `sync_submodule()` is doing the same thing that
`compute_submodule_clone_url()` is doing. Let's reuse that helper here.

Note that this change adds a small overhead where we allocate and free
the 'remote' twice, but that is a small price to pay for the higher
level of abstraction we get.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4b496bac6..9b676c12f8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1373,20 +1373,10 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (sub && sub->url) {
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
-			char *remote_url, *up_path;
-			char *remote = get_default_remote();
-			strbuf_addf(&sb, "remote.%s.url", remote);
-
-			if (git_config_get_string(sb.buf, &remote_url))
-				remote_url = xgetcwd();
-
-			up_path = get_up_path(path);
-			sub_origin_url = relative_url(remote_url, sub->url, up_path);
-			super_config_url = relative_url(remote_url, sub->url, NULL);
-
-			free(remote);
+			char *up_path = get_up_path(path);
+			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
+			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
 			free(up_path);
-			free(remote_url);
 		} else {
 			sub_origin_url = xstrdup(sub->url);
 			super_config_url = xstrdup(sub->url);
-- 
2.32.0

