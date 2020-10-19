Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D887BC433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E4D223BF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijVdW4FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgJSTbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJSTbr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880AFC0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so1045114wrq.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HgXufAkE2foL/3BiZYE8jrp61fMaIouJlX8dQncGfrk=;
        b=ijVdW4FTKehhVRcfs28QziQGEQYMWRTYxMF6yIPLMdRBlsqPilLhO9RTbp8PtJQeVB
         bXtYDnJhkwNDReqGnCseGPgnjUymiUsXPk0fRCjMpVRdm33jUNGvc7i+qA31s2qqPvu0
         CvtbBCmCBE9cPPXEbDKDNfvwfhnv8Qb9RzWFFw6LNCxwwHU94tDv6ICsxOo9lpewbi6w
         SmxBcaDImH3wwv+XY2E7oq1YdrweK72nDkWw+IiS8amtgiggD+DfdFMg80TUjeHUhxQK
         t5IaDrqNk2Hxht7yXGM3q6QIix9goYpr2yfTf0iL1BKogETB2v7MLdWqdqnrXwaLA0ms
         1Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HgXufAkE2foL/3BiZYE8jrp61fMaIouJlX8dQncGfrk=;
        b=aixFwkqCJJa1roM47B4BjYY6tSHCbE6PYbcVn3a2Rq63iI9IAV0w3xDEL/FycCNjpg
         9vWwqQYMqExFGXXpACOx+LEusvnDXhGKEU4U8/HT6qutB+6ZDA4TEsSPCktCPDOd1NAw
         fJm9lPeRqVGe2MY7Rfm5u8GiiY/QuFiZoavOo+C7To1o99jdbXr3NBIUW2GnwOKhu/pv
         DCAozMvufydDjwMd2ZA62Ej5R+d1ATjIqY1MkYGBoJAka7KDygqUg/V4dvNSx/yCxCFi
         HtcoAd0nJ/Q9UNLWQAL6gVfSUJPzmJ6hhHX+BfT8zRiTOIDdDLAGgtxPx7bQZ6TCTBTk
         x5Pg==
X-Gm-Message-State: AOAM532ucV84x9mh0tdK3zOzainvq7sc+k4o8Ivz76DGUcPCDA9FX6uT
        1fuiA0bBDo9ucpdguHf7FzKU1xug2hQ=
X-Google-Smtp-Source: ABdhPJzi6KZsTIa9moZNqXAt82YUrYT85aDgd6QhJkCts6MV5XODpQEZtTjJ23nbuutKJ4PyTz+GnA==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr880442wrp.179.1603135906002;
        Mon, 19 Oct 2020 12:31:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm904343wrb.21.2020.10.19.12.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:45 -0700 (PDT)
Message-Id: <cf950c6f6a48f9a6ad55ac027afbc0640f9a535d.1603135902.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:32 +0000
Subject: [PATCH 01/10] fmt-merge-msg: also suppress "into main" by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for changing the default branch name to `main`, let's
skip the suffix "into main" in merge commit messages.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fmt-merge-msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index bd22e1ea88..9a664a4a58 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -626,8 +626,10 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
 
-	if (!suppress_dest_pattern_seen)
+	if (!suppress_dest_pattern_seen) {
+		string_list_append(&suppress_dest_patterns, "main");
 		string_list_append(&suppress_dest_patterns, "master");
+	}
 
 	memset(&merge_parents, 0, sizeof(merge_parents));
 
-- 
gitgitgadget

