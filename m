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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EA8C433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FD1207FB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhACJi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 04:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbhACJi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 04:38:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FCFC0613C1
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 01:37:47 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h22so57786814lfu.2
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9pvG6dgK0fq9U4gx4tC1Z2QmcZb9g16si1bTJM5aG8=;
        b=uHHv8S4+c6inmo1PXpiMmy4SGSft9WDFMPFga3R7a/y9RmMkenTr3JUYN8q0D0BH9F
         PXSRfSIcsL+TwnfnX4056T/ftec81mA/zSId4ZbPbbXczQIh4pMMal8dT8lECeZJNCsz
         AELy7mnUaPuXTrs+d25WmqIFM2H1uliMhSWrzQj7VJCZ1XLyfRCc9/fY8hqf8j48Tfbw
         EwhMaRgUaXu8NQtph0nVQweBLKJ435BGJ2yDwvHablnTPT+8FIP0u2NJnbEXeUytzSVD
         26NV8FT7/3B+HBUzq/NIOSK8T3TTu6ncifCNati0MXia3+9OgRIjpKCb0QcbkkPm7e1W
         lnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9pvG6dgK0fq9U4gx4tC1Z2QmcZb9g16si1bTJM5aG8=;
        b=kYxrJQq1GEPHoaWqcggGih8OlXXpq5MLe0tFd48xJkX0wDYURKNfmN+J9xTp1AMZUe
         A96FXc8yBKECl3eoFt/yPdp2INFIkpXM3R097p6Y5yMI9mGABEUwPuLnMIir9J4CNUOl
         RCRuSkLVYcaXvgKLcP5Fvm5IwaiPQfk3QezcilLdb/eIcsCD/hZd3nQ5GNaQghr1/Mv6
         XjkBCib2oCdCTpzKM6jEdappM+d5Eu+hSJVaJm0SZV6Y+duevrgnhqhTHJfRMlxma5ca
         q2+fAuesWliGD+XWcqv++69mA1i2Vj6Yjsgzh5y4RDM3EgzjNuJVs+14vQdkn+5Nc/AM
         G5QA==
X-Gm-Message-State: AOAM5300kpPvhLE49YLI3XqT2Q1Zsy66WhirOylmUL27DELoy68VTqx4
        lBmBhgt/vFYv/4tbvhIq9uvE4xr8cV4=
X-Google-Smtp-Source: ABdhPJxO7Za1Ci9dBfdK+Np47VVpHKLAZPMvZhnc/lML0qDtriS8GbcGE1SG+Y/b7q4NWkb9BSbFeA==
X-Received: by 2002:ac2:598f:: with SMTP id w15mr27557680lfn.577.1609666666242;
        Sun, 03 Jan 2021 01:37:46 -0800 (PST)
Received: from localhost.localdomain (host-189-203-5.junet.se. [207.189.203.5])
        by smtp.gmail.com with ESMTPSA id h13sm7025202lfj.110.2021.01.03.01.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 01:37:45 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t1300: remove duplicate test for `--file ../foo`
Date:   Sun,  3 Jan 2021 10:36:46 +0100
Message-Id: <20210103093649.2221-2-martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103093649.2221-1-martin.agren@gmail.com>
References: <20210103093649.2221-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two tests for checking that we can handle `git config --file
../other-config ...`. One, using `--file`, was introduced in 65807ee697
("builtin-config: Fix crash when using "-f <relative path>" from
non-root dir", 2010-01-26), then another, using `GIT_CONFIG`, came about
in 270a34438b ("config: stop using config_exclusive_filename",
2012-02-16).

The latter of these was then converted to use `--file` in f7e8714101
("t: prefer "git config --file" to GIT_CONFIG", 2014-03-20). Both where
then simplified in a5db0b77b9 ("t1300: extract and use
test_cmp_config()", 2018-10-21).

These two tests differ slightly in the order of the options used, but
other than that, they are identical. Let's drop one. As noted in
f7e8714101, we do still have a test for `GIT_CONFIG` and it shares the
implementation with `--file`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1300-config.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97a04c6cc2..302821fb02 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -506,10 +506,6 @@ test_expect_success 'editing stdin is an error' '
 
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
-	test_cmp_config -C x strasse --get --file ../other-config ein.bahn
-'
-
-test_expect_success 'refer config from subdirectory via --file' '
 	test_cmp_config -C x strasse --file=../other-config --get ein.bahn
 '
 
-- 
2.30.0

