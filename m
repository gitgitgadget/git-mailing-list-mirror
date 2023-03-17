Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF8C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCQPgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCQPgD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D5535BC
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so21901645edb.10
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzNsp2akuohY/H7dKVAAe652mqxsnmH9o7l3NfkZFdE=;
        b=FvyXPLes/3Iw7G6x359x9A8zxlMMjY6gSW9v+1Kz8TH9k5BjmU+JiikOS4khFCfGH+
         i6YCmqrWdRwpkaXln0aTcRTayivvE2yYCR1Ql4G+JpU/v4i09T45pWgxp0qDy/iXRo8v
         LNfRkdLqsRJX3g+QCzVmCImF+Rtpb66tpKZKi35xlw0y6uuV1auGijjHDojk3fK72G59
         AoBnlJxustZKL5WC0l/lsiAqT2/iBuKwdkx+PkzQiqBmk1NrXv8UHO/WF1Ci11+Kncgn
         5vn1e5gCiahDpHZwnbg2vzF8TxYOEJiBwSec6Hp98I7g5QQSY7slOjxlkQtp/k4gZM9A
         48gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzNsp2akuohY/H7dKVAAe652mqxsnmH9o7l3NfkZFdE=;
        b=mS+Pa0w9rxrQZU16IOXZ0urGWbX3X6MYStLHwT8+ofB2gAJuhe42euv2eF00YuGjLg
         fPoMxhqI2Q8LQfIzlKG6IW74VOGpP9UQ9iCfgwZvxJTriEXKt+EwxoQf5jwSTrGdCgJ2
         sa4CR4fdwd8u8B20mxvO5/WyhxiuaH1m2xgxxanbx88hZhJtjtjHZZQEd9f8xc4i7j+f
         8rJZookkzTbLTjF+PMA8yWTB7X5WG+Jrhqnu59x/p7d7VdtrMwJMDXoWbHNXT4AQswIC
         z2+KCb+T+gkEj4yIWe12eu+ut2dYXMq7JaJOk3HnRKuhUr6AptssKodtVXk+xR8cmlHV
         gkyw==
X-Gm-Message-State: AO0yUKUWAVr7FCqeiOE5OtDNNV6mEi5eowKapWzyvstvP+H/S6/OwaQE
        T4XuFbolIBFhsATrIFp3sH0C7Q+k4UMgHw==
X-Google-Smtp-Source: AK7set9egyZ6Ul/wElsQT9cUFXBRNZzm8N1+sqXWRwZFfR/0xyCsSB/imt+sXADErWw+SrOV8efqvw==
X-Received: by 2002:aa7:d6d0:0:b0:4fb:fd22:29c0 with SMTP id x16-20020aa7d6d0000000b004fbfd2229c0mr3425329edr.26.1679067328955;
        Fri, 17 Mar 2023 08:35:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/17] cocci: add missing "the_repository" macros to "pending"
Date:   Fri, 17 Mar 2023 16:35:08 +0100
Message-Id: <patch-04.17-4b62e9a35a9-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of diff.h, rerere.h and revision.h the macros were added
in [1], [2] and [3] when "the_repository.pending.cocci" didn't
exist. None of the subsequently added migration rules covered
them. Let's add those missing rules.

In the case of macros in "cache.h", "commit.h", "packfile.h",
"promisor-remote.h" and "refs.h" those aren't guarded by
"NO_THE_REPOSITORY_COMPATIBILITY_MACROS", but they're also macros that
add "the_repository" as the first argument, so we should migrate away
from them.

1. 2abf3503854 (revision.c: remove implicit dependency on the_index,
   2018-09-21)
2. e6757652350 (diff.c: remove implicit dependency on the_index,
   2018-09-21)
3. 35843b1123e (rerere.c: remove implicit dependency on the_index,
   2018-09-21)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../coccinelle/the_repository.pending.cocci   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 84b79dce480..8b3f2580e6b 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,7 +5,44 @@
 @@
 @@
 (
+// cache.h
+- get_oid
++ repo_get_oid
+|
+- get_oid_commit
++ repo_get_oid_commit
+|
+- get_oid_committish
++ repo_get_oid_committish
+|
+- get_oid_tree
++ repo_get_oid_tree
+|
+- get_oid_treeish
++ repo_get_oid_treeish
+|
+- get_oid_blob
++ repo_get_oid_blob
+|
+- get_oid_mb
++ repo_get_oid_mb
+|
+- find_unique_abbrev
++ repo_find_unique_abbrev
+|
+- find_unique_abbrev_r
++ repo_find_unique_abbrev_r
+|
+- for_each_abbrev
++ repo_for_each_abbrev
+|
+- interpret_branch_name
++ repo_interpret_branch_name
+|
+- peel_to_type
++ repo_peel_to_type
 // commit-reach.h
+|
 - get_merge_bases
 + repo_get_merge_bases
 |
@@ -36,6 +73,13 @@
 |
 - logmsg_reencode
 + repo_logmsg_reencode
+|
+- get_commit_tree
++ repo_get_commit_tree
+// diff.h
+|
+- diff_setup
++ repo_diff_setup
 // object-store.h
 |
 - read_object_file
@@ -50,6 +94,32 @@
 |
 - format_commit_message
 + repo_format_commit_message
+// packfile.h
+|
+- approximate_object_count
++ repo_approximate_object_count
+// promisor-remote.h
+|
+- promisor_remote_reinit
++ repo_promisor_remote_reinit
+|
+- promisor_remote_find
++ repo_promisor_remote_find
+|
+- has_promisor_remote
++ repo_has_promisor_remote
+// refs.h
+|
+- dwim_ref
++ repo_dwim_ref
+// rerere.h
+|
+- rerere
++ repo_rerere
+// revision.h
+|
+- init_revisions
++ repo_init_revisions
 )
   (
 + the_repository,
-- 
2.40.0.rc1.1034.g5867a1b10c5

