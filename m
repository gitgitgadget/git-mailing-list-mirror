Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE9C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B54E61AA2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhKSU3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhKSU3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:29:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A3C06175A
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so20090061wrr.8
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGTPAzjBxHiBN4ZiLHqa1yUBTlCpWk/DAYWqRaosINM=;
        b=evFXV1CFTCuydPux0C39tb03GDzs9ArQJYa0IhzmIQPv+BjtemFYoW5t9LcId7Jh0V
         7LfDFNat3Bq3yhiQsIhO+bk7XvTcTuQACW08QBNhi2HRKKZySCG8Gxq3RWX0x/O9j0AT
         y4TuemxGz++fY2C4G8j1tp7lUZyjwsnH87O+tDjOYmv2Y7ynXtqVX0qzNpTqj6LJ7LwC
         z0AE3WXrJXIfvzp71DON83/U6X53E6ktvWAUzaWGdtxpF9MBYkXltXOFVtMH9RoD3ung
         4GyNKB0rPHTpgJ80yRyfwsW6rHIm499y4/Bf0pXlVFfZ/0IssjpM1R1mpGlJiexYxVTL
         7Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGTPAzjBxHiBN4ZiLHqa1yUBTlCpWk/DAYWqRaosINM=;
        b=FPVniSs+1F+nvDIMDpXEc0WiYScq2m1XDJiGkInNyMm/2fsoPiSNI9OYmJJlExMYF4
         Le6sErqnqlMq3oIapl+fshk3SGbbxc1ft4MvS6/G2U4M1eMAgBDPIzZWtW8M9dArF2S3
         IhgSeS0OX4iKq2xEt1QjPAi3Z5GhSHPs711eJph9220nMyyAlotlRZYXC3h2sCxQhZlQ
         89e6pAVU26zjAMKq3F8y+CCb3ld8d2E40OTBAgXy/XtYW6Y1XWlQD+/OIv5FDpF9z/0z
         htCH24GtzColG81MSRBtYg/kkVBY16V8m0D1RdCjSz1BB4ALLgUBVLqT67+OhEXtEmCR
         8wvQ==
X-Gm-Message-State: AOAM531K7e7DuUEs+olA1qNilRxaPTnHJPIK6KZ0lPO6bJZjGoI6DWkN
        bMOo8vT9KBWsdbNx8fnKIPP4O0ajG8tJ6Q==
X-Google-Smtp-Source: ABdhPJxI24rm9lnTaKCIBzs6I+M9WsmWR6XzjEj0xyTm0b0B5jQl44CSximGXU9u9uLY/t3d+LfEMw==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr10512718wrb.436.1637353591688;
        Fri, 19 Nov 2021 12:26:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg14sm856202wmb.5.2021.11.19.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:26:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] json-writer.[ch]: remove unused formatting functions
Date:   Fri, 19 Nov 2021 21:26:25 +0100
Message-Id: <patch-v2-5.5-818f1a46d66-20211119T202455Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were added in 75459410edd (json_writer: new routines to create
JSON data, 2018-07-13) for future use with trace2, but have not been
used by anything. These are easy enough to bring back should we need
them, but until then there's no point in carrying them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 json-writer.c | 24 ------------------------
 json-writer.h |  3 ---
 2 files changed, 27 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index f1cfd8fa8c6..8a81c2d5fce 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -331,36 +331,12 @@ void jw_array_false(struct json_writer *jw)
 	strbuf_addstr(&jw->json, "false");
 }
 
-void jw_array_bool(struct json_writer *jw, int value)
-{
-	if (value)
-		jw_array_true(jw);
-	else
-		jw_array_false(jw);
-}
-
 void jw_array_null(struct json_writer *jw)
 {
 	array_common(jw);
 	strbuf_addstr(&jw->json, "null");
 }
 
-void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value)
-{
-	assert_is_terminated(value);
-
-	array_common(jw);
-	append_sub_jw(jw, value);
-}
-
-void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv)
-{
-	int k;
-
-	for (k = 0; k < argc; k++)
-		jw_array_string(jw, argv[k]);
-}
-
 void jw_array_argv(struct json_writer *jw, const char **argv)
 {
 	while (*argv)
diff --git a/json-writer.h b/json-writer.h
index 209355e0f12..563c7e0e004 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -95,10 +95,7 @@ void jw_array_intmax(struct json_writer *jw, intmax_t value);
 void jw_array_double(struct json_writer *jw, int precision, double value);
 void jw_array_true(struct json_writer *jw);
 void jw_array_false(struct json_writer *jw);
-void jw_array_bool(struct json_writer *jw, int value);
 void jw_array_null(struct json_writer *jw);
-void jw_array_sub_jw(struct json_writer *jw, const struct json_writer *value);
-void jw_array_argc_argv(struct json_writer *jw, int argc, const char **argv);
 void jw_array_argv(struct json_writer *jw, const char **argv);
 
 void jw_array_inline_begin_object(struct json_writer *jw);
-- 
2.34.0.823.gcc3243ae16c

