Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD4ACD54B9
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 11:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjISLzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 07:55:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48ABA
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 04:55:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503056c8195so4946228e87.1
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695124500; x=1695729300; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ikcZozmKiAO56T5OTucn4AeRogW6M5oJrJUe9so+Ppg=;
        b=I4QY4nUmqOB1TrNfG/JuLMupVTmHQ7m8z12edBqaboAhFucrS0XxMxiawTIyWjFo1a
         pgKuBTlt6jjoUKq4kGuDJFuzvDYMDqrgMXHXBX6mcfqNlYoIPsBdG2QEJCm6hbsoa7PW
         USQ9BztZ1zMGisL5ABouwOXBAQEkQn8rDL8mCd3HEs4mfw+6KdN031zK9VDqr/jxb80L
         hxi5xrwd0H1Y6O1u10IV1HXSxlNNO8pEQOrCmxTH+8brox4HsHDmY1o3orek7OPXSmjF
         HVkidkTCbOVtJIY0RanK2bqq1vRxbecgOrpSMz/b+nDluHGgHbFOy3SzyfMysGIPZbtv
         x1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124500; x=1695729300;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikcZozmKiAO56T5OTucn4AeRogW6M5oJrJUe9so+Ppg=;
        b=jLxsjbQwyycGXFy56Y55zhqJsJfcWurCrQJqweb/DLoELgOa4Fva6JhENpL6vnyz7j
         RA+X5UcOw4tsKhLbw5yS4kquBeLUhcFAmPC96NR0gicka9lcZ+YsVUhygqbs9EaV1M0M
         2yNipNxERX6Y1lTT4FFQYaFw2VcsPi3IA1IAPOakxV72qSjWloPqNM0XlaSxujD6mj4N
         6NgZh3OGIrhPeRgMn/AbmX6zg+mzX3MiU2lMosP1/dmhsd3Z7paXGanKa9O0NK9364N3
         fmtnNQXRs/y/YCfJd9BuKwZWKwAxQ/oibF4zPzVSRtIvlofkIEgX0AZF0TvSMrLHd/EW
         hEEA==
X-Gm-Message-State: AOJu0YyRpQhxzTdpeOQeg9v2N4E8tcDCVXgTDokwfoAlEIdahdUKJmZs
        /zvhXTviyff9KsyfBG/9ebW5ZMXhHbo=
X-Google-Smtp-Source: AGHT+IEWheDZQ3zCf2DTgnGNXelfia4xMLeWGHfJcawJifHAkQV0LjT3YAC6BIbswjmdZXNyj1TuoQ==
X-Received: by 2002:a19:5206:0:b0:503:654:cf27 with SMTP id m6-20020a195206000000b005030654cf27mr6437304lfb.28.1695124500026;
        Tue, 19 Sep 2023 04:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b00402c0a8a084sm17723152wmk.17.2023.09.19.04.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:54:59 -0700 (PDT)
Message-ID: <pull.1576.git.git.1695124498925.gitgitgadget@gmail.com>
From:   "mark via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Sep 2023 11:54:58 +0000
Subject: [PATCH] fix: check parameters in json-write.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     mark <870355373@qq.com>, wangsirun <wangsirun@zhidaoauto.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: wangsirun <wangsirun@zhidaoauto.com>

When I used the json-writer.c file as a lib, I found that
it often caused coredump errors, so I submitted this patch

Signed-off-by: sirun Wang <870355373@qq.com>
---
    fix: check parameters in json-write.c
    
    When I used the json-writer.c file as a lib, I found that it often
    caused coredump errors, so I submitted this patch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1576%2Fwangsirun%2Fjson-write-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1576/wangsirun/json-write-fix-v1
Pull-Request: https://github.com/git/git/pull/1576

 json-writer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/json-writer.c b/json-writer.c
index 005c820aa42..23ba7046e5d 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -20,6 +20,11 @@ static void append_quoted_string(struct strbuf *out, const char *in)
 {
 	unsigned char c;
 
+	if (!in || !*in) {
+		strbuf_addstr(out, "\"\"");
+		return;
+	}
+
 	strbuf_addch(out, '"');
 	while ((c = *in++) != '\0') {
 		if (c == '"')

base-commit: d4a83d07b8cc66d4afac2f33a8af729f2ba93bba
-- 
gitgitgadget
