Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA945C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCQPgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjCQPgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99992C65B
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so21938831ede.8
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ2egSyX+4OijyDCBPTo8CBCCDrwBAFw2cIi7XfKEqQ=;
        b=J+8ZuJes+hTVoGeoiIGSwpG6fmSU2bjcbUyT2XAy/YB4XykvebWVmf+0BuCuYIBZgt
         qhGFywQQ3SnaeUjIJurMx7wNG/s3qOyRw6xmbsmCTKJHBm551a30HFCKE/YudflwArF1
         q/co6NX5IXEM8JeP6lThiumg89XoHHlbT+hoqi9WSjyh2sk9HZsU2eEhhlm8QKRiYnjk
         iHx0TOM7FHTJYZoTLtlTRgo/fMhXm3/JP5sUQ/YwCx7TgWI6AxScnyzIhAMdiBfOLZWC
         bwClf57YHffr4KGoQNEnj/vo7Tjie1RS1XLE4wmp24z46spb6nYK0lrlaQm3RWx3DksA
         x9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ2egSyX+4OijyDCBPTo8CBCCDrwBAFw2cIi7XfKEqQ=;
        b=78JpnioS9zIa+FfpmPXmf90bX4SLnhCUbHsXbydN/n5aa4A/T1HWiCRzRY8+aDHiNT
         1k01Y78COlwyiQ0YjazrRmBPOH0Yj/nsybwppt8YwwhcYaSPASnc5NXyV0aOd+I9R3ud
         ph5pMx7+kHiGTkXnqe2z2llVlFtYH7rrkGAanT20sOhUi/X0aQFDRl7CH3VYTsUS8L9q
         IV96SVlsIDFBpV5erxnBGtCFy0Z7sqRV3eVzYCCCnFYn2brpGY9NOPYBMYnYO3i8ESaq
         zTVgzoacKmIrDuH1eMYar+FC5grU6oS4t4/Os9iRUlBtvUgBNW6MML/Gxyhi82KMGzPC
         DJNg==
X-Gm-Message-State: AO0yUKURlaleup1KRl3RlSlrz7SGtg0NwDbP0IOBL5W5XvVzeUWsUgWb
        pJOW0w4JwPaPTJW1Q4si913hSheibFFh/g==
X-Google-Smtp-Source: AK7set+r38LmPUYVKihFWif4q01Uz/1Mh1gOXFue35/Q5bLkwzALd1HJNTB0IVnbqow8IdSR99sqNA==
X-Received: by 2002:a05:6402:883:b0:4fa:2363:6806 with SMTP id e3-20020a056402088300b004fa23636806mr3481060edy.17.1679067335450;
        Fri, 17 Mar 2023 08:35:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/17] cocci: apply the "packfile.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:15 +0100
Message-Id: <patch-11.17-8cfc1c18878-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"packfile.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c                                    | 2 +-
 commit-graph.c                                  | 2 +-
 contrib/coccinelle/the_repository.cocci         | 4 ++++
 contrib/coccinelle/the_repository.pending.cocci | 4 ----
 packfile.h                                      | 1 -
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e60decbc56c..bef26020f99 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -284,7 +284,7 @@ static uint64_t total_ram(void)
 
 static uint64_t estimate_repack_memory(struct packed_git *pack)
 {
-	unsigned long nr_objects = approximate_object_count();
+	unsigned long nr_objects = repo_approximate_object_count(the_repository);
 	size_t os_cache, heap;
 
 	if (!pack || !nr_objects)
diff --git a/commit-graph.c b/commit-graph.c
index 8273085aa60..268410e913c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2360,7 +2360,7 @@ int write_commit_graph(struct object_directory *odb,
 			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}
 
-	ctx->approx_nr_objects = approximate_object_count();
+	ctx->approx_nr_objects = repo_approximate_object_count(the_repository);
 
 	if (ctx->append && ctx->r->objects->commit_graph) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index ff4c56114f1..a325361f961 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -91,6 +91,10 @@
 |
 - format_commit_message
 + repo_format_commit_message
+// packfile.h
+|
+- approximate_object_count
++ repo_approximate_object_count
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 375850e773c..9b426e49e66 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,11 +5,7 @@
 @@
 @@
 (
-// packfile.h
-- approximate_object_count
-+ repo_approximate_object_count
 // promisor-remote.h
-|
 - promisor_remote_reinit
 + repo_promisor_remote_reinit
 |
diff --git a/packfile.h b/packfile.h
index a3f6723857b..6ec16567971 100644
--- a/packfile.h
+++ b/packfile.h
@@ -65,7 +65,6 @@ struct packed_git *get_all_packs(struct repository *r);
  * for speed.
  */
 unsigned long repo_approximate_object_count(struct repository *r);
-#define approximate_object_count() repo_approximate_object_count(the_repository)
 
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs);
-- 
2.40.0.rc1.1034.g5867a1b10c5

