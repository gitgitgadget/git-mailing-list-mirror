Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3FC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJMPj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJMPjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F42AF5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so3541449wrt.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpMROUk6R0s2dbCr2dG7A3B36EP3WJO7vLYsQy9MJUs=;
        b=nyUicadSwLrpEkwQrqAVu+M6IMvElhgVXpQ/1IEnxG+zMm0VYQ7PX3+Jp0ZsDx888w
         itZLf33aLEiPLxnPqNZderXgWKH02MrJeUcl3xqo8WrH0UphgHrDNP8KmBh/hhMCRNQg
         lYmJHsjkhgA6rleEH0DpYhsEFsyeKkX1v7YessMP6HGKbLKRTQeeVzKqgyRpa1JvOD/0
         x3MdRBKd8uyjDoOsilrIHP9YWV7NK5w8JIlUM8IeCpEQtC5nC36QwOyoAuHVGML1e5oG
         QMHEH6Z7K7JgLc9KBlkLL04ifXkxAFJeme39D2XxLLNdDOyi4ihHTZJs6QxHNwcZwfmu
         L5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpMROUk6R0s2dbCr2dG7A3B36EP3WJO7vLYsQy9MJUs=;
        b=6MenqvQTjWegOe9ZUGlSvc6bF0wiR8/kU1Bs48JbVyx7hBW6iWkrEh56nRrVEoX7Rt
         kAASjN3Eu5fYyjfs/dMwB6OXXfhCeBy9p29ZHFD6Pu/nC2yz2PHL/ehR0Rhi0HFE4Uq+
         ku1mK+O0Fz/TeEkC13s9dKW3i5xndj9CD0zmda4LVUy6xnqOpSAuURFbgC6ENoUPVDLE
         duH82L+2pvpyidCEjzgVcNSqnV2Zf05Hk7H0AqYsR4x0IWmX1x7jfEUhJ/WOE9xK0GQk
         6S3ZVbHFlwiqLWz3NEqs2vZ2/PjNdNHKfVpUIpMSdEEq//QQbswSLPI77ggNjSCz43Wo
         TKdQ==
X-Gm-Message-State: ACrzQf1KkkmpD8SFV4BtA3ZPOv6r8MvQsJDb4KGacnV+3Ko2NoMRYaOI
        AY0HFOmziabJBBDtnk1PVI3z1HPssgJ3Mw==
X-Google-Smtp-Source: AMsMyM4TwfhoxsqWBtSuzzRH6CFqAFMaKaLorOWqd/MLS9l+uyaXa8tojFAN0K9N9RESwE7ye56p4Q==
X-Received: by 2002:a05:6000:2cd:b0:22e:5cef:4332 with SMTP id o13-20020a05600002cd00b0022e5cef4332mr396029wry.540.1665675577902;
        Thu, 13 Oct 2022 08:39:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:37 -0700 (PDT)
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
Subject: [PATCH v5 04/34] bundle: define subcommand -h in terms of command -h
Date:   Thu, 13 Oct 2022 17:38:58 +0200
Message-Id: <patch-v5-04.34-7c9b42d8a9b-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

