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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98435C43333
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A34164FA8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBEWH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhBEOyU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:54:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C28C0611BC
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:32:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 190so6516942wmz.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NXW0/IyLnefqrhgwRAQLEbWDjQP16jqzthXYIuY4v24=;
        b=V5/cLbeY2UT+Dvi3m7C/NU2EqXOx7iuzQsPucpBNiCmAujlb6gRguL+wd+FEjMzwhS
         pC/bJ6JywyTVV4Ky1esQjwhONi2wOGgIt95pkzAElCQzRgjBYXUDMn4MpdPsfNZZoJt5
         1i05lfAAQ9HNLi81ZvJbEhkWXNe/bj3yc17laoS6j+VhFICjDh6xHRN+s5beNcuXiRcv
         XWLi2+DUssVZ4oN57PnOJrDNoHoApBu3Wlp7tPB9sg2jLnvYT/Gb6HCvFAbc+YmswXpf
         3PsKDtAsaeoRzSyInv1uDWkT50eWF6c5/uiw2J5RdOVQKfuXgtpuZnfObSj08gdczi2q
         Ydxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NXW0/IyLnefqrhgwRAQLEbWDjQP16jqzthXYIuY4v24=;
        b=KV3tbLbJwhmFCR5FCymXvXFbFSGnCz6wKluEvFsjeAhNJE/haHkm9rBUiS8pm7qCxG
         xWUGVMz+8szOft5sqzfdIbQi+dR9CoPSXJpVtlwMACcaR2SrvNN7I9Xcpd1DYdUMu21W
         kTOS29NfnC3p6ol3TMNgshjwQKvvJt+l2hlSA1yYVofYxoSK1W663FGqeu2Mcsd9pG5I
         Md/uOwifvtOjgghYBV4G+LKWVqJxJeKn8hlzq0f6MGwVL9vkjRHFELLeNMaj/DuOok2k
         k9zRf18Gzz1A1XErMji+Kgmc0ujJT++ZXjkQ2JDllrYRC7wFm8HtWUkoBRQ0E6DkKs+X
         +2vQ==
X-Gm-Message-State: AOAM531tK/XBQfUbgdJPLr2Opebi7TW1iE9ZULqxIVLfJNxs/+61gPFv
        N1QlZq/x7+58+htX3w/pvp1u8N6g+lQ=
X-Google-Smtp-Source: ABdhPJwpBQxCY67GnsxvF9JPCaM9EODDCImFQs4pguUIn0REhEMukVM5IYeIC7L2cC9HFLiRP4Dqow==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr3932227wmj.96.1612536375504;
        Fri, 05 Feb 2021 06:46:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u142sm9367046wmu.3.2021.02.05.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:46:15 -0800 (PST)
Message-Id: <15f4f6abdaa206ca9b89f4f2444b88a77ef1060c.1612536373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
        <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:46:08 +0000
Subject: [PATCH v2 1/6] range-diff: avoid leaking memory in two error code
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the code paths in question, we already release a lot of memory, but
the `current_filename` variable was missed. Fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/range-diff.c b/range-diff.c
index 7a38dc871543..9972808fe4cf 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -98,6 +98,7 @@ static int read_patches(const char *range, struct string_list *list,
 			if (get_oid(p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				free(util);
+				free(current_filename);
 				string_list_clear(list, 1);
 				strbuf_release(&buf);
 				strbuf_release(&contents);
@@ -113,6 +114,7 @@ static int read_patches(const char *range, struct string_list *list,
 			error(_("could not parse first line of `log` output: "
 				"did not start with 'commit ': '%s'"),
 			      line);
+			free(current_filename);
 			string_list_clear(list, 1);
 			strbuf_release(&buf);
 			strbuf_release(&contents);
-- 
gitgitgadget

