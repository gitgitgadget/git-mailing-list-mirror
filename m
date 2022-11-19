Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A521C4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiKSNIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 08:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKSNHy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 08:07:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C79150F
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f27so19219303eje.1
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LTZurM52svLb6DffW0f3XwhUa3KTR3d9c5iYxl60wY=;
        b=okvhGAU96Eq8a+ypffVK+8lVPuKKaYVF8TbyjAz7XYt+4Uo6ki1stHuVFqpHDY5gUQ
         735t97nwaZTZ72LR0PjqZhKMyNeTi0N8qx6uGzDzcy/IvmX6KXkJt1BecwmeiRtJj2L5
         pdMldbq5Ma1bDhyDNHZeXmeVRqtBc/lycu79IRhilOmw8vY1SD7jmjMsv3zWGTA8EWbS
         GBWIWH0Hbk9A8dMCPSccym6IaSzAUkRy6CCbehEj8pS9rRCBf/YGWdekaAa32HPd6EAj
         0ZCHbb+F1unaAPsziVcW2LzFh2qM8xR9chAYwdKBoSHHuJQqW5Q+zgdxFdgP2eTpDCXh
         ENmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LTZurM52svLb6DffW0f3XwhUa3KTR3d9c5iYxl60wY=;
        b=1YNuQ/vZQTLXxtxQI7VgMby9DT6KUXUZLOk742moVqywbKxpgBZDU3WKypPeYE3o1b
         cv0NmewRadmcnmFnHi3PcdYn20l3/eKNSTV8IqJKtTIiImRBsfKBekP3s/j5cscSiuMR
         x/Ro03PtvdPP/Z9bpHCz/h9lFV8GYzC94BU3TuMkjae62XVB6iej/FQnOE6NOBNM+d2X
         bKGInBW+V2wAe06po2U3JUmH9htIn4AF5qlL5DyYMR6eCLXgysFCfBYEiHrYFeWTGpm3
         Ur36FJwTbfDzadWH3jbfxOtcqzBnd82QhRCRiQnZHG1+kL413H8EXB/l0fUsUxHU3hyz
         u/8g==
X-Gm-Message-State: ANoB5pk1LwO73iEbz/+JCHLGNNwIk/N64TVhaV/Of/lp5svdPi1PwODr
        j6+yi43bfhmJkxthamTzjXHh5Vjr8q/EEw==
X-Google-Smtp-Source: AA0mqf5VB2lP/rM/4Xr5RPqGEvWDq7fU6IqPuQUjzoqbEPOmaRVJsEn7L8qT0wbgETmeXYE7uRz/1A==
X-Received: by 2002:a17:906:2693:b0:7aa:57c3:3f26 with SMTP id t19-20020a170906269300b007aa57c33f26mr9452304ejc.195.1668863271678;
        Sat, 19 Nov 2022 05:07:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ch28-20020a0564021bdc00b0045d74aa401fsm2923802edb.60.2022.11.19.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 05:07:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] cocci: add a index-compatibility.pending.cocci
Date:   Sat, 19 Nov 2022 14:07:32 +0100
Message-Id: <patch-v2-05.11-ec740a81d9f-20221119T125551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221119T125550Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule which covers the rest of the macros guarded by
"USE_THE_INDEX_COMPATIBILITY_MACROS" cache.h. If the result of this
were applied it can be reduced down to just:

	#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
	extern struct index_state the_index;
	#endif

But that patch is just under 2000 lines, so let's first add this as a
"pending", and then incrementally pick changes from it in subsequent
commits. In doing that we'll migrate rules from this
"index-compatibility.pending.cocci" to the "index-compatibility.cocci"
created in a preceding commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../index-compatibility.pending.cocci         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 contrib/coccinelle/index-compatibility.pending.cocci

diff --git a/contrib/coccinelle/index-compatibility.pending.cocci b/contrib/coccinelle/index-compatibility.pending.cocci
new file mode 100644
index 00000000000..6e96de0f638
--- /dev/null
+++ b/contrib/coccinelle/index-compatibility.pending.cocci
@@ -0,0 +1,110 @@
+// the_index.* variables
+@@
+@@
+(
+- active_cache
++ the_index.cache
+|
+- active_nr
++ the_index.cache_nr
+|
+- active_cache_changed
++ the_index.cache_changed
+|
+- active_cache_tree
++ the_index.cache_tree
+)
+
+// "the_repository" simple cases
+@@
+@@
+(
+- read_cache
++ repo_read_index
+|
+- hold_locked_index
++ repo_hold_locked_index
+)
+  (
++ the_repository,
+  ...)
+
+// "the_index" simple cases
+@@
+@@
+(
+- discard_cache
++ discard_index
+|
+- cache_name_pos
++ index_name_pos
+|
+- add_cache_entry
++ add_index_entry
+|
+- remove_file_from_cache
++ remove_file_from_index
+|
+- ce_match_stat
++ ie_match_stat
+|
+- ce_modified
++ ie_modified
+|
+- resolve_undo_clear
++ resolve_undo_clear_index
+)
+  (
++ &the_index,
+  ...)
+
+// "the_repository" special-cases
+@@
+@@
+(
+- read_cache_preload
++ repo_read_index_preload
+)
+  (
++ the_repository,
+  ...
++ , 0
+  )
+
+@@
+@@
+(
+- refresh_and_write_cache
++ repo_refresh_and_write_index
+)
+  (
++ the_repository,
+  ...
++ , NULL, NULL, NULL
+  )
+
+
+// "the_index" special-cases
+@@
+@@
+(
+- read_cache_from
++ read_index_from
+)
+  (
++ &the_index,
+  ...
++ , get_git_dir()
+  )
+
+@@
+@@
+(
+- refresh_cache
++ refresh_index
+)
+  (
++ &the_index,
+  ...
++ , NULL, NULL, NULL
+  )
-- 
2.38.0.1509.g9445af83948

