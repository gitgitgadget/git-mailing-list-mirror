Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE11C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7F3611CE
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhGTKAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbhGTJ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:20 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D476C0613DF
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so1200763wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CroHrlIswWe0UcKsGuSy3azuqUBqALEU25neQYHZWRQ=;
        b=k7hRkAvdixsrlWiMUCEBGpGmRygIukjbD4xjuW3uWhC8N84oNofmCuvxRtlgSm4nb1
         oZtmPfUem4OsXik7Al3Mm4kdWLGIVDn0PG7q7nWr+S5RnmK+j3af9iib0/7O7wzbu6eY
         L2fcp9YMUfvE4a1cH8UdIol6E7joKX5qExMMUdTmnWEduKT7YlggUPC+q1LdSVWAfEnh
         cpHqVvaTDMWzyYLxEzjFseRtzOdenGo2a+YCNCmzlFnt31nxw92tNBRttjDCj1V/suH3
         VrYFPX5R5X2oq4NgK+AQ4nOJRN6u9wElp4UJohZTjRHtaSE5bn0gvM4ieJSMoy2VAlxQ
         VvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CroHrlIswWe0UcKsGuSy3azuqUBqALEU25neQYHZWRQ=;
        b=N/xCmYQChoBw+NF9L7CwihJo64nGJS3VwOCJ6THPiEvC0duWj0SQyPtCfugGv6o6Ti
         zscMZC149YOsk4z4ZIH3oGGMMn+DTtETnfLvRbTOwrcJnJMBFQS/qirsagUqwF0u0kb4
         Y6QwEx3Vo2r3ebID9tVot6jM5a3DAfKvaTHH3hFVJZFaoQ9rHf2WfjtSROOxCQ5vlY7E
         xlJ4wkVgFI8hnBa6JONM06e0UpXP9BMIVx+4wPejkmzLlX9+A6opQktw9BjrqcUE7hIr
         2mhoBrU+njQHlgiOAJ0PRrTJ/VTxsliZc0/mCc39ZqtXCHK4ODcaDjpe9GdMHnk9HG3o
         Ga3A==
X-Gm-Message-State: AOAM533HiPs3uqVml3a4v+jziN5MHre1CcBVNtltNLtN1DlSHyW44nnq
        1TaVHcNJh+PsZ66iwRQCASTbvCu/m/k=
X-Google-Smtp-Source: ABdhPJz4aDhdAtLMEfkWAwMosA0FbbSyj7Z7msZ3BS9U9ltZVwZYmHhZlIvIWihtW7J1shSbCf3grA==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr30785842wml.92.1626777401754;
        Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm23203056wrw.62.2021.07.20.03.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:41 -0700 (PDT)
Message-Id: <c160222ab3cee77c88cb947f4bf18993a923d53b.1626777394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:32 +0000
Subject: [PATCH v2 11/12] diff: use designated initializers for
 emitted_diff_symbol
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This makes it clearer which fields are being explicitly initialized
and will simplify the next commit where we add a new field to the
struct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index f899083d028..31a20a34240 100644
--- a/diff.c
+++ b/diff.c
@@ -1460,7 +1460,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
-	struct emitted_diff_symbol e = {line, len, flags, 0, 0, s};
+	struct emitted_diff_symbol e = {
+		.line = line, .len = len, .flags = flags, .s = s
+	};
 
 	if (o->emitted_symbols)
 		append_emitted_diff_symbol(o, &e);
-- 
gitgitgadget

