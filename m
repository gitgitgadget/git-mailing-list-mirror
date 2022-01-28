Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53EC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiA1M4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiA1M4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E312C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k25so15719319ejp.5
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFIuLLitEvRPDM4TJL/MPfua9VjrPWM8OtmzztW+PzQ=;
        b=ALGUQSWJqmvayEFLPUtzxPSxd4MlAdC9NPr/GJKd4LB3TJ4rBAlvEEAaa7aoK69YO/
         +2jrXxAYKXZqzdOzEw0JefhCL8TNJD0Ih4YSHbu37kOFQcCNQeb8ESgGQYpt0ZMxS9RP
         4ESUgCPbYSGtjezpGpzeLeY0i0Ir6oLJrqejH1nGmTI8miwIvWysu3AWj0Vunetonlrl
         sI+wjvmFK9QW2rMvXfpnPM+i/4OTdMaUieeCxbPoovQJJiyw/KdMJfGT0qsi6IPD1og1
         bu98nd9QRnBZO/2iBCZHch41dyVEcpiCkPtw0hNmytsjhY/dag9CJzSnwkyrpc8INeBz
         3Z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFIuLLitEvRPDM4TJL/MPfua9VjrPWM8OtmzztW+PzQ=;
        b=TpxbbkOyPv2TDTSP89AaZV5FZKHRos+Uh4fFYD7LYFGSi5+Cs80ChEfWzv4jUILrHn
         3Qq5fmPcixov1tnjIQKyU3ZH3qAuj3eNHZPKMcg8A4C3K0gZZiDhWX0Sq/7cYBq43uav
         4AssvT4Tg3+2LlzsgzFhJj8GKT5kNt/yBnykyXzETX81F7439AULsR7AFIp4dfsJtbJa
         ZcPOn3HzgpD6HduxpkdR70oTEOjt2kRMsujzPMSqNhouqqNNB3p5GEQkU9oUM3t1MqnR
         440n4B+owL/7ncP4PCtENCGBXJlsy+HQB6onsKmqDhQT1HF0vAYtz4OWOh2wnm573DZf
         ztbg==
X-Gm-Message-State: AOAM533Ixx4b24360437xAPAnfmIAC398K1bDOz4VReQl+l5xdzrWip8
        jMg7SPGVpfVeP8LlmRwMpnnwBox5tHgTDQ==
X-Google-Smtp-Source: ABdhPJwNjIpOXgqAUVhImA1/jvBkMcE2MF/l3CVrDbqqk2Ryr7ppPVyzNZy6QxCeKBl7biku7Dxk2A==
X-Received: by 2002:a17:907:9816:: with SMTP id ji22mr6982543ejc.168.1643374608551;
        Fri, 28 Jan 2022 04:56:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/9] submodule--helper: refactor get_submodule_displaypath()
Date:   Fri, 28 Jan 2022 13:56:33 +0100
Message-Id: <patch-v5-2.9-bc694987893-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c7c1e1432d..5efceb9d46c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -261,11 +261,8 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *do_get_submodule_displaypath(const char *path, const char *prefix, const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -281,6 +278,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.35.0.914.ge5c8aab0d5b

