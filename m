Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E743C433E1
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5782311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/6fXBRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgHFQoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgHFQmr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442CC0A893E
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:41:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u128so27765pfb.6
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mdIZs/Pkn/WvMYhW7eSZbuS3HU/Bc2jIkQ3RaFA5qA=;
        b=q/6fXBRvrDMo/8c9SLGSn8NZZKndvnc1IMp80spI3JkM9hN0s8AFds5K7CERHz14G0
         83YQCWHGpLCLNbE5rZJW45LJxM7HiOFOV48miwntGLFnuZn2fMPumv75VHXpWm7+iWts
         KXGi9hmZMeCP3zFIfNyLlISz8fNQnOCk6M3s1sZ+1IijCJXPluDDXexSAVzjzxPopuj4
         Dcu8GuDChqBXhHcV687Mc+AmhDRUS5yTnANI8pHfBXQk+M8K55H8Tok1oW4vX3Bhpzr+
         FUR/NZVDnoalOFm1ldp4age7XU8w1lpUdms4HaKXJhJoaGpAx1S8oVEvGhkLCowOG+Fj
         S38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8mdIZs/Pkn/WvMYhW7eSZbuS3HU/Bc2jIkQ3RaFA5qA=;
        b=ZAus8FBTHo5K5EMONjAA3nev6tn08Z+xW92wt5g5me6TWZJnk56FwObaFqKuZ0SrRz
         d1v0DJRAsK6Ol5I9DRE9Zm/YBnEOaHfi2mqQ2QGB8l47W//ok6jomF1xBzh/dgAw7Lp1
         /WtvIBDyHj/OFZFawIymZtMj+P2qxdw6V3Z4xaCbqePJ8XDUewT9uMNrm9igX5Bl1bRH
         qHSYyL4wg3m8/upf8hW5dJPewR2SpY3A73ylBo1qUZj8+Ggq5QtM84Ej8+XsN83WJt6+
         Efz6Tf523gLDd4QEEZydhKv4iamNozc8T6mMuBTlJHU0g2YB27LZBn3KiFhlNuSkXjKL
         SIHw==
X-Gm-Message-State: AOAM5306Q+ONqNMQm1OKHyHJC/CHoNEBqbHFHndsp6hQX3pTulOgzON6
        ILRGkKO8z94ngJqO2T3xPovGuVOktPQ=
X-Google-Smtp-Source: ABdhPJw09ef+NkxRXTa1dcYIn+4P79pfBvtScArAIBqFfofALPJKUzMOgY9G51rddDKRMvSZU32Cag==
X-Received: by 2002:aa7:8c19:: with SMTP id c25mr9187426pfd.17.1596732094529;
        Thu, 06 Aug 2020 09:41:34 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id w16sm8008381pjd.50.2020.08.06.09.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:41:33 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 5/5] submodule: port submodule subcommand 'summary' from shell to C
Date:   Thu,  6 Aug 2020 22:11:02 +0530
Message-Id: <20200806164102.6707-6-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

Convert submodule subcommand 'summary' to a builtin and call it via
'git-submodule.sh'.

The shell version had to call $diff_cmd twice, once to find the modified
modules cared by the user and then again, with that list of modules
to do various operations for computing the summary of those modules.
On the other hand, the C version does not need a second call to
$diff_cmd since it reuses the module list from the first call to do the
aforementioned tasks.

In the C version, we use the combination of setting a child process'
working directory to the submodule path and then calling
'prepare_submodule_repo_env()' which also sets the 'GIT_DIR' to '.git',
so that we can be certain that those spawned processes will not access
the superproject's ODB by mistake.

A behavioural difference between the C and the shell version is that the
shell version outputs two line feeds after the 'git log' output when run
outside of the tests while the C version outputs one line feed in any
case. The reason for this is that the shell version calls log with
'--pretty=format:<fmt>' whose output is followed by two echo
calls; 'format' does not have "terminator" semantics like its 'tformat'
counterpart. So, the log output is terminated by a newline only when
invoked by the user and not when invoked from the scripts. This results
in the one & two line feed differences in the shell version.
On the other hand, the C version calls log with '--pretty=<fmt>'
which is equivalent to '--pretty:tformat:<fmt>' which is then
followed by a 'printf("\n")'. Due to its "terminator" semantics the
log output is always terminated by newline and hence one line feed in
any case.

Also, when we try to pass an option-like argument after a non-option
argument, for instance:

    git submodule summary HEAD --foo-bar

    (or)

    git submodule summary HEAD --cached

That argument would be treated like a path to the submodule for which
the user is requesting a summary. So, the option ends up having no
effect. Though, passing '--quiet' is an exception to this:

    git submodule summary HEAD --quiet

While 'summary' doesn't support '--quiet', we don't get an output for
the above command as '--quiet' is treated as a path which means we get
an output only if a submodule whose path is '--quiet' exists.

The error message in case of computing a summary for non-existent
submodules in the C version is different from that of the shell version.
Since the new error message is not marked for translation, change the
'test_i18ngrep' in t7421.4 to 'grep'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Stefan Beller <stefanbeller@gmail.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c      | 436 +++++++++++++++++++++++++++++++
 git-submodule.sh                 | 186 +------------
 t/t7421-submodule-summary-add.sh |   2 +-
 3 files changed, 438 insertions(+), 186 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3641718d0a..43ed2f645f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -927,6 +927,441 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct module_cb {
+	unsigned int mod_src;
+	unsigned int mod_dst;
+	struct object_id oid_src;
+	struct object_id oid_dst;
+	char status;
+	const char *sm_path;
+};
+#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
+
+struct module_cb_list {
+	struct module_cb **entries;
+	int alloc, nr;
+};
+#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
+
+struct summary_cb {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	unsigned int cached: 1;
+	unsigned int for_status: 1;
+	unsigned int files: 1;
+	int summary_limit;
+};
+#define SUMMARY_CB_INIT { 0, NULL, NULL, 0, 0, 0, 0 }
+
+enum diff_cmd {
+	DIFF_INDEX,
+	DIFF_FILES
+};
+
+static char* verify_submodule_committish(const char *sm_path,
+					 const char *committish)
+{
+	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+	struct strbuf result = STRBUF_INIT;
+
+	cp_rev_parse.git_cmd = 1;
+	cp_rev_parse.dir = sm_path;
+	prepare_submodule_repo_env(&cp_rev_parse.env_array);
+	argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
+			 "--short", NULL);
+	argv_array_pushf(&cp_rev_parse.args, "%s^0", committish);
+	argv_array_push(&cp_rev_parse.args, "--");
+
+	if (capture_command(&cp_rev_parse, &result, 0))
+		return NULL;
+
+	strbuf_trim_trailing_newline(&result);
+	return strbuf_detach(&result, NULL);
+}
+
+static void print_submodule_summary(struct summary_cb *info, char* errmsg,
+				    int total_commits, const char *displaypath,
+				    const char *src_abbrev, const char *dst_abbrev,
+				    int missing_src, int missing_dst,
+				    struct module_cb *p)
+{
+	if (p->status == 'T') {
+		if (S_ISGITLINK(p->mod_dst))
+			printf(_("* %s %s(blob)->%s(submodule)"),
+				 displaypath, src_abbrev, dst_abbrev);
+		else
+			printf(_("* %s %s(submodule)->%s(blob)"),
+				 displaypath, src_abbrev, dst_abbrev);
+	} else {
+		printf("* %s %s...%s",
+			displaypath, src_abbrev, dst_abbrev);
+	}
+
+	if (total_commits < 0)
+		printf(":\n");
+	else
+		printf(" (%d):\n", total_commits);
+
+	if (errmsg) {
+		printf(_("%s"), errmsg);
+	} else if (total_commits > 0) {
+		struct child_process cp_log = CHILD_PROCESS_INIT;
+
+		cp_log.git_cmd = 1;
+		cp_log.dir = p->sm_path;
+		prepare_submodule_repo_env(&cp_log.env_array);
+		argv_array_pushl(&cp_log.args, "log", NULL);
+
+		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
+			if (info->summary_limit > 0)
+				argv_array_pushf(&cp_log.args, "-%d",
+						 info->summary_limit);
+
+			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
+					 "--first-parent", NULL);
+			argv_array_pushf(&cp_log.args, "%s...%s",
+					 src_abbrev,
+					 dst_abbrev);
+		} else if (S_ISGITLINK(p->mod_dst)) {
+			argv_array_pushl(&cp_log.args, "--pretty=  > %s",
+					 "-1", dst_abbrev, NULL);
+		} else {
+			argv_array_pushl(&cp_log.args, "--pretty=  < %s",
+					 "-1", src_abbrev, NULL);
+		}
+		run_command(&cp_log);
+	}
+	printf("\n");
+}
+
+static void generate_submodule_summary(struct summary_cb *info,
+				       struct module_cb *p)
+{
+	char *displaypath, *src_abbrev, *dst_abbrev;
+	int missing_src = 0, missing_dst = 0;
+	char *errmsg = NULL;
+	int total_commits = -1;
+
+	if (!info->cached && oideq(&p->oid_dst, &null_oid)) {
+		if (S_ISGITLINK(p->mod_dst)) {
+			struct ref_store *refs = get_submodule_ref_store(p->sm_path);
+			if (refs)
+				refs_head_ref(refs, handle_submodule_head_ref, &p->oid_dst);
+		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
+			struct stat st;
+			int fd = open(p->sm_path, O_RDONLY);
+
+			if (fd < 0 || fstat(fd, &st) < 0 ||
+			    index_fd(&the_index, &p->oid_dst, fd, &st, OBJ_BLOB,
+				     p->sm_path, 0))
+				error(_("couldn't hash object from '%s'"), p->sm_path);
+		} else {
+			/* for a submodule removal (mode:0000000), don't warn */
+			if (p->mod_dst)
+				warning(_("unexpected mode %d\n"), p->mod_dst);
+		}
+	}
+
+	if (S_ISGITLINK(p->mod_src)) {
+		src_abbrev = verify_submodule_committish(p->sm_path,
+							 oid_to_hex(&p->oid_src));
+		if (!src_abbrev) {
+			missing_src = 1;
+			/*
+			 * As `rev-parse` failed, we fallback to getting
+			 * the abbreviated hash using oid_src. We do
+			 * this as we might still need the abbreviated
+			 * hash in cases like a submodule type change, etc.
+			 */
+			src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
+		}
+	} else {
+		/*
+		 * The source does not point to a submodule.
+		 * So, we fallback to getting the abbreviation using
+		 * oid_src as we might still need the abbreviated
+		 * hash in cases like submodule add, etc.
+		 */
+		src_abbrev = xstrndup(oid_to_hex(&p->oid_src), 7);
+	}
+
+	if (S_ISGITLINK(p->mod_dst)) {
+		dst_abbrev = verify_submodule_committish(p->sm_path,
+							 oid_to_hex(&p->oid_dst));
+		if (!dst_abbrev) {
+			missing_dst = 1;
+			/*
+			 * As `rev-parse` failed, we fallback to getting
+			 * the abbreviated hash using oid_dst. We do
+			 * this as we might still need the abbreviated
+			 * hash in cases like a submodule type change, etc.
+			 */
+			dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
+		}
+	} else {
+		/*
+		 * The destination does not point to a submodule.
+		 * So, we fallback to getting the abbreviation using
+		 * oid_dst as we might still need the abbreviated
+		 * hash in cases like a submodule removal, etc.
+		 */
+		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
+	}
+
+	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
+
+	if (!missing_src && !missing_dst) {
+		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
+		struct strbuf sb_rev_list = STRBUF_INIT;
+
+		argv_array_pushl(&cp_rev_list.args, "rev-list",
+				 "--first-parent", "--count", NULL);
+		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
+			argv_array_pushf(&cp_rev_list.args, "%s...%s",
+					 src_abbrev,
+					 dst_abbrev);
+		else
+			argv_array_push(&cp_rev_list.args,
+					S_ISGITLINK(p->mod_src) ?
+					src_abbrev :
+					dst_abbrev);
+		argv_array_push(&cp_rev_list.args, "--");
+
+		cp_rev_list.git_cmd = 1;
+		cp_rev_list.dir = p->sm_path;
+		prepare_submodule_repo_env(&cp_rev_list.env_array);
+
+		if (!capture_command(&cp_rev_list, &sb_rev_list, 0))
+			total_commits = atoi(sb_rev_list.buf);
+
+		strbuf_release(&sb_rev_list);
+	} else {
+		/*
+		 * Don't give error msg for modification whose dst is not
+		 * submodule, i.e., deleted or changed to blob
+		 */
+		if (S_ISGITLINK(p->mod_dst)) {
+			struct strbuf errmsg_str = STRBUF_INIT;
+			if (missing_src && missing_dst) {
+				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
+					    displaypath, oid_to_hex(&p->oid_src),
+					    oid_to_hex(&p->oid_dst));
+			} else {
+				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
+					    displaypath, missing_src ?
+					    oid_to_hex(&p->oid_src) :
+					    oid_to_hex(&p->oid_dst));
+			}
+			errmsg = strbuf_detach(&errmsg_str, NULL);
+		}
+	}
+
+	print_submodule_summary(info, errmsg, total_commits,
+				displaypath, src_abbrev,
+				dst_abbrev, missing_src,
+				missing_dst, p);
+
+	free(displaypath);
+	free(src_abbrev);
+	free(dst_abbrev);
+}
+
+static void prepare_submodule_summary(struct summary_cb *info,
+				      struct module_cb_list *list)
+{
+	int i;
+	for (i = 0; i < list->nr; i++) {
+		const struct submodule *sub;
+		struct module_cb *p = list->entries[i];
+		struct strbuf sm_gitdir = STRBUF_INIT;
+
+		if (p->status == 'D' || p->status == 'T') {
+			generate_submodule_summary(info, p);
+			continue;
+		}
+
+		if (info->for_status && p->status != 'A' &&
+		    (sub = submodule_from_path(the_repository,
+					       &null_oid, p->sm_path))) {
+			char *config_key = NULL;
+			const char *value;
+			int ignore_all = 0;
+
+			config_key = xstrfmt("submodule.%s.ignore",
+					     sub->name);
+			if (!git_config_get_string_const(config_key, &value))
+				ignore_all = !strcmp(value, "all");
+			else if (sub->ignore)
+				ignore_all = !strcmp(sub->ignore, "all");
+
+			free(config_key);
+			if (ignore_all)
+				continue;
+		}
+
+		/* Also show added or modified modules which are checked out */
+		strbuf_addstr(&sm_gitdir, p->sm_path);
+		if (is_nonbare_repository_dir(&sm_gitdir))
+			generate_submodule_summary(info, p);
+		strbuf_release(&sm_gitdir);
+	}
+}
+
+static void submodule_summary_callback(struct diff_queue_struct *q,
+				       struct diff_options *options,
+				       void *data)
+{
+	int i;
+	struct module_cb_list *list = data;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct module_cb *temp;
+
+		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
+			continue;
+		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		temp->mod_src = p->one->mode;
+		temp->mod_dst = p->two->mode;
+		temp->oid_src = p->one->oid;
+		temp->oid_dst = p->two->oid;
+		temp->status = p->status;
+		temp->sm_path = xstrdup(p->one->path);
+
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = temp;
+	}
+}
+
+static const char *get_diff_cmd(enum diff_cmd diff_cmd)
+{
+	switch (diff_cmd) {
+	case DIFF_INDEX: return "diff-index";
+	case DIFF_FILES: return "diff-files";
+	default: BUG("bad diff_cmd value %d", diff_cmd);
+	}
+}
+
+static int compute_summary_module_list(struct object_id *head_oid,
+				       struct summary_cb *info,
+				       enum diff_cmd diff_cmd)
+{
+	struct argv_array diff_args = ARGV_ARRAY_INIT;
+	struct rev_info rev;
+	struct module_cb_list list = MODULE_CB_LIST_INIT;
+
+	argv_array_push(&diff_args, get_diff_cmd(diff_cmd));
+	if (info->cached)
+		argv_array_push(&diff_args, "--cached");
+	argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
+			 NULL);
+	if (head_oid)
+		argv_array_push(&diff_args, oid_to_hex(head_oid));
+	argv_array_push(&diff_args, "--");
+	if (info->argc)
+		argv_array_pushv(&diff_args, info->argv);
+
+	git_config(git_diff_basic_config, NULL);
+	init_revisions(&rev, info->prefix);
+	rev.abbrev = 0;
+	precompose_argv(diff_args.argc, diff_args.argv);
+
+	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
+					 &rev, NULL);
+	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = submodule_summary_callback;
+	rev.diffopt.format_callback_data = &list;
+
+	if (!info->cached) {
+		if (diff_cmd == DIFF_INDEX)
+			setup_work_tree();
+		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+			perror("read_cache_preload");
+			return -1;
+		}
+	} else if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
+
+	if (diff_cmd == DIFF_INDEX)
+		run_diff_index(&rev, info->cached);
+	else
+		run_diff_files(&rev, 0);
+	prepare_submodule_summary(info, &list);
+	return 0;
+}
+
+static int module_summary(int argc, const char **argv, const char *prefix)
+{
+	struct summary_cb info = SUMMARY_CB_INIT;
+	int cached = 0;
+	int for_status = 0;
+	int files = 0;
+	int summary_limit = -1;
+	enum diff_cmd diff_cmd = DIFF_INDEX;
+	struct object_id head_oid;
+	int ret;
+
+	struct option module_summary_options[] = {
+		OPT_BOOL(0, "cached", &cached,
+			 N_("use the commit stored in the index instead of the submodule HEAD")),
+		OPT_BOOL(0, "files", &files,
+			 N_("to compare the commit in the index with that in the submodule HEAD")),
+		OPT_BOOL(0, "for-status", &for_status,
+			 N_("skip submodules with 'ignore_config' value set to 'all'")),
+		OPT_INTEGER('n', "summary-limit", &summary_limit,
+			     N_("limit the summary size")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper summary [<options>] [commit] [--] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_summary_options,
+			     git_submodule_helper_usage, 0);
+
+	if (!summary_limit)
+		return 0;
+
+	if (!get_oid(argc ? argv[0] : "HEAD", &head_oid)) {
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else if (!argc || !strcmp(argv[0], "HEAD")) {
+		/* before the first commit: compare with an empty tree */
+		oidcpy(&head_oid, the_hash_algo->empty_tree);
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else {
+		if (get_oid("HEAD", &head_oid))
+			die(_("could not fetch a revision for HEAD"));
+	}
+
+	if (files) {
+		if (cached)
+			die(_("--cached and --files are mutually exclusive"));
+		diff_cmd = DIFF_FILES;
+	}
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.cached = !!cached;
+	info.files = !!files;
+	info.for_status = !!for_status;
+	info.summary_limit = summary_limit;
+
+	ret = compute_summary_module_list((diff_cmd == DIFF_INDEX) ? &head_oid : NULL,
+					  &info, diff_cmd);
+	return ret;
+}
+
 struct sync_cb {
 	const char *prefix;
 	unsigned int flags;
@@ -2341,6 +2776,7 @@ static struct cmd_struct commands[] = {
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
+	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index dda3fee167..236a08f27d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -59,31 +59,6 @@ die_if_unmatched ()
 	fi
 }
 
-#
-# Print a submodule configuration setting
-#
-# $1 = submodule name
-# $2 = option name
-# $3 = default value
-#
-# Checks in the usual git-config places first (for overrides),
-# otherwise it falls back on .gitmodules.  This allows you to
-# distribute project-wide defaults in .gitmodules, while still
-# customizing individual repositories if necessary.  If the option is
-# not in .gitmodules either, print a default value.
-#
-get_submodule_config () {
-	name="$1"
-	option="$2"
-	default="$3"
-	value=$(git config submodule."$name"."$option")
-	if test -z "$value"
-	then
-		value=$(git submodule--helper config submodule."$name"."$option")
-	fi
-	printf '%s' "${value:-$default}"
-}
-
 isnumber()
 {
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
@@ -831,166 +806,7 @@ cmd_summary() {
 		shift
 	done
 
-	test $summary_limit = 0 && return
-
-	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
-	then
-		head=$rev
-		test $# = 0 || shift
-	elif test -z "$1" || test "$1" = "HEAD"
-	then
-		# before the first commit: compare with an empty tree
-		head=$(git hash-object -w -t tree --stdin </dev/null)
-		test -z "$1" || shift
-	else
-		head="HEAD"
-	fi
-
-	if [ -n "$files" ]
-	then
-		test -n "$cached" &&
-		die "$(gettext "The --cached option cannot be used with the --files option")"
-		diff_cmd=diff-files
-		head=
-	fi
-
-	cd_to_toplevel
-	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
-	# Get modified modules cared by user
-	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
-		sane_egrep '^:([0-7]* )?160000' |
-		while read -r mod_src mod_dst sha1_src sha1_dst status sm_path
-		do
-			# Always show modules deleted or type-changed (blob<->module)
-			if test "$status" = D || test "$status" = T
-			then
-				printf '%s\n' "$sm_path"
-				continue
-			fi
-			# Respect the ignore setting for --for-status.
-			if test -n "$for_status"
-			then
-				name=$(git submodule--helper name "$sm_path")
-				ignore_config=$(get_submodule_config "$name" ignore none)
-				test $status != A && test $ignore_config = all && continue
-			fi
-			# Also show added or modified modules which are checked out
-			GIT_DIR="$sm_path/.git" git rev-parse --git-dir >/dev/null 2>&1 &&
-			printf '%s\n' "$sm_path"
-		done
-	)
-
-	test -z "$modules" && return
-
-	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
-	sane_egrep '^:([0-7]* )?160000' |
-	cut -c2- |
-	while read -r mod_src mod_dst sha1_src sha1_dst status name
-	do
-		if test -z "$cached" &&
-			is_zero_oid $sha1_dst
-		then
-			case "$mod_dst" in
-			160000)
-				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
-				;;
-			100644 | 100755 | 120000)
-				sha1_dst=$(git hash-object $name)
-				;;
-			000000)
-				;; # removed
-			*)
-				# unexpected type
-				eval_gettextln "unexpected mode \$mod_dst" >&2
-				continue ;;
-			esac
-		fi
-		missing_src=
-		missing_dst=
-
-		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_src^0 >/dev/null &&
-		missing_src=t
-
-		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git rev-parse -q --verify $sha1_dst^0 >/dev/null &&
-		missing_dst=t
-
-		display_name=$(git submodule--helper relative-path "$name" "$wt_prefix")
-
-		total_commits=
-		case "$missing_src,$missing_dst" in
-		t,)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_src")"
-			;;
-		,t)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_dst")"
-			;;
-		t,t)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commits \$sha1_src and \$sha1_dst")"
-			;;
-		*)
-			errmsg=
-			total_commits=$(
-			if test $mod_src = 160000 && test $mod_dst = 160000
-			then
-				range="$sha1_src...$sha1_dst"
-			elif test $mod_src = 160000
-			then
-				range=$sha1_src
-			else
-				range=$sha1_dst
-			fi
-			GIT_DIR="$name/.git" \
-			git rev-list --first-parent $range -- | wc -l
-			)
-			total_commits=" ($(($total_commits + 0)))"
-			;;
-		esac
-
-		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src 2>/dev/null ||
-			echo $sha1_src | cut -c1-7)
-		sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst 2>/dev/null ||
-			echo $sha1_dst | cut -c1-7)
-
-		if test $status = T
-		then
-			blob="$(gettext "blob")"
-			submodule="$(gettext "submodule")"
-			if test $mod_dst = 160000
-			then
-				echo "* $display_name $sha1_abbr_src($blob)->$sha1_abbr_dst($submodule)$total_commits:"
-			else
-				echo "* $display_name $sha1_abbr_src($submodule)->$sha1_abbr_dst($blob)$total_commits:"
-			fi
-		else
-			echo "* $display_name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
-		fi
-		if test -n "$errmsg"
-		then
-			# Don't give error msg for modification whose dst is not submodule
-			# i.e. deleted or changed to blob
-			test $mod_dst = 160000 && echo "$errmsg"
-		else
-			if test $mod_src = 160000 && test $mod_dst = 160000
-			then
-				limit=
-				test $summary_limit -gt 0 && limit="-$summary_limit"
-				GIT_DIR="$name/.git" \
-				git log $limit --pretty='format:  %m %s' \
-				--first-parent $sha1_src...$sha1_dst
-			elif test $mod_dst = 160000
-			then
-				GIT_DIR="$name/.git" \
-				git log --pretty='format:  > %s' -1 $sha1_dst
-			else
-				GIT_DIR="$name/.git" \
-				git log --pretty='format:  < %s' -1 $sha1_src
-			fi
-			echo
-		fi
-		echo
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${prefix:+--prefix "$prefix"} ${files:+--files} ${cached:+--cached} ${for_status:+--for-status} ${summary_limit:+-n $summary_limit} -- "$@"
 }
 #
 # List all submodules, prefixed with:
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
index 829fe26d6d..59a9b00467 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
 	git commit -m "change submodule path" &&
 	rev=$(git -C sm rev-parse --short HEAD^) &&
 	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-	test_i18ngrep "fatal:.*my-subm" err &&
+	grep "fatal:.*my-subm" err &&
 	cat >expected <<-EOF &&
 	* my-subm ${rev}...0000000:
 
-- 
2.28.0

