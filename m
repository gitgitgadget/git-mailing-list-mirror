Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C344C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjC1N7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjC1N7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE213A
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso9516809wmb.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2iaTobd7U8jGdUfdw9d8q88d3tJJxq8Qsw72DV/zfQ=;
        b=KxtU5ilh4t9wFwJFud1o2DwW+vbDFTH/bl8j+u7BoVHdfJM+Ez5CeudWWhIh+yLLhM
         KI0aw6lxthM/bKE9YwoHWcnX3zeyxJOMLaaz5+bT7C6y1p8P8VpHY8tlq6kF/2ikxRTo
         iZwUFjk3dBuRvEZemhkzvT1zhNQGaX22rLlxcpjlm2PKXnziy8TTRwajs7VLBy7Ie72K
         ZlylgNT/o7dGeanM/BzSY4G9EcbCVLRRub3WQ35o+yg7+mDyfEczeVo/EBcXP0EJmDLJ
         +sXU3D5CZQsClFgm2Qy8Kyzqo0RhUppzZvPk7yVctRNIwxNnE8UxEDdzOVpMyz76Gplx
         Hi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2iaTobd7U8jGdUfdw9d8q88d3tJJxq8Qsw72DV/zfQ=;
        b=OwhGsLMYDgWm5LpMggDXhBBnKzDnum6Ie0id405bcKz0ZxiPlLf50OhArjFKlH6g+f
         DbYyUDXYIGEIZxtc/q6mIQmU5aGATDaTWAyrNSDqTNxFzhy2bEIeimA44xkDZNWVGVTj
         dAlOS/UfamRGaJ6I/LqkCDHvbkKt8IA9sCySqhi+FF7kaF65m68mUPGk2qGBJHSwlMTh
         gkuJReTvi5LjDxvM9iseQCEC7ihAfVtptu7CSFEgBpZm6vLd9EvqCDHCsHPpeOgSBGiM
         XsK1Z3xvP8qnzOcOdKG/9bjKAwU+Zgv7Wu22vsy+P4UjyolZ5bwoZ8K9vw/erwzinprP
         /MPQ==
X-Gm-Message-State: AO0yUKUZbwdoFiaMBoyADDhlF2ikFpk9oQE2XheHbo3Tn9/Ke1dYW4P+
        THJFENPxRAZgUJD7+vDCt/Hd7G7T52lgaQ==
X-Google-Smtp-Source: AK7set9yaquT9izF38Rp298Fm19rkiq8/YDXT8RRtD4toFMKagcr3ZHckICS/ReGoARbSEnrQYpWOA==
X-Received: by 2002:a7b:cbd2:0:b0:3ee:3e07:5d26 with SMTP id n18-20020a7bcbd2000000b003ee3e075d26mr12226232wmi.24.1680011951561;
        Tue, 28 Mar 2023 06:59:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/17] cocci: fix incorrect & verbose "the_repository" rules
Date:   Tue, 28 Mar 2023 15:58:43 +0200
Message-Id: <patch-v2-02.17-5ac9d5b8905-20230328T110946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
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

