Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F78BC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbiKRLba (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiKRLbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:31:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B867AF7E
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:15 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gv23so12350711ejb.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQhCCH0kSNRcJlPbdWmC7UKt6Q7ybAo46hFH5ir6P8I=;
        b=fAjh3HZNWzlLMeifB72uhYQmPV7vn2oVMAZ4RSiCgsd2bBQej9ElOnroX0GZmJoXq6
         WKzdURIi5VcQjRRtlV9ph3xhuQmogkPaQK8lv3Azg3GdAX64XBmIGFyCeJFwiRHjzRKd
         bzXSv0w8sVMTg2YpwIA66k7BA3ZUW3qop6N53WC3Mo/e/+9syPXdUWNYP58/uERx3Mpa
         yzMGmqbkgMlN64/qvc4sJFSLZ9e3TciXkvFt82yybt1TT/1ad0voEgpzr9rGjkv8nNMs
         xsWKUjmTCI5JJffRmcy9H0uBVDeNsOVHYCwzXis8hmT5irtECA39R4xCJXECCU38hz6I
         he1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQhCCH0kSNRcJlPbdWmC7UKt6Q7ybAo46hFH5ir6P8I=;
        b=fa/LmK+20VyKwkLzjEPrMh/OYjNBwFTZwvhYeIZMYnxpXrANE/Ryb5QKW5iMdsvZy9
         +uBt6pqTQFmbyJMLKjeN5v5bof4tyf2MfavtKN1CmPciq16cbCjOqO3Cc23STaVbGqj9
         gv+nw3BWsvlMr3iwFUKdv4+Avibw5JUtsLASogp1pTS41jINaMRBi1bPiz2Zalfi9OpF
         7a/9PXNfFa0OkunHJGKIlalD6K+Na1JL2nQNTxn0ahfi9rC8gkY18aK6qJ/r3ANDv/gn
         Usle9Z/PUFJty5XfUr2HSABS0ZbrBvxFFgxxxOm5aFGE0B5RzTDd56/AQpMCpZBRQElJ
         0gxA==
X-Gm-Message-State: ANoB5pnF29CgmZTm6i9pqRhkPkpIWBCn2Ek013NR3kQ/rcq0eDo9/RCL
        yyAgYnmpqRlyQuhz3U/ozgrhJv7kydy0rw==
X-Google-Smtp-Source: AA0mqf5pY2/YzC5RM4SG17HLfVsk+QkNN7+UxdGQiyPci8IEuzLzubdxkueoC4Hf739qztO3VUQKfw==
X-Received: by 2002:a17:907:9190:b0:78a:52bb:d904 with SMTP id bp16-20020a170907919000b0078a52bbd904mr5459700ejb.630.1668771072765;
        Fri, 18 Nov 2022 03:31:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm1713302edb.42.2022.11.18.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:31:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/12] cocci: add a index-compatibility.pending.cocci
Date:   Fri, 18 Nov 2022 12:30:59 +0100
Message-Id: <patch-05.12-14bf6e7188c-20221118T112205Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
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
2.38.0.1511.gcdcff1f1dc2

