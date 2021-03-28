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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE37C433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4548F619A1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhC1C06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhC1C0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:26:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D4C0613B2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so4839897wmf.5
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MA4d887IsCN9gNY8X5E9E4eHf86FSsB0QBPTIHyEkm0=;
        b=YexKTfLV4cEdJ6VTSjYDLPoTo0TN1Vs2MpGDmAct+S0j5MtnZAEcdqGckWs/pkT/wu
         R0dBXRXQV9BgTOKt3/NkScnOzKCAFphEILLcMGlx+iB9obVkQ8VbWngTEZWtJ0xTBWbY
         bLnKhDkSm5cFAp+8q9yHmBXlJHlwI+W0224BOx4JEsiz+yJSlUwbin5xooIirbKKpAZu
         Fstjs45nXvDXm5R8FWgapuH8ypAkCQTmruir9AKLPNYzFVOl98wPdK5lSdiG03qrE3+9
         lywQBDUvaFSk571uUGmJgA/C/OvB5b1QWsAdK+kDIcn8JD19dOWp70ZWZHE7CCkng1Ul
         UMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MA4d887IsCN9gNY8X5E9E4eHf86FSsB0QBPTIHyEkm0=;
        b=ne8O1Ecc7EkSSiacIKBmRwXGPso/qHWB6u+ygvs15LpoLwFZAwzZgiNLFjY2C7J4R5
         myzBP1VB86u4KwNZKIykT6VcrmY9PK/5DFvc5FiBLdLo1gOgm8WK+q4FRPl5egBJKT3h
         PM+y7vvpzSCaHOxmJxTFmucuGsy7ET/o8PTQfzRh+D1tgMH5avcWq9yDAUnCnQGLe27I
         xHygA23hai17t3cU+VPMBGHGgZX7VxP6ZBV1BDyWlHjnMgaudKgw+uaYDx5l5j5W/x6b
         FPrbVJSlaGXX8faMM3E397DledFuCF4zM6NwtNa6gNOcMdFyUtqMbSq4JyVVoLC0QHrW
         ZbPg==
X-Gm-Message-State: AOAM533lNU6x/MEbFjZLpZMwYCgpN1AUG3Qd0xwlHwqA9UzMLdy8IDAl
        XAngbGfjthtAvxs/VHe9w/sfEdYhhNQYrg==
X-Google-Smtp-Source: ABdhPJwQ0MNyUfkDk2gHvFhBtsrKy8juuUuLjAqgbEKzpNDkhsuShGpwEDT0uOTBZcLbIYT3tOZq8w==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr18648757wmq.25.1616898378399;
        Sat, 27 Mar 2021 19:26:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11sm17887305wmi.3.2021.03.27.19.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:26:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] usage.c: don't copy/paste the same comment three times
Date:   Sun, 28 Mar 2021 04:26:00 +0200
Message-Id: <patch-1.5-a7b329c21cf-20210328T022343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In gee4512ed481 (trace2: create new combined trace facility,
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
2.31.1.445.g91d8e479b0a

