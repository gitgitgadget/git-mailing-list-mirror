Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73569C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjCQPgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCQPf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:35:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDCAAA27D
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x13so22025665edd.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2iaTobd7U8jGdUfdw9d8q88d3tJJxq8Qsw72DV/zfQ=;
        b=jebKPz2WkwYqnrqlCIKDJGSOaTuXzFdvjnjpXEWtqrY+iyXBKR5tegmc4E2rGmliJH
         kQkZ/LE9YWXm6gjaa61FJ12a1xmt1EHO8207siTldApu9PN4Y8+T0LnvoYf26YkEL7Uv
         1REJzTJrnIorIbm9EgdcC/qq51kH5+8gH9QOhGTEYQYfzBXWGF2s3a/9dLb4z4lLPOX7
         jAy8yU1Ksdco7Ht2u5RF8tba6T3EKwjBNB9VHvjHlg6wWf08Bd2dNuJH8aYBA4G85pEl
         ZGMmN37Ndi+D8ekiKsvkLcjETYaVr1TPQj/lQrsqGoqR9gLnAnlp5acrZ8IukUcvLmV6
         sbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2iaTobd7U8jGdUfdw9d8q88d3tJJxq8Qsw72DV/zfQ=;
        b=gWKziDvI5gObd8bAOFgyhkJWF8cBQjJKTMWCxbHrobYLPjc5yDupkY/2MTwx7ZqW/s
         p+ZyxHntJO+0Lf50QWeMcK1yaslXWKG1BzoiBwsP2Mz/9goeNK9LzVki5siT2YKdjyZ9
         3olAYFSaDDUaUYGRyZIcP+3AJ3fctXsYhsb1eBSZiP+QLJrtBr0ucYQdANyK/19Tup/2
         ONkPDA1oqik83I+1w/CUEptw+neV9EHHxDNP8KFduGZk8bBeV+riDqwZFCG9B+sPsu77
         E99dopKhG2NoFxvYZZcqmVOSXyI5dbzgFX3rafVpc2l28slqAfUOTtKAMVMTSvc0EGff
         hLUA==
X-Gm-Message-State: AO0yUKU1AxPt64TchU7PAwaZ1zch8NRzZQXrk2bprQYgUmACMvf6nSsm
        lcqlIETriHd7+IbTo5IB7S7XlmgUkhxBSg==
X-Google-Smtp-Source: AK7set+M6O+D2zvJSFO4jjqoBlMSS/+k1nGqP8RlBGOh1woqItEzhp5Grbfu998RTD9LgDm3AvNtkA==
X-Received: by 2002:aa7:c792:0:b0:4fd:298a:62cb with SMTP id n18-20020aa7c792000000b004fd298a62cbmr3191772eds.21.1679067326623;
        Fri, 17 Mar 2023 08:35:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/17] cocci: fix incorrect & verbose "the_repository" rules
Date:   Fri, 17 Mar 2023 16:35:06 +0100
Message-Id: <patch-02.17-1b1fc5d41f5-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When these rules started being added in [1] they didn't use a ";"
after the ")", and would thus catch uses of these macros within
expressions. But as of [2] the new additions were broken in that
they'd only match a subset of the users of these macros.

Rather than narrowly fixing that, let's have these use the much less
verbose pattern introduced in my recent [3]: There's no need to
exhaustively enumerate arguments if we use the "..." syntax. This
means that we can fold all of these different rules into one.

1. afd69dcc219 (object-store: prepare read_object_file to deal with
   any repo, 2018-11-13)
2. 21a9651ba3f (commit-reach: prepare get_merge_bases to handle any
   repo, 2018-11-13)
3. 0e6550a2c63 (cocci: add a index-compatibility.pending.cocci,
   2022-11-19)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../coccinelle/the_repository.pending.cocci   | 160 +++++-------------
 1 file changed, 46 insertions(+), 114 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 23b97536da5..99e192736ee 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -3,118 +3,50 @@
 // our code base.
 
 @@
-expression E;
-expression F;
-expression G;
 @@
-- read_object_file(
-+ repo_read_object_file(the_repository,
-  E, F, G)
-
-@@
-expression E;
-@@
-- has_object_file(
-+ repo_has_object_file(the_repository,
-  E)
-
-@@
-expression E;
-@@
-- has_object_file_with_flags(
-+ repo_has_object_file_with_flags(the_repository,
-  E)
-
-@@
-expression E;
-expression F;
-expression G;
-@@
-- parse_commit_internal(
-+ repo_parse_commit_internal(the_repository,
-  E, F, G)
-
-@@
-expression E;
-@@
-- parse_commit(
-+ repo_parse_commit(the_repository,
-  E)
-
-@@
-expression E;
-expression F;
-@@
-- get_merge_bases(
-+ repo_get_merge_bases(the_repository,
-  E, F);
-
-@@
-expression E;
-expression F;
-expression G;
-@@
-- get_merge_bases_many(
-+ repo_get_merge_bases_many(the_repository,
-  E, F, G);
-
-@@
-expression E;
-expression F;
-expression G;
-@@
-- get_merge_bases_many_dirty(
-+ repo_get_merge_bases_many_dirty(the_repository,
-  E, F, G);
-
-@@
-expression E;
-expression F;
-@@
-- in_merge_bases(
-+ repo_in_merge_bases(the_repository,
-  E, F);
-
-@@
-expression E;
-expression F;
-expression G;
-@@
-- in_merge_bases_many(
-+ repo_in_merge_bases_many(the_repository,
-  E, F, G);
-
-@@
-expression E;
-expression F;
-@@
-- get_commit_buffer(
-+ repo_get_commit_buffer(the_repository,
-  E, F);
-
-@@
-expression E;
-expression F;
-@@
-- unuse_commit_buffer(
-+ repo_unuse_commit_buffer(the_repository,
-  E, F);
-
-@@
-expression E;
-expression F;
-expression G;
-@@
-- logmsg_reencode(
-+ repo_logmsg_reencode(the_repository,
-  E, F, G);
-
-@@
-expression E;
-expression F;
-expression G;
-expression H;
-@@
-- format_commit_message(
-+ repo_format_commit_message(the_repository,
-  E, F, G, H);
+(
+- read_object_file
++ repo_read_object_file
+|
+- has_object_file
++ repo_has_object_file
+|
+- has_object_file_with_flags
++ repo_has_object_file_with_flags
+|
+- parse_commit_internal
++ repo_parse_commit_internal
+|
+- parse_commit
++ repo_parse_commit
+|
+- get_merge_bases
++ repo_get_merge_bases
+|
+- get_merge_bases_many
++ repo_get_merge_bases_many
+|
+- get_merge_bases_many_dirty
++ repo_get_merge_bases_many_dirty
+|
+- in_merge_bases
++ repo_in_merge_bases
+|
+- in_merge_bases_many
++ repo_in_merge_bases_many
+|
+- get_commit_buffer
++ repo_get_commit_buffer
+|
+- unuse_commit_buffer
++ repo_unuse_commit_buffer
+|
+- logmsg_reencode
++ repo_logmsg_reencode
+|
+- format_commit_message
++ repo_format_commit_message
+)
+  (
++ the_repository,
+  ...)
-- 
2.40.0.rc1.1034.g5867a1b10c5

