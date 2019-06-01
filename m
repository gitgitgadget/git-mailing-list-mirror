Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2DD1F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfFAAgb (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:36:31 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37768 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFAAgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 20:36:31 -0400
Received: by mail-yw1-f73.google.com with SMTP id j68so10375888ywj.4
        for <git@vger.kernel.org>; Fri, 31 May 2019 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4aBa33JqXUmynj90qnc05rPN1ZbGoDsEyb3IfGaHvnk=;
        b=ey2M/B29ExPpNawGQEGkwI6pVmfuQNh1EwefREvsoNprPYz7LQWZkpTyMWNA8nRNNI
         0pb7FnSAeDidAmUtx1kGuRxr531IE/VrEqVcMTr3dolV76dFvcZjqAxJM7iVcw70N54v
         vPu4U8sWIFJ7WoFRfJWl1/PwRk7irzy6u4RCAUGJRI5t47UYS5DzCjwR6sSWF3Dyol2I
         aWczWFZ96qkoILf5iDIU3cy8VnFiCspdZNXp5G8uqc5/lG6p54YtrNctxvQ3r270ivqT
         BtnkqZZH6cNYWAXknfWIJvt5KleAmaVomfvVHO6WrE2hxYXOusq/rC2paIxUWqRojGEa
         mnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4aBa33JqXUmynj90qnc05rPN1ZbGoDsEyb3IfGaHvnk=;
        b=IpyivLHZqK6yP7pYqHnzg4XdbG2XM3tLyW1mJjCRdpY31QWLE72HgmaZOecPtLQAFN
         hAkHmWJ1mGepLGcgP56LqAnF2QqA8XMEYSeVPZj314AwBSmMGfbwR5zpNVeWBLI5OEBn
         5KC2V4F95ZT0fRJAV9E3R/m5PNZLPhr9NN3TudhvC2mfj+JGu+sf9NmCCUiHnqOvAfTj
         Q8jzeAJLMfRdrALui9EDfgV9smgc4LCVATAZe5LsRo/Zi0CA0QTAvQp+DI5Mnrvnuhla
         u+Sp6cOzKyehQer8Fo6PliHYvt+33X/u5KV6Zial0xQeMBtykchMME94U1riHBDppXjr
         OhAg==
X-Gm-Message-State: APjAAAV2wLnGKcsMwyFimFOP0GTsDOnWi2MM6Vz9ykWvnqfxYWEqWhjc
        mEaaSqamRvFZjRcVsnrY+iRtuEI7VIarVe7Yoz7S86NudNxZb7sRfXQuBBzUktVbx85qHePxi2Y
        DLtR2zzmJflfmWWPW5OQzXSVUZWJNtL1MeCu9gO1Er03vJ8QGZiucgLtysgc=
X-Google-Smtp-Source: APXvYqy8zxUF8i19eM7rtpELy5Qca52pqtky3uace/nIfWrxCikfXGNiCZ+E7Mxe/qEoLIoWkDAt8UOKkT47
X-Received: by 2002:a25:d6:: with SMTP id 205mr6595615yba.180.1559349390315;
 Fri, 31 May 2019 17:36:30 -0700 (PDT)
Date:   Fri, 31 May 2019 17:36:00 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <20190601003603.90794-7-matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a strbuf
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the filter_spec string a strbuf rather than a raw C string. A
future patch will need to grow this string dynamically.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/rev-list.c            |  2 +-
 list-objects-filter-options.c | 16 ++++++++++------
 list-objects-filter-options.h |  2 +-
 upload-pack.c                 |  2 +-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9f31837d30..7137f13a74 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -460,21 +460,21 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&filter_options, arg);
 			if (filter_options.choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			if (filter_options.choice == LOFC_SPARSE_OID &&
 			    !filter_options.sparse_oid_value)
 				die(_("invalid sparse value '%s'"),
-				    filter_options.filter_spec);
+				    filter_options.filter_spec.buf);
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
 			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
 			arg_print_omitted = 1;
 			continue;
 		}
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8132b811e..5687425847 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -203,21 +203,22 @@ cleanup:
 	}
 	return result;
 }
 
 int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
 			      const char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	if (filter_options->choice)
 		die(_("multiple filter-specs cannot be combined"));
-	filter_options->filter_spec = strdup(arg);
+	strbuf_init(&filter_options->filter_spec, 0);
+	strbuf_addstr(&filter_options->filter_spec, arg);
 	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
 		die("%s", buf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
@@ -226,39 +227,39 @@ int opt_parse_list_objects_filter(const struct option *opt,
 		return 0;
 	}
 
 	return parse_list_objects_filter(filter_options, arg);
 }
 
 void expand_list_objects_filter_spec(
 	const struct list_objects_filter_options *filter,
 	struct strbuf *expanded_spec)
 {
-	strbuf_init(expanded_spec, strlen(filter->filter_spec));
+	strbuf_init(expanded_spec, 0);
 	if (filter->choice == LOFC_BLOB_LIMIT)
 		strbuf_addf(expanded_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
 	else if (filter->choice == LOFC_TREE_DEPTH)
 		strbuf_addf(expanded_spec, "tree:%lu",
 			    filter->tree_exclude_depth);
 	else
-		strbuf_addstr(expanded_spec, filter->filter_spec);
+		strbuf_addstr(expanded_spec, filter->filter_spec.buf);
 }
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	size_t sub;
 
 	if (!filter_options)
 		return;
-	free(filter_options->filter_spec);
+	strbuf_release(&filter_options->filter_spec);
 	free(filter_options->sparse_oid_value);
 	free(filter_options->sparse_path_value);
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
 void partial_clone_register(
 	const char *remote,
@@ -278,32 +279,35 @@ void partial_clone_register(
 	git_config_set("core.repositoryformatversion", "1");
 	git_config_set("extensions.partialclone", remote);
 
 	repository_format_partial_clone = xstrdup(remote);
 
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
 	 */
 	core_partial_clone_filter_default =
-		xstrdup(filter_options->filter_spec);
+		xstrdup(filter_options->filter_spec.buf);
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
 	if (!core_partial_clone_filter_default)
 		return;
 
-	filter_options->filter_spec = strdup(core_partial_clone_filter_default);
+	if (!filter_options->filter_spec.buf)
+		strbuf_init(&filter_options->filter_spec, 0);
+	strbuf_addstr(&filter_options->filter_spec,
+		      core_partial_clone_filter_default);
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
 					 &errbuf);
 	strbuf_release(&errbuf);
 }
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 8f08ed74a1..e1e23fd191 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -19,21 +19,21 @@ enum list_objects_filter_choice {
 };
 
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
 	 * or protocol request.  (The part after the "--keyword=".)  For
 	 * commands that launch filtering sub-processes, or for communication
 	 * over the network, don't use this value; use the result of
 	 * expand_list_objects_filter_spec() instead.
 	 */
-	char *filter_spec;
+	struct strbuf filter_spec;
 
 	/*
 	 * 'choice' is determined by parsing the filter-spec.  This indicates
 	 * the filtering algorithm to use.
 	 */
 	enum list_objects_filter_choice choice;
 
 	/*
 	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
 	 */
diff --git a/upload-pack.c b/upload-pack.c
index d2ea5eb20d..2cdd499f28 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -133,21 +133,21 @@ static void create_pack_file(const struct object_array *have_obj,
 
 	argv_array_push(&pack_objects.args, "--stdout");
 	if (shallow_nr)
 		argv_array_push(&pack_objects.args, "--shallow");
 	if (!no_progress)
 		argv_array_push(&pack_objects.args, "--progress");
 	if (use_ofs_delta)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
-	if (filter_options.filter_spec) {
+	if (filter_options.filter_spec.len) {
 		struct strbuf expanded_filter_spec = STRBUF_INIT;
 		expand_list_objects_filter_spec(&filter_options,
 						&expanded_filter_spec);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
 			sq_quote_buf(&buf, expanded_filter_spec.buf);
 			argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
 			strbuf_release(&buf);
 		} else {
 			argv_array_pushf(&pack_objects.args, "--filter=%s",
-- 
2.17.1

