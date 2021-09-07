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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7C7C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D5E60F45
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbhIGVGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbhIGVGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92285C061796
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t18so87093wrb.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R3kvvAjuHU9kB8pCXZcktms6JeImZmVmMGH/f8QJMOw=;
        b=g9cCkHC07gdH12eeazrGCvp9LBqizP0vNV/xH/4V+PXhzfLlMV0gP3zh0FHpyXveRg
         VWLWQt5npd099zFWAfDdBaIKNobvA2+fbQIVytuhIFsSzGcIUfI4V2pOF/WUW4em8Xpa
         tcVLhIQOcCv462Rpq9fayMbTjmX5oPapgiIqNN7WNZJNpbyVFIeesdzfYowZ3mOCZHF6
         oaKoE4SvRxQWLYg8KyofT70gRzg+HvlCmIE2xhQYx0f3pDoH05r2+JHMSfw/UapiIHRG
         Q6/HQh6837T+FxllCsG/fZA7iVy+CBXunCRoFboHJLWv6x8o0Bs04Dn119xGmqJOYWDT
         ZhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R3kvvAjuHU9kB8pCXZcktms6JeImZmVmMGH/f8QJMOw=;
        b=iCWqeMj3NlaAV8ST23ydQCrgHJvBuy7ht7s3jYPxCwgsyc+surk+3Ya5gJvkXxFjOH
         XLJFtf4W7LemmVuItXInAXKGSSwfLl7A6pL8aRSgP5/Da13+dgzBNHt1VOFSxXqsHAba
         vkeU0VRuMAGBVPi5Hgtryt2MgHehG+NMlSTKjOyVfCbEwsV1flGHjeEaGJH6xBq0/BFu
         XdDOb1+dux7RSJ41syOFgKUHTniSniyS60DvcZpqSqoWK6n/qNmtDsjV1eSsBwW8vu85
         S9gQY8uFYHbyY0fFeCJ6Yr3bVDmeyoPAt8Csf7M4eY35x0BAuUkypQHXNbSEO5EX9bfM
         bPTQ==
X-Gm-Message-State: AOAM533bm4IDg5AZO7u6ly7oGaWxoRwHR654rd8ndFgVxiPj1ioN3Mcy
        a6c7GrIKZfLc/VTgrenMo85OeRkNbAc=
X-Google-Smtp-Source: ABdhPJxfqcLaCfN1wEKI91xtp89gsioe4fvYC7B7Zb+dnqTOD6YUn0WEp9VTgXfYocGGJ+w32oiaTg==
X-Received: by 2002:adf:c44b:: with SMTP id a11mr333407wrg.416.1631048719269;
        Tue, 07 Sep 2021 14:05:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w29sm77371wra.88.2021.09.07.14.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:19 -0700 (PDT)
Message-Id: <d23f245b68442df01f698bb9f5aaabcc5bee5f9c.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:09 +0000
Subject: [PATCH v3 08/11] rebase: remove obsolete code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that we no longer have a `--preserve-merges` backend, this comment
needs to be adjusted.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0935e8d6e83..b8eb8e8304b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1415,7 +1415,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.ignore_date)
 			strvec_push(&options.git_am_opts, "--ignore-date");
 	} else {
-		/* REBASE_MERGE and PRESERVE_MERGES */
+		/* REBASE_MERGE */
 		if (ignore_whitespace) {
 			string_list_append(&strategy_options,
 					   "ignore-space-change");
-- 
gitgitgadget

