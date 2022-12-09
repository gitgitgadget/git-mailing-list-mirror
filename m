Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C5C04FDE
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLIVDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLIVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 16:03:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB88AFCF0
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 13:03:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n7so749075wms.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+LG3K7Zdoj3E/D2T2MnPbI/94+SH7nse5Tvtu68px0=;
        b=KHTZY/ygGQ4FXZGjHVLRmj6lLNQ/JhqQkZhep4DCiWVI3wH8HjdJdcd2jWGICtpjyW
         2rs5UMBGJHjUOO5fyvGrOJCpdeTvVJyzeyycT3cIwLDpWXSaGVKoOEaCyLCZ1qIq8SLU
         h+DF2IBTCoz6sA5JpTYU2uzih1H/4svt3iRSQBzHsCIYOkPrxoJaOgSLuyJs7evlUdDm
         wlMH1KTPVfSOAOSTWugSEWYIPErKinjtzzu6NazL/cU2BkbywHwrfAZ72JqIb31UkuuK
         TnZOr2ZIrXNNfN6+tFoQWGaV6Uf+AmuELDjX7WG+naXD8zcZWKy3pUnfcMMF9gD7aTxn
         mXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+LG3K7Zdoj3E/D2T2MnPbI/94+SH7nse5Tvtu68px0=;
        b=qnRJRGjbkhLScnKXlab8LxnW5cjygpI35yKKGXsTYtN8QpkvkpL44xf6rPzK42q8JS
         TYdodx9372JINTbJdv8qynuHt3y7Ayh/yeh1r2V3m849nsHtuw1RUVOH7RUuCeAqfGCA
         juVAAW2o8YgGv6UK8Elj8n5hLht9ofUXLRTjw7gWgbxv3TVyBszCpApPkE9lrLdx/+RA
         YEnFc4WQy2fuCTviMrnR4L3HvTTLt0TCgzBA1CbNY2UEHJp7lqFNLwi9FU9uQ6KYR9ay
         RJT93MPiosQd5MGdEW8gPyCdyrMynsqlHm5xMZaVzFiLUGUWvQ6M87CfpiqmL6j/uEKo
         NATQ==
X-Gm-Message-State: ANoB5pmNZ/5NkTfb0XDgQIEeXXwmlrRtw+008+JmS+JxPZ3tWlfLnWYR
        YJGnF/2uOiPYtzcryCcrzrAdp7SzrDQ+9g==
X-Google-Smtp-Source: AA0mqf7TCTQJSXZkotdKY+IFh0ckEWZfq6RiVJDGN0Lrx6kK76IiPBfmpqSubR1k4V3V6YiuQitiuQ==
X-Received: by 2002:a05:600c:502c:b0:3cf:900c:de6b with SMTP id n44-20020a05600c502c00b003cf900cde6bmr6255608wmr.15.1670619806371;
        Fri, 09 Dec 2022 13:03:26 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003c701c12a17sm887838wmo.12.2022.12.09.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:03:26 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] check-attr: add support to work with revisions
Date:   Fri,  9 Dec 2022 22:03:19 +0100
Message-Id: <20221209210321.709156-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/

Given a pathname, git-check-attr(1) will list the attributes which apply to that
pathname by reading all relevant gitattributes files. Currently there is no way
to specify a revision to read the gitattributes from.

This is specifically useful in bare repositories wherein the gitattributes are
only present in the git working tree but not available directly on the
filesystem.

This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
allows us to read gitattributes from the specified revision.

Changes since version 1:
1. Now we parse the userinput revision at the start (builtin/attr.c) and only
propagate the tree_oid object. This allows us to also exit early in case a wrong
revision is provided.
2. Added missing documentation
3. Changed the argument positioning
4. Some code review fixes around the syntax

range-diff against version 1:

1:  2e71cbbddd = 1:  2e71cbbddd Git 2.39-rc2
2:  898041f243 = 2:  898041f243 t0003: move setup for `--all` into new block
3:  36eec9ba1a ! 3:  12a72e09e0 attr: add flag `-r|--revisions` to work with revisions
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
         Co-authored-by: toon@iotcl.com
     
    + ## Documentation/git-check-attr.txt ##
    +@@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes information
    + SYNOPSIS
    + --------
    + [verse]
    +-'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
    +-'git check-attr' --stdin [-z] [-a | --all | <attr>...]
    ++'git check-attr' [-a | --all | <attr>...] [-r <revision>] [--] <pathname>...
    ++'git check-attr' --stdin [-z] [-a | --all | <attr>...] [-r <revision>]
    + 
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-check-attr.txt: OPTIONS
    + 	If `--stdin` is also given, input paths are separated
    + 	with a NUL character instead of a linefeed character.
    + 
    ++--r <revision>::
    ++--revision=<revision>::
    ++	Check attributes against the specified revision.
    ++
    + \--::
    + 	Interpret all preceding arguments as attributes and all following
    + 	arguments as path names.
    +
      ## archive.c ##
     @@ archive.c: static const struct attr_check *get_archive_attrs(struct index_state *istate,
      	static struct attr_check *check;
      	if (!check)
      		check = attr_check_initl("export-ignore", "export-subst", NULL);
     -	git_check_attr(istate, path, check);
    -+	git_check_attr(istate, path, check, NULL);
    ++	git_check_attr(istate, NULL, path, check);
      	return check;
      }
      
    @@ attr.c
      #include "dir.h"
     +#include "git-compat-util.h"
     +#include "strbuf.h"
    ++#include "tree-walk.h"
      #include "utf8.h"
      #include "quote.h"
     +#include "revision.h"
    @@ attr.c: static struct attr_stack *read_attr_from_file(const char *path, unsigned
     +	char *sp;
      	int lineno = 0;
      
    -+	if (buf == NULL)
    ++	if (!buf)
     +		return NULL;
     +
     +	CALLOC_ARRAY(res, 1);
    @@ attr.c: static struct attr_stack *read_attr_from_file(const char *path, unsigned
     +	return res;
     +}
     +
    -+static struct attr_stack *read_attr_from_blob(const char *path,
    -+					      const char *object_name,
    -+					      unsigned flags)
    ++static struct attr_stack *read_attr_from_blob(struct index_state *istate,
    ++					      const struct object_id *tree_oid,
    ++					      const char *path, unsigned flags)
     +{
     +	struct object_id oid;
     +	unsigned long sz;
     +	enum object_type type;
     +	void *buf;
    -+	struct strbuf sb;
    ++	unsigned short mode;
     +
    -+	if (object_name == NULL)
    ++	if (!tree_oid)
     +		return NULL;
     +
    -+	strbuf_init(&sb, strlen(path) + 1 + strlen(object_name));
    -+	strbuf_addstr(&sb, object_name);
    -+	strbuf_addstr(&sb, ":");
    -+	strbuf_addstr(&sb, path);
    -+
    -+	if (get_oid(sb.buf, &oid))
    ++	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
     +		return NULL;
     +
     +	buf = read_object_file(&oid, &type, &sz);
    @@ attr.c: static struct attr_stack *read_attr_from_index(struct index_state *istat
      }
      
      static struct attr_stack *read_attr(struct index_state *istate,
    --				    const char *path, unsigned flags)
    -+				    const char *path, const char *object_name,
    -+				    unsigned flags)
    ++				    const struct object_id *tree_oid,
    + 				    const char *path, unsigned flags)
      {
      	struct attr_stack *res = NULL;
      
      	if (direction == GIT_ATTR_INDEX) {
      		res = read_attr_from_index(istate, path, flags);
    -+	} else if (object_name != NULL) {
    -+		res = read_attr_from_blob(path, object_name, flags);
    ++	} else if (tree_oid) {
    ++		res = read_attr_from_blob(istate, tree_oid, path, flags);
      	} else if (!is_bare_repository()) {
      		if (direction == GIT_ATTR_CHECKOUT) {
      			res = read_attr_from_index(istate, path, flags);
    @@ attr.c: static void push_stack(struct attr_stack **attr_stack_p,
      }
      
      static void bootstrap_attr_stack(struct index_state *istate,
    --				 struct attr_stack **stack)
    -+				 struct attr_stack **stack,
    -+				 const char *object_name)
    ++				 const struct object_id *tree_oid,
    + 				 struct attr_stack **stack)
      {
      	struct attr_stack *e;
    - 	unsigned flags = READ_ATTR_MACRO_OK;
     @@ attr.c: static void bootstrap_attr_stack(struct index_state *istate,
      	}
      
      	/* root directory */
     -	e = read_attr(istate, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
    -+	e = read_attr(istate, GITATTRIBUTES_FILE, object_name, flags | READ_ATTR_NOFOLLOW);
    ++	e = read_attr(istate, tree_oid, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
      	push_stack(stack, e, xstrdup(""), 0);
      
      	/* info frame */
     @@ attr.c: static void bootstrap_attr_stack(struct index_state *istate,
    - 	push_stack(stack, e, NULL, 0);
      }
      
    --static void prepare_attr_stack(struct index_state *istate,
    --			       const char *path, int dirlen,
    --			       struct attr_stack **stack)
    -+static void prepare_attr_stack(struct index_state *istate, const char *path,
    -+			       int dirlen, struct attr_stack **stack,
    -+			       const char *object_name)
    + static void prepare_attr_stack(struct index_state *istate,
    ++			       const struct object_id *tree_oid,
    + 			       const char *path, int dirlen,
    + 			       struct attr_stack **stack)
      {
    - 	struct attr_stack *info;
    - 	struct strbuf pathbuf = STRBUF_INIT;
     @@ attr.c: static void prepare_attr_stack(struct index_state *istate,
      	 * .gitattributes in deeper directories to shallower ones,
      	 * and finally use the built-in set as the default.
      	 */
     -	bootstrap_attr_stack(istate, stack);
    -+	bootstrap_attr_stack(istate, stack, object_name);
    ++	bootstrap_attr_stack(istate, tree_oid, stack);
      
      	/*
      	 * Pop the "info" one that is always at the top of the stack.
    @@ attr.c: static void prepare_attr_stack(struct index_state *istate,
      		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
      
     -		next = read_attr(istate, pathbuf.buf, READ_ATTR_NOFOLLOW);
    -+		next = read_attr(istate, pathbuf.buf, object_name, READ_ATTR_NOFOLLOW);
    ++		next = read_attr(istate, tree_oid, pathbuf.buf, READ_ATTR_NOFOLLOW);
      
      		/* reset the pathbuf to not include "/.gitattributes" */
      		strbuf_setlen(&pathbuf, len);
     @@ attr.c: static void determine_macros(struct all_attrs_item *all_attrs,
    -  * If check->check_nr is non-zero, only attributes in check[] are collected.
       * Otherwise all attributes are collected.
       */
    --static void collect_some_attrs(struct index_state *istate,
    + static void collect_some_attrs(struct index_state *istate,
     -			       const char *path,
     -			       struct attr_check *check)
    -+static void collect_some_attrs(struct index_state *istate, const char *path,
    -+			       struct attr_check *check,
    -+			       const char *object_name)
    ++			       const struct object_id *tree_oid,
    ++			       const char *path, struct attr_check *check)
      {
      	int pathlen, rem, dirlen;
      	const char *cp, *last_slash = NULL;
    @@ attr.c: static void collect_some_attrs(struct index_state *istate,
      	}
      
     -	prepare_attr_stack(istate, path, dirlen, &check->stack);
    -+	prepare_attr_stack(istate, path, dirlen, &check->stack, object_name);
    ++	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
      	all_attrs_init(&g_attr_hashmap, check);
      	determine_macros(check->all_attrs, check->stack);
      
     @@ attr.c: static void collect_some_attrs(struct index_state *istate,
    - 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
      }
      
    --void git_check_attr(struct index_state *istate,
    + void git_check_attr(struct index_state *istate,
     -		    const char *path,
    --		    struct attr_check *check)
    -+void git_check_attr(struct index_state *istate, const char *path,
    -+		    struct attr_check *check, const char *object_name)
    ++		    const struct object_id *tree_oid, const char *path,
    + 		    struct attr_check *check)
      {
      	int i;
      
     -	collect_some_attrs(istate, path, check);
    -+	collect_some_attrs(istate, path, check, object_name);
    ++	collect_some_attrs(istate, tree_oid, path, check);
      
      	for (i = 0; i < check->nr; i++) {
      		size_t n = check->items[i].attr->attr_nr;
    @@ attr.c: void git_check_attr(struct index_state *istate,
      }
      
     -void git_all_attrs(struct index_state *istate,
    --		   const char *path, struct attr_check *check)
    -+void git_all_attrs(struct index_state *istate, const char *path,
    -+		   struct attr_check *check, const char *object_name)
    ++void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
    + 		   const char *path, struct attr_check *check)
      {
      	int i;
      
      	attr_check_reset(check);
     -	collect_some_attrs(istate, path, check);
    -+	collect_some_attrs(istate, path, check, object_name);
    ++	collect_some_attrs(istate, tree_oid, path, check);
      
      	for (i = 0; i < check->all_attrs_nr; i++) {
      		const char *name = check->all_attrs[i].attr->name;
     
      ## attr.h ##
    -@@ attr.h: struct attr_check {
    - 	int all_attrs_nr;
    - 	struct all_attrs_item *all_attrs;
    - 	struct attr_stack *stack;
    -+	char *object_id;
    - };
    +@@
    + #ifndef ATTR_H
    + #define ATTR_H
      
    - struct attr_check *attr_check_alloc(void);
    ++#include "hash.h"
    ++
    + /**
    +  * gitattributes mechanism gives a uniform way to associate various attributes
    +  * to set of paths.
     @@ attr.h: void attr_check_free(struct attr_check *check);
      const char *git_attr_name(const struct git_attr *);
      
      void git_check_attr(struct index_state *istate,
     -		    const char *path, struct attr_check *check);
    -+					const char *path, struct attr_check *check,
    -+					const char *object_name);
    ++		    const struct object_id *tree_oid, const char *path,
    ++		    struct attr_check *check);
      
      /*
       * Retrieve all attributes that apply to the specified path.
       * check holds the attributes and their values.
       */
    - void git_all_attrs(struct index_state *istate,
    --		   const char *path, struct attr_check *check);
    -+				   const char *path, struct attr_check *check,
    -+				   const char *object_name);
    +-void git_all_attrs(struct index_state *istate,
    ++void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
    + 		   const char *path, struct attr_check *check);
      
      enum git_attr_direction {
    - 	GIT_ATTR_CHECKIN,
     
      ## builtin/check-attr.c ##
    +@@
    ++#include "repository.h"
    + #define USE_THE_INDEX_VARIABLE
    + #include "builtin.h"
    + #include "cache.h"
     @@
      static int all_attrs;
      static int cached_attrs;
      static int stdin_paths;
    -+static char *object_name;
    ++static char *revision;
      static const char * const check_attr_usage[] = {
    - N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
    - N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
    +-N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
    +-N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
    ++N_("git check-attr [-a | --all | <attr>...] [-r <revision>] [--] <pathname>..."),
    ++N_("git check-attr --stdin [-z] [-a | --all | <attr>...] [-r <revision>]"),
    + NULL
    + };
    + 
     @@ builtin/check-attr.c: static const struct option check_attr_options[] = {
      	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
      	OPT_BOOL('z', NULL, &nul_term_line,
      		 N_("terminate input and output records by a NUL character")),
    -+	OPT_STRING('r', "revision", &object_name, N_("revision"), N_("check attributes at this revision")),
    ++	OPT_STRING('r', "revision", &revision, N_("revision"), N_("check attributes at this revision")),
      	OPT_END()
      };
      
    @@ builtin/check-attr.c: static void output_attr(struct attr_check *check, const ch
     -static void check_attr(const char *prefix,
     -		       struct attr_check *check,
     -		       int collect_all,
    --		       const char *file)
     +static void check_attr(const char *prefix, struct attr_check *check,
    -+		       int collect_all, const char *file,
    -+		       const char *object_name
    -+)
    ++		       const struct object_id *tree_oid, int collect_all,
    + 		       const char *file)
    ++
      {
      	char *full_path =
      		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
      
      	if (collect_all) {
     -		git_all_attrs(&the_index, full_path, check);
    -+		git_all_attrs(&the_index, full_path, check, object_name);
    ++		git_all_attrs(&the_index, tree_oid, full_path, check);
      	} else {
     -		git_check_attr(&the_index, full_path, check);
    -+		git_check_attr(&the_index, full_path, check, object_name);
    ++		git_check_attr(&the_index, tree_oid, full_path, check);
      	}
      	output_attr(check, file);
      
    @@ builtin/check-attr.c: static void output_attr(struct attr_check *check, const ch
     -				   struct attr_check *check,
     -				   int collect_all)
     +static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
    -+				   int collect_all, const char *object_name)
    ++				   const struct object_id *tree_oid, int collect_all)
      {
      	struct strbuf buf = STRBUF_INIT;
      	struct strbuf unquoted = STRBUF_INIT;
    @@ builtin/check-attr.c: static void check_attr_stdin_paths(const char *prefix,
      			strbuf_swap(&buf, &unquoted);
      		}
     -		check_attr(prefix, check, collect_all, buf.buf);
    -+		check_attr(prefix, check, collect_all, buf.buf, object_name);
    ++		check_attr(prefix, check, tree_oid, collect_all, buf.buf);
      		maybe_flush_or_die(stdout, "attribute to stdout");
      	}
      	strbuf_release(&buf);
    +@@ builtin/check-attr.c: static NORETURN void error_with_usage(const char *msg)
    + int cmd_check_attr(int argc, const char **argv, const char *prefix)
    + {
    + 	struct attr_check *check;
    ++	struct object_id tree_oid;
    + 	int cnt, i, doubledash, filei;
    + 
    + 	if (!is_bare_repository())
     @@ builtin/check-attr.c: int cmd_check_attr(int argc, const char **argv, const char *prefix)
    + 		}
      	}
      
    ++	if (revision)
    ++		if (repo_get_oid_tree(the_repository, revision, &tree_oid))
    ++			error("%s: not a valid revision", revision);
    ++
      	if (stdin_paths)
     -		check_attr_stdin_paths(prefix, check, all_attrs);
    -+		check_attr_stdin_paths(prefix, check, all_attrs, object_name);
    ++		check_attr_stdin_paths(prefix, check, &tree_oid, all_attrs);
      	else {
      		for (i = filei; i < argc; i++)
     -			check_attr(prefix, check, all_attrs, argv[i]);
    -+			check_attr(prefix, check, all_attrs, argv[i], object_name);
    ++			check_attr(prefix, check, &tree_oid, all_attrs, argv[i]);
      		maybe_flush_or_die(stdout, "attribute to stdout");
      	}
      
    @@ builtin/pack-objects.c: static int no_try_delta(const char *path)
      	if (!check)
      		check = attr_check_initl("delta", NULL);
     -	git_check_attr(the_repository->index, path, check);
    -+	git_check_attr(the_repository->index, path, check, NULL);
    ++	git_check_attr(the_repository->index, NULL, path, check);
      	if (ATTR_FALSE(check->items[0].value))
      		return 1;
      	return 0;
    @@ convert.c: void convert_attrs(struct index_state *istate,
      	}
      
     -	git_check_attr(istate, path, check);
    -+	git_check_attr(istate, path, check, NULL);
    ++	git_check_attr(istate, NULL, path, check);
      	ccheck = check->items;
      	ca->crlf_action = git_path_check_crlf(ccheck + 4);
      	if (ca->crlf_action == CRLF_UNDEFINED)
    @@ ll-merge.c: enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
      	}
      
     -	git_check_attr(istate, path, check);
    -+	git_check_attr(istate, path, check, NULL);
    ++	git_check_attr(istate, NULL, path, check);
      	ll_driver_name = check->items[0].value;
      	if (check->items[1].value) {
      		marker_size = atoi(check->items[1].value);
    @@ ll-merge.c: int ll_merge_marker_size(struct index_state *istate, const char *pat
      	if (!check)
      		check = attr_check_initl("conflict-marker-size", NULL);
     -	git_check_attr(istate, path, check);
    -+	git_check_attr(istate, path, check, NULL);
    ++	git_check_attr(istate, NULL, path, check);
      	if (check->items[0].value) {
      		marker_size = atoi(check->items[0].value);
      		if (marker_size <= 0)
    @@ pathspec.c: int match_pathspec_attrs(struct index_state *istate,
      		name = to_free = xmemdupz(name, namelen);
      
     -	git_check_attr(istate, name, item->attr_check);
    -+	git_check_attr(istate, name, item->attr_check, NULL);
    ++	git_check_attr(istate, NULL, name, item->attr_check);
      
      	free(to_free);
      
    @@ t/t0003-attributes.sh: test_expect_success 'setup' '
     +	(
     +		echo "f	test=f" &&
     +		echo "a/i test=n"
    -+	) | git hash-object -w --stdin > id &&
    ++	) | git hash-object -w --stdin >id &&
     +	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
    -+	git write-tree > id &&
    -+	git commit-tree $(cat id) -m "random commit message" > id &&
    -+	git update-ref refs/heads/branch1 $(cat id) &&
    ++	git write-tree >id &&
    ++	tree_id=$(cat id) &&
    ++	git commit-tree $tree_id -m "random commit message" >id &&
    ++	commit_id=$(cat id) &&
    ++	git update-ref refs/heads/branch1 $commit_id &&
     +
     +	(
     +		echo "g test=g" &&
     +		echo "a/i test=m"
    -+	) | git hash-object -w --stdin > id &&
    ++	) | git hash-object -w --stdin >id &&
     +	git update-index --add --cacheinfo 100644,$(cat id),foo/bar/.gitattributes &&
    -+	git write-tree > id &&
    -+	git commit-tree $(cat id) -m "random commit message" > id &&
    -+	git update-ref refs/heads/branch2 $(cat id)
    ++	git write-tree >id &&
    ++	tree_id=$(cat id) &&
    ++	git commit-tree $tree_id -m "random commit message" >id &&
    ++	commit_id=$(cat id) &&
    ++	git update-ref refs/heads/branch2 $commit_id
     +'
     +
      test_expect_success 'command line checks' '
      	test_must_fail git check-attr &&
      	test_must_fail git check-attr -- &&
    + 	test_must_fail git check-attr test &&
    + 	test_must_fail git check-attr test -- &&
    + 	test_must_fail git check-attr -- f &&
    ++	test_must_fail git check-attr -r &&
    ++	test_must_fail git check-attr -r not-a-valid-ref &&
    + 	echo "f" | test_must_fail git check-attr --stdin &&
    + 	echo "f" | test_must_fail git check-attr --stdin -- f &&
    + 	echo "f" | test_must_fail git check-attr --stdin test -- f &&
     @@ t/t0003-attributes.sh: test_expect_success 'using --git-dir and --work-tree' '
      	)
      '
    @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
     +		(
     +			echo "f	test=f" &&
     +			echo "a/i test=a/i"
    -+		) | git hash-object -w --stdin > id &&
    ++		) | git hash-object -w --stdin >id &&
     +		git update-index --add --cacheinfo 100644 $(cat id) .gitattributes &&
    -+		git write-tree > id &&
    -+		git commit-tree $(cat id) -m "random commit message" > id &&
    -+		git update-ref refs/heads/master $(cat id) &&
    ++		git write-tree >id &&
    ++		tree_id=$(cat id) &&
    ++		git commit-tree $tree_id -m "random commit message" >id &&
    ++		commit_id=$(cat id) &&
    ++		git update-ref refs/heads/master $commit_id &&
     +		attr_check_revision f f HEAD &&
     +		attr_check_revision a/f f HEAD &&
     +		attr_check_revision a/c/f f HEAD &&
    @@ userdiff.c: struct userdiff_driver *userdiff_find_by_path(struct index_state *is
      	if (!path)
      		return NULL;
     -	git_check_attr(istate, path, check);
    -+	git_check_attr(istate, path, check, NULL);
    ++	git_check_attr(istate, NULL, path, check);
      
      	if (ATTR_TRUE(check->items[0].value))
      		return &driver_true;
    @@ ws.c: unsigned whitespace_rule(struct index_state *istate, const char *pathname)
      		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
      
     -	git_check_attr(istate, pathname, attr_whitespace_rule);
    -+	git_check_attr(istate, pathname, attr_whitespace_rule, NULL);
    ++	git_check_attr(istate, NULL, pathname, attr_whitespace_rule);
      	value = attr_whitespace_rule->items[0].value;
      	if (ATTR_TRUE(value)) {
      		/* true (whitespace) */


Karthik Nayak (2):
  t0003: move setup for `--all` into new block
  attr: add flag `-r|--revisions` to work with revisions

 Documentation/git-check-attr.txt |   8 ++-
 archive.c                        |   2 +-
 attr.c                           | 100 ++++++++++++++++++++++---------
 attr.h                           |   7 ++-
 builtin/check-attr.c             |  33 ++++++----
 builtin/pack-objects.c           |   2 +-
 convert.c                        |   2 +-
 ll-merge.c                       |   4 +-
 pathspec.c                       |   2 +-
 t/t0003-attributes.sh            |  71 +++++++++++++++++++++-
 userdiff.c                       |   2 +-
 ws.c                             |   2 +-
 12 files changed, 180 insertions(+), 55 deletions(-)

-- 
2.38.1

