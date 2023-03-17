Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A5C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCQPgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjCQPgC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF2E11179
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so21879546edb.12
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkkwpitzlrRJdJ6OQOUcN1V6YydOfFTbrH1AB+jyCWE=;
        b=MdP+l1l/LTvvmN4ZP3jjtokjWMsYlsdaYQOHwtzgoUaiDkezTsIEI9WMKhXG6ETxz0
         uPou6hD0vyPJs+uJe27K38tiZ1tEFdzCpwvh+4SWLylBBdHwPkTVakBy2GN8Xt2OwApR
         Za21/cHiO57QWivpFvsmch2UMOTvB/wqAsQqLBNxYgubNWtu9crBfnrLgC+k1vhLG+I5
         JVU9GChmc4t6eSpsYGHv4vFvYzES+asl3Gwe9ARH/CklRRiHrH2JjEAcFDNGHBhvUpxp
         Uxbxxd/me0i8Tb94dSr3xXALCc2U9nootPYbSC++u4eQHVDS0uyi1//MnWq4wmxCBXa3
         3BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkkwpitzlrRJdJ6OQOUcN1V6YydOfFTbrH1AB+jyCWE=;
        b=srijZ5tU/YuNu/NglpjVYI0XLC+976m5MBHrdXV2GNe8eJcjBa2hYktcRM1jr5zj00
         1QdB4MHxWRDV2hWENy4Vv9EKbZxWne9NiRlpgTj2cwFR3SzzGwNJXXQDEFA/seLSP34i
         aGN7ncg04y5ApttUCxhA0FaxV5q+492YRCf/xRrNBj1d5BzfyNEFb+M3Edlx8hElJs15
         nGK2LvmsJ2t6L1o77IkjDPBtxWefS8PDOAVrOrkVVHuIQKMUcyVXMhu5rXqqci9DvEpY
         h5TWBXbZvt/14C769nh4kMdh8tR8w7W4v7YlKULOwncLLsqyzbAwOpcZ6c8d5NbjbcV8
         0nzw==
X-Gm-Message-State: AO0yUKXYHyjgG6rOpsaC6tn9B2foywSwhiXJKcMFNoa9zbd+Hbm//Wuw
        33Ph7rbmA0kguWiJMEAC1mja3G79PS3kDg==
X-Google-Smtp-Source: AK7set+Sn5iotbDh6mzfrCZMJeRDB7d5fCKfrx8oSpW3a/KmJy44qXU964orqzJN+56HV6XCJRwsRw==
X-Received: by 2002:aa7:c050:0:b0:4fe:cbce:5fcb with SMTP id k16-20020aa7c050000000b004fecbce5fcbmr3419942edo.9.1679067327578;
        Fri, 17 Mar 2023 08:35:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/17] cocci: sort "the_repository" rules by header
Date:   Fri, 17 Mar 2023 16:35:07 +0100
Message-Id: <patch-03.17-34c6b8afd6c-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sort the "the_repository.pending.cocci" file by which header the
macros are in, and add a comment to that effect in front of the
rules. This will make subsequent commits easier to follow, as we'll be
applying these rules on a header-by-header basis.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../coccinelle/the_repository.pending.cocci   | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 99e192736ee..84b79dce480 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,21 +5,7 @@
 @@
 @@
 (
-- read_object_file
-+ repo_read_object_file
-|
-- has_object_file
-+ repo_has_object_file
-|
-- has_object_file_with_flags
-+ repo_has_object_file_with_flags
-|
-- parse_commit_internal
-+ repo_parse_commit_internal
-|
-- parse_commit
-+ repo_parse_commit
-|
+// commit-reach.h
 - get_merge_bases
 + repo_get_merge_bases
 |
@@ -34,6 +20,13 @@
 |
 - in_merge_bases_many
 + repo_in_merge_bases_many
+// commit.h
+|
+- parse_commit_internal
++ repo_parse_commit_internal
+|
+- parse_commit
++ repo_parse_commit
 |
 - get_commit_buffer
 + repo_get_commit_buffer
@@ -43,6 +36,17 @@
 |
 - logmsg_reencode
 + repo_logmsg_reencode
+// object-store.h
+|
+- read_object_file
++ repo_read_object_file
+|
+- has_object_file
++ repo_has_object_file
+|
+- has_object_file_with_flags
++ repo_has_object_file_with_flags
+// pretty.h
 |
 - format_commit_message
 + repo_format_commit_message
-- 
2.40.0.rc1.1034.g5867a1b10c5

