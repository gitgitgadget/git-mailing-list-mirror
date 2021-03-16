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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E4C4332E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A42765024
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhCPCOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhCPCNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E90C061762
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j2so9643329wrx.9
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/EUe0RS08UvXCr/QRKhBQGnZARPUkvw6TX6lcOsPQU=;
        b=FdapUcfNfDScwhKkwO9X4g/K+Z76pXFdaIXgbomKvUfGTKmurQ+IpOG2d6/bext5Zv
         9UESVGa3lyWKOCyEHwSoZPXFrNYTfIyuv7tPmon5WgCs71piXTeyaYwpzxpA1zfVNdmf
         iDUxwXSx2+Kb1CZDF12rKyOHix2tqstIo8jrFh8EwbeTdQvdBm9AWGgfJipCD7Q13BU9
         64289P+YxBimiH9IEnVbfzKdHmhGouWPxvh55CnoeFUVeYTh3qjGYrL0zVzqBpjm2ha7
         xJEvr6fKQTKtmpzTYDNrdlcaSbS7M/AIayaXK6BYbmVvXmqGwQlnusyIWfzPEeMPYG3z
         SgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/EUe0RS08UvXCr/QRKhBQGnZARPUkvw6TX6lcOsPQU=;
        b=OdZOzo5LzlgXikAPF6mlXMKyYveU9NjQMzBIwLBe+23iH5QOvC78HuHCXz5jFuLwWb
         UjNCcEt6SOTiGEkgs0p810hxEDmx2ZsWHYCMQai6MDjlZRudUV9d5aPFxvJLPqpnYSok
         CH8Rr64UndlCr4sOvK4qW5H9Su0C2dataJ8b1BStxCu/B57FCXjpnYRuzicmKnXt5pKA
         ii1jv5Bfcj8KpGjDgvVnZLfaGkznJr78uhacyUe9JY9RL55L02vTyAUpDc98AXQGqxlF
         pRGlRag1lH5kPmvI2lz95aZJBtyrvghnzhAUmAwhkD2+svn+fRsHILrtGDEf5U8u8dbN
         UGDQ==
X-Gm-Message-State: AOAM532Oc9M3TJeqVmstTH4j77KWjkB4UoSDTnmlqbAoweMhA6CwZuVF
        lSpqs3N1JAUp3zrUZtzAMZXC55fKqCCZvg==
X-Google-Smtp-Source: ABdhPJzi+M6D0gqQs9dbmaMB7oLd2rqR1PoP9XVjuhlv2N/P+BOKUnyBbU1ZEXcpq0ns7L6j+ph+UA==
X-Received: by 2002:a05:6000:221:: with SMTP id l1mr2255246wrz.370.1615860829584;
        Mon, 15 Mar 2021 19:13:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:48 -0700 (PDT)
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
Subject: [PATCH v2 21/29] tree-walk.h API users: use "tmp" for mode in shift_tree_by()
Date:   Tue, 16 Mar 2021 03:13:04 +0100
Message-Id: <20210316021312.13927-22-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor code added in 85e51b783c3 (Make "subtree" part more
orthogonal to the rest of merge-recursive., 2008-06-30) to make it
obvious that we don't care about the "mode" here outside of the if
statement it appears in.

That's opposed to the sub1 & sub2 variables, where we use the two
object ids later in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 0faacd8f4ae..e84f993a460 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -317,17 +317,17 @@ void shift_tree_by(struct repository *r,
 		   const char *shift_prefix)
 {
 	struct object_id sub1, sub2;
-	unsigned short mode1, mode2;
+	unsigned short tmp;
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &mode1) &&
-	    S_ISDIR(mode1))
+	if (!get_tree_entry_mode(r, hash1, shift_prefix, &sub1, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &mode2) &&
-	    S_ISDIR(mode2))
+	if (!get_tree_entry_mode(r, hash2, shift_prefix, &sub2, &tmp) &&
+	    S_ISDIR(tmp))
 		candidate |= 2;
 
 	if (candidate == 3) {
-- 
2.31.0.rc2.211.g1d0b8788b3

