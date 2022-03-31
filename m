Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0B7C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiCaJWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiCaJWK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 05:22:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC80B147500
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3033990pjh.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13Glgy9Q+WbRqZOZL75vVU/OVHKbuhWHm2bJJAqXxb0=;
        b=GkL70rv0hw7ic5XhuVUG0qoXuD9Wm81eumTHg9c1QwrF9EcWejmRXU+8SzQeelKxLO
         YLWiyJ9Typ47Nwp3NslMmUtGSJZAKWs20uCl2yzLUNPAmH7XwmIckyc4Vss/atq5M8JR
         aa5CLSmXb2huZIjYHHwcc3jeiBXADeABpL2Pg0GxLAV66uEYIJGld0ZEUzv1+31LZEfn
         p9Mc7JSdb6u8HYsRL18GBOWIGmuTUX0uICYoOeE6of9RiwCX452sK24hJI/wwgZZg2LB
         ZU4eDIRGn9whMqZ4UIK2ry8v5n2E+UhymLyIuUavg7qpEoli07rv8Ru4YVfX9xfpTnel
         kSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13Glgy9Q+WbRqZOZL75vVU/OVHKbuhWHm2bJJAqXxb0=;
        b=Geffu2SRCLjxrRZZalxedEj/q4pdi1CIuGnaI3kS7do5oVqO7A6q/BTlZldeD96gkR
         mhKlRDzaj8wS/9VrUYQ+FZ2PCl/tJgTq40Ct2VSREGZ47JPl/YBFRRhQqblmTgEqjDv8
         yFthVXjLFf+AuuNaV0ITpSWK1Mgww5vac5Gdr2RoChhh2v9Onobg/OYXHUfv0q4e+/d3
         yPWKcdJFQQYU/tDcloTFl9+Gu7ghYqQ4vxlMYQnPIicVGet7Q2FCJlFmkkLesSoA4B1n
         KaRLGJI5cDtl1BwQTJBMm/OY95DDgM2x8QB/bzH+3tTpisC2v8H9yZ0j1tZqptyV/nut
         CwUQ==
X-Gm-Message-State: AOAM5301X8J7+8raKrP3hIAPqG8Pv1jQfYRNx2N+H4/q1YDLH7/3Tovc
        XUJdd53gwn5LMwdKYqODk+TDv2OK98E=
X-Google-Smtp-Source: ABdhPJy+F8b6P36pEmLrdzwPaf7bVGkPZ0MmRKVIza0yc6KzbcZWKYM/fZxIB16yHjNF2f/plhSXhA==
X-Received: by 2002:a17:902:ab8b:b0:156:16c0:dc6d with SMTP id f11-20020a170902ab8b00b0015616c0dc6dmr4465749plr.147.1648718423070;
        Thu, 31 Mar 2022 02:20:23 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.75])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm27225931pfk.88.2022.03.31.02.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:20:22 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file into cone
Date:   Thu, 31 Mar 2022 17:17:54 +0800
Message-Id: <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, the SKIP_WORKTREE bit is not removed when moving an out-of-cone
file into sparse cone, thus the moved file does not show up in the working tree.
Hint the user to use "git sparse-checkout reapply" to reapply the sparsity rules
to the working tree, by which the SKIP_WORKTREE bit is removed.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
I offered this solution becasue I'm not sure how to turn a cache_entry's 
ce_flags back to a non-sparse state. I tried directly set it to 0 like this:

	ce->ce_flags = 0;

But the behavior after this seems undefined. The file still won't show up
in the working tree.

And I found that "git sparse-checkout reapply" seems to be a nice fit for the
job. But I guess if there is a way (there must be but I don't know) to do it
direcly in the code, that could also be nice.

 builtin/mv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 9da9205e01..5f511fb8da 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -138,6 +138,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, flags, gitmodules_modified = 0;
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
+	int advise_to_reapply = 0;
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -383,6 +384,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
 		rename_cache_entry_at(pos, dst);
+		if (!advise_to_reapply &&
+			!path_in_sparse_checkout(src, &the_index) &&
+			path_in_sparse_checkout(dst, &the_index)) {
+				advise_to_reapply = 1;
+			}
 	}
 
 	if (gitmodules_modified)
@@ -392,6 +398,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
+	if (advise_to_reapply)
+		printf(_("Please use \"git sparse-checkout reapply\" to reapply the sparsity.\n"));
+
 	string_list_clear(&src_for_dst, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
-- 
2.35.1

