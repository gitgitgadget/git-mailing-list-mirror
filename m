Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC65BC54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIGSMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIGSMI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:12:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBCC0B5D
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:12:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 65so5195206pfx.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=uOYZ/b871Asw4gEI9/Sq8QvZvw23YQzFoAv79rsr7Tg=;
        b=YAIPxPDTfC75bZF1l3Ic3x4SaLE5xR49J4FZD+vOf9Q+xHR1wCR/2yGQGNLJxByovz
         +htzGWChPDDT4CZJs1xXKP5X16diIsOs0qlcgtiL4Pd3w7knME58d0AeX5qUGTvyrOas
         Lty0Je44RdbbLk1r3WBAKA2f3uTGXhmcOzVLd8S5L4pKcjbqYyiCfDPD0ytxg5/Kyyes
         iYUtfDxRZlAIp/L8sI1Q+/XKFSs3+X6pT0n3w6PAqVq+SodKutquEQWwfDNsBPMvZKw8
         DfSkaynQc7Aw7yXjXm883DhebYjm0H2/2yysEqKfR1iXakeaNxIbNvAaoQezaIJChCku
         JavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=uOYZ/b871Asw4gEI9/Sq8QvZvw23YQzFoAv79rsr7Tg=;
        b=3APELwBNQF7nphAKFWPtN/jUzlqSQv8CvYlDa9NE2eeTHGdaC+Pxz6W65PvlMs1dIF
         N6KnxmwUN/aQ9Gi+isFhwWFzw6VCURminMlvYb4HthrBq7OToVKkDonjFSJ3ruwwPFpF
         5t/0J8G8aRN/zP31X8HazH+ALtWHcwwohgyLzWqGeNYcp83u9zwR4+bB6g4bqsEvy6ZE
         beZW5BYBnku4UuIlz3b9QsipgQYDfGyfT/xoDWMAvTb8szYA5nWi1c5quFDRA6tco+1N
         Ku01fxEOf9mx3162+trXPifAXerc2gfM2gFRKy1nOQOEKtMvivPu5xftjpyrA09pKwh9
         1h6A==
X-Gm-Message-State: ACgBeo1L97lBW2szUjRVpdBSPmM0O6gpVKCTL07MZGYNCCJh9JbpAVM5
        KhRDtHFboM0/z3r7NGHBRIg5JccPCw8=
X-Google-Smtp-Source: AA6agR7HmSgTeNMPaesePv11hRp1PEUWW7Bhl0UKGRsoyUVeqLeoMBNPFM2tz+nzs03EdBHQB+5VRA==
X-Received: by 2002:a63:8241:0:b0:435:fa7:f0f1 with SMTP id w62-20020a638241000000b004350fa7f0f1mr1422766pgd.155.1662574327223;
        Wed, 07 Sep 2022 11:12:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t6-20020a654b86000000b0041ae78c3493sm11096853pgq.52.2022.09.07.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:12:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/7] rebase: store orig_head as a commit
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <9daee95d434155742dbb19271eea8c0bc05eb365.1662561470.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 11:12:06 -0700
Message-ID: <xmqqzgfbuk95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 56e4214b441..a3cf1ef5923 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -68,7 +68,7 @@ struct rebase_options {
>  	const char *upstream_name;
>  	const char *upstream_arg;
>  	char *head_name;
> -	struct object_id orig_head;
> +	struct commit *orig_head;

OK.

> @@ -261,13 +261,13 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  	struct replay_opts replay = get_replay_opts(opts);
>  	struct string_list commands = STRING_LIST_INIT_DUP;
>  
> -	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
> +	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
>  				&revisions, &shortrevisions))
>  		return -1;

This step has ton of changes like this, which are fallouts from the
change of type of a member that used to be an oid to a full blown
commit object.  It is expected and I will strip all of them from my
quotes.  They all look correct, and otherwise the compiler would
complain ;-).

> @@ -448,7 +447,8 @@ static int read_basic_state(struct rebase_options *opts)
>  	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
>  				  READ_ONELINER_WARN_MISSING))
>  		return -1;
> -	if (get_oid(buf.buf, &opts->orig_head))
> +	opts->orig_head = lookup_commit_reference_by_name(buf.buf);

This is not exactly a new problem, but I noticed it while looking
for more iffy uses of lookup_commit_reference_by_name(), so...

At this point in the codepath, we expect buf.buf has full-hex object
name and nothing else; the original should have used get_oid_hex()
to highlight that fact.  lookup_commit_reference_by_name() allows
object names that are not written as full-hex object name, and it
may get confused if a branch or tag with 40-hex (or 64-hex in a
repository with newhash) name exists.  It would be a more sensible
conversion to use get_oid_hex() to turn buf.buf into an object name
and then use lookup_commit_reference() on it.

> @@ -866,15 +866,11 @@ static int is_linear_history(struct commit *from, struct commit *to)
>  
>  static int can_fast_forward(struct commit *onto, struct commit *upstream,
>  			    struct commit *restrict_revision,
> -			    struct object_id *head_oid, struct object_id *merge_base)
> +			    struct commit *head, struct object_id *merge_base)
>  {
> -	struct commit *head = lookup_commit(the_repository, head_oid);
>  	struct commit_list *merge_bases = NULL;
>  	int res = 0;
>  
> -	if (!head)
> -		goto done;
> -

This one benefits from being able to avoid its own lookup_commit()
because the caller already has it in the desired form.

This is not a comment on the new code, but it does make readers
wonder if the conversion changes behaviour.  lookup_commit() takes
an object name and requires it to be a commit object's name, doesn't
it?  If we gave a tag to the program, the old code would have had
the object name of that tag in head_oid and at this point and
lookup_commit() noticed and would have stopped you from fast
forwarding your branch to the tag, which was a good thing.  In the
new code, since we turn the object name we take from the user into a
commit object way before the control reaches this place, we won't
get such an error here, but if we fast-forward to the object, we
will still fast forward to the commit that is pointed by the tag,
so the new behaviour is even better, perhaps?

> @@ -1610,17 +1606,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		/* Is it a local branch? */
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "refs/heads/%s", branch_name);
> -		if (!read_ref(buf.buf, &options.orig_head)) {
> +		options.orig_head = lookup_commit_reference_by_name(buf.buf);
> +		if (options.orig_head) {
>  			die_if_checked_out(buf.buf, 1);
>  			options.head_name = xstrdup(buf.buf);
>  		/* If not is it a valid ref (branch or commit)? */

This is iffy, or it may be just wrong.

The old code is checking if "refs/heads/$branch_name" is a branch
and does the check.  If you had a branch "refs/heads/A" (whose ref
is at "refs/heads/refs/heads/A") but do not have a branch "A", and
if you fed "A" to this part of the code in buf.buf, then the
original code would not have been fooled by the presence of such a
funny branch.  New code (incorrectly) does because it prefixes
"refs/heads/" to "A" and asks to turn string "refs/heads/A" into a
commit object, triggering the usual ref dwim rules.

We end up setting options.head_name to a wrong thing (in this case,
the user said "A", we turned it into a refname "refs/heads/A" that
does not exist, and set options.orig_head to the commit object
pointed by the ref "refs/heads/refs/heads/A", and we use that commit
as orig_head, but use an incorrect head_name).

I didn't look as carefully as this one, but there may be similarly
iffy uses of lookup_commit_reference_by_name() introduced by this
patch that used to be more strict/exact; they may need to be fixed.

>  		} else {
> -			struct commit *commit =
> +			options.orig_head =
>  				lookup_commit_reference_by_name(branch_name);
> -			if (!commit)
> +			if (!options.orig_head)
>  				die(_("no such branch/commit '%s'"),
>  				    branch_name);
> -			oidcpy(&options.orig_head, &commit->object.oid);
>  			options.head_name = NULL;

This side, which is "this is what happens to a random object name
that is not a branch name", is perfectly fine.
