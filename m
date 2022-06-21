Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50627CCA473
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354812AbiFUWoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354745AbiFUWoK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:44:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6EC31DD7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:44:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso7982808wmc.4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcwMBcjEk1edOFq4KD2z1Qr8QcW0owhuo7ld4jpi43Y=;
        b=cEThKcI3BuJ++OFYvopREyJt5oLwyfHifJioiytKoJm9HXqQpEpO+oMtDWbZOCSHoH
         LRYdq+2WoQCCAJIpr3Ntxx48xyaKOdBvhVH7myeHXZcbsCliOfchzwFHLimS9bmkIZJl
         nn6rBSmoJRS2O5uGP4alcsHD/7YS/60ujIV1HKX2umcjGZgymFhRcq8Ftln3eWD6y7Ct
         +tJ5xLgZVnNrTDNldt6iKq5/ObHDeplHXsjLzFktL25fK6Kq4QSOuVwt40XsOcI31emJ
         0CUGbyyf08qjAnc77tDnZy/ehl/NAnkN2Pl8xMDmT53Q/xk7byeSxakbiXC7Fb//7iCF
         l9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcwMBcjEk1edOFq4KD2z1Qr8QcW0owhuo7ld4jpi43Y=;
        b=r0sJ61MxuWk+0CqYSvRu5NU1PY2E4vk+YTR85tGkbKxiquU7Dr5cvMw4XAn6+NSkkj
         VrQ/AR4vmLWA+KdCmNdWmZfGKbhtcGq/DnfJhh+sXqpPxQMW7Uoal5e/Qq/lUR2RS8PT
         AhTHoAoZDlO+uKxCvGoF+2gJwGjE1Y7NSmaKT6eqWsJNgdLE4j9ofJF6FyiQCcu2rV6r
         4YiNZJigp7vhNmOCD2OP0CBLE54D91XlLPJbbiOQZCpilbD3W3UIOvsApGOJE0YRwEi3
         Z1xrCZATYSXtQPQ0IZgdFVRp2hKmCUFLaDZWCdD1UpDN03/b0aNpYY1CW2gJN4fjI8lY
         9O0w==
X-Gm-Message-State: AJIora9cr9Vnvme2iuMh0lRjbUu2mdj+eJLIhkgxPrapVymo7PsZxqGY
        E2teRx+QXoN/9Fs6LjVql86UmjCeVN9drw==
X-Google-Smtp-Source: AGRyM1vBxRZUouBYxYJd1QzEUfe+bibUyAMGmZ0RK0O2cN8wGYvzxrorzVHiYQtHbDMOVMcQoihSrA==
X-Received: by 2002:a7b:cbda:0:b0:397:48d6:6c9f with SMTP id n26-20020a7bcbda000000b0039748d66c9fmr451040wmi.10.1655851447900;
        Tue, 21 Jun 2022 15:44:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d564c000000b0021b9585276dsm4024261wrw.101.2022.06.21.15.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:44:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] cocci: remove "when strict" from unused.cocci
Date:   Wed, 22 Jun 2022 00:44:03 +0200
Message-Id: <patch-v2-2.2-4130dc15287-20220621T223954Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
References: <patch-1.1-7d90f26b73f-20220520T115426Z-avarab@gmail.com> <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "when strict" constraint from the newly introduced rule to
find unused code. As seen in the change this will help us find cases
where a "return" was causing spatch in the middle of our match was
causing spatch to abort its analysis.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c                 | 2 --
 builtin/repack.c                | 2 --
 contrib/coccinelle/unused.cocci | 2 --
 3 files changed, 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bbd70b17bc6..23170f2d2a6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_oid(stash))
@@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	strbuf_release(&sb);
 	refresh_cache(REFRESH_QUIET);
 }
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 4a7ae4cf489..482b66f57d6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -727,7 +727,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
@@ -1117,7 +1116,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	string_list_clear(&names, 0);
-	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
index 45452f8979a..6eaea01380b 100644
--- a/contrib/coccinelle/unused.cocci
+++ b/contrib/coccinelle/unused.cocci
@@ -32,7 +32,6 @@ identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
 // ... Optionally followed by lines that make no use of "buf", "&buf"
 // etc., but which ...
 <... when != \( I \| &I \)
-     when strict
 // .. (only) make use of "buf" or "&buf" to call something like
 // "strbuf_init(&buf, ...)" ...
 (
@@ -55,7 +54,6 @@ identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
 // init/strbuf_release() patterns, where "&buf" could be used
 // afterwards.
   ... when != \( I \| &I \)
-      when strict
 // Note that we're intentionally loose in accepting e.g. a
 // "strbuf_init(&buf)" followed by a "string_list_clear(&buf,
 // 0)". It's assumed that the compiler will catch any such invalid
-- 
2.36.1.1239.gfba91521d90

