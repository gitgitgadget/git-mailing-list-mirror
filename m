Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77288C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285C322B3F
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbhAYSEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731333AbhAYRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:55:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE57C0611C1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so13809562wrx.4
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jQ96vWOniBW8PZNv61/9806PkJgXsRsQRxZXXKQWvDQ=;
        b=dX+JjGIRXPfcQ3y2rS7eHH341hd6cTOLnGB++IdByOE+ca1aZLOj6uA3BGnBaAc9nr
         pFWBVmft7m4onJDP7qAUwqJuU3U0nhRtqo8L22GGnPdralrnw5sA1TZ9wmiCImTxpLSZ
         ++Fdv5SgD8FkaW+e7HjTN/4UTagGqJG/yVQ7cTZ4vAkYrxgdom3i1sNrfVj341ZVdl5n
         D6nyjyxBwAnc6IiwWsFwwV/AUtWmJD7x8qESH5z6xwEl0QuW+caSMU26KeDHzERRAb60
         42JMXOA6WDw6eDA2cKpfh9ijFre5VNJxJYkBkht5+YzEJ39CW8fxth/kQYaVU2wnxcgp
         rtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jQ96vWOniBW8PZNv61/9806PkJgXsRsQRxZXXKQWvDQ=;
        b=ZpUVWiH7HdqDOkNW//QRu2RtiNs5/p6RKPUFfFpiKpObADJfJv+JMgTNxHD1ra+Doi
         KmapK4eEvWUq/cRIWeO9afRzutlPBMYyvIV+akr+PPzQuRf0vouEc2WKDBGMx2ee7uCE
         XOCmHVi1YSu+vkXsVTTRODpHjnXGg9t/UKZqFez9yVKDo2j2RKBXHyiP9m8SeiA1tTuK
         L0XwRUmNDQyEK1SACVjbE+/ZwIKCG0iAmR6pAZCNW3HCipBXMG4ozNPLKc82KEfAoBWq
         O+N8ow0j8iSahaD4thfPqd6zEPI7Jo+xFIPV40087FDdkUxAkTXQXr7eY5icir9hkWrZ
         WgAg==
X-Gm-Message-State: AOAM533T63HWuhLXUzgS1xDypyCMhEJt1POcOpV9Q7IDK1oX6VCOhs01
        jBgGlOdYLOR2GQHav+ZNZcUzZ/sVr/U=
X-Google-Smtp-Source: ABdhPJyvAZqzlUUKvBUQZZ6/c743L6W6tMO6Qc+rhwilxFY4tYaX1eaBdOh093AanGbL2v2ulvGezg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr2208157wrj.225.1611596556697;
        Mon, 25 Jan 2021 09:42:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y63sm29684wmd.21.2021.01.25.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:36 -0800 (PST)
Message-Id: <926a2e12cf7534339e1f9bedff50d97bf251ffa2.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:10 +0000
Subject: [PATCH 24/27] dir: use expand_to_path in add_patterns()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_patterns() method has a way to extract a pattern file from the
index. If this pattern file is sparse and within a sparse directory
entry, then we need to expand the index before looking for that entry as
a file path.

For now, convert ensure_full_index() into expand_to_path() to only
expand this way when absolutely necessary.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 21998c7c4b7..7df8d3b1da0 100644
--- a/dir.c
+++ b/dir.c
@@ -1093,7 +1093,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			int pos;
 
 			if (istate)
-				ensure_full_index(istate);
+				expand_to_path(istate, fname, strlen(fname), 0);
 
 			if (oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
-- 
gitgitgadget

