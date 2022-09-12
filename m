Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C9C6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 19:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiILTRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 15:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiILTRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 15:17:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D797E286D9
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:17:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d12so9503711plr.6
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=oSXP+R8kGICJCNqtqF6TqMQK2c5QJjpisRbmR5wYyk8=;
        b=HIQgnxOOx9G69a3Z2nujrAwU5Wy8Tu96YCWWqsZJt/0EGp4MWjmd/qdRZ7D/iE6FiR
         YZWuusp71ZJEhY622JDkdG0HkU7KuJLOB/p4u4lq25B2TrnnnDioZOEkMrn3BHEYkCzB
         BfnpfC1ELhIHSPK89RPO44svrgdFtr3a+rLTonS9F4iP0/OOJ3WzC0RoO/LYEBkwSq6z
         puIMKtaL4cnrO/3zXv+P5oF5qp7pZF2eYrgg/RvFGBSgLj0Fs6uHxZ+BeHIwnIX2wzJV
         RVI/MY4cPKCmY6f27aYED+mHj9nq8GGicIKjxl/sJU3fuoNEw9Da1xwMnuD94XZNNCwl
         OHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=oSXP+R8kGICJCNqtqF6TqMQK2c5QJjpisRbmR5wYyk8=;
        b=7zpOpXe0H8qihYEjGb6o9B46spgApgAxS6m4f+IiO9mACos6oKvmwKzkNOyrikyXA3
         fqT1tqhLCFjKq8EUSqNfgxtCCeSHztXmGT0Tjay1qWslOmFspvCS7MS9cIcTQjFo4hcS
         1C9ZL1t9AbCI/KERRlBdedCtuSedCXGIAtC6z8bqbA32+PpRjS/u8hYjS5ov+p9kZ87+
         FnqI3XQ/igaYEkWHeJPTTgzL3hRxWwCKM51SOjKmJgn3xlGcvIo1fpWpFiLe26gaY/gl
         XWppLwf/gno4cqkVro6LviGFv6r42efWXMETIJ5MfevWI4pygiRFYVvwikNS4jPDC9VF
         6iKg==
X-Gm-Message-State: ACgBeo11Ecv+9/Jg77u+5XF8FlFqA7Yn7RYoXxAbN5sCjhfotEAeKxlC
        a8MdgJ/QWeIg41GYqeyruMI=
X-Google-Smtp-Source: AA6agR5l81SbkiLNztIN3eQce/Nkq0KcC7YD5lgGoII3cS74nFGWuekhS71gEKPHrzWb7crLHUGG/g==
X-Received: by 2002:a17:902:b681:b0:176:6471:8ee6 with SMTP id c1-20020a170902b68100b0017664718ee6mr28411055pls.8.1663010251116;
        Mon, 12 Sep 2022 12:17:31 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n25-20020a056a00213900b00540ffb28da0sm6042129pfj.91.2022.09.12.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:17:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 12:17:30 -0700
In-Reply-To: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 12 Sep 2022 17:01:35
        +0000")
Message-ID: <xmqq1qsge71x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The logic to handle worktree refs (worktrees/NAME/REF and
> main-worktree/REF) existed in two places:
>
> * ref_type() in refs.c
>
> * parse_worktree_ref() in worktree.c
>
> Collapse this logic together in one function parse_worktree_ref():
> this avoids having to cross-check the result of parse_worktree_ref()
> and ref_type().
> ...
> The files-backend must avoid packing refs/bisect/* and friends into
> packed-refs, so expose is_per_worktree_ref() separately.

A sensible goal.

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 9407f835cb6..bd568d2d931 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -26,7 +26,8 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
>  	 * Avoid collecting the same shared ref multiple times because
>  	 * they are available via all worktrees.
>  	 */
> -	if (!worktree->is_current && ref_type(ref) == REF_TYPE_NORMAL)
> +	if (!worktree->is_current &&
> +	    parse_worktree_ref(ref, NULL, NULL, NULL) == REF_WORKTREE_SHARED)
>  		return 0;

We used to say "for a ref without anything magical" but now we say
"for a ref that is not per worktree at all", and they mean the same
thing.  OK.

>  	strbuf_worktree_ref(worktree, &newref, ref);
> diff --git a/reflog.c b/reflog.c
> index 47ba8620c56..0b8b767f97c 100644
> --- a/reflog.c
> +++ b/reflog.c
> @@ -310,16 +310,9 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
>  
>  static int is_head(const char *refname)
>  {
> -	switch (ref_type(refname)) {
> -	case REF_TYPE_OTHER_PSEUDOREF:
> -	case REF_TYPE_MAIN_PSEUDOREF:
> -		if (parse_worktree_ref(refname, NULL, NULL, &refname))
> -			BUG("not a worktree ref: %s", refname);
> -		break;
> -	default:
> -		break;
> -	}
> -	return !strcmp(refname, "HEAD");

It used to do some sort of input validation with BUG() but it no
longer does.  Intended?

The new call to parse_worktree_ref() is only to strip the possible
"main-worktree/" and/or "worktrees/$name/" names.

> +	const char *stripped_refname;
> +	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
> +	return !strcmp(stripped_refname, "HEAD");
>  }


> @@ -738,37 +738,60 @@ static int is_pseudoref_syntax(const char *refname)
>  			return 0;
>  	}
>  
> +	/* HEAD is not a pseudoref, but it certainly uses the
> +	 * pseudoref syntax. */


/*
 * Our multi-line comments have opening slash-aster
 * and closing aster-slash on their own line.
 */


Not your fault but the fault of the original file contents and diff
algorithms; the patch around here is simply unreadble because almost
nothing in the preimage contributes to the result.  So I'll remove
'-' lines first before commenting.

> +enum ref_worktree_type parse_worktree_ref(const char *worktree_ref,
> +					  const char **name, int *name_length,
> +					  const char **ref)

It is hard to see what's input and what's output.  You have comments
in <refs.h> but the prototype uses different parameter names and
they do not tell what is input and what is output, either.

>  {
> +	const char *name_dummy;
> +	int name_length_dummy;
> +	const char *ref_dummy;

Style: Have blank here between the end of decls and the beginning of statements.

> +	if (!name)
> +		name = &name_dummy;
> +	if (!name_length)
> +		name_length = &name_length_dummy;
> +	if (!ref)
> +		ref = &ref_dummy;

I can guess from these that worktree_ref is the input and all three
are to point at variables that receive optional output.  The patch
author shouldn't make the code reader guess.

> +	*ref = worktree_ref;
> +	if (is_pseudoref_syntax(worktree_ref)) {
> +		return REF_WORKTREE_CURRENT;
> +	}

Style: No braces around a single statement block.

OK, given a worktree_ref, FETCH_HEAD, MERGE_HEAD, etc. are all valid
only for the current worktree.

> +	if (is_per_worktree_ref(worktree_ref)) {
> +		return REF_WORKTREE_CURRENT;
> +	}

Also the ones that are within a certain known namespaces, like
"refs/bisect/*".

In the above two cases, name/name_length are undefined.  Presumably
the caller behaves well enough not to peek into them unless it is
told to by the returned value REF_WORKTREE_OTHER?

> +	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {

The special syntax "main-worktree/$their_ref".  We skip the prefix
and then ...

> +		if (!*worktree_ref)
> +			return -1;

Do we know if, or do we have control over, "enum ref_worktree_type"
ends up being signed or unsigned?  I am not sure if the callers in
this patch even pays attention to the error condition.

> +		*name = NULL;
> +		*name_length = 0;
> +		*ref = worktree_ref;
> +
> +		if (parse_worktree_ref(*ref, NULL, NULL, NULL) ==
> +		    REF_WORKTREE_CURRENT)
> +			return REF_WORKTREE_MAIN;

In "main-worktree/$their_ref", if $their_ref is the per worktree
name, then it is a ref specific to the primary worktree.  

It is not clear what *name and *name_length are trying to return to
the caller here.

Otherwise we fall through with worktree_ref that we have stripped
main-worktree/ prefix, which means the original input

	main-worktree/worktrees/foo/blah

is now 

	worktrees/foo/blah

and the next skip_prefix() will see that it begins with "worktrees/".
Of course, if the initial input were

	worktrees/foo/blah

then we wouldn't have skipped main-worktree/ prefix from it, and go
to the next skip_prefix().  So from here on, we cannot tell which
case the original input was.

But that is OK.  Asking "give me the ref 'blah' in the worktree 'foo'"
in the current worktree should yield the same answer to the question
"give me the ref 'blah' in the worktree 'foo', as if I asked you to
do so in the main worktree".

> +	}
> +	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
> +		const char *slash = strchr(worktree_ref, '/');
> +
> +		if (!slash || slash == worktree_ref || !slash[1])
> +			return -1;
> +		*name = worktree_ref;
> +		*name_length = slash - worktree_ref;
> +		*ref = slash + 1;

OK, name and name_length are giving the name of the worktree to the
caller here.  But this is done even when we do not end up returning
REF_WORKTREE_OTHER, which sounds eh, ugly.

In any case, the part after worktrees/$worktreename/ is a per
worktree name, then we say "that's a per-worktree ref that belongs
to $worktreename" by returning _OTHER and with *name/*name_length.

> +		if (parse_worktree_ref(*ref, NULL, NULL, NULL) ==
> +		    REF_WORKTREE_CURRENT)
> +			return REF_WORKTREE_OTHER;

> +	}
> +
> +	return REF_WORKTREE_SHARED;

And everything else is _SHARED.

The logic sounds sane enough, but the name/name_length being
sometimes undefined and sometimes cleared feels yucky to me. 

>  }
>  
>  long get_files_ref_lock_timeout_ms(void)
> diff --git a/refs.h b/refs.h
> index 23479c7ee09..9e40efc4787 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -825,15 +825,30 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
>   */
>  int ref_is_hidden(const char *, const char *);
>  
> +/* Is this a per-worktree ref living in the refs/ namespace? */
> +int is_per_worktree_ref(const char *refname);
> +
> +/* Describes how a refname relates to worktrees */
> +enum ref_worktree_type {
> +	REF_WORKTREE_CURRENT, /* implicitly per worktree, eg. HEAD or
> +				 refs/bisect/SOMETHING */

OK.

> +	REF_WORKTREE_MAIN, /* explicitly in main worktree, eg.
> +			      refs/main-worktree/HEAD */
> +	REF_WORKTREE_OTHER, /* explicitly in named worktree, eg.
> +			       refs/worktrees/bla/HEAD */

Hmph.  Do we need refs/ prefix before main-worktree/ and
worktrees/bla?  The code we reviewed above seemed to skip
"main-worktree/" and "worktrees/" with the assumption that there
will be no "refs/" prefix before them.  Probably just two typoes,
as the comment before parse_worktree_ref() below also seems to
assume that there is no refs/ before them.

> +	REF_WORKTREE_SHARED, /* the default, eg. refs/heads/main */
>  };
>  
> -enum ref_type ref_type(const char *refname);
> +/* Parse a ref that possibly explicitly refers to a worktree ref
> + * (ie. either REFNAME, main-worktree/REFNAME or
> + * worktree/WORKTREE/REFNAME). If the name references a worktree
> + * implicitly or explicitly, return what kind it was. The
> + * worktree_name, worktree_name_length and refname argument maybe NULL.
> + */

Here is my attempt to clarify what the comment tries to explain.

	/*
	 * Parse maybe_worktree_ref (input) that possibly explicitly
	 * refers to a worktree ref (i.e. REFNAME, main-worktree/REFNAME,
	 * main-worktree/worktrees/WORKTREE/REFNAME, or
	 * worktrees/WORKTREE/REFNAME).  Return what kind of ref
         * (among the four kinds listed above) it is.
         * 
	 * The location pointed at by worktree_name and worktree_name_length
	 * are modified to point to "WORKTREE" part of such an input string
         * when the returned value is REF_WORKTREE_OTHER.
	 * Otherwise they are undefined (they may still be smudged).
	 *
	 * refname is made to piont to REFNAME part of the input string in
	 * all cases.
	 *
	 * These three output parameters are optional and NULL can
	 * be given for them.
	 */

> +enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
> +					  const char **worktree_name,
> +					  int *worktree_name_length,
> +					  const char **refname);
