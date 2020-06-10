Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF0C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0829206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i871A82l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgFJRek (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:34:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58373 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgFJRej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:34:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE232D823F;
        Wed, 10 Jun 2020 13:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1lclTdterNyK17m3x/70yFatmiM=; b=i871A8
        2lusPPcHI7VigvaTkVcRRm7feed4a8FNlxr4jZSJHbHOYmvjwJMo9DksCp8CB41G
        EBQWPvvyETjUwV9sbVXMcGKiHTNoCr2YOQuSfrMPaLjdXalvtseXHjcq6DWGxPVt
        CzIAWpQZiVHL0BeK+kd1wFIUqDaV/l7xz/aB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QELHr/QYAxhfJrXar+EQPxL6F6773GW2
        +qIzyfgoP7rtlfjgYcFRTf8dR82dIu+vEnkaPG7OleNq32UR23f00tHEu0s2Rmqk
        6GR6P4JvG8GVzpdsKNMd0ZQ8dmkEXF1r1w1rC3xLexC5ozD6hn2EhdXz0nnFzMIr
        1oqsqEADovk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0824D823E;
        Wed, 10 Jun 2020 13:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C635D823B;
        Wed, 10 Jun 2020 13:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        Jonathan =?utf-8?Q?M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 4/7] worktree: prune duplicate entries referencing same worktree path
References: <20200610063049.74666-1-sunshine@sunshineco.com>
        <20200610063049.74666-5-sunshine@sunshineco.com>
        <20200610115028.GA11750@konoha>
        <CAPig+cQjR78+wanyRXhB33qsVwHqjSAc_c1O+CG6ZkJi6W3mDA@mail.gmail.com>
Date:   Wed, 10 Jun 2020 10:34:32 -0700
In-Reply-To: <CAPig+cQjR78+wanyRXhB33qsVwHqjSAc_c1O+CG6ZkJi6W3mDA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 10 Jun 2020 11:21:11 -0400")
Message-ID: <xmqqa71ag6zb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A64E22C0-AB40-11EA-992C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jun 10, 2020 at 7:50 AM Shourya Shukla
> <shouryashukla.oo@gmail.com> wrote:
>> > +static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
>>
>> What exactly is the role of 'wtpath' in here? Maybe this is explained in
>> the later patches.
>
> 'wtpath' holds the location of the worktree. It's used in this patch
> by prune_worktrees() to collect a list of paths which haven't been
> marked for pruning. Once it has the full list, it passes it to
> prune_dups() for pruning duplicate entries.

"wt" being a fairly common abbreviation of "work(ing) tree" in the
codebase may escape new readers of the code.  The comment before the
function can explicitly mention the variable name in the description
to help them, I would think.  For example ...

> +/*
> + * Return true if worktree entry should be pruned, along with the reason for
> + * pruning. Otherwise, return false and the worktree's path, or NULL if it

... the first sentence makes it clear that the function returns two
things (i.e. "true"---presumably is returned as its return value, and
"the reason"---the readers are supposed to guess it is stuffed in
the strbuf), and the second sentence also says the function returns
two things (i.e. "false", and "the worktree's path"---it is not
immediately obvious where NULL goes, though).

> + * cannot be determined. Caller is responsible for freeing returned path.
> + */

	Determine if the worktree entry specified by its "id" should
	be pruned.

	When returning 'true', the caller-supplied strbuf "reason"
	is filled with the reason why it should be pruned.  "wtpath"
	is left intact.

	When returning 'false', the string variable pointed by
	"wtpath" receives the absolute path of the worktree; or NULL
	if the location of the worktree cannot be determined.
	"reason" is left intact.

perhaps?  I didn't check what you do to *wtpath when you return
true, so "left intact" may not be what you are doing, and I am *not*
suggesting to leave it intact in that case---I am only suggesting
that we should describe what happens.

>> > +static int prune_cmp(const void *a, const void *b)
>>
>> Can we rename the function arguments better? 'a' and 'b' sound very
>> naive to me. Maybe change these to something more like: 'firstwt' and
>> 'secondwt'? Yeah even this sounds kiddish but you get the idea right? Or
>> like 'wt' and 'wt_dup'?
>
> As with any language, C has its idioms, as does Git itself. Sticking
> to idioms makes it easier for others to understand the code
> at-a-glance. Short variable names, such as "i" and "j" for indexes,
> "n" for counters, "s" and "t" for strings, are very common among
> experienced programmers. Likewise, "a" and "b" are well-understood as
> the arguments of a "comparison" function. There are many such examples
> in the Git source code itself. Here are just a few:
>
>     cmp_uint32(const void *a_, const void *b_)
>     maildir_filename_cmp(const char *a, const char *b)
>     tipcmp(const void *a_, const void *b_)
>     cmp_by_tag_and_age(const void *a_, const void *b_)
>     cmp_remaining_objects(const void *a, const void *b)
>     version_cmp(const char *a, const char *b)
>     diffnamecmp(const void *a_, const void *b_)
>     spanhash_cmp(const void *a_, const void *b_)
>     void_hashcmp(const void *a, const void *b)
>     pathspec_item_cmp(const void *a_, const void *b_)

While that is true, what happens in the funcion is a bit unusual.

> +static int prune_cmp(const void *a, const void *b)
> +{
> +	const struct string_list_item *x = a;
> +	const struct string_list_item *y = b;

Usually we do

	static int foo_cmp(const void *a_, const void *b_)
	{
		const true_type *a = a_;
		const true_type *b = b_;

		/* use a and b for comparison */

without involving 'x' and 'y'.

>> > +test_expect_success 'prune duplicate (linked/linked)' '
>> > +   test_when_finished rm -fr .git/worktrees w1 w2 &&
>>
>> Nit: maybe make it 'rm -rf' as that's the popular way of doing it?
>
> It's true that "-rf" has wider usage in Git tests than "-fr", though
> the latter is heavily used, as well.

I myself write "rm -rf" more often when I am casually programming
out of inertia, but when consciously making a decision on how to
spell the combination, I tend to go alphabetical, because there is
no logical reason to write 'r' first, other than the fact that "-rf"
visually looks prettier than "-fr".  

If recursiveness of the removal is more important than forcedness,
then favouring "-rf" over "-fr" would be justifiable, but I do not
think that is the case here.

And as you said, it is not something that justifies a reroll (or
updating existing uses of "-rf") alone.
