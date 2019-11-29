Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ACDC33CA0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA82F21771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+pMAGFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK2VL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:11:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfK2VL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so520533wrm.11
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzXPmqK8AJLwEd8SEby1zSIQcChj5YCbYFe/JYqbQ+U=;
        b=k+pMAGFwaROGyms1/3qnHvGu9hCTGGyd4hi+crq8NDfmpuSzWz9pj4PLa937OBoUfa
         f3cF3yGvVjnd6trPMpFPojBS65gTXrpGzTpc7QgykV4N7i60y1jb4P/I4867ic56k+Xw
         UUOhHTeJINO4sOmxr81NNpEjZI9IqqBVOmhHR+hoXe12RHVBhPe5vc/Y4lGanxdnU6Wo
         RBXnzNfWUellbnh3TRhVWJ13E4+e5pxL0CywZaSVN0jDdyNy/L9JLnFpIDWEfNWXCzbT
         ox2pYdhE/8fVTsM4748S1Gms1aedX1sDkbWCnLDs1AWvvN/87n+4mAtzibW2DLDZ0npW
         RvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzXPmqK8AJLwEd8SEby1zSIQcChj5YCbYFe/JYqbQ+U=;
        b=KKEIcI03Cv6d90D97b/ASft9fQZRLyZF3QJoKGVMQjUJXB0h/c4dBNt/Tmz2/mifxG
         ZoOEnsl3QgWaiJ4OdPdrDxT1vrJcKUUBzpPNGhyGRasDjEIUUT/t+SIzVd+80Wtl1Zap
         xfz7etQXB6LD4Cs6Jp0ghO9N36fOAo0AQOkDv4pVHuhHqXHisQM6W+hCoe9egXhAwOEb
         GBFZp/cLQr32Erl0t8LM7RILN7ZRthZcZV+5iiso1oxD9WMGzVvUX26TZcZn90nxMlKg
         zNjH5kMnF0d7qaiWjc2ajqV20G0+3fEPITCZJ2vN2x4eAWd8x67Ki8tUPzEaRRhtr342
         1ZmQ==
X-Gm-Message-State: APjAAAXbPCM+r88vFiUOXXNK/6/sncZt4OwSb2GLMhiu9FGhODZ/7VVR
        QEf2tzTi651aNv/Bnx8LjczoXRAn
X-Google-Smtp-Source: APXvYqxsTGdrSM8oWh4RGftiWZ9pWPbTI6a6XNxPhe3aEeQQ3LwfrhQTbv74cx9vORSTCBr8IfTdRg==
X-Received: by 2002:adf:c50a:: with SMTP id q10mr17106736wrf.374.1575061914839;
        Fri, 29 Nov 2019 13:11:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm8482731wrn.19.2019.11.29.13.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:54 -0800 (PST)
Message-Id: <f70723a160c1ecddf87349fc99af25f7718e1413.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:45 +0000
Subject: [PATCH v2 5/9] built-in add -i: re-implement `revert` in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a relatively straight-forward port from the Perl version, with
the notable exception that we imitate `git reset -- <paths>` in the C
version rather than the convoluted `git ls-tree HEAD -- <paths> | git
update-index --index-info` followed by `git update-index --force-remove
-- <paths>` for the missed ones.

While at it, we fix the pretty obvious bug where the `revert` command
offers to unstage files that do not have staged changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 1e34e88069..adab17a635 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -657,6 +657,114 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static void revert_from_diff(struct diff_queue_struct *q,
+			     struct diff_options *opt, void *data)
+{
+	int i, add_flags = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filespec *one = q->queue[i]->one;
+		struct cache_entry *ce;
+
+		if (!(one->mode && !is_null_oid(&one->oid))) {
+			remove_file_from_index(opt->repo->index, one->path);
+			printf(_("note: %s is untracked now.\n"), one->path);
+		} else {
+			ce = make_cache_entry(opt->repo->index, one->mode,
+					      &one->oid, one->path, 0, 0);
+			if (!ce)
+				die(_("make_cache_entry failed for path '%s'"),
+				    one->path);
+			add_index_entry(opt->repo->index, ce, add_flags);
+		}
+	}
+}
+
+static int run_revert(struct add_i_state *s, const struct pathspec *ps,
+		      struct prefix_item_list *files,
+		      struct list_and_choose_options *opts)
+{
+	int res = 0, fd;
+	size_t count, i, j;
+
+	struct object_id oid;
+	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &oid,
+					     NULL);
+	struct lock_file index_lock;
+	const char **paths;
+	struct tree *tree;
+	struct diff_options diffopt = { NULL };
+
+	if (get_modified_files(s->r, INDEX_ONLY, files, ps) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		putchar('\n');
+		return 0;
+	}
+
+	opts->prompt = N_("Revert");
+	count = list_and_choose(s, files, opts);
+	if (count <= 0)
+		goto finish_revert;
+
+	fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
+	if (fd < 0) {
+		res = -1;
+		goto finish_revert;
+	}
+
+	if (is_initial)
+		oidcpy(&oid, s->r->hash_algo->empty_tree);
+	else {
+		tree = parse_tree_indirect(&oid);
+		if (!tree) {
+			res = error(_("Could not parse HEAD^{tree}"));
+			goto finish_revert;
+		}
+		oidcpy(&oid, &tree->object.oid);
+	}
+
+	ALLOC_ARRAY(paths, count + 1);
+	for (i = j = 0; i < files->items.nr; i++)
+		if (files->selected[i])
+			paths[j++] = files->items.items[i].string;
+	paths[j] = NULL;
+
+	parse_pathspec(&diffopt.pathspec, 0,
+		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH,
+		       NULL, paths);
+
+	diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	diffopt.format_callback = revert_from_diff;
+	diffopt.flags.override_submodule_config = 1;
+	diffopt.repo = s->r;
+
+	if (do_diff_cache(&oid, &diffopt))
+		res = -1;
+	else {
+		diffcore_std(&diffopt);
+		diff_flush(&diffopt);
+	}
+	free(paths);
+	clear_pathspec(&diffopt.pathspec);
+
+	if (!res && write_locked_index(s->r->index, &index_lock,
+				       COMMIT_LOCK) < 0)
+		res = -1;
+	else
+		res = repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0, 1,
+						   NULL, NULL, NULL);
+
+	if (!res)
+		printf(Q_("reverted %d path\n",
+			  "reverted %d paths\n", count), (int)count);
+
+finish_revert:
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -752,6 +860,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	} command_list[] = {
 		{ "status", run_status },
 		{ "update", run_update },
+		{ "revert", run_revert },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

