Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7293C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiKRLTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbiKRLSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467EB20984
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n21so12206628ejb.9
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axs2AR0zL47+0jCPuLp/bfTP9r7AbJOyo7Gbyrj0kAE=;
        b=cf/ZDRPu9sxX76qQH3ZbhiCrEdJ6JN5fFbKXaW3GXHgYfaIXBQl/CqXGBQ+L31QBpQ
         1u6bSsSQCmrNL+Z96f2qWn69MRtb7VtbgG8mvbEkc5vnwxShEs9+NPm7QxcmZ7Cz3KW4
         2LulGN7878xXqK1B4sxDg3MnvLUawLK4mdMgLQIG5ZgzYQvm/z6HJskyITIdyDRvlTZv
         ikcRmt1q/WvyMwB63gpQOgA8u5TBxeV2sx06J/qvXe64pqo2Dl1XYYfvz8kJR6Wc+koA
         AQOcfBJCl+eMu9oveqmViqD4XCW0Q6dn2TOEyW2RBxSE2B4J4qHX6mwMZt6+7wR6md5y
         7JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axs2AR0zL47+0jCPuLp/bfTP9r7AbJOyo7Gbyrj0kAE=;
        b=fnUtLcNIyOBjy3PnJph+8mY51MB9ne0QNwtK8OQLR/SakUHyiwmyA7FQC3tM0wvRtl
         qzdjCsKpFeg+NZOafzwQGC3pvJ04QNR83iUq/KsugtyoT7LlSnKGCVM3l8YJVfRBVNo1
         LTuHC7ujweg3DPo7i3rp30NQsN7G7qIq92XbfX23GMOutXLEotDlNEhj7qgaN053ti6E
         LN45651feXjzZ3fweQoWVeEpcXKuwUJHUt1Rx2cOace+EWn5BTDotPjXSly6W73Gzv3x
         rw2MDnp0E3T1JzBxS0I8D0umvRD4e0Al41bEdIsFmbN5GVC6HHQdk6ubHG6t3mgaY8KX
         In8A==
X-Gm-Message-State: ANoB5pnSvWzd/uaKansNx3z7a0aRnFTj8zp2IKpI7NAxZxx6eQlGJGjZ
        ujwOvCJTyUTgofJCIp4QmOoWpFiZYxv0aQ==
X-Google-Smtp-Source: AA0mqf4uXeLdoiuQpHYMWjN715kbYbDEdfJ2yTP3eratrquXguNocuLY+0tc9GRtJcHOgJ2I1i/GQw==
X-Received: by 2002:a17:906:81cc:b0:7ae:4373:c8aa with SMTP id e12-20020a17090681cc00b007ae4373c8aamr5650702ejx.466.1668770321474;
        Fri, 18 Nov 2022 03:18:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 09/12] builtin/merge-index.c: don't USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Fri, 18 Nov 2022 12:18:26 +0100
Message-Id: <patch-v9-09.12-f29343197eb-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove "USE_THE_INDEX_COMPATIBILITY_MACROS" and instead pass
"the_index" around between the functions in this file. In a subsequent
commit we'll libify this, and don't want to use
"USE_THE_INDEX_COMPATIBILITY_MACROS" in any more places in the
top-level *.c files. Doing this first makes that diff a lot smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 9bffcc5b0f1..c269d76cc8f 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "parse-options.h"
 #include "run-command.h"
@@ -7,7 +6,7 @@ static const char *pgm;
 static int one_shot, quiet;
 static int err;
 
-static int merge_entry(int pos, const char *path)
+static int merge_entry(struct index_state *istate, int pos, const char *path)
 {
 	int found;
 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
@@ -15,11 +14,11 @@ static int merge_entry(int pos, const char *path)
 	char ownbuf[4][60];
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if (pos >= active_nr)
+	if (pos >= istate->cache_nr)
 		die(_("'%s' is not in the cache"), path);
 	found = 0;
 	do {
-		const struct cache_entry *ce = active_cache[pos];
+		const struct cache_entry *ce = istate->cache[pos];
 		int stage = ce_stage(ce);
 
 		if (strcmp(ce->name, path))
@@ -29,7 +28,7 @@ static int merge_entry(int pos, const char *path)
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < active_nr);
+	} while (++pos < istate->cache_nr);
 	if (!found)
 		die(_("'%s' is not in the cache"), path);
 
@@ -46,27 +45,27 @@ static int merge_entry(int pos, const char *path)
 	return found;
 }
 
-static void merge_one_path(const char *path)
+static void merge_one_path(struct index_state *istate, const char *path)
 {
-	int pos = cache_name_pos(path, strlen(path));
+	int pos = index_name_pos(istate, path, strlen(path));
 
 	/*
 	 * If it already exists in the cache as stage0, it's
 	 * already merged and there is nothing to do.
 	 */
 	if (pos < 0)
-		merge_entry(-pos-1, path);
+		merge_entry(istate, -pos-1, path);
 }
 
-static void merge_all(void)
+static void merge_all(struct index_state *istate)
 {
 	int i;
 
-	for (i = 0; i < active_nr; i++) {
-		const struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
-		i += merge_entry(i, ce->name)-1;
+		i += merge_entry(istate, i, ce->name)-1;
 	}
 }
 
@@ -116,16 +115,16 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
 			      usage, options);
 
-	read_cache();
+	repo_read_index(the_repository);
 
 	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+	ensure_full_index(the_repository->index);
 
 	if (all)
-		merge_all();
+		merge_all(the_repository->index);
 	else
 		for (size_t i = 0; i < argc; i++)
-			merge_one_path(argv[i]);
+			merge_one_path(the_repository->index, argv[i]);
 
 	if (err && !quiet)
 		die(_("merge program failed"));
-- 
2.38.0.1511.gcdcff1f1dc2

