Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB7C433E2
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249046193E
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 10:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhCUKwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 06:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUKwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 06:52:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D9C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 03:52:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso1702858wmq.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=iZFYel33nnXtoiKd9tiRbR8yDnaRmPCQOB2N6pAuDkg=;
        b=IGrtKIVA8S3xDpbdKozot3eMu0Nkpy6TM0Sz74LfhCLmC+zhro6ZXaI/ILIHn7JdmZ
         TvlexZOifFGMlDXgOa+SYl041S1OUQD1/A9Ojl+bNW52nNF8jFPyWZi3wTRqkrA7atmA
         ktc9vUw8eWpqCeChz8CXhGjcz6k7f8xk0bBtZICmHeeprRwxeT6cBUax77G1DzATxS0C
         qYpChmhim8uoBCv+B2jnyuFpJQQyfxnhGrjqaE0aUEcs4pWpUGAqeXwuwAcGM5hCgfzV
         oDNdyapIMZZFDcDiaK4SN3RJzDtwF2Pyae013BOH8FTaKB0GWiiALYHUs/YeiBuXZfSC
         gNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=iZFYel33nnXtoiKd9tiRbR8yDnaRmPCQOB2N6pAuDkg=;
        b=JjbeZ+mmSJJa2Hyn3QgX767xNJmTVWsO9fgFpaNTjHcrIzSRYUoM7zh/7kBfpCEspi
         8V/+FxlBD+KF2cTcekqQxTiI4NaixYGvnqWsGmZuOQEaCvZLviNiSZfsiY1i10ELEBgN
         4Dr9KSX42q7qlMHW60ycY8lImkciS9WiIzBSbC4RuTGxExrCCJUZejfgyJhj5Gz9RR5B
         eY6YQrLaEdgB8WvSfP2t94Zf/eRcwOf6PUGlH1GqQB2lRLvHQ6xmb6OMmOEDylgSHTiW
         V/fQfLsNWh3atDGb+8UMk+XwI/RVFzOxY30tF/AU6UcFStITNiYMtl0DRQNz61RpkojU
         nUjg==
X-Gm-Message-State: AOAM531qnupVI8r8CnGSOJQrrHKWcZCA0L6p9Q/xh47PU8FHr/lKBVCn
        BJKr/LfQ27lnEJymRVb9+Od3cwJWhZg=
X-Google-Smtp-Source: ABdhPJy7WBLjZaaJCx+Zp57ZziY46hqu/Tb7dOOSSTn8pLvF5pdW2fXXliPbOfyHYMsSjpjhCvNhKQ==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr11727781wmq.159.1616323937920;
        Sun, 21 Mar 2021 03:52:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm15858805wrl.49.2021.03.21.03.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 03:52:17 -0700 (PDT)
Message-Id: <pull.983.git.git.1616323936790.gitgitgadget@gmail.com>
From:   "Kleber =?UTF-8?Q?Tarc=C3=ADsio?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 10:52:16 +0000
Subject: [PATCH] fix null pointer dereference
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Kleber =?UTF-8?Q?Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>,
        =?UTF-8?q?Kleber=20Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Kleber=20Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>

The malloc function can return null when the memory allocation fails. This commit adds a condition to handle these cases properly. https://cwe.mitre.org/data/definitions/476.html

Signed-off-by: Kleber Tarcísio <klebertarcisio@yahoo.com.br>
---
    Avoiding null pointer dereference
    
    This pull request aims to fix null pointer dereference.
    
    Null pointer dereference
    [https://cwe.mitre.org/data/definitions/476.html]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-983%2Fklebertarcisio%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-983/klebertarcisio/patch-1-v1
Pull-Request: https://github.com/git/git/pull/983

 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d505a6329c8..92349d715a78 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1215,6 +1215,8 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
 			continue;
 		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		if (!temp) 
+			die(_("out of memory"));
 		temp->mod_src = p->one->mode;
 		temp->mod_dst = p->two->mode;
 		temp->oid_src = p->one->oid;

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
