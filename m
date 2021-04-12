Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91223C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE3D61278
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbhDLRQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbhDLRQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1298C06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso9128114wmq.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ceSPWEsw+cUeH4Euo4CFjQZN4aLbChH5L2Rds4UQ+I=;
        b=YH+lGq6V/E+vyeJx7rxNwW0Bom9Z795s2Gu2hI6PWTR81LMTiyK0KAaEFDpqhuXGAv
         O0pqGF1/I69v7bRqvNrKHPGtq2Kw1PSCDUukW9xlZkUG8MweipTgFnIJm4XsAofJuccd
         leqC6bVgK9CT3H5ByP+r20SGxB5MprlGQhD1Vcu+cLJOHfhmuj7zlx7aAGtD2IzNePjC
         0gactOIyvYarZefPGqfWTJuH8ojdGJaNlp5XvAmbxtTOKdxddB0qV0x6MXDMD7iy2Gyo
         tgi6Xweb+OEzUsS0ul/Myje+KrWPxN7JqRKKGWYZH308ct1knAiwVtxWkSd287yAgZDn
         QaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ceSPWEsw+cUeH4Euo4CFjQZN4aLbChH5L2Rds4UQ+I=;
        b=T9dhIvRx51ac94C0Ip/eXYON/3QjZXo5O2H+Zs38GAAjZ0wTd7sbmh7ukb+xwzc4eA
         cVqPbD9Rd/JufgmfVw70k6pMsdqO45dAnRKjVy9Y0GObToJIScUwTtOMhsIYIngcYWuG
         kTWeH/drgrjHHCtAK2+NopkfG1agw2r677dh09aGKAb8IY3HqavoYc1xQ83a4PUb1Ttx
         bBpSsXcIHpgvwylF+zZfZqIdZZE+BJeCeJKxRRkJWdVDXJb9JI5S0ZpfuerCqJK/LdA3
         iPciBZhC6qiWLM53tjNC372mU9oGONMQouSuZ2AYazPTu0GGdApmxXtpZszTR25QwuEt
         srUw==
X-Gm-Message-State: AOAM531ugMXBBKZMpJteZmHIh+p+ooMAE0DPhzzBJ9aueC3rSV5hazxn
        OwOhWPznbZ5sGisyyiXEv6c9DYQQgPAGXA==
X-Google-Smtp-Source: ABdhPJyNV3g/GndU1uft+EXRoD/urSxhG4Ev3ZQ8xDBtbpMLP4rVGKydehIWY4TJNtnwfixzp0Wp8g==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr164618wmh.56.1618247740269;
        Mon, 12 Apr 2021 10:15:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/22] pickaxe tests: add test for diffgrep_consume() internals
Date:   Mon, 12 Apr 2021 19:15:10 +0200
Message-Id: <patch-03.22-ddd2224836b-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In diffgrep_consume() we generate a diff, and then advance past the
"+" or "-" at the start of the line for matching. This has been done
ever since the code was added in f506b8e8b5f (git log/diff: add
-G<regexp> that greps in the patch text, 2010-08-23).

If we match "line" instead of "line + 1" no tests fail, i.e. we've got
zero coverage for whether any of our searches match the beginning of
the line or not. Let's add a test for this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index ad45d8cfd0a..eacb9f0a1b5 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,6 +106,21 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
+test_expect_success 'setup log -[GS] plain' '
+	test_create_repo GS-plain &&
+	test_commit -C GS-plain --append A data.txt "a" &&
+	test_commit -C GS-plain --append B data.txt "a a" &&
+	test_commit -C GS-plain C data.txt "" &&
+	git -C GS-plain log >full-log
+'
+
+test_expect_success 'log -G trims diff new/old [-+]' '
+	git -C GS-plain log -G"[+-]a" >log &&
+	test_must_be_empty log &&
+	git -C GS-plain log -G"^a" >log &&
+	test_cmp log full-log
+'
+
 test_expect_success 'setup log -[GS] binary & --text' '
 	test_create_repo GS-bin-txt &&
 	test_commit -C GS-bin-txt --printf A data.bin "a\na\0a\n" &&
-- 
2.31.1.639.g3d04783866f

