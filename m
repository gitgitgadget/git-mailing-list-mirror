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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6865C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A792661185
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhDIIud (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhDIIu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:50:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E04C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:50:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so7452403eju.1
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7xybGHsN0JYfgY5tgrx2+cuNyyXZyfdogT5+tDXU+0=;
        b=PHfFOI2BkH1c4erX5yj/1S2eYK7lvnMV1sNh8yj/xTfqbPrUBNA5qZPHLdy65bqkVD
         AFs9OFur0DQxxP+GI0+jfxsrJozCcltsJt9zDetM0D2fJvtDi7nebYSM3sdZ5k2wGf1P
         +Tr1WqfNaNnJjcMLSOwT0HECX1CIVDzQ5nuhRY1c1ik2gRDlNM0uigIsXhHTMOYpgTYW
         XRvhdxME6+rP5kYyN3KFjCziXkusz84Lq9m/thAH1vFyMBj/DUmgR0+zO7Ag/E3xkIOl
         15FxxJiIQCKFCn4Yw4XWSsnyF85mpKWgvVVWP8Yq8xQ8uKM+d6DSdufjDb5m8hvJs+SZ
         O5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7xybGHsN0JYfgY5tgrx2+cuNyyXZyfdogT5+tDXU+0=;
        b=Ru7NLh0vv0zhpc5MAJLvsBMJP9nAonwD6Qg1nbynzUerbJw6v7dEYFIhO1+w7geQE3
         Pyr7wFyaeiIA4Y2IgXwsJC0M3zj9Y2wofru0mlZqWD8SobiNN/9uWsbr4eNOqd+KV1qZ
         qKHWqqP+Ga3AVQbxp57keWcYm8a/JWnbefTfcW2tjwgNFYap8P27FeTUTzh7JB/9Z+yD
         SKtiREwDSfGn+7K8M96E6WrqpdeKWtbhwE4r5yEd0tsJEkuYngdyZIVW0NqsNnPUWLSv
         5UVhZjLSWzTPooT1wHc7NsGz1oJtBJUj+EgUF6G0VN5Z1Ur5c1N3/WaHvj/7GXGUetgr
         BnzQ==
X-Gm-Message-State: AOAM531z8ymReYZClMcpmlyElcj/GefxFP9VskcREdEf85l11p8iBryE
        /fdz/u8I+Ntz//FXyI5BDhiz1b/7/GkM9g==
X-Google-Smtp-Source: ABdhPJwy04L5xpoDwqpY/zFVnHiGJKSPN1NUeAD3KIk6+VAY8PpX3QRyp0yXPhVYCt7SClEMK02ndw==
X-Received: by 2002:a17:907:94c3:: with SMTP id dn3mr15316743ejc.280.1617958212411;
        Fri, 09 Apr 2021 01:50:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m29sm883601ejl.61.2021.04.09.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:50:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] tree.c: fix misindentation in parse_tree_gently()
Date:   Fri,  9 Apr 2021 10:49:56 +0200
Message-Id: <patch-1.7-4bf9a4f7a1-20210409T083436Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.592.gdf54ba9003
In-Reply-To: <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T083436Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables declared in parse_tree_gently() had a single space after
the TAB. This dates back to their introduction in bd2c39f58f9 ([PATCH]
don't load and decompress objects twice with parse_object(),
2005-05-06). Let's fix them to follow the style of the rest of the
file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 410e3b477e..482a37d8fa 100644
--- a/tree.c
+++ b/tree.c
@@ -123,9 +123,9 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 
 int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
-	 enum object_type type;
-	 void *buffer;
-	 unsigned long size;
+	enum object_type type;
+	void *buffer;
+	unsigned long size;
 
 	if (item->object.parsed)
 		return 0;
-- 
2.31.1.592.gdf54ba9003

