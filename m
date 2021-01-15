Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6BC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2256923AAC
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbhAOBAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 20:00:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63949 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbhAOBAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 20:00:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 303E8115060;
        Thu, 14 Jan 2021 19:59:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SJOKMYY9qTr+
        MZo7NlQBzNuQkoA=; b=WLrVlSWc1vyomIaSREQImVe1qTPDogA2MdIO0oUF39rs
        RCO/3LYNJN6hKTC3wmQPTDTiyjz+z1iaU89aQBKE48BKZPF68dEjbMIRWrMdLI7f
        qjDsqqgrJzdwnEQOvyYCcAJVT6mNyhO+pPmkk1Kaxr/XbGSWNnCGbsTeD1aE8bY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=X+zYE7
        3PumQIxKizrt4T6pZ775xSoijUPL/SqLhS4MCTddGdfVt8NY/bCi0y8Ja28ikGtx
        icS9HOOpTEg1NzYUmhAGE/k3E8CwPXxDlUaTTs4itj1WIiIucd0KoSaxwG2IJKCQ
        lyDwSgrLuPMDxnMsVD2vKX6w/i8hX90aGy4EY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A12111505F;
        Thu, 14 Jan 2021 19:59:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 679D911505B;
        Thu, 14 Jan 2021 19:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v3] ls-files.c: add --dedup option
References: <pull.832.v2.git.1610116600.gitgitgadget@gmail.com>
        <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
Date:   Thu, 14 Jan 2021 16:59:40 -0800
In-Reply-To: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
 (=?utf-8?B?IumYv+W+t+eDiA==?=
        via GitGitGadget"'s message of "Thu, 14 Jan 2021 12:22:22 +0000")
Message-ID: <xmqqczy7vwub.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F38DB68A-56CC-11EB-A3F3-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget"  <gitgitgadget@gmail.com> =
writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> In order to provide users a better experience
> when viewing information about files in the index
> and the working tree, the `--dedup` option will suppress
> some duplicate options under some conditions.
>
> In a merge conflict, one item of "git ls-files" output may
> appear multiple times. For example,now the file `a.c` has
> a conflict,`a.c` will appear three times in the output of
> "git ls-files".We can use "git ls-files --dedup" to output
> `a.c` only one time.(unless `--stage` or `--unmerged` is
> used to view all the detailed information in the index)

Unlike these option names we see in the description, "dedup" is not
a full word.  Perhaps spell it fully "--deduplicate" while letting
parse-options machinery to accept unique prefix (including
"--dedup"?

> In addition, if you use both `--delete` and `--modify` in
> the same time, The `--dedup` option can also suppress modified

"at the same time", I think.

> entries output.

[let's call this point "point A"]

> `--dedup` option relevant descriptions in
> `Documentation/git-ls-files.txt`,

I am not sure what this means.

> the test script in `t/t3012-ls-files-dedup.sh`
> prove the correctness of the `--dedup` option.

No amount of tests "proves" any correctness, but that is OK.  I
think you meant to say "a few tests have been added to t3012 to
protect the new feature from future breakage" or something like
that.

In any case, I think everything after "point A" and before your sign
off does not belong to the log message.  The diffstat shows that
documentation and tests have been added already.

> +--dedup::
> +	Suppress duplicate entries when conflict happen

"conflict happen" -> "there are unmerged paths", as the term
"unmerged" is already shown to readers of "ls-files --help".

> +	or `--deleted` and `--modified` are combined.

I somehow thought that you refrained from deduping when you are
showing the stages with "ls-files -u" and "ls-files -s", or you are
showing status with "ls-files -t", because you will otherwise lose
information.  In other words, showing only one cache entry out of
many that share the same name makes sense only when we are showing
name and nothing else.

Has that been changed from the previous rounds?

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index c8eae899b82..bc4eded19ab 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -316,6 +318,20 @@ static void show_files(struct repository *repo, st=
ruct dir_struct *dir)
>  		for (i =3D 0; i < repo->index->cache_nr; i++) {
>  			const struct cache_entry *ce =3D repo->index->cache[i];
> =20
> +			if (show_cached && delete_dup) {
> +				switch (ce_stage(ce)) {
> +				case 0:
> +				default:
> +					break;

This part looks somewhat strange for two reasons:

 - The code enumerates ALL the possible stage numbers from 0 to 3;
   if we were to have "default", I'd expect it would be a separate
   switch arm from the possible values that calls out an programming
   error, e.g. BUG("at stage #%d???", ce_stage(ce)).  Simply removing
   the "default" arm would be another way out of this strangeness.

 - When we see a stage #0 entry, we know we will not have higher
   stage entries with the same name.  Not clearing last_stage here
   feels wrong, as the primary reason why last_stage variable is
   used is to remember the last ce that was shown, so that other
   entries with the same name can be skipped.

By the way, "last_shown_ce" may be a much better name for the
variable, as you do not really care what stage number the ce you
showed last was at (you care about its name).

Also, I do not see a good reason why the last_shown_ce variable
should have lifetime longer than the block that contains this for()
loop (and the other for loop for deleted/modified codepath we see
later).  Especially since you initialize the variable that you made
visible to the entire function to NULL before entering the first for
loop, but you do not set it back to NULL before entering the second
for loop, it is inviting a subtle bug.  You may have been given
show_cached and show_modified at the same time, so you enter the
first loop and have shown the first stage of the last conflicted
path, whose cache entry is left in the last_stage variable.  Since
the variable has longer lifespan than necessary, when the second
loop is entered, it still points at the cache entry for the highest
stage of the last conflicted path.  That is because the code forgets
to clear it to NULL before entering the second for loop.

Having said all that, I suspect that we may be much better off if we
can somehow merge the two loops into one.  You may be dedup adjacent
entries in each loop separately with the approach taken by this
patch, but I do not think the patch would work to deduplicate across
two loops.  For example, what happens if you do this?

    $ git reset --hard
    $ echo >>builtin/ls-files.c
    $ git ls-files -c -m builtin/ls-files.c
    $ git ls-files -t -c -m builtin/ls-files.c

I think you see the path twice in the output, with or without your
--dedup option (remember what I said about proving, by the way? ;-)).

Once we successfully merged two loops into one, the part that shows
tracked paths in the function would have only one loop, and it would
become a lot cleaner to add the logic to "skip showing the ce if it
has the same name as the previously shown one, only when doing so
won't lose information", by doing something like this:

	static void show_files(....)
	{
		/* show_others || show_killed done here */
		...

		/* leave early if not showing anything */
		if (! (show_cached || show_stage || show_deleted || show_modified))
			return;

		last_shown_ce =3D NULL;
		for (i =3D 0; i < repo->index->cache_nr; i++) {
			const struct cache_entry *ce =3D repo->index->cache[i];

			if (skipping_duplicates && last_shown_ce)
				if (!strcmp(ce->name, last_shown_ce->name))
					continue;

			construct_fullname();

                        /* various reasons to skip the entry tested */
			if (showing ignored directory and ce is excluded)
				continue;
			if (show_unmerged && !ce_stage(ce))
				continue;
			if (ce->ce_flags & CE_UPDATE)
				continue;
			... other reasons may appear here ...

			/* now we are committed to show it */
			last_shown_ce =3D ce;

			... various different ways to show ce come here ...=20
			show_ce(...);
		}
	}

where "skipping_duplicates" would be set when "--deduplicate" is
asked and we are not showing information other than the pathname
via various options e.g. the tags (-t) or stages (-s/-u).

> +			if (delete_dup && show_deleted && show_modified && err)
>  				show_ce(repo, dir, ce, fullname.buf, tag_removed);

I actually think the original code that is still shown here ...

> +			else {
> +				if (show_deleted && err)
> +					show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +				if (show_modified && ie_modified(repo->index, ce, &st, 0))

... about modified file is buggy.  If lstat() failed, then &st has
no useful information, so it is wrong to feed it to ie_modified().

Perhaps a three-patch series that is structured like this may be in
order?

 #1: bugfix for --deleted and --modified.

	err =3D lstat(fullname.buf, &st);
	if (err) {
		/* deleted? */
		if (errno !=3D E_NOENT)
			error_errno("cannot lstat '%s'", fullname.buf);
		else {
			if (show_deleted)
                        	show_ce(..., tag_removed);
			if (show_modified)
                        	show_ce(..., tag_modified);
		}
	} else if (show_modified && ie_modified(...))
		show_ce(..., tag_modified);
   =20
     This hopefully should not change the semantics.  If you ask
     --deleted and --modified, a deleted path would be listed twice.

 #2: consolidate two for loops into one.

     The two loops have slightly different condition to skip a ce,
     and different logic on what tag each path is shown with.  When
     --cached and --modified or --deleted are asked for at the same
     time, we'd show them multiple times (this is done inside the
     loop for each ce)

	if (show_cached || show_stage)
		show_ce(... ce_stage(ce) ? tag_unmerged : ...);
	err =3D lstat(fullname.buf, &st);
	if (err) {
        	/* deleted? */
                ... code that corresponds to the
		... illustration in #1 above come here.
	} else if (...)
		show_ce(..., tag_modified);

     This changes the semantics.  The original iterates the index
     twice, so you may see the same entry from --cached once and
     then again from --modified.  The updated one still will show
     the same entry twice but next to each other.

 #3: optionally deduplicate.

     Once we have a single loop, deduplicationg based on names is
     trivial, as we seen before.


Hmm?
