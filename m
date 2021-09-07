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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64066103E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbhIGVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbhIGVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2744C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u16so20490wrn.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pKPQH7LwQtfFgrYlegGI8c5fEAyto9CC1WAj6hyGcrE=;
        b=omXiePf9eVIlsHQTJBVAsFjoq8Ym/7AaKg4TUir9fJuEIvvux8uGTf/7qb5sCA40pT
         ka489d/72KE68TtZwF5pobR1xmaIE36VGW/vo1vDL5HVPURYVmBg99IWHTf/GFxppkkF
         ltlLEpCcK9Xi7lahtgNn4aUlsRyjLsBiIXs19wWXUxobiegYlejpJjngz7yBhm/tI1/h
         bZtYpv9vfshYAzORvT3LUc2gJfKuculZ/NV0WkB4IZ/gocmkSZyRzXnlxJ2beU1pw/y0
         oA98ft2PvdpOPsEW9HS1+wbJEua5+k0mLeWGJbrqQY3UVxH65PaGf87/6m4MBCTscUmF
         LTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pKPQH7LwQtfFgrYlegGI8c5fEAyto9CC1WAj6hyGcrE=;
        b=D5gjHzKa974ui5jdQsmI7WCjMAboDnZIHiEayqoNB8cBa4hVozEU8EzktcxlB//r08
         u8w5KyILWCeSgm3DZkL0p6PAwssGUdpBdphoQ7aP0ScETkftvwVgqeHMEoi8rbNAWQgq
         SCjXAmsnQDGn+VOo8g3rZMBpteaFcNd7yW6R2oSFULfeiCH+lHgfY9Ntbop5D28musjm
         8LBMi83rmWijiPXH8r97aW1e8OMdvstbMgC4PWBawmMDG0coMpIXP+B33k4ssFh30761
         bx/ohK404PkGoaxtOKXmD7WZhM/I9AOqKNuJ7wnaPEKO5lzRNJNRPDCpwfBO1a3My0a9
         1JUA==
X-Gm-Message-State: AOAM531Kw4IFzCIe7XfoHgB/SO23nWG0cn5GffVVqBzkx1iDXYtWeORV
        V0mjsDQGdRsBsFZaijzTuc4EAOfEcr0=
X-Google-Smtp-Source: ABdhPJxkq9e0D9MDYY30Wos69OITwjk6B6mQK3f4lkBAb6QNvB9aFmHWrIR6u2u3SniZjXGKW1VExw==
X-Received: by 2002:adf:b7cd:: with SMTP id t13mr326804wre.63.1631048715569;
        Tue, 07 Sep 2021 14:05:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9sm151276wmi.44.2021.09.07.14.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:15 -0700 (PDT)
Message-Id: <acda0f599475c07c6c1a5e75384e0cff98d2c19f.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:03 +0000
Subject: [PATCH v3 02/11] remote: warn about unhandled branch.<name>.rebase
 values
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

We ignore them silently, but it actually makes sense to warn the users
that their config setting has no effect.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f88e6ce9de..5705e088e5b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -318,6 +318,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		 * truth value with >= REBASE_TRUE.
 		 */
 		info->rebase = rebase_parse_value(value);
+		if (info->rebase == REBASE_INVALID)
+			warning(_("unhandled branch.%s.rebase=%s; assuming "
+				  "'true'"), name, value);
 		break;
 	case PUSH_REMOTE:
 		if (info->push_remote_name)
-- 
gitgitgadget

