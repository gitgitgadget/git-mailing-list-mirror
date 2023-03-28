Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103BFC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjC1N7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjC1N7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7113E
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so9154183wmq.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzNsp2akuohY/H7dKVAAe652mqxsnmH9o7l3NfkZFdE=;
        b=EGVtQfSiVewwUisW79sct9s1E72bSJa8mrP+H/myjetJ5lfBFG5KvFRuHD6lE/FZDb
         sEQJF3zbwOnP5YkNZwmpd2wfOP44lP89BXBGQKQ+HtM0x768z6Yim9eH3+B9M30LON6V
         GCVoiywwFr5xjZPToVWMYN1Pa+Rh9tqCCzfXyntvv6c1jdKU9pbBYbwzUCxivruEacD8
         f1bUVo63ZUO30Fuz5nwfvZqyV9E9/YUPrOCPyE6W8vmCjfLX759Pp2QCHyxTDdF94BC3
         jQIc1jLIjswEfvHJY+vdKqPQPSfZhJ8M1Jsl81NILUCQkMY+WRrW7Pko67bCwWST3wob
         QCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzNsp2akuohY/H7dKVAAe652mqxsnmH9o7l3NfkZFdE=;
        b=RDOVDAmKeEo9uHAhX4GRN5zXq7gWH0WMCdxnQv+6ahsTdzxk140nR31AuMIk5hK/6L
         W1uVc46Xmm/oklerc/pc4xlH31hCi8BXgsttJBEt+DIQvNAMM8pUZ9GFMBfA1HVxnit2
         EP0eEHZooEF6Gn22TmUBYlrPwGsgGpYczHEu2a/rTXM9TmpGXi6o8HkqEEkajVSIxXFX
         kDI/VeI5wz20Cfj0R8WLioFFohfLvETWH/RZv//1YCeNEG+agmlmkhkV7latF6p8Oqkk
         E50x3opz6tUUv6ObpHjVIAWdRVg2hrmF7j5I0Id4YJo1+2FqSEBvIk+m9p7oQ3HKwTGd
         62vQ==
X-Gm-Message-State: AO0yUKWoFr6zJlT0obLsIxYB6SasNYvbIs6ZtDdnH7K2fNzVGaB8HAOJ
        G6HfImpwsK2yahffdp1jL+Ainf/MLMVs0g==
X-Google-Smtp-Source: AK7set/Y0v8/NGgW+geeuZFRqdtrTfWdsYZKwQf/Kay489NHjxbZil9kuk44Fhnv4VvxDFIatNcXeg==
X-Received: by 2002:a7b:cb93:0:b0:3ee:814b:9c39 with SMTP id m19-20020a7bcb93000000b003ee814b9c39mr11954593wmi.18.1680011953085;
        Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/17] cocci: add missing "the_repository" macros to "pending"
Date:   Tue, 28 Mar 2023 15:58:45 +0200
Message-Id: <patch-v2-04.17-af8bdc2adec-20230328T110946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
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

