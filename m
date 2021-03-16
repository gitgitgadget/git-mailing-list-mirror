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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60957C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5E164F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbhCPP7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhCPP6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE7C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y16so10762701wrw.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxfSwPNZZlmwjEMQTuH1bp0rCXGfVnB6FcqBOYXqDjE=;
        b=UG2ZIlyGPwiY01yf/HrRFmgvx3cR3rwd6N2psSDGiYJ5sanSE68Agbi0B6fbddnhId
         pQV43lUE1641Jj4aQB58OlqyKyLPumtsKwES9d5x3/vMdNSDP4vpWifPnrZRDdLZklne
         IQOlYmjLC2gH/Fyk+K1L2C4YssxwyXTgjMOgbHMZSD8EbRiEzoTDRwNDGC/pEGuypPR0
         ieWDaHhQLTiWstF+Q+kN2fvf6GRWNWE9WCU2edOEih7+dDFEeVTkkbv3mbodBJzwoR9O
         mlwmEH9ZThKAnlJ/meMEo3BWp87+EJGTF7EAnzmKWxCkcdBnUsDmmtVOubXupxhPp2RP
         opGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxfSwPNZZlmwjEMQTuH1bp0rCXGfVnB6FcqBOYXqDjE=;
        b=BF1rkVZ9ratUuvfdLRfuLQjNrAZBdL0t0wFrakVlCbN5ypH/wORvD08pTY5oWyEBA0
         Nwo2nZ9qgZS4HdblVG3bRwvWVTHHeODaVs8tHdBmZ7cJHDR4OcRJZrJVT4dRDimWx4su
         xGVWrpe+9y+tEKBhRcHi59Gkos0MXCvwSxw1uXGynRrh/waEcYI95vROk86CIHLKFrkD
         YWR5m1bDkbFIzRT1Vepq5tpntNc6jO+L6Ka2HT8lQwIH+FRTXz10ROxuSZDk9pYiB+lH
         cLHUCJHxt34d1L/6cdpsdX4U70mFBMsDWWlpYs8j8jzAemCickbJoWuzH1O+znaEkSQI
         2w7Q==
X-Gm-Message-State: AOAM532ubP2qpcYTwJs6oUR2A2rQhRhs7v8Au4x9QYT9HuV4Us13QA9N
        tD17wF08hediSY5EVM76gMsrrnm9cf/CoA==
X-Google-Smtp-Source: ABdhPJzJvDC7wVBswMNMXfYyJjBrHhtm8j/tadScFdO0hdy7pr94Q32nJhzCF+ro9/bi6adgnL7gsg==
X-Received: by 2002:adf:a3d3:: with SMTP id m19mr5752533wrb.24.1615910318319;
        Tue, 16 Mar 2021 08:58:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/32] diff.c: remove redundant canon_mode() call
Date:   Tue, 16 Mar 2021 16:57:58 +0100
Message-Id: <20210316155829.31242-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a call to canon_mode() from fill_filespec(). This has been
redundant since the tree-walk.c API supplies it pre-canonicalized
since 7146e66f086 (tree-walk: finally switch over tree descriptors to
contain a pre-parsed entry, 2014-02-06).

This call to the predecessor of canon_mode() was added back in
4130b995719 ([PATCH] Diff updates to express type changes,
2005-05-26).

This was the only such call in the codebase. The rest are all either
one of these sorts of forms:

    canon_mode(st.st_mode); /* a stat(2) struct */
    canon_mode(S_IFREG | 0644) /* A compile-time literal */

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 6956f5e335..bf46e6a4d8 100644
--- a/diff.c
+++ b/diff.c
@@ -3846,7 +3846,7 @@ void fill_filespec(struct diff_filespec *spec, const struct object_id *oid,
 		   int oid_valid, unsigned short mode)
 {
 	if (mode) {
-		spec->mode = canon_mode(mode);
+		spec->mode = mode;
 		oidcpy(&spec->oid, oid);
 		spec->oid_valid = oid_valid;
 	}
-- 
2.31.0.256.gf0ddda3145

