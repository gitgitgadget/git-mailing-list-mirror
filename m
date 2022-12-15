Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13806C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLOIxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLOIwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:46 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E33E090
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h11so2257434wrw.13
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57JBlm0NImiEIoiDlgTbf26rGwUtOwPbjIvjNODgzkU=;
        b=Qvbvmvr7Doz5Mt3tGOxF7VWBFDcLuRwy6BeYsNZXB8SziFbYSwGxFXTetKd58mzqGv
         TIQPQ+6Ffyhw08NxrRSXbqUZpPGQrY9Xd4JHc/fLjJT+6Col2CLWuLL3+XhG2Zhbvb6Z
         M4724V9qGkByv6IGkyJFuaB0YzPJRMoJqbPVw2ogp1dtuDlwXqJZTn0u2ppQVB0kuCz+
         uP7yqP4jq5f4EaBUlZYqIFO4Fj85Wuh+lXTRRlPekLnpBFtk0uFLm2Tr5jikaUboLXnQ
         Z0TwtbSqsKZdP68+FJ/jIVpzkTDr4pm+y04huKdNMemGQwDWoqQdyUi55w63qVzdpeMr
         GY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57JBlm0NImiEIoiDlgTbf26rGwUtOwPbjIvjNODgzkU=;
        b=vfMSV0UScjad957EIyzEazKAz41j4Rn34a72ZEVv57XTaLEpFn79+XTcAaAF55IT3O
         nRgvkQILMkQkZfdzV304F8JU094t9uq2N48913f9lPTDF5MHkxKVKms15jWvYdfNybTo
         Kmkafiojod/YVQ/CLcz1l8npC1dowDMzuSGn9JYoRL9io2mZ4IOZDhWvFxD1C3dlswCK
         QA388FS525KTeGNcTHRWnJkNr/ETh5iTpxMWlEso10/pyZaEmehS1LHrZuUvCosOq80P
         QQmYPtOBDgS+NzbDh9JN+89DO445JpQCv4rVEO5+YqhvMdhlsOF26zvSp138Jn815Q0e
         nTZg==
X-Gm-Message-State: ANoB5pm16aaOCqx/tLSoCwjkDerppu8agUVgJPX/N/Nxkx1cW2aC4u1e
        4K2+dLr7yZBM1nZ0TOKHzwk7Mjn8VCLotA==
X-Google-Smtp-Source: AA0mqf4DwVC5KqgCAS0WPtwz0H/iOM20kW5yEpGlDvnOCZJ78ZESogr24zRNguJAU9GNjkVmFxgITQ==
X-Received: by 2002:adf:fa09:0:b0:242:4f41:4dae with SMTP id m9-20020adffa09000000b002424f414daemr20205212wrr.71.1671094354481;
        Thu, 15 Dec 2022 00:52:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:33 -0800 (PST)
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
Subject: [PATCH v10 10/12] merge-index: libify merge_one_path() and merge_all()
Date:   Thu, 15 Dec 2022 09:52:14 +0100
Message-Id: <patch-v10-10.12-0efc5039e46-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alban Gruin <alban.gruin@gmail.com>

Move the workhorse functions in "builtin/merge-index.c" into a new
"merge-strategies" library, and mostly "libify" the code while doing
so.

Eventually this will allow us to invoke merge strategies such as
"resolve" and "octopus" in-process, once we've followed-up and
replaced "git-merge-{resolve,octopus}.sh" etc.

But for now let's move this code, while trying to optimize for as much
of it as possible being highlighted by the diff rename detection.

We still call die() in this library. An earlier version of this[1]
converted these to "error()", but the problem with that that we'd then
potentially run into the same error N times, e.g. once for every
"<file>" we were asked to operate on, instead of dying on the first
case. So let's leave those to "die()" for now.

1. https://lore.kernel.org/git/20220809185429.20098-4-alban.gruin@gmail.com/

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile              |  1 +
 builtin/merge-index.c | 95 ++++++++++++++++---------------------------
 merge-strategies.c    | 87 +++++++++++++++++++++++++++++++++++++++
 merge-strategies.h    | 19 +++++++++
 4 files changed, 142 insertions(+), 60 deletions(-)
 create mode 100644 merge-strategies.c
 create mode 100644 merge-strategies.h

diff --git a/Makefile b/Makefile
index 0f7d7ab1fd2..6f4ac2e541d 100644
--- a/Makefile
+++ b/Makefile
@@ -1064,6 +1064,7 @@ LIB_OBJS += merge-blobs.o
 LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
+LIB_OBJS += merge-strategies.o
 LIB_OBJS += merge.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c269d76cc8f..21598a52383 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,77 +1,50 @@
 #include "builtin.h"
 #include "parse-options.h"
+#include "merge-strategies.h"
 #include "run-command.h"
 
-static const char *pgm;
-static int one_shot, quiet;
-static int err;
+struct mofs_data {
+	const char *program;
+};
 
-static int merge_entry(struct index_state *istate, int pos, const char *path)
+static int merge_one_file(struct index_state *istate,
+			  const struct object_id *orig_blob,
+			  const struct object_id *our_blob,
+			  const struct object_id *their_blob, const char *path,
+			  unsigned int orig_mode, unsigned int our_mode,
+			  unsigned int their_mode, void *data)
 {
-	int found;
+	struct mofs_data *d = data;
+	const char *pgm = d->program;
 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
 	char ownbuf[4][60];
+	int stage = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	if (pos >= istate->cache_nr)
-		die(_("'%s' is not in the cache"), path);
-	found = 0;
-	do {
-		const struct cache_entry *ce = istate->cache[pos];
-		int stage = ce_stage(ce);
-
-		if (strcmp(ce->name, path))
-			break;
-		found++;
-		oid_to_hex_r(hexbuf[stage], &ce->oid);
-		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
-		arguments[stage] = hexbuf[stage];
-		arguments[stage + 4] = ownbuf[stage];
-	} while (++pos < istate->cache_nr);
-	if (!found)
-		die(_("'%s' is not in the cache"), path);
-
-	strvec_pushv(&cmd.args, arguments);
-	if (run_command(&cmd)) {
-		if (one_shot)
-			err++;
-		else {
-			if (!quiet)
-				die(_("merge program failed"));
-			exit(1);
-		}
+#define ADD_MOF_ARG(oid, mode) \
+	if ((oid)) { \
+		stage++; \
+		oid_to_hex_r(hexbuf[stage], (oid)); \
+		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%06o", (mode)); \
+		arguments[stage] = hexbuf[stage]; \
+		arguments[stage + 4] = ownbuf[stage]; \
 	}
-	return found;
-}
-
-static void merge_one_path(struct index_state *istate, const char *path)
-{
-	int pos = index_name_pos(istate, path, strlen(path));
 
-	/*
-	 * If it already exists in the cache as stage0, it's
-	 * already merged and there is nothing to do.
-	 */
-	if (pos < 0)
-		merge_entry(istate, -pos-1, path);
-}
-
-static void merge_all(struct index_state *istate)
-{
-	int i;
+	ADD_MOF_ARG(orig_blob, orig_mode);
+	ADD_MOF_ARG(our_blob, our_mode);
+	ADD_MOF_ARG(their_blob, their_mode);
 
-	for (i = 0; i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (!ce_stage(ce))
-			continue;
-		i += merge_entry(istate, i, ce->name)-1;
-	}
+	strvec_pushv(&cmd.args, arguments);
+	return run_command(&cmd);
 }
 
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
+	int err = 0;
 	int all = 0;
+	int one_shot = 0;
+	int quiet = 0;
 	const char * const usage[] = {
 		N_("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))"),
 		NULL
@@ -91,6 +64,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 #undef OPT__MERGE_INDEX_ALL
+	struct mofs_data data = { 0 };
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -109,7 +83,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	/* <merge-program> and its options */
 	if (!argc)
 		usage_msg_opt(_("need a <merge-program> argument"), usage, options);
-	pgm = argv[0];
+	data.program = argv[0];
 	argc = parse_options(argc, argv, prefix, options_prog, usage, 0);
 	if (argc && all)
 		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
@@ -121,12 +95,13 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	ensure_full_index(the_repository->index);
 
 	if (all)
-		merge_all(the_repository->index);
+		err |= merge_all_index(the_repository->index, one_shot, quiet,
+				       merge_one_file, &data);
 	else
 		for (size_t i = 0; i < argc; i++)
-			merge_one_path(the_repository->index, argv[i]);
+			err |= merge_index_path(the_repository->index,
+						one_shot, quiet, argv[i],
+						merge_one_file, &data);
 
-	if (err && !quiet)
-		die(_("merge program failed"));
 	return err;
 }
diff --git a/merge-strategies.c b/merge-strategies.c
new file mode 100644
index 00000000000..30691fccd77
--- /dev/null
+++ b/merge-strategies.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+#include "merge-strategies.h"
+
+static int merge_entry(struct index_state *istate, unsigned int pos,
+		       const char *path, int *err, merge_index_fn fn,
+		       void *data)
+{
+	int found = 0;
+	const struct object_id *oids[3] = { 0 };
+	unsigned int modes[3] = { 0 };
+
+	*err = 0;
+
+	if (pos >= istate->cache_nr)
+		die(_("'%s' is not in the cache"), path);
+	do {
+		const struct cache_entry *ce = istate->cache[pos];
+		int stage = ce_stage(ce);
+
+		if (strcmp(ce->name, path))
+			break;
+		found++;
+		oids[stage - 1] = &ce->oid;
+		modes[stage - 1] = ce->ce_mode;
+	} while (++pos < istate->cache_nr);
+	if (!found)
+		die(_("'%s' is not in the cache"), path);
+
+	if (fn(istate, oids[0], oids[1], oids[2], path, modes[0], modes[1],
+	       modes[2], data))
+		(*err)++;
+
+	return found;
+}
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_index_fn fn, void *data)
+{
+	int err, ret;
+	int pos = index_name_pos(istate, path, strlen(path));
+
+	/*
+	 * If it already exists in the cache as stage0, it's
+	 * already merged and there is nothing to do.
+	 */
+	if (pos >= 0)
+		return 0;
+
+	ret = merge_entry(istate, -pos - 1, path, &err, fn, data);
+	if (ret < 0)
+		return ret;
+	if (err) {
+		if (!quiet && !oneshot)
+			die(_("merge program failed"));
+		return 1;
+	}
+	return 0;
+}
+
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_index_fn fn, void *data)
+{
+	int err, ret;
+	unsigned int i;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (!ce_stage(ce))
+			continue;
+
+		ret = merge_entry(istate, i, ce->name, &err, fn, data);
+		if (ret < 0)
+			return ret;
+		else if (ret > 0)
+			i += ret - 1;
+
+		if (err && !oneshot) {
+			if (!quiet)
+				die(_("merge program failed"));
+			return 1;
+		}
+	}
+
+	if (err && !quiet)
+		die(_("merge program failed"));
+	return err;
+}
diff --git a/merge-strategies.h b/merge-strategies.h
new file mode 100644
index 00000000000..cee9168a046
--- /dev/null
+++ b/merge-strategies.h
@@ -0,0 +1,19 @@
+#ifndef MERGE_STRATEGIES_H
+#define MERGE_STRATEGIES_H
+
+struct object_id;
+struct index_state;
+typedef int (*merge_index_fn)(struct index_state *istate,
+			      const struct object_id *orig_blob,
+			      const struct object_id *our_blob,
+			      const struct object_id *their_blob,
+			      const char *path, unsigned int orig_mode,
+			      unsigned int our_mode, unsigned int their_mode,
+			      void *data);
+
+int merge_index_path(struct index_state *istate, int oneshot, int quiet,
+		     const char *path, merge_index_fn fn, void *data);
+int merge_all_index(struct index_state *istate, int oneshot, int quiet,
+		    merge_index_fn fn, void *data);
+
+#endif /* MERGE_STRATEGIES_H */
-- 
2.39.0.rc2.1048.g0e5493b8d5b

