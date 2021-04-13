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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1914C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FACC613B6
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhDMJJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbhDMJIz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:08:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF64C061756
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u17so24758723ejk.2
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ClaFBbvgyIY+CZsiBOXIMAHg4vYaYlBk7ozkvfWzgk=;
        b=ZCIVW30B0z0nn37CcV8St67ZbEU0WBep09OrzO+1QzmB6q2GAbQUMKJO2PNwIJ0DJx
         uuam6Tf70Qlg81L+Nf92dUmZZkyBGB/I2J4ewmtdpjCk532vTJFVQW88gsR/yGBBS8/X
         cFqrJyQKB+ZnyUQ87OlJaCmiCz7sR4PMlg0twRDe39dgemN+3MQ/aSNDDUyk+bLjWcLc
         N08ojLo5CIFvJ+t2W4iy+r8QO+UAQJZTru1CeWirt9XRcDImYlrxOkNt8B6/5Z1hMqRn
         8YGUYnRUz/e8lwh254xH87Zu74nPxOACqfjxMrxoaqw5hK5Wv4T34UXpCVWQG/TLRGAQ
         XrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ClaFBbvgyIY+CZsiBOXIMAHg4vYaYlBk7ozkvfWzgk=;
        b=uJBVF0B83qnsJCNofFnD1GRkf2bdDgKNTZIidt1W98mwPlRPh50Jwyl+wKB5/i15VP
         qBh05zwQc8GX0wS/84VhmtceQKJcM65aFtHMpt7DaA1CtnyrZ0Kcv3mzOAsj5phxWmTK
         Jkx0P5rRNqfIFryIGmEnTA1Xjm86F8pCzoG+MUHmRJuPQp3IcJfkZYqP+yOrh9T12fdT
         kYSOxuXwa9l+z2LlbgaUQwbrCtuQKBDbAf7//7YKOvwBLEsp2VsGmSF5YLkN4Sl0mS2v
         wsXOXBm3zxb4cytWZdXmcAfKk8sWfjstftVIzO97RFiN7TO/32E6oPGrkHghiuP0RRy8
         5VyQ==
X-Gm-Message-State: AOAM533P7Visj4kuXApOdSUZdYVPQqMADkaJF0D+LDPooYGJPweqxF5i
        JeOZa04IvgEA5NDGdgVNoeQsGoZ99twCBA==
X-Google-Smtp-Source: ABdhPJyl0Qbl/M3AKyOmYo5YYyOx2nUpJ64Lw6xVC07GwesRclZKGdEIRn8rvcnNaBx+2Jdb5F1erw==
X-Received: by 2002:a17:906:8a86:: with SMTP id mu6mr9701465ejc.505.1618304911179;
        Tue, 13 Apr 2021 02:08:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 28sm8918318edw.82.2021.04.13.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:08:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] usage.c: don't copy/paste the same comment three times
Date:   Tue, 13 Apr 2021 11:08:19 +0200
Message-Id: <patch-1.3-2e4665b625b-20210413T090603Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com> <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ee4512ed481 (trace2: create new combined trace facility,
2019-02-22) we started with two copies of this comment,
0ee10fd1296 (usage: add trace2 entry upon warning(), 2020-11-23) added
a third. Let's instead add an earlier comment that applies to all
these mostly-the-same functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 usage.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/usage.c b/usage.c
index 1b206de36d6..c7d233b0de9 100644
--- a/usage.c
+++ b/usage.c
@@ -55,12 +55,13 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 	exit(129);
 }
 
+/*
+ * We call trace2_cmd_error_va() in the below functions first and
+ * expect it to va_copy 'params' before using it (because an 'ap' can
+ * only be walked once).
+ */
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	/*
-	 * We call this trace2 function first and expect it to va_copy 'params'
-	 * before using it (because an 'ap' can only be walked once).
-	 */
 	trace2_cmd_error_va(err, params);
 
 	vreportf("fatal: ", err, params);
@@ -70,10 +71,6 @@ static NORETURN void die_builtin(const char *err, va_list params)
 
 static void error_builtin(const char *err, va_list params)
 {
-	/*
-	 * We call this trace2 function first and expect it to va_copy 'params'
-	 * before using it (because an 'ap' can only be walked once).
-	 */
 	trace2_cmd_error_va(err, params);
 
 	vreportf("error: ", err, params);
@@ -81,10 +78,6 @@ static void error_builtin(const char *err, va_list params)
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	/*
-	 * We call this trace2 function first and expect it to va_copy 'params'
-	 * before using it (because an 'ap' can only be walked once).
-	 */
 	trace2_cmd_error_va(warn, params);
 
 	vreportf("warning: ", warn, params);
-- 
2.31.1.645.g989d83ea6a6

