Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5725CC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13009206CC
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcWKbhtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbgDBPEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:04:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37702 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbgDBPEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 11:04:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id j19so4030750wmi.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPG9CsYed7T5+sgHb9e68KwAEc6CAn4WlzNShpOC+QU=;
        b=CcWKbhtkpCP8YRpdrDqGGyVZhIHSpIqdM/3XbsMoolHK7D+wLMtH5WXpB0dGz6Qedm
         HY3IvN7KFROtgmZtWBKW7e1Xa8MILjrdtBrnkQykYJMtsU43qqWfLG/6bIwJwaOiAYQr
         ifo2Ze/m7DhQcp6mJrrhbVcerAuWGvOPwgDMo01tyOW5yVvci2HlldzCU75arQaYMzo9
         /fh7Oe6W4fFSrC5pY8bl43sloIAO97VvuabW1n6pOwYtfuywmOXErffl21U8+nQkv2r3
         2xK+rffRGHt6gZSP21e1yBqH6poAUGj7KAV6NNNZ/TM69CxNmsAXILolcVucTaAlprO7
         MUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TPG9CsYed7T5+sgHb9e68KwAEc6CAn4WlzNShpOC+QU=;
        b=UBtJ4FLYWn4I0YkPsFZ8v6ujq+z1ACp+mgp7vw+UH18dnXARHhNcxMpwzX2Yp0Ij5A
         +G8vDtYKUp5DgCkgO9jlEipoYOOfTNLY0tTi7CPgea91wTxllpyZNpUJalJc2Qxd6R/u
         zBg/oqNDe8Ck2IRzsaA28toaTEJwTQGCtYXaUMLzMUB/ZPRVlR4gfcel1X2EHeKTO4ze
         bRjWaf6vB3u+7LMXIWV3m/ow9t40JpWI8g8GZ7kRBa5uBptYqYet0d2DfKr7NGaDzdM/
         0cobR2mPffFI0Y1/Z26NK1dVGA95XeKjoUWBs29o7Y9r1uZ28ps6x4CjOavGNZyleZ2a
         B8rw==
X-Gm-Message-State: AGi0PuZ5UK2FQftlxSFcllnu+cgOuSviewfU+lJXNX/jsGS4jgnNHOdc
        pXKherE7psEdkQyhUT2PCsw=
X-Google-Smtp-Source: APiQypITLA4sxQF37ZLtoBOkgxtpvHHEpC0aDndPq49qxKNRRA+9Pjhu0VzSW7/Yu81kq9ralZxwVw==
X-Received: by 2002:a7b:cd02:: with SMTP id f2mr3766555wmj.97.1585839884854;
        Thu, 02 Apr 2020 08:04:44 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id f187sm7642432wme.9.2020.04.02.08.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 08:04:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 11/19] reset: extract reset_head() from rebase
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <a14a2e0849fea91c6c41cf71b8d049123bea0c6d.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <47714403-0537-176d-ffc3-86d914d0cf8b@gmail.com>
Date:   Thu, 2 Apr 2020 16:04:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a14a2e0849fea91c6c41cf71b8d049123bea0c6d.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> Continue the process of lib-ifying the autostash code. In a future
> commit, this will be used to implement `--autostash` in other builtins.
> 
> This patch is best viewed with `--color-moved`.

Indeed! It looks good. Looking ahead I hope we can use this to avoid 
forking 'git checkout' in sequencer.c

Best Wishes

Phillip

> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   Makefile         |   1 +
>   builtin/rebase.c | 139 +---------------------------------------------
>   reset.c          | 140 +++++++++++++++++++++++++++++++++++++++++++++++
>   reset.h          |  20 +++++++
>   4 files changed, 162 insertions(+), 138 deletions(-)
>   create mode 100644 reset.c
>   create mode 100644 reset.h
> 
> diff --git a/Makefile b/Makefile
> index f709fc3f77..338fb55b73 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -970,6 +970,7 @@ LIB_OBJS += replace-object.o
>   LIB_OBJS += repo-settings.o
>   LIB_OBJS += repository.o
>   LIB_OBJS += rerere.o
> +LIB_OBJS += reset.o
>   LIB_OBJS += resolve-undo.o
>   LIB_OBJS += revision.o
>   LIB_OBJS += run-command.o
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 52eb45b6c4..caff67b00d 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -27,6 +27,7 @@
>   #include "branch.h"
>   #include "sequencer.h"
>   #include "rebase-interactive.h"
> +#include "reset.h"
>   
>   #define DEFAULT_REFLOG_ACTION "rebase"
>   
> @@ -766,144 +767,6 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
>   	}
>   }
>   
> -#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
> -
> -#define RESET_HEAD_DETACH (1<<0)
> -#define RESET_HEAD_HARD (1<<1)
> -#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
> -#define RESET_HEAD_REFS_ONLY (1<<3)
> -#define RESET_ORIG_HEAD (1<<4)
> -
> -static int reset_head(struct repository *r, struct object_id *oid, const char *action,
> -		      const char *switch_to_branch, unsigned flags,
> -		      const char *reflog_orig_head, const char *reflog_head,
> -		      const char *default_reflog_action)
> -{
> -	unsigned detach_head = flags & RESET_HEAD_DETACH;
> -	unsigned reset_hard = flags & RESET_HEAD_HARD;
> -	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> -	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
> -	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
> -	struct object_id head_oid;
> -	struct tree_desc desc[2] = { { NULL }, { NULL } };
> -	struct lock_file lock = LOCK_INIT;
> -	struct unpack_trees_options unpack_tree_opts;
> -	struct tree *tree;
> -	const char *reflog_action;
> -	struct strbuf msg = STRBUF_INIT;
> -	size_t prefix_len;
> -	struct object_id *orig = NULL, oid_orig,
> -		*old_orig = NULL, oid_old_orig;
> -	int ret = 0, nr = 0;
> -
> -	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> -		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
> -
> -	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
> -		ret = -1;
> -		goto leave_reset_head;
> -	}
> -
> -	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
> -		ret = error(_("could not determine HEAD revision"));
> -		goto leave_reset_head;
> -	}
> -
> -	if (!oid)
> -		oid = &head_oid;
> -
> -	if (refs_only)
> -		goto reset_head_refs;
> -
> -	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> -	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> -	unpack_tree_opts.head_idx = 1;
> -	unpack_tree_opts.src_index = r->index;
> -	unpack_tree_opts.dst_index = r->index;
> -	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
> -	unpack_tree_opts.update = 1;
> -	unpack_tree_opts.merge = 1;
> -	if (!detach_head)
> -		unpack_tree_opts.reset = 1;
> -
> -	if (repo_read_index_unmerged(r) < 0) {
> -		ret = error(_("could not read index"));
> -		goto leave_reset_head;
> -	}
> -
> -	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
> -		ret = error(_("failed to find tree of %s"),
> -			    oid_to_hex(&head_oid));
> -		goto leave_reset_head;
> -	}
> -
> -	if (!fill_tree_descriptor(r, &desc[nr++], oid)) {
> -		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
> -		goto leave_reset_head;
> -	}
> -
> -	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
> -		ret = -1;
> -		goto leave_reset_head;
> -	}
> -
> -	tree = parse_tree_indirect(oid);
> -	prime_cache_tree(r, r->index, tree);
> -
> -	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
> -		ret = error(_("could not write index"));
> -		goto leave_reset_head;
> -	}
> -
> -reset_head_refs:
> -	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> -	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
> -	prefix_len = msg.len;
> -
> -	if (update_orig_head) {
> -		if (!get_oid("ORIG_HEAD", &oid_old_orig))
> -			old_orig = &oid_old_orig;
> -		if (!get_oid("HEAD", &oid_orig)) {
> -			orig = &oid_orig;
> -			if (!reflog_orig_head) {
> -				strbuf_addstr(&msg, "updating ORIG_HEAD");
> -				reflog_orig_head = msg.buf;
> -			}
> -			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> -				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
> -		} else if (old_orig)
> -			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> -	}
> -
> -	if (!reflog_head) {
> -		strbuf_setlen(&msg, prefix_len);
> -		strbuf_addstr(&msg, "updating HEAD");
> -		reflog_head = msg.buf;
> -	}
> -	if (!switch_to_branch)
> -		ret = update_ref(reflog_head, "HEAD", oid, orig,
> -				 detach_head ? REF_NO_DEREF : 0,
> -				 UPDATE_REFS_MSG_ON_ERR);
> -	else {
> -		ret = update_ref(reflog_head, switch_to_branch, oid,
> -				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> -		if (!ret)
> -			ret = create_symref("HEAD", switch_to_branch,
> -					    reflog_head);
> -	}
> -	if (run_hook)
> -		run_hook_le(NULL, "post-checkout",
> -			    oid_to_hex(orig ? orig : &null_oid),
> -			    oid_to_hex(oid), "1", NULL);
> -
> -leave_reset_head:
> -	strbuf_release(&msg);
> -	rollback_lock_file(&lock);
> -	while (nr)
> -		free((void *)desc[--nr].buffer);
> -	return ret;
> -}
> -
>   static int move_to_original_branch(struct rebase_options *opts)
>   {
>   	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> diff --git a/reset.c b/reset.c
> new file mode 100644
> index 0000000000..79b683bffa
> --- /dev/null
> +++ b/reset.c
> @@ -0,0 +1,140 @@
> +#include "git-compat-util.h"
> +#include "cache-tree.h"
> +#include "lockfile.h"
> +#include "refs.h"
> +#include "reset.h"
> +#include "run-command.h"
> +#include "tree-walk.h"
> +#include "tree.h"
> +#include "unpack-trees.h"
> +
> +int reset_head(struct repository *r, struct object_id *oid, const char *action,
> +	       const char *switch_to_branch, unsigned flags,
> +	       const char *reflog_orig_head, const char *reflog_head,
> +	       const char *default_reflog_action)
> +{
> +	unsigned detach_head = flags & RESET_HEAD_DETACH;
> +	unsigned reset_hard = flags & RESET_HEAD_HARD;
> +	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
> +	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
> +	struct object_id head_oid;
> +	struct tree_desc desc[2] = { { NULL }, { NULL } };
> +	struct lock_file lock = LOCK_INIT;
> +	struct unpack_trees_options unpack_tree_opts;
> +	struct tree *tree;
> +	const char *reflog_action;
> +	struct strbuf msg = STRBUF_INIT;
> +	size_t prefix_len;
> +	struct object_id *orig = NULL, oid_orig,
> +		*old_orig = NULL, oid_old_orig;
> +	int ret = 0, nr = 0;
> +
> +	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> +		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
> +
> +	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
> +		ret = -1;
> +		goto leave_reset_head;
> +	}
> +
> +	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
> +		ret = error(_("could not determine HEAD revision"));
> +		goto leave_reset_head;
> +	}
> +
> +	if (!oid)
> +		oid = &head_oid;
> +
> +	if (refs_only)
> +		goto reset_head_refs;
> +
> +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> +	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> +	unpack_tree_opts.head_idx = 1;
> +	unpack_tree_opts.src_index = r->index;
> +	unpack_tree_opts.dst_index = r->index;
> +	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
> +	unpack_tree_opts.update = 1;
> +	unpack_tree_opts.merge = 1;
> +	if (!detach_head)
> +		unpack_tree_opts.reset = 1;
> +
> +	if (repo_read_index_unmerged(r) < 0) {
> +		ret = error(_("could not read index"));
> +		goto leave_reset_head;
> +	}
> +
> +	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
> +		ret = error(_("failed to find tree of %s"),
> +			    oid_to_hex(&head_oid));
> +		goto leave_reset_head;
> +	}
> +
> +	if (!fill_tree_descriptor(r, &desc[nr++], oid)) {
> +		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
> +		goto leave_reset_head;
> +	}
> +
> +	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
> +		ret = -1;
> +		goto leave_reset_head;
> +	}
> +
> +	tree = parse_tree_indirect(oid);
> +	prime_cache_tree(r, r->index, tree);
> +
> +	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
> +		ret = error(_("could not write index"));
> +		goto leave_reset_head;
> +	}
> +
> +reset_head_refs:
> +	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> +	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
> +	prefix_len = msg.len;
> +
> +	if (update_orig_head) {
> +		if (!get_oid("ORIG_HEAD", &oid_old_orig))
> +			old_orig = &oid_old_orig;
> +		if (!get_oid("HEAD", &oid_orig)) {
> +			orig = &oid_orig;
> +			if (!reflog_orig_head) {
> +				strbuf_addstr(&msg, "updating ORIG_HEAD");
> +				reflog_orig_head = msg.buf;
> +			}
> +			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> +				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
> +		} else if (old_orig)
> +			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> +	}
> +
> +	if (!reflog_head) {
> +		strbuf_setlen(&msg, prefix_len);
> +		strbuf_addstr(&msg, "updating HEAD");
> +		reflog_head = msg.buf;
> +	}
> +	if (!switch_to_branch)
> +		ret = update_ref(reflog_head, "HEAD", oid, orig,
> +				 detach_head ? REF_NO_DEREF : 0,
> +				 UPDATE_REFS_MSG_ON_ERR);
> +	else {
> +		ret = update_ref(reflog_head, switch_to_branch, oid,
> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +		if (!ret)
> +			ret = create_symref("HEAD", switch_to_branch,
> +					    reflog_head);
> +	}
> +	if (run_hook)
> +		run_hook_le(NULL, "post-checkout",
> +			    oid_to_hex(orig ? orig : &null_oid),
> +			    oid_to_hex(oid), "1", NULL);
> +
> +leave_reset_head:
> +	strbuf_release(&msg);
> +	rollback_lock_file(&lock);
> +	while (nr)
> +		free((void *)desc[--nr].buffer);
> +	return ret;
> +
> +}
> diff --git a/reset.h b/reset.h
> new file mode 100644
> index 0000000000..12f83c78e2
> --- /dev/null
> +++ b/reset.h
> @@ -0,0 +1,20 @@
> +#ifndef RESET_H
> +#define RESET_H
> +
> +#include "hash.h"
> +#include "repository.h"
> +
> +#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
> +
> +#define RESET_HEAD_DETACH (1<<0)
> +#define RESET_HEAD_HARD (1<<1)
> +#define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
> +#define RESET_HEAD_REFS_ONLY (1<<3)
> +#define RESET_ORIG_HEAD (1<<4)
> +
> +int reset_head(struct repository *r, struct object_id *oid, const char *action,
> +	       const char *switch_to_branch, unsigned flags,
> +	       const char *reflog_orig_head, const char *reflog_head,
> +	       const char *default_reflog_action);
> +
> +#endif
> 
