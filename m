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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A1CC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E4E61378
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhHWLhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhHWLhH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB99C0613CF
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so10498570wml.3
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnnPIouhRiMkdlXzQwixtqUxX/ryUUSg9y1GW4JA69U=;
        b=etkywXXa3S5ndxqcpnSzxh85DEl0CO4ZiozTi9pdDlyojBChwgxMUk09bj/9u4moSH
         56I1mdPBXaEhvk2uzZ4/y8JvBRcXwz1/FfzrCoBKnTdj9jsevbVMSYLNZxu7ODiI4hoh
         AhamPCqRvOKtxb3ppN0DCqoyGi/37XfHGJqZd2zeJqV1LMorEg3ueDil8BUUJeJ640uE
         vOdZ1SVncPuCex+xstR5srx7VeskAQrvRvWbTwabotmQlz9HBWdqsqp1kmpPspf2UyDX
         cdLCdw84P6hXHuq5kPLZV2m70EB8sNHMa/Nr5SZQ6dQg3kSvuTI273myssHh7t9QjVZL
         voCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnnPIouhRiMkdlXzQwixtqUxX/ryUUSg9y1GW4JA69U=;
        b=k3QF5hMDNzp4fBXzfzVHTEIIAx95TUUw2hAOoO7CwX2MI1MFkFSLU01I+ql9iPA+GX
         Lwx5wQ7AwuOXAv7XlrOnW5zC7ikJbNKO3gIoK3YltmtSOk/dYJI1CwqZ0fMw8jxQGhyx
         JNnDOpc21lXm8SixRu2+JwgTSmGQ2kPShUJSSie0rQkZVAkAySyZme7IIDks7+GUq59g
         Snr/aPLmxPutDABoPXv8W8e90TNhijrToJxqLR7HunMeTNl/0t1tvdvj9vcm67SJ68ZC
         XhScPpoHDePeyL0SqItOA5zEbTzraUmWEuuU3ORIpOi//UDRwZO1D4/x+dj5+lUSCOBV
         +sMQ==
X-Gm-Message-State: AOAM532HzlkDzF06cqrrRoyHyK8kzJFQri74b4tcRP6aszHgUoPjarK1
        M7HpYNs1LQL5ByZ0rNntG1+HKlotLeCpIEAR
X-Google-Smtp-Source: ABdhPJxL1kWjqlaCM1td3mbjxAyAmq1VclrX1ZdOoQl56CWYVlTFXCQ4JNIPjiYsG79A/ugoyQ2Fhw==
X-Received: by 2002:a1c:2090:: with SMTP id g138mr15741447wmg.98.1629718581988;
        Mon, 23 Aug 2021 04:36:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/13] refs/debug: re-indent argument list for "prepare"
Date:   Mon, 23 Aug 2021 13:36:07 +0200
Message-Id: <patch-v5-06.13-24449766060-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-indent this argument list that's been mis-indented since it was
added in 34c319970d1 (refs/debug: trace into reflog expiry too,
2021-04-23). This makes a subsequent change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 1a7a9e11cfa..3f1455db2df 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -365,8 +365,8 @@ struct debug_reflog_expiry_should_prune {
 };
 
 static void debug_reflog_expiry_prepare(const char *refname,
-				    const struct object_id *oid,
-				    void *cb_data)
+					const struct object_id *oid,
+					void *cb_data)
 {
 	struct debug_reflog_expiry_should_prune *prune = cb_data;
 	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s\n", refname);
-- 
2.33.0.662.g438caf9576d

