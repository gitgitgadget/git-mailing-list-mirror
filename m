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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BBC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31F964FDC
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhBEW15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhBEOUK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:20:10 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FAC0698C3
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 07:56:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id w1so12611954ejf.11
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDK16P2e0rTeYMiBGwvWsBHGJpVBBYm+JTdtKixPLIE=;
        b=N/puu1ticPrVVnoV8QYaGTI7PErmhUNzPFwuahjI4N+mMCGkQv9jW4zi/M7EEV2dSV
         OtxmALwfHIxlavzH1ngNBUAYewRH4Queeyt9yRKuDqhNPIeAEXQICdTkRE856/yltOK6
         HXPLK9C9WOJLj0BJ4J9IXa9nEX1Om+1ShTknrIC4Xq8T+6C8RMJvYIUVs/hJhyOvovPS
         IvAyvnOCwliP6yrLBqHxel5nwZlXyUzARDVWru9bczd7SUqHPHnkwVNxHAc/ZVeMmE6R
         Uka5BOywa7gEyoDFx0tm0PLpUWb89ZkUAOg3rgi1HlGrk69+OqkytTO1RAAoCjAznBC4
         zVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDK16P2e0rTeYMiBGwvWsBHGJpVBBYm+JTdtKixPLIE=;
        b=gJSIN5IAXG0yx6yGuDo6rm5v1ceiFONn304MKr8AH+bWjQTg+y6G537mhYl0aDPO4e
         KxdvzjQnf+m2GiAqcZe0d4Hj/SLKvPBNl+KIxaRcGUAmeG8B4TKFceEunVES217HicrY
         EechBjCyZJHCXxqXWm91YK4k+yyTWpm4XmalN1t2Hup2Z7cfKggEgvO7X4LNX3loXluH
         +vAOO+C/pFcyKQuyJFSwB2JIHS2wP1T8BG6FXQh1fABVLtMKoZjlRuLOfpPOZIVBekC8
         U6smG9VYNq7C9Bebb2OkfGX2Z/388HbXcxZa996a0CwtsTxIB4nG8Lk5t4FLv2CZNeYP
         L4wQ==
X-Gm-Message-State: AOAM531gwzrCGG06QBLbGWeLpUGqLLFQBVTIr8lwta9HMbJVxhHnDArQ
        s6z4CZFxV8oIb5JvYTz3dlylk0nAjd+suA==
X-Google-Smtp-Source: ABdhPJx6JPMH9qXo9vEavZ+kpPjSaeDHh2RHtrbMZz2prp6LptNJ81RaoQuE3mZMgsXJK7mdyxj6DQ==
X-Received: by 2002:a05:6000:1547:: with SMTP id 7mr5323426wry.301.1612534656062;
        Fri, 05 Feb 2021 06:17:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j15sm12630172wrw.9.2021.02.05.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:17:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] diff: plug memory leak from regcomp() on {log,diff} -I
Date:   Fri,  5 Feb 2021 15:13:20 +0100
Message-Id: <20210205141320.18076-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20201020064809.14297-1-michal@isc.org>
References: <20201020064809.14297-1-michal@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in 296d4a94e7 (diff: add -I<regex> that ignores
matching changes, 2020-10-20) by freeing the memory it allocates in
the newly introduced diff_free(). See the previous commit for details
on that.

This memory leak was intentionally introduced in 296d4a94e7, see the
discussion on a previous iteration of it in
https://lore.kernel.org/git/xmqqeelycajx.fsf@gitster.c.googlers.com/

At that time freeing the memory was somewhat tedious, but since it
isn't anymore with the newly introduced diff_free() let's use it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/diff.c b/diff.c
index 3e6f8f0a71..24257759bb 100644
--- a/diff.c
+++ b/diff.c
@@ -6450,10 +6450,17 @@ void diff_flush(struct diff_options *options)
 
 void diff_free(struct diff_options *options)
 {
+	int i;
 	if (options->no_free)
 		return;
 	if (options->fclose_file)
 		fclose(options->file);
+
+	for (i = 0; i < options->ignore_regex_nr; i++) {
+		regfree(options->ignore_regex[i]);
+		free(options->ignore_regex[i]);
+	}
+	free(options->ignore_regex);
 }
 	
 
-- 
2.30.0.284.gd98b1dd5eaa7

