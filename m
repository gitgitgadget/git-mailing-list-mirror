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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC1C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360E723122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438016AbhALVhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436848AbhALUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABDC06179F
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k10so3039766wmi.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qguZE9vRyYW4p0GjHBfq1uKkD9Jw32ItTgP9aoQc26U=;
        b=tMbt9BXd+M0Ts4jl//n3vYqgKykUffdDvpZ15edd3E8Ogkm0NobhcBuYOr7uaDI2j6
         0l/JFQcE1nL30Y6YQuuuXyhJE7HS4RFt9w18WEmBehis0X9OATGl8dd8t0u5JKEIBNXI
         Ws0jA7dncADT+7mtOCd+kVzRHogA7zFGUXIvYx/igHWZT3Q24IB5wfD84KEi3p3PcT5I
         SNRE/eo/+3d2Xb7YaaqNB2xl0uETDH2hS7/aKAwQENy3SdJ3a7S5FQpKIJ8lNTZ0OSdn
         FX9ukXC99r6tFoBHp2OG51d7QEnJN5azyGaO+BV3MN1z+DeIWINoOHlr3HgUL9A+hxHU
         7nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qguZE9vRyYW4p0GjHBfq1uKkD9Jw32ItTgP9aoQc26U=;
        b=NIFy5c3j45X1sG3yyPL3VeBCnztXyfRoZSXW/usiXLvDh5SAcd8zBUwANv02Z9V3Rp
         WVFc7xakUUzCTca8UHX0IGoOQ28K7qWNu7mlo5YMyAo+VZWydGmXVX0QJxBaPh098YZo
         vItS7Eu64S9aVlXbi11g4ZUEneLmWMcmoIIGGNT2k/gtkBE8nBOqSzJoCtzwSgExDwy8
         b5fzbuNL+xAbMtHQSrsl7Ye1aSF6/FweQ2KII27iZNLTLB0brl+pGsWeohozFEMFYx+1
         r4WZQR1zxvekgE3lJXL0tIiaJra3yvDIazLqqMGFjeLDzoztpUIUr7KQRnAKo+QZWqTZ
         K1tQ==
X-Gm-Message-State: AOAM53375kMWPoW+lrkRG7PsVcbVw1QZx4J52DQLBnE6hfkfypGd6Hs9
        6iSrDKj6v7Dg3f6h+nj/zIEUWcTWXN9CyQ==
X-Google-Smtp-Source: ABdhPJxJbiVKVphbQ62e8oG8621d26v1aWyMhjjQTXR2CRx1qQmIhqaVMuFt5MaIp1kWzNRODkcm3A==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr554945wma.118.1610482698019;
        Tue, 12 Jan 2021 12:18:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/22] check-mailmap doc: note config options
Date:   Tue, 12 Jan 2021 21:17:47 +0100
Message-Id: <20210112201806.13284-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a passing mention of the mailmap.file and mailmap.blob
configuration options. Before this addition a reader of the
"check-mailmap" manpage would have no idea that a custom map could be
specified, unless they'd happen to e.g. come across it in the "config"
manpage first.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-check-mailmap.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 45a5cfafd8..02f4418323 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -36,6 +36,13 @@ name is provided or known to the 'mailmap', ``Name $$<user@host>$$'' is
 printed; otherwise only ``$$<user@host>$$'' is printed.
 
 
+CONFIGURATION
+-------------
+
+See `mailmap.file` and `mailmap.blob` in linkgit:git-config[1] for how
+to specify a custom `.mailmap` target file or object.
+
+
 MAPPING AUTHORS
 ---------------
 
-- 
2.29.2.222.g5d2a92d10f8

