Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4BC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjECXSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjECXSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 19:18:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188DE7A8D
        for <git@vger.kernel.org>; Wed,  3 May 2023 16:18:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51fdc1a1270so3911738a12.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683155925; x=1685747925;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbY/pHtgmrZ7reyLOplSq2n5cFv79j1eFlFdV2Xbw7g=;
        b=WSBL8i07dVK/sq+/mSaQD7NHbw2BFwmSDT+5iZnQP5Vg7ASAlWN8XOUPGRdutMaTmB
         CT1qL0rqJoYfAWMNR1zfAsLS51OETHmjHvDPQmkDufzAiCTNJqYlQpa3+orXmYGus9uY
         P0KbcMvDIDc4y0mSokYnNV7Lfp0VJcrD12EgfZRH+zO3R1DUWfwG4/+rc0fQ0ipiq1hV
         EUYozhskcS7pgWCHKh9R4kwOBhHJGnGPSZgAeVJQFIbC+m3/b0eavhKjoZFQJlSi6F0Y
         TpwIYN4WmPQOC3lilo6PEmDERYl+xwkGHFGNgfDuCkV5K8uNTYBjR86lBifisAdQdYkD
         NQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683155925; x=1685747925;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbY/pHtgmrZ7reyLOplSq2n5cFv79j1eFlFdV2Xbw7g=;
        b=e4Xx3RsIXRG8E6YDeYNmCjChgmFQVKNBsHXRBI52e6d41/vbnJ5P+ld2zY30upRaL+
         0KD5ZEpHa/nmPmHVONAQ+xHWeV6KdtzRO/LOH54VpD7kAVxKUKxw1R+7h0NzJrNS3RAb
         BW9o+wjaBGH1RBrK3MU/YkLZA9IfacZDVK9LuRWI7CU8b3YQxfytcE8LvkspJF+1uIF+
         dqi89zWwqIwDLSaEYjC3SSAw13lDx69iYQzB6rgQrvkrnK4YTnbjrWU5+1tjy2xE15t+
         fd/XnKWWZpjoKA1JHn7l3Q1lPdygtKyK4n+H/dI/SSZYrfQm7gO9au36qk49+VL4IDt6
         E8Rg==
X-Gm-Message-State: AC+VfDyA1YAMuM5a3FtP98vlO+W1hnkmfRz5v3MIA+KWVdIuOzbhM+J7
        XDsME3wACLsh2mCBBfvLeBCfTwmNS6E=
X-Google-Smtp-Source: ACHHUZ4kyLbgUqZLwY34guLNemS14YYvVcj54erdC+gsixS/x5/884NR1Vm8zI+UI8Gm+V414dt3Ag==
X-Received: by 2002:a17:90b:4c42:b0:24e:2f9c:ee5e with SMTP id np2-20020a17090b4c4200b0024e2f9cee5emr159818pjb.42.1683155925284;
        Wed, 03 May 2023 16:18:45 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id oj16-20020a17090b4d9000b0024bb47eba2asm1948049pjb.7.2023.05.03.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:18:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] builtin/pack-objects.c: introduce `pack.extraCruftTips`
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
        <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
Date:   Wed, 03 May 2023 16:18:44 -0700
In-Reply-To: <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 3 May 2023 18:05:45 -0400")
Message-ID: <xmqqv8h9m2az.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   - When not pruning, all packed and loose objects which do not appear
>     in the any of the packs which wil remain (as indicated over stdin,
>     with `--cruft`) are packed separately into a cruft pack.

"wil remain" -> "will remain"

But more importantly, it is not clear to me whose "stdin" we are
talking about and what is sent "over stdin" here.  Somebody pipes
the output of "printf %s --cruft" to "pack-objects"???

> However, there is no option to be able to keep around certain objects
> that have otherwise aged out of the grace period. The only way to retain
> those objects is:
>
>   - to point a reference at them, which may be undesirable or
>     infeasible,
>   - to track them via the reflog, which may be undesirable since the
>     reflog's lifetime is limited to that of the reference it's tracking
>     (and callers may want to keep those unreachable objects around for
>     longer)
>   - to extend the grace period, which may keep around other objects that
>     the caller *does* want to discard,
>   - or, to force the caller to construct the pack of objects they want
>     to keep themselves, and then mark the pack as kept by adding a
>     ".keep" file.

If you do not want to point objects you want to keep with a ref,
then you are making a problem for yourself, as gc decisions are
designed around the notion that anything worthwhile to keep are
supposed to be reachable from some anchoring points (like the refs,
the reflogs, the index and its various extensions, etc.).

> Here is a reworked version of the pack.extraCruftTips feature to reuse
> parts of the "rescue old/unreachable, but reachable-from-recent" traversal.

That sounds like a sensible way to go, but as I said earlier, it
still is not clear, at least to me, why the pack.extraCruftTips
program can compute them cheaply enough when you cannot have these
tips pointed at with refs in some reserved namespaces of your own.

> +pack.extraCruftTips::

Is this consistent with the way we name a variable whose value
specifies a command to run?  At first, I thought this was a
multi-valued configuration variable, each of the value is an object
name.  extraCruftTipsCmd?  extraCruftTipsHook?

> +	When generating a cruft pack, use the shell to execute the
> +	specified command(s), and interpret their output as additional
> +	tips of objects to keep in the cruft pack, regardless of their

What is a "tip of an object"?  The first byte ;-)?

A "tip of history" would only imply commit objects, but presumably
you would want to specify a tree and protect all the blobs and trees
it recursively contains, so that is not a good name for it.

> +	age.
> ++
> +Output must contain exactly one hex object ID per line, and nothing
> +else. Objects which cannot be found in the repository are ignored.

Are objects that cannot be found the same as objects that are
missing?  How do we determine if a given object name refers to an
object which cannot be found?  Would the lazy fetching from promisor
remotes come into play?

> +Multiple hooks are supported, but all must exit successfully, else no
> +cruft pack will be generated.
> +

Now, we are told this variable refers to "hooks".  If that is the
name we want to call them, we'd better use the term from the
beginning.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a5b466839b..6f6e7872cd 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -44,6 +44,7 @@
>  #include "pack-mtimes.h"
>  #include "parse-options.h"
>  #include "wrapper.h"
> +#include "run-command.h"
>
>  /*
>   * Objects we are going to pack are collected in the `to_pack` structure.
> @@ -3543,11 +3544,85 @@ static void enumerate_cruft_objects(void)
>  	stop_progress(&progress_state);
>  }
>
> +static int enumerate_extra_cruft_tips_1(struct rev_info *revs, const char *args)

Let's lose the _1 suffix unless you have
enumerate_extra_cruft_tips() that farms out bulk of its inner
workings to this one.

> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	FILE *out;
> +	int ret = 0;
> +
> +	cmd.use_shell = 1;
> +	cmd.out = -1;
> +
> +	strvec_push(&cmd.args, args);
> +
> +	if (start_command(&cmd))
> +		return -1;
> +
> +	out = xfdopen(cmd.out, "r");

It somehow feels funny to be reading from "out", which is usually
where we write things to.

> +	while (strbuf_getline(&buf, out) != EOF) {

Ditto.

> +		struct object_id oid;
> +		struct object *obj;
> +		int type;
> +		const char *rest;
> +
> +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> +			goto done;
> +		}
> +
> +		type = oid_object_info(the_repository, &oid, NULL);
> +		if (type < 0)
> +			continue;
> +
> +		obj = lookup_object_by_type(the_repository, &oid, type);
> +		if (!obj)
> +			continue;

Hmph, we may want to have an interface that lets us avoid looking up
the same oid twice in the same set of tables.  Given an object
unseen so far, oid_object_info() should have done most of the work
necessary for lookup_object_by_type() to get to and start parsing
the data of the object in the good case (i.e. object exists and in a
pack---just we haven't needed it yet), but in the above sequence
there is not enough information passed between two calls to take
advantage of it.

> +		display_progress(progress_state, ++nr_seen);
> +		add_pending_object(revs, obj, "");
> +	}
> +
> +	ret = finish_command(&cmd);
> +
> +done:
> +	if (out)
> +		fclose(out);
> +	strbuf_release(&buf);
> +	child_process_clear(&cmd);
> +
> +	return ret;
> +}
> +
> +static void add_extra_cruft_tips_to_traversal(struct rev_info *revs)
> +{
> +	const struct string_list *programs;
> +	int ret = 0;
> +	size_t i;
> +
> +	if (git_config_get_string_multi("pack.extracrufttips", &programs))
> +		return;
> +
> +	if (progress)
> +		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
> +	nr_seen = 0;
> +	for (i = 0; i < programs->nr; i++) {
> +		ret = enumerate_extra_cruft_tips_1(revs,
> +						   programs->items[i].string);
> +		if (ret)
> +			break;
> +	}
> +	stop_progress(&progress_state);

We iterate over the value list internal to the repo_config, but we
are only borrowing them so there is no need to do any clean-up upon
leaving.  OK.

> +	if (ret)
> +		die(_("unable to enumerate additional cruft tips"));
> +}
> +
>  static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
>  {
>  	struct packed_git *p;
>  	struct rev_info revs;
> -	int ret;
> +	int ret = 0;
>
>  	repo_init_revisions(the_repository, &revs, NULL);
>
> @@ -3560,11 +3635,15 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
>
>  	revs.ignore_missing_links = 1;
>
> -	if (progress)
> -		progress_state = start_progress(_("Enumerating cruft objects"), 0);
> -	ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
> -						     set_cruft_mtime, 1);
> -	stop_progress(&progress_state);
> +	if (cruft_expiration) {
> +		if (progress)
> +			progress_state = start_progress(_("Enumerating cruft objects"), 0);
> +		ret = add_unseen_recent_objects_to_traversal(&revs, cruft_expiration,
> +							     set_cruft_mtime, 1);
> +		stop_progress(&progress_state);
> +	}
> +
> +	add_extra_cruft_tips_to_traversal(&revs);

Hmph, is this hunk doing two unrelated things at the same time?
What was the reason why we didn't have to be conditional on
cruft_expiration in the original code, and why does it start
mattering when we teach the code to call out to hooks?

> @@ -3639,8 +3718,19 @@ static void read_cruft_objects(void)
>
>  	if (cruft_expiration)
>  		enumerate_and_traverse_cruft_objects(&fresh_packs);
> -	else
> +	else {
> +		/*
> +		 * call both enumerate_cruft_objects() and
> +		 * enumerate_and_traverse_cruft_objects(), since:
> +		 *
> +		 *   - the former is required to implement non-pruning GCs
> +		 *   - the latter is a noop for "cruft_expiration == 0", but
> +		 *     picks up any additional tips mentioned via
> +		 *     `pack.extraCruftTips`.
> +		 */
>  		enumerate_cruft_objects();
> +		enumerate_and_traverse_cruft_objects(&fresh_packs);
> +	}
