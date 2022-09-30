Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC8DC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiI3SIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiI3SIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD31E2FFC
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x18so8030795wrm.7
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AXDXwSpz/fzamEBJPfnphI4yzZxJE1iiVA11g7zgc+8=;
        b=HMNI/S173ODv4kpXK5vFaOP2srSF/bUvb4Yu29tcTGWsqJWxVw7FltrkeEEbR7+iRn
         ulzYymgl0kRiuciIWBFddMerJmtDsMvM6ZUQUWgvMri+veb1cbVLdJHoRwGeb03yYXUI
         DWdHggea9Uc6M9j89+IOeSD0kScg5edViTppgrY5IOO4wLURD3hu9NgKk1eyPe+RTCZY
         /1sDd5VhQZKvH2UbdKt74aeBSBIpQzXG3lrGY/AmlvizOffp9/mQ6BQ56a9JQgNdNDKK
         4OvN5BOf0JEVHHSowT96thMGBJhaQH3PpwtSHAlihnPVGe1qwK+dxSSFHK+4ybAiKbSM
         4WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AXDXwSpz/fzamEBJPfnphI4yzZxJE1iiVA11g7zgc+8=;
        b=p3Cpcuf5zmN4x/+RuxSSBYcWnGamsATBIndB76LRslDvZDRHablfWxIIrFhlAjT/Hb
         itNZXpIH1G1Aq/QYSS6nJktzc/q1x1vDHvNNyhQ2jjHE1vJMEkE07U8KHINn/rOA9xzT
         WVQJV/6yYfhKhO14lCKL5IPHq0zJyCiOGaZIXf2Pml5z3WQ1vnESghQtafG0lL1oF+E8
         bi2jDDIFSPNMlE1OYXvLqoJzLBYEfIA92yYWeTR/fcD/52eop3yQ3l3Q6M5aAUA1xw7Q
         kLVM0laLdq9UgnYNrI1GMUiBZsJukdHeaL8rUlPZuZYffGvGQ+IStbQ96rkpabb30urC
         y0BA==
X-Gm-Message-State: ACrzQf1FboZrJqi8NwSi5yziUIhvsa1loIluSpBqxEzP/X+xmavkqvA3
        yVU1NfvzknVHiRjVxG28+DGvzBfeaZn9Mw==
X-Google-Smtp-Source: AMsMyM4+wnpsu4/eN7UKLj1KEi3MDBErQjJVPzjXbso4U/UArLEnR3f7fA2wSSefUjUVOfy2T8iokA==
X-Received: by 2002:a05:6000:1566:b0:22e:2d99:76c3 with SMTP id 6-20020a056000156600b0022e2d9976c3mr856wrz.328.1664561298005;
        Fri, 30 Sep 2022 11:08:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:12 -0700 (PDT)
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
Subject: [PATCH v3 03/36] bundle: define subcommand -h in terms of command -h
Date:   Fri, 30 Sep 2022 20:07:26 +0200
Message-Id: <patch-v3-03.36-953a72abee1-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid repeating the "-h" output for the "git bundle" command, and
instead define the usage of each subcommand with macros, so that the
"-h" output for the command itself can re-use those definitions. See
[1], [2] and [3] for prior art using the same pattern.

1. b25b727494f (builtin/multi-pack-index.c: define common usage with a
   macro, 2021-03-30)
2. 8757b35d443 (commit-graph: define common usage with a macro,
   2021-08-23)
3. 1e91d3faf6c (reflog: move "usage" variables and use macros,
   2022-03-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5c78894afd5..1b08700bf9e 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -11,31 +11,40 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char * const builtin_bundle_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
-	N_("git bundle verify [<options>] <file>"),
-	N_("git bundle list-heads <file> [<refname>...]"),
-	N_("git bundle unbundle <file> [<refname>...]"),
-	NULL
+#define BUILTIN_BUNDLE_CREATE_USAGE \
+	N_("git bundle create [<options>] <file> <git-rev-list args>")
+#define BUILTIN_BUNDLE_VERIFY_USAGE \
+	N_("git bundle verify [<options>] <file>")
+#define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
+	N_("git bundle list-heads <file> [<refname>...]")
+#define BUILTIN_BUNDLE_UNBUNDLE_USAGE \
+	N_("git bundle unbundle <file> [<refname>...]")
+
+static char const * const builtin_bundle_usage[] = {
+	BUILTIN_BUNDLE_CREATE_USAGE,
+	BUILTIN_BUNDLE_VERIFY_USAGE,
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
+	NULL,
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	BUILTIN_BUNDLE_CREATE_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-	N_("git bundle verify [<options>] <file>"),
+	BUILTIN_BUNDLE_VERIFY_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-	N_("git bundle list-heads <file> [<refname>...]"),
+	BUILTIN_BUNDLE_LIST_HEADS_USAGE,
 	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-	N_("git bundle unbundle <file> [<refname>...]"),
+	BUILTIN_BUNDLE_UNBUNDLE_USAGE,
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

