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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85887C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4888864F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhBXT4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhBXTxl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D01C0611BD
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:18 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l13so2893742wmg.5
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzixICTvEWBkooTXMVAoZaLGLhnvA7AjnnRsLjhnhWE=;
        b=g0zKH+X3GEmyhnEq6mV80CKYHKpwTAnHr/yCiFFCHD5poW1vokyENUPIG3UU3Frok3
         6ExnsXbT8aECvemizKthhm3nR4rJ5zU6f8tQ6hU4XwNS5gjH8W5mdyjtr3UlrCvSnNKz
         JH0Gnm6qA25lTs+qxuYM8px+0Pd3Lrx5/3crFsTAv3bYX0tH+BujwP8KtLjT6c969YS3
         7sMNYjss2o9sZi6QsIKBl7yPY8qIL7d4yAqYOBAAWwYQntr4o49kOzWGrcpmhbuUDNd6
         C3wx5uN8E029kq2wtH6idgHWlzARnxVscBxqpZQzmzwN1/S0BzaFoGAT9kCIdIieuYw4
         TMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzixICTvEWBkooTXMVAoZaLGLhnvA7AjnnRsLjhnhWE=;
        b=MgujRV+DyYw5DoEHXm0CuTXYis6NskZtr4JBhkNGDRKH4SuepDsQBRn32i2NhanfhS
         OTw5WDO7RrDk/2FGC/kDl9CO/2dj+GehINFTVHDfsiX6lx7yI4jqq/JhkRjyT2drw2gP
         zBrCi51Z3hSk6tI/K37tHXAN9ZV4uwqp2NYgy+L4nrvGDHZad/YuA15Qq43vdYrauF0X
         mtTtR4klVkJN7rRxAAwOIPhVPNwSNuqIT4qcXXWua3H5bpOJsRJukZU9CD5bizpnyqV2
         68mI3TukmZejwYjsCQO8E+Xe04nEau3zAaRci/0WBzcV5Jjbalc9g1mGMEZO01A/oT6o
         dwWg==
X-Gm-Message-State: AOAM533oZ1BP5QM2ZzCfMy7TYidkhGiDMt/Hoxs/0ohDpAmpc16otKiy
        iV7BLkmv6d5Tk2Ghm9H7dEHVw/pYNciANw==
X-Google-Smtp-Source: ABdhPJy+qQPQdQgzy8hJHKS73aL2ha1KQ9EMax3xpU7BbGejpbraqIlEfRq2lsBPBiwDtmx1kcBgYw==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr5243875wmy.120.1614196337179;
        Wed, 24 Feb 2021 11:52:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 29/35] userdiff tests: test for a bug in 1dbf0c0ad6c
Date:   Wed, 24 Feb 2021 20:51:23 +0100
Message-Id: <20210224195129.4004-30-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for a bug in 1dbf0c0ad6c (userdiff: add built-in pattern
for golang, 2018-03-01), we'd ignore everything after the "{" only for
"type" lines, but not "func".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/golang | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4018/golang b/t/t4018/golang
index 000e66b1c7b..70bf0d936bb 100644
--- a/t/t4018/golang
+++ b/t/t4018/golang
@@ -16,6 +16,13 @@ func RIGHT() {
 	b := ChangeMe
 }
 
+t4018 description: func with comment after {
+t4018 header: func name() { // comment
+func name() { // comment
+	a := 5
+	b := ChangeMe
+}
+
 t4018 description: interface
 t4018 header: type RIGHT interface {
 type RIGHT interface {
@@ -37,3 +44,10 @@ type RIGHT struct {
 	a Type
 	b ChangeMe
 }
+
+t4018 description: struct with comment after {
+t4018 header: type some struct {
+type some struct { // comment
+	a Type
+	b ChangeMe
+}
-- 
2.30.0.284.gd98b1dd5eaa7

