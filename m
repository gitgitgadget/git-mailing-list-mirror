Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D89F207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 21:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940861AbcIZVX4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 17:23:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50195 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938984AbcIZVXz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 17:23:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F0424266D;
        Mon, 26 Sep 2016 17:23:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zNM1mQzJfLAIsE8hIuGQzDmpRic=; b=v/sHYc
        4rwxjBm3VAMfw3ferECgnOYkM4hBZOymdq55H6B5Bh7utoQXbNzJpB44N40h8Vx7
        csKL+13t2HWGMrM8AgNrsyzqb5XIIfB0Ia0kEsaAVRS9KCjkOFAH8RYb+M7cuUEk
        IIfuJmQpWdkK5kAIDEKZXmpLHLgIWA6Gd5K6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=spR1+VbDzLDlgHzvhnYcQW5Uwhx2d8DB
        ZfRmrIshpoSGieePBCcV1L78/Wu0XblXMloccqTs3Fz1AAAHKEZcNWEQRhK9Ohm/
        50ThL3s5e3nSxOvp41oRLRqQ1Dn21Uiiru0hd4CF9461+wxCIaJPRyTupYIrZQFe
        WtgrqlsaaQc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D764266B;
        Mon, 26 Sep 2016 17:23:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 046014266A;
        Mon, 26 Sep 2016 17:23:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
        Kevin Bracey <kevin@bracey.fi>,
        Philip Oakley <philipoakley@iee.org>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC PATCH v4] revision: new rev^-n shorthand for rev^n..rev
References: <20160926204959.26007-1-vegard.nossum@oracle.com>
Date:   Mon, 26 Sep 2016 14:23:50 -0700
In-Reply-To: <20160926204959.26007-1-vegard.nossum@oracle.com> (Vegard
        Nossum's message of "Mon, 26 Sep 2016 22:49:59 +0200")
Message-ID: <xmqqr386pd7d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 862F37F4-842F-11E6-97EC-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> I often use rev^..rev to get all the commits in the branch that was merged
> in by the merge commit 'rev' (including the merge itself). To save typing
> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
> we can make rev^- a shorthand for that.
>
> The existing syntax rev^! seems like it should do the same thing, but it
> doesn't really do the right thing for merge commits (it doesn't include
> the commits from side branches).
>
> As a natural generalisation, we also accept rev^-n where n excludes the
> nth parent of rev. For example, for a two-parent merge, you can use rev^-2
> to get the set of commits which were made to the main branch while the
> topic branch was prepared.

I am tempted to suggest that this four-line paragraph may be
sufficient:
    
    "git log rev^..rev" is commonly used to show all work done on
    and merged from a side branch.  Introduce a short-hand "rev^-"
    for this, and also allow it to take "rev^-$n" to mean "reachable
    from rev, excluding what is reachable from n-th parent of rev".

This alone is not a strong enough reason to ask you to reroll the
patch.

> diff --git builtin/rev-parse.c builtin/rev-parse.c
> index 76cf05e..2c3da19 100644
> --- builtin/rev-parse.c
> +++ builtin/rev-parse.c
> @@ -298,14 +298,30 @@ static int try_parent_shorthands(const char *arg)
>  	unsigned char sha1[20];
>  	struct commit *commit;
>  	struct commit_list *parents;
> -	int parents_only;
> -
> -	if ((dotdot = strstr(arg, "^!")))
> -		parents_only = 0;
> -	else if ((dotdot = strstr(arg, "^@")))
> -		parents_only = 1;
> -
> -	if (!dotdot || dotdot[2])
> +	int parent_number;
> +	int include_rev = 0;
> +	int include_parents = 0;
> +	int exclude_parent = 0;
> +
> +	if ((dotdot = strstr(arg, "^!"))) {
> +		include_rev = 1;
> +		if (dotdot[2])
> +			return 0;
> +	} else if ((dotdot = strstr(arg, "^@"))) {
> +		include_parents = 1;
> +		if (dotdot[2])
> +			return 0;
> +	} else if ((dotdot = strstr(arg, "^-"))) {
> +		include_rev = 1;
> +		exclude_parent = 1;
> +
> +		if (dotdot[2]) {
> +			char *end;
> +			exclude_parent = strtoul(dotdot + 2, &end, 10);
> +			if (*end != '\0' || !exclude_parent)
> +				return 0;
> +		}
> +	} else
>  		return 0;

Nice; we can tell where this is going without looking at the rest,
which is a very good sign that the new variables are doing their
work of telling the readers what is going on clearly.

> @@ -314,14 +330,21 @@ static int try_parent_shorthands(const char *arg)
>  		return 0;
>  	}
>  
> -	if (!parents_only)
> +	if (include_rev)
>  		show_rev(NORMAL, sha1, arg);
>  	commit = lookup_commit_reference(sha1);
> -	for (parents = commit->parents; parents; parents = parents->next)
> -		show_rev(parents_only ? NORMAL : REVERSED,
> -				parents->item->object.oid.hash, arg);
> +	for (parent_number = 1, parents = commit->parents;
> +	     parents; parents = parents->next, parent_number++) {

Micronit.  When splitting "for (init; fini; cont)" into multiple
lines, it is often easier to read to make that into three lines:

	for (parent_number = 1, parents = commit->parents;
	     parents;
	     parents = parents->next, parent_number++) {

> +		if (exclude_parent && parent_number != exclude_parent)
> +			continue;
> +
> +		show_rev(include_parents ? NORMAL : REVERSED,
> +			 parents->item->object.oid.hash, arg);
> +	}

It is very clear to see what is going on.  Good job.

>  	*dotdot = '^';
> +	if (exclude_parent >= parent_number)
> +		return 0;

This is not quite nice.  You've already called show_rev() number of
times, and it is too late to signal an error here.  I think you
would need to count the number of parents much earlier when
exclude_parent option is in effect and error out before making any
call to show_rev().

> diff --git revision.c revision.c
> index 969b3d1..9ae95bf 100644
> --- revision.c
> +++ revision.c
> @@ -1289,12 +1289,14 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
>  	}
>  }
>  
> -static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
> +static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
> +			    int exclude_parent)
>  {
>  	unsigned char sha1[20];
>  	struct object *it;
>  	struct commit *commit;
>  	struct commit_list *parents;
> +	int parent_number;
>  	const char *arg = arg_;
>  
>  	if (*arg == '^') {
> @@ -1316,12 +1318,18 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags)
>  	if (it->type != OBJ_COMMIT)
>  		return 0;
>  	commit = (struct commit *)it;
> -	for (parents = commit->parents; parents; parents = parents->next) {
> +	for (parent_number = 1, parents = commit->parents;
> +	     parents; parents = parents->next, parent_number++) {
> +		if (exclude_parent && parent_number != exclude_parent)
> +			continue;
> +
>  		it = &parents->item->object;
>  		it->flags |= flags;
>  		add_rev_cmdline(revs, it, arg_, REV_CMD_PARENTS_ONLY, flags);
>  		add_pending_object(revs, it, arg);
>  	}
> +	if (exclude_parent >= parent_number)
> +		return 0;

Likewise.  It is way too late to say "Nah, this wasn't a valid rev^-
notation after all" to the caller after calling add_rev_cmdline()
and add_pending_object() in the above loop.  Just like "blob^-"
silently returns 0 in the pre-context in this hunk, count the number
of parents before entering this loop when exclude_parent is in
effect, and if the number after '-' exceeds the actual number of
parents, silently return 0, perhaps?

> diff --git t/t6070-rev-parent-exclusion.sh t/t6070-rev-parent-exclusion.sh

We already seem to have t6101 as the best place to add test for this
new feature.  Near the end of that script, ^@ and ^! are tested.

Thanks.
