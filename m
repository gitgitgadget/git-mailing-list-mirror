Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6752CC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiKRLTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiKRLSq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274F1A22D
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f18so12264579ejz.5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5LQuB7/t+iJlAKGV61jn4A5w203UXDyJDtx8BCO5ug=;
        b=p8aYPPXUnSk6pyTmmM5k06otcBYnncpm359xaxd+yWPubKGJUKq34VcewKWEXAE8tx
         aKAI2plDvNrWm1QkMZTw+r5uJjBzxwKNjiorMXNaBTJmTf9SP1WupyuRtXn9lIU9UbHt
         38jbUc5dTKZyskKjpynhJmNZurTUcEBRF6a20py0efJnO1vuv3LgPBMWHz8AW5Mit1zq
         0ctF1bRAOi40ob+/oypJZZjHU0gERX7+KNcRDchfv7BQxe7tnPTi/I+LaiTjmArnlGrx
         21W4qZSrK6Xo/YTSw9VZQFOCJ4jesgu+fFFxTjAPjBMWzGhSRKucPlhWA7IkO2sPEyXz
         JfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5LQuB7/t+iJlAKGV61jn4A5w203UXDyJDtx8BCO5ug=;
        b=Iv/8Tz6c1u5bY1OKmAme5ivsjBPO032WeaJ0boUd3SfpiOdDxJExWGhUgssLf3+L0m
         JG0Xz7DhfN4DZNrcDPOS52imHeiYVBni0hj76AkQYgS1ucl2ueczFHWcMSiPiPIvXzvM
         m17x20E8ipn1FmE528HnQa+OcwBvXmVEhVtfJycXAiW16WS7ZCjgKRp4IeHLH/meT4FC
         isdTf6+/s5YFtzYi32UTVaUXRQ72jTt8X5oSuloJeVAmUhqsGp8LZ97UJFOqcBJUWkO3
         cZI5N/poPFpFdr+PXNrvfz4uuijOMMaSJXpENx266ekHMbWCNC8f5MmrWRRuOR0GuHP8
         kXjA==
X-Gm-Message-State: ANoB5pnoq05ztnMPcFVXaNoB42yPi9TF80hUiBvQxb+fVMneUbR+78H6
        hQhAoPlR7D0xszRPBpYrBslFLodKCyMjSQ==
X-Google-Smtp-Source: AA0mqf6zVeY5yBUfQF6ncanZA0Eo1EwZRFIrTjWAvIhdFvLJmElCoLoM0tbFXpALMxb2IwwpsqGq0Q==
X-Received: by 2002:a17:906:945a:b0:7a8:3597:34a8 with SMTP id z26-20020a170906945a00b007a8359734a8mr5580388ejx.628.1668770322510;
        Fri, 18 Nov 2022 03:18:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:41 -0800 (PST)
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
Subject: [PATCH v9 10/12] merge-index: libify merge_one_path() and merge_all()
Date:   Fri, 18 Nov 2022 12:18:27 +0100
Message-Id: <patch-v9-10.12-c7a131a9a86-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
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
index 4927379184c..ccd467cec79 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,6 +1000,7 @@ LIB_OBJS += merge-blobs.o
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
2.38.0.1511.gcdcff1f1dc2

