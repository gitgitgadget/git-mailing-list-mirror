Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B86C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A71A20747
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 21:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFAFLiy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832108AbgJ0VKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 17:10:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51317 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832105AbgJ0VKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 17:10:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E841E7D26;
        Tue, 27 Oct 2020 17:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1qKUUaE8MYgwdowg8u6o6zqRDAI=; b=CFAFLi
        y7YC45UkOK1rNrPSX8dB6dGLcL7LplCQHzpvcN+ChRRiLrwqB/esj2qgwHoIgspa
        Ari9t7OJZPyYCjpjGkp4n7XA97KdWrW3qUG4cypSV+HM0dOGO8Be/FMqdwz40FM4
        627I31kSHRCESI+yTqdXMnMe2L6JZi/x399WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WRSddqwCqrWqSKTyofMlgAyHZ/wJFI6a
        PfBUkAYTucArvhv0EHYWyVpkE++3lDl8Ni91z4rmYehAfHaTSFnBcAq3O21sasBw
        ku/+QdZt5UtgYGuUndX6PcgEFexQHu2vRip1gKx29T1xCOxeYPGORd6nUcfZy5Ne
        /yJANmjGAro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 672D6E7D25;
        Tue, 27 Oct 2020 17:10:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B12FCE7D24;
        Tue, 27 Oct 2020 17:10:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
        <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 14:10:38 -0700
In-Reply-To: <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Tue, 27 Oct 2020 14:02:14
        +0000")
Message-ID: <xmqq7drbbcj5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDA22346-1898-11EB-835A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>

My initial impression after seeing the recent report about ORIG_HEAD
was "hmph, these days, rebasing is done on detached HEAD and the
final step updates the target branch only once, so @{1} is much
easier to use---perhaps it is time to deprecate use of ORIG_HEAD?".
After all, ORIG_HEAD was invented way before we had reflog, and
given that one of the goal of reflog was to give more general
recovery mechanism than going back one-step like ORIG_HEAD allowed
us to, and "rebase" were taught to work on detached HEAD to make
@{1} more useful, it would not be too bad to eventually retire
ORIG_HEAD in a distant future, I thought.

But it is a good initiative anyway to make ORIG_HEAD again work as
documented.  Thanks for working on it.

> After rebasing ORIG_HEAD is supposed to point to the old HEAD of the

A comma after "rebasing".

> rebased branch. Unfortunately the buffer storing the oid was
> overwritten with a new oid before ORIG_HEAD was created. The buffer is
> also used when writing .git/rebase-merge/orig-head which is used by
> `rebase --abort` to restore the previous head. Luckily that file is
> written before the buffer is overwritten.  As we want the full oid
> find_unique_abbrev() is replaced with oid_to_hex_r() rather than
> find_unique_abbrev_r().

The above is hard to read and understand.  It is unclear where the
observation of the current behaviour (which is often the explanation
of the cause of the bug) ends and the description of new behaviour
begins.

    ... old HEAD of the rebased branch.  The code used
    find_unique_abbrev() to obtain the object name of the old HEAD
    and wrote to both .git/rebase-merge/orig-head (used by `rebase
    --abort` to go back to the previous state) and to ORIG_HEAD.
    The buffer find_unique_abbrev() gives back is volatile,
    unfortunately, and was overwritten after the former file is
    written but before ORIG_FILE is written, leaving an incorrect
    object name in it.

Up to that point is the observation of the current code, which
explains where the bug comes from.  Please have a paragraph break
after that, before explaining the solution, e.g.

    Avoid relying on the volatile buffer of find_unique_abbrev(),
    and instead supply our own buffer to keep the object name.
    Because we want to use the full object name, use oid_to_hex_r()
    instead of find_unique_abbrev_r() to do so.

> I think that all of the users of head_hash should actually be using
> opts->orig_head instead as passing a string rather than a struct
> object_id around is a hang over from the scripted implementation. This
> patch just fixes the immediate bug and adds a regression test based on
> Caspar's reproduction example. The users will be converted to use
> struct object_id and head_hash removed in the next few commits.

Makes sense.

>
> Reported-by: Caspar Duregger <herr.kaste@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

If you cite "Caspar's repro example" like that in the log message,
it is incomplete to leave out a URL to the mail archive.


>  builtin/rebase.c              | 10 +++++-----
>  t/t3404-rebase-interactive.sh | 11 +++++++++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index eeca53382f..6def28a533 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -270,15 +270,15 @@ static int edit_todo_file(unsigned flags)
>  }
>  
>  static int get_revision_ranges(struct commit *upstream, struct commit *onto,
> -			       struct object_id *orig_head, const char **head_hash,
> +			       struct object_id *orig_head, char *head_hash,
>  			       char **revisions, char **shortrevisions)
>  {
>  	struct commit *base_rev = upstream ? upstream : onto;
>  	const char *shorthead;
>  
> -	*head_hash = find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
> +	oid_to_hex_r(head_hash, orig_head);
>  	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
> -						   *head_hash);
> +						   head_hash);
>  
>  	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
>  
> @@ -327,7 +327,7 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
>  static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  {
>  	int ret;
> -	const char *head_hash = NULL;
> +	char head_hash[GIT_MAX_HEXSZ];
>  	char *revisions = NULL, *shortrevisions = NULL;
>  	struct strvec make_script_args = STRVEC_INIT;
>  	struct todo_list todo_list = TODO_LIST_INIT;
> @@ -335,7 +335,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>  	struct string_list commands = STRING_LIST_INIT_DUP;
>  
>  	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
> -				&head_hash, &revisions, &shortrevisions))
> +				head_hash, &revisions, &shortrevisions))
>  		return -1;
>  
>  	if (init_basic_state(&replay,
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 07a1617351..1e56696e4f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1797,6 +1797,17 @@ test_expect_success 'todo has correct onto hash' '
>  	test_i18ngrep "^# Rebase ..* onto $onto" actual
>  '
>  
> +test_expect_success 'ORIG_HEAD is updated correctly' '
> +	test_when_finished "git checkout master && git branch -D test-orig-head" &&
> +	git checkout -b test-orig-head A &&
> +	git commit --allow-empty -m A1 &&
> +	git commit --allow-empty -m A2 &&
> +	git commit --allow-empty -m A3 &&
> +	git commit --allow-empty -m A4 &&
> +	git rebase master &&
> +	test_cmp_rev ORIG_HEAD test-orig-head@{1}
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
