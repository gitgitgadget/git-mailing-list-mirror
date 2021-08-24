Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5B3C4320E
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A86611C8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhHXVwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhHXVwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0AC0617AD
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so3220619wms.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i9HtyxcyL/rFpqLzUK1JHZNiZLF1vUp90EnsiHFgFOg=;
        b=nw7A4dwpQi1pz+4s6K++BF9XvLrgP6iYten5Jd4c3Jh/sLtwIgzvxPcM8jHOPS9Tn2
         ogF0MOi5dqF8/TijbOnSXukBl7buw0N3ukKXkgu5ivByTofKJz4VI6EMFDJimMM7vIlZ
         F5wIT3NWZBHvMrXRhUpGtVVGenf74SfNk45SzYASrOZoEY89L7tdQguru0wjMEXSe8ro
         ro6AsX82XQsX7L+2qyRkUNAVN1iZJ8iU7QYnJG3jpSyuCwqHexFVYbmdgs7d1aRud7E3
         HFawKUEE4+lYeaxMycJX5Dz94hTxlLb+Qh8FUQ7PSKBgDh9bd/A0XFOalpEo5gm5S3FB
         /Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i9HtyxcyL/rFpqLzUK1JHZNiZLF1vUp90EnsiHFgFOg=;
        b=EmUeUTX1m2Fb/9bWxzkCStazqswPO+CpYOn3sM3xAUZrUkEgyGh5p+gPUD2CSUyzVo
         4dABa1ZADhd/BQS4yriexT5pDBGHaL8mr3oWEFOu3G15KCbGNQhvhqF+2oUyoJlFGiBW
         stSnRU/Nca2SjzI8MLZn1CVR0QtRSFwbZMHa34JKDx1HA91mvMHWvCDmUtLKOUKOSGkx
         tc0mKAUqjWgWr7SIM1qQDexsfDx9jdoupo4vKNQQ8z0FmEVQzKYFDQeoLO3Vz/u9/8qV
         wd+AcUhyD77mjJhDKXCV/h60pIYkjaUQHbOXxUDFswuiTZaPTwslkPGYgVbK0P1iMIMh
         1TGQ==
X-Gm-Message-State: AOAM5327VOTJ07PY4KsWQka1gauHknZKjYEc7sTee8FiIB86s7IbgUmH
        JxU7a2TOcpSixOlN7/iZP0UipzryLS4=
X-Google-Smtp-Source: ABdhPJySd0Zb0VTyEvHCs7X0OZJLbnHJY1NKTmfNnusOS0m3eAjVS4w2awOwaiADkREBKBJz9Le6ZA==
X-Received: by 2002:a05:600c:3b98:: with SMTP id n24mr5879707wms.11.1629841910172;
        Tue, 24 Aug 2021 14:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm3355989wmc.25.2021.08.24.14.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:49 -0700 (PDT)
Message-Id: <e496f3cee66d176a8776a3bde5d04716a4b52f26.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
        <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:41 +0000
Subject: [PATCH v4 07/10] attr: be careful about sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 attr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/attr.c b/attr.c
index d029e681f28..62db4aed443 100644
--- a/attr.c
+++ b/attr.c
@@ -14,6 +14,7 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
+#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -744,6 +745,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
 	if (!istate)
 		return NULL;
 
+	/*
+	 * The .gitattributes file only applies to files within its
+	 * parent directory. In the case of cone-mode sparse-checkout,
+	 * the .gitattributes file is sparse if and only if all paths
+	 * within that directory are also sparse. Thus, don't load the
+	 * .gitattributes file since it will not matter.
+	 *
+	 * In the case of a sparse index, it is critical that we don't go
+	 * looking for a .gitattributes file, as the index will expand.
+	 */
+	if (!path_in_cone_mode_sparse_checkout(path, istate))
+		return NULL;
+
 	buf = read_blob_data_from_index(istate, path, NULL);
 	if (!buf)
 		return NULL;
-- 
gitgitgadget

