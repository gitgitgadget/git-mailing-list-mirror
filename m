Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E622C3DA7A
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 23:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjABXiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 18:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjABXiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 18:38:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7536268
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 15:38:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso19808083pjc.2
        for <git@vger.kernel.org>; Mon, 02 Jan 2023 15:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pMNVNUaRnLS8pjWuNG3IgoMH12T90t00bZ7iQiPof8o=;
        b=Ce3EORZ3KsNEfrBeaiCoono+ZalqUoItbpvX7P00UI/zPafq6P5V+AtXmUVAKx7ojp
         hBy6HeGIGKtB0D/sYpbQRxwuWKFZBAiEQ9j+ylgvOt3BELX8VmLGNMwXWrsCnJCehguV
         wfJ8Y5rIYGYjor4hFZUxoMjQmOhYV9wJf4zDtha6HGE+Xe9ydrmCnZlNU/tBFyaVV1fb
         Obw1Mv80A6FaAyXPAwaGpT2I11hKpon5obYRoj1Q8UyWWywjUvsaqB8p1XWAuC7aGF9L
         8Ze2oSIjzitwy2icjoYz+cFsD0b0nZqdlUMoT8vq6DI+iwdkPXxRFpmd6EfwmfFpS0Iq
         ergA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMNVNUaRnLS8pjWuNG3IgoMH12T90t00bZ7iQiPof8o=;
        b=I3qSjaVdBhANXjhOV/ja8EAh4HTXb48ZxNz61MRFY7ofKajAdBfdVVxO0UdPVZQBFz
         rpWKyQaEzGgWsk1MhrQwJown40E8KC8MUGQnPjXyhYZV8xnEpFncMZqHGzYOxLwHWi7e
         L3trJGQr0FaJrKLEVsUxcjIDPP/2QJL/AxQo/VfMfCEiIRJPjsAIstVGsI3FFgBp5gJ8
         D5CQiNfgwWXv4Jau6Z4vuKLRldv/Tkq6jMF0+M/oIeQ/wZ182naPw0mwjLzViiDXr1CU
         +mNAeVbnRQoqC8f61KzB5akh1GDUKB+2J2aCHqwhcJkiy/nw2l13ZAnDTZedm5XC9G6s
         EZHg==
X-Gm-Message-State: AFqh2kruxAuk1iBeqcI8M7i9mfK9/FDyv2FC0hGGQGqZejdpB90rNATv
        aWbocjtbqeHfTULSWP/1uAc=
X-Google-Smtp-Source: AMrXdXtXrPqUTNc3bW8Pdpe/SB5WjYwq0uyoZEjRnNIG/dOod6Qe6ApptDfRUDr7vVN0+L2+3yl/GA==
X-Received: by 2002:a05:6a20:1455:b0:b0:7873:dda9 with SMTP id a21-20020a056a20145500b000b07873dda9mr65276724pzi.3.1672702683027;
        Mon, 02 Jan 2023 15:38:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l10-20020a63f30a000000b00496317241f9sm16411221pgh.51.2023.01.02.15.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 15:38:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 2/2] attr: add flag `--source` to work with tree-ish
References: <https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com/>
        <cover.1671793109.git.karthik.188@gmail.com>
        <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
Date:   Tue, 03 Jan 2023 08:38:02 +0900
Message-ID: <xmqq1qocwlr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> The contents of the .gitattributes files may evolve over time, but "git
> check-attr" always checks attributes against them in the working tree
> and/or in the index. It may be beneficial to optionally allow the users
> to check attributes taken from a commit other than HEAD against paths.
>
> Add a new flag `--source` which will allow users to check the
> attributes against a commit (actually any tree-ish would do). When the
> user uses this flag, we go through the stack of .gitattributes files but
> instead of checking the current working tree and/or in the index, we
> check the blobs from the provided tree-ish object. This allows the
> command to also be used in bare repositories.
>
> Since we use a tree-ish object, the user can pass "--source
> HEAD:subdirectory" and all the attributes will be looked up as if
> subdirectory was the root directory of the repository.
>
> We cannot simply use the `<rev>:<path>` syntax without the `--source`
> flag, similar to how it is used in `git show` because any non-flag
> parameter before `--` is treated as an attribute and any parameter after
> `--` is treated as a pathname.
>
> The change involves creating a new function `read_attr_from_blob`, which
> given the path reads the blob for the path against the provided source and
> parses the attributes line by line. This function is plugged into
> `read_attr()` function wherein we go through the stack of attributes
> files.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> Co-authored-by: toon@iotcl.com
> ---
>  Documentation/git-check-attr.txt | 10 +++-
>  archive.c                        |  2 +-
>  attr.c                           | 97 +++++++++++++++++++++++---------
>  attr.h                           |  5 +-
>  builtin/check-attr.c             | 35 +++++++-----
>  builtin/pack-objects.c           |  2 +-
>  convert.c                        |  2 +-
>  ll-merge.c                       |  4 +-
>  pathspec.c                       |  2 +-
>  t/t0003-attributes.sh            | 42 +++++++++++++-
>  userdiff.c                       |  2 +-
>  ws.c                             |  2 +-
>  12 files changed, 152 insertions(+), 53 deletions(-)
>
> diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> index 84f41a8e82..fb15c44598 100644
> --- a/Documentation/git-check-attr.txt
> +++ b/Documentation/git-check-attr.txt
> @@ -9,8 +9,8 @@ git-check-attr - Display gitattributes information
>  SYNOPSIS
>  --------
>  [verse]
> -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
> -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
> +'git check-attr' [--source <tree>] [-a | --all | <attr>...] [--] <pathname>...
> +'git check-attr' --stdin [-z] [--source <tree>] [-a | --all | <attr>...]
>  
>  DESCRIPTION
>  -----------
> @@ -36,6 +36,12 @@ OPTIONS
>  	If `--stdin` is also given, input paths are separated
>  	with a NUL character instead of a linefeed character.
>  
> +--source=<tree>::
> +	Check attributes against the specified tree-ish. Paths provided as part
> +	of the revision will be treated as the root directory. It is common to
> +	specify the source tree by naming a commit, branch or tag associated
> +	with it.
> +
>  \--::
>  	Interpret all preceding arguments as attributes and all following
>  	arguments as path names.
> diff --git a/archive.c b/archive.c
> index 941495f5d7..81ff76fce9 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -120,7 +120,7 @@ static const struct attr_check *get_archive_attrs(struct index_state *istate,
>  	static struct attr_check *check;
>  	if (!check)
>  		check = attr_check_initl("export-ignore", "export-subst", NULL);
> -	git_check_attr(istate, path, check);
> +	git_check_attr(istate, NULL, path, check);
>  	return check;
>  }
>  
> diff --git a/attr.c b/attr.c
> index 42ad6de8c7..a63f267187 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -13,6 +13,8 @@
>  #include "dir.h"
>  #include "utf8.h"
>  #include "quote.h"
> +#include "revision.h"
> +#include "object-store.h"
>  #include "thread-utils.h"
>  
>  const char git_attr__true[] = "(builtin)true";
> @@ -729,14 +731,62 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
>  	return res;
>  }
>  
> -static struct attr_stack *read_attr_from_index(struct index_state *istate,
> -					       const char *path,
> -					       unsigned flags)
> +static struct attr_stack *read_attr_from_buf(char *buf, const char *path,
> +					     unsigned flags)
>  {
>  	struct attr_stack *res;
> -	char *buf, *sp;
> +	char *sp;
>  	int lineno = 0;
>  
> +	if (!buf)
> +		return NULL;
> +
> +	CALLOC_ARRAY(res, 1);
> +	for (sp = buf; *sp;) {
> +		char *ep;
> +		int more;
> +
> +		ep = strchrnul(sp, '\n');
> +		more = (*ep == '\n');
> +		*ep = '\0';
> +		handle_attr_line(res, sp, path, ++lineno, flags);
> +		sp = ep + more;
> +	}
> +	free(buf);
> +
> +	return res;
> +}
> +
> +static struct attr_stack *read_attr_from_blob(struct index_state *istate,
> +					      const struct object_id *tree_oid,
> +					      const char *path, unsigned flags)
> +{
> +	struct object_id oid;
> +	unsigned long sz;
> +	enum object_type type;
> +	void *buf;
> +	unsigned short mode;
> +
> +	if (!tree_oid)
> +		return NULL;
> +
> +	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
> +		return NULL;
> +
> +	buf = read_object_file(&oid, &type, &sz);
> +	if (!buf || type != OBJ_BLOB) {
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	return read_attr_from_buf(buf, path, flags);
> +}
> +
> +static struct attr_stack *read_attr_from_index(struct index_state *istate,
> +					       const char *path, unsigned flags)
> +{
> +	char *buf;
> +
>  	if (!istate)
>  		return NULL;
>  
> @@ -758,28 +808,19 @@ static struct attr_stack *read_attr_from_index(struct index_state *istate,
>  	if (!buf)
>  		return NULL;
>  
> -	CALLOC_ARRAY(res, 1);
> -	for (sp = buf; *sp; ) {
> -		char *ep;
> -		int more;
> -
> -		ep = strchrnul(sp, '\n');
> -		more = (*ep == '\n');
> -		*ep = '\0';
> -		handle_attr_line(res, sp, path, ++lineno, flags);
> -		sp = ep + more;
> -	}
> -	free(buf);
> -	return res;
> +	return read_attr_from_buf(buf, path, flags);
>  }
>  
>  static struct attr_stack *read_attr(struct index_state *istate,
> +				    const struct object_id *tree_oid,
>  				    const char *path, unsigned flags)
>  {
>  	struct attr_stack *res = NULL;
>  
>  	if (direction == GIT_ATTR_INDEX) {
>  		res = read_attr_from_index(istate, path, flags);
> +	} else if (tree_oid) {
> +		res = read_attr_from_blob(istate, tree_oid, path, flags);
>  	} else if (!is_bare_repository()) {
>  		if (direction == GIT_ATTR_CHECKOUT) {
>  			res = read_attr_from_index(istate, path, flags);
> @@ -839,6 +880,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
>  }
>  
>  static void bootstrap_attr_stack(struct index_state *istate,
> +				 const struct object_id *tree_oid,
>  				 struct attr_stack **stack)
>  {
>  	struct attr_stack *e;
> @@ -864,7 +906,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  	}
>  
>  	/* root directory */
> -	e = read_attr(istate, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
> +	e = read_attr(istate, tree_oid, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
>  	push_stack(stack, e, xstrdup(""), 0);
>  
>  	/* info frame */
> @@ -878,6 +920,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
>  }
>  
>  static void prepare_attr_stack(struct index_state *istate,
> +			       const struct object_id *tree_oid,
>  			       const char *path, int dirlen,
>  			       struct attr_stack **stack)
>  {
> @@ -899,7 +942,7 @@ static void prepare_attr_stack(struct index_state *istate,
>  	 * .gitattributes in deeper directories to shallower ones,
>  	 * and finally use the built-in set as the default.
>  	 */
> -	bootstrap_attr_stack(istate, stack);
> +	bootstrap_attr_stack(istate, tree_oid, stack);
>  
>  	/*
>  	 * Pop the "info" one that is always at the top of the stack.
> @@ -954,7 +997,7 @@ static void prepare_attr_stack(struct index_state *istate,
>  		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
>  		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
>  
> -		next = read_attr(istate, pathbuf.buf, READ_ATTR_NOFOLLOW);
> +		next = read_attr(istate, tree_oid, pathbuf.buf, READ_ATTR_NOFOLLOW);
>  
>  		/* reset the pathbuf to not include "/.gitattributes" */
>  		strbuf_setlen(&pathbuf, len);
> @@ -1074,8 +1117,8 @@ static void determine_macros(struct all_attrs_item *all_attrs,
>   * Otherwise all attributes are collected.
>   */
>  static void collect_some_attrs(struct index_state *istate,
> -			       const char *path,
> -			       struct attr_check *check)
> +			       const struct object_id *tree_oid,
> +			       const char *path, struct attr_check *check)
>  {
>  	int pathlen, rem, dirlen;
>  	const char *cp, *last_slash = NULL;
> @@ -1094,7 +1137,7 @@ static void collect_some_attrs(struct index_state *istate,
>  		dirlen = 0;
>  	}
>  
> -	prepare_attr_stack(istate, path, dirlen, &check->stack);
> +	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
>  	all_attrs_init(&g_attr_hashmap, check);
>  	determine_macros(check->all_attrs, check->stack);
>  
> @@ -1103,12 +1146,12 @@ static void collect_some_attrs(struct index_state *istate,
>  }
>  
>  void git_check_attr(struct index_state *istate,
> -		    const char *path,
> +		    const struct object_id *tree_oid, const char *path,
>  		    struct attr_check *check)
>  {
>  	int i;
>  
> -	collect_some_attrs(istate, path, check);
> +	collect_some_attrs(istate, tree_oid, path, check);
>  
>  	for (i = 0; i < check->nr; i++) {
>  		size_t n = check->items[i].attr->attr_nr;
> @@ -1119,13 +1162,13 @@ void git_check_attr(struct index_state *istate,
>  	}
>  }
>  
> -void git_all_attrs(struct index_state *istate,
> +void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
>  		   const char *path, struct attr_check *check)
>  {
>  	int i;
>  
>  	attr_check_reset(check);
> -	collect_some_attrs(istate, path, check);
> +	collect_some_attrs(istate, tree_oid, path, check);
>  
>  	for (i = 0; i < check->all_attrs_nr; i++) {
>  		const char *name = check->all_attrs[i].attr->name;
> diff --git a/attr.h b/attr.h
> index 3fb40cced0..84a3279215 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -190,13 +190,14 @@ void attr_check_free(struct attr_check *check);
>  const char *git_attr_name(const struct git_attr *);
>  
>  void git_check_attr(struct index_state *istate,
> -		    const char *path, struct attr_check *check);
> +		    const struct object_id *tree_oid, const char *path,
> +		    struct attr_check *check);

FYI, this breaks "make hdr-check".

>  /*
>   * Retrieve all attributes that apply to the specified path.
>   * check holds the attributes and their values.
>   */
> -void git_all_attrs(struct index_state *istate,
> +void git_all_attrs(struct index_state *istate, const struct object_id *tree_oid,
>  		   const char *path, struct attr_check *check);

Likewise.

Perhaps squash something like this in in the next iteration?

 attr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git i/attr.h w/attr.h
index 84a3279215..fca6c30430 100644
--- i/attr.h
+++ w/attr.h
@@ -108,6 +108,7 @@
  */
 
 struct index_state;
+struct object_id;
 
 /**
  * An attribute is an opaque object that is identified by its name. Pass the
