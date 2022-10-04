Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B9C43217
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJDNVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJDNVb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:21:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874AACE3E
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:21:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bq9so21306103wrb.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNsiYuRQSP+tfKsK0fGGzhUJVjHNLbZA9YRouJmlX0c=;
        b=JjTyfoVX1GhBfItfu3wnUPuJgygo5yNb3YTK8JQJAmMVs8mPspXCxQXRKCQHcW5yDM
         sf3XRBBkBR3HclEhYXOIM/ULZmaiDO7iGVpS35/Kk0gaUjreSxZlr1WXgVScvY77Pnls
         ZWzVYhSxLq16krzDu4QoAPM3DuPkEThTXLNQXhsTymxiIyQZnbKVU7lzhBmI3urXt+Cb
         3LrkGz7yD+gCTVn+6IrsmLaWLENRBRHUyaj8Tp3rVnMdvQm17vJ/lWsVoI/7nkhDgFQz
         mrV7SysCud4i7EkAAyefDaeQLIUB5n5ZvdINtVa5CwijDOK7I1sziR1D1TOSlHhAlc4d
         LPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNsiYuRQSP+tfKsK0fGGzhUJVjHNLbZA9YRouJmlX0c=;
        b=Tz4aa3HfnrmlICUWTL9T/QgZiggdCOWJRYkv8aN9H7tV2Qb+f+cOs7xeI48y8pEVLA
         T0IhrQWm+oaHyCNh0JaQYEsJpehgMv+plpNReb+Z7wwONdgtovaO5fTCzTwkfjesPZPQ
         Ymz4WJgaNVaYRMqu/0if+3nr9Cd8M6FtICE9pkOP9ARmewF7b7HwwppnhBB5fKrw4owi
         975EnSYdoJ5HoNQkz1u+qWfWTQq0g/T0+xPBLBMn8DXustAUVLGWDcF1BaPD6vf0gJrK
         BfhA3wMbdm+J2yz6V9p9TZ2ajjBmQlAs6kBW7cTETGZ7BhADZgFEJ4JARpqVP0c7Upbd
         0IWg==
X-Gm-Message-State: ACrzQf0+T+YzFeMXtNP4XYPgNAAE+IAlRTmyCRrELe1ecwKhFQZGhsbB
        Q+vit1/eq29D1mybVre0VC/tJm8IMfSAFw==
X-Google-Smtp-Source: AMsMyM5vTpTSYBj3TVEj6ccumF5zBx3dFHFcodOoKCOzeMJqS3YlYwUjLsXflZFrvWDI01fgykUbUw==
X-Received: by 2002:adf:ed41:0:b0:225:3fde:46ea with SMTP id u1-20020adfed41000000b002253fde46eamr16112656wro.345.1664889687646;
        Tue, 04 Oct 2022 06:21:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020adfdb47000000b00228cbac7a25sm12429205wrj.64.2022.10.04.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:21:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/34] builtin/bundle.c: indent with tabs
Date:   Tue,  4 Oct 2022 15:20:48 +0200
Message-Id: <patch-v3-03.34-b7c98a40393-20221004T131009Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix indentation issues introduced with 73c3253d75e (bundle: framework
for options before bundle file, 2019-11-10), and carried forward in
some subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index e80efce3a42..5c78894afd5 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,31 +12,31 @@
  */
 
 static const char * const builtin_bundle_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  N_("git bundle verify [<options>] <file>"),
-  N_("git bundle list-heads <file> [<refname>...]"),
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	N_("git bundle verify [<options>] <file>"),
+	N_("git bundle list-heads <file> [<refname>...]"),
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-  N_("git bundle verify [<options>] <file>"),
-  NULL
+	N_("git bundle verify [<options>] <file>"),
+	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-  N_("git bundle list-heads <file> [<refname>...]"),
-  NULL
+	N_("git bundle list-heads <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static int parse_options_cmd_bundle(int argc,
-- 
2.38.0.rc2.935.g6b421ae1592

