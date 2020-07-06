Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB2C433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E92212CC
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rPBYlHiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGFU1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:27:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61153 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgGFU1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 16:27:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4955C9621;
        Mon,  6 Jul 2020 16:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=33ffEUk3wpQuf0Vprg4bSZCOymg=; b=rPBYlH
        iJvTPD/X3Ncb8P2JIfY+n5PvzsKqVNCRavOlReshkWrvou/AxaQCW3PDVPi2ECin
        so1qtRtkPcuMumIyWrXpZnMudZsbzMO8TLzB45+Ywla/bZfi07fenc9TMJV20uxJ
        tSqH9nom1krKUZPRhW7x8kEdTybyiZRBfyXaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=clHZSI3G8L/rwVY5Q0Uh03Unwh9cABg5
        sYQyV4CeoEqLoMdQmhvcHHPRpIyvcQqC+xQvZVyDhvajLlDQCx7GKM579BQWaLMk
        6gtSObkx8xeN6pJA+CniKzgkQBvkrEWjtXqzaXuoKJhF6o2QRWFiGhzqai3Q08B5
        1hs2mjJQvnk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC95CC9620;
        Mon,  6 Jul 2020 16:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F321FC961F;
        Mon,  6 Jul 2020 16:26:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 13:26:55 -0700
In-Reply-To: <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 06 Jul 2020
        17:29:31 +0000")
Message-ID: <xmqqimf09ypc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 09AF579A-BFC7-11EA-8F50-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 1/2] Modify pseudo refs through ref backend storage
> From: Han-Wen Nienhuys <hanwen@google.com>

With what definition of "pseudo refs" has this change been made?
Those things like HEAD, CHERRY_PICK_HEAD, FETCH_HEAD etc. that have
traditionally been written as a plain text file in $GIT_DIR and are
used to name objects by having a full object name in it?  

Or the entities that behave like refs and stored in ref backends,
with all-uppercase-names but do not sit inside refs/ hierarchy?

I think it is OK (and possibly a good move in the longer term, but
that is just my gut feeling) to make ref backends resopnsible for
enumerating, reading and writing them (i.e. I think we want to use
the latter definition for the longer term health of the project).
And we would want to ...

> The previous behavior was introduced in commit 74ec19d4be
> ("pseudorefs: create and use pseudoref update and delete functions",
> Jul 31, 2015), with the justification "alternate ref backends still
> need to store pseudorefs in GIT_DIR".

... declare that justification invalid for that purpose.

Is that what is going on?  I just want to make sure I am following
your flow of thought.

> Refs such as REBASE_HEAD are read through the ref backend. This can
> only work consistently if they are written through the ref backend as
> well. Tooling that works directly on files under .git should be
> updated to use git commands to read refs instead.

OK.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6516c7bc8c..9951c2e403 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1228,7 +1228,6 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  
>  	for (i = 0; i < refnames->nr; i++) {
>  		const char *refname = refnames->items[i].string;
> -
>  		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
>  			result |= error(_("could not remove reference %s"), refname);
>  	}

Unreleated change?

> @@ -2436,7 +2435,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  	update->backend_data = lock;
>  
>  	if (update->type & REF_ISSYMREF) {
> -		if (update->flags & REF_NO_DEREF) {
> +		if (update->flags & REF_NO_DEREF ||
> +		    (ref_type(update->refname) == REF_TYPE_PSEUDOREF &&
> +		     strcmp(update->refname, "HEAD"))) {
>  			/*
>  			 * We won't be reading the referent as part of
>  			 * the transaction, so we have to read it here

The old "if we are not dereferencing" condition in if() exactly
matched the comment, but the condition in if() after this change is
not "if we are not dereferencing".  Even if we are dereferencing,
under some new condition, we would still drop into this block and do
not follow the "else" side that creates a new update for the
referent.  Is this part of "modify pseudo refs via backend" topic,
or should it be a separate modification?  Why is this change needed?

It seems that no matter where in the refs/ hierarchy (or even
outside) a symbolic ref resides, the way to update itself (not the
referent through the symbolic ref) should be the same, which is what
the original says, and we want to change that reasoning here, but it
is not quite clear to me why.

> @@ -2782,8 +2783,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  		struct ref_update *update = transaction->updates[i];
>  		struct ref_lock *lock = update->backend_data;
>  
> -		if (update->flags & REF_NEEDS_COMMIT ||
> -		    update->flags & REF_LOG_ONLY) {
> +		if ((ref_type(lock->ref_name) != REF_TYPE_PSEUDOREF ||
> +		     !strcmp(lock->ref_name, "HEAD")) &&
> +		    (update->flags & REF_NEEDS_COMMIT ||
> +		     update->flags & REF_LOG_ONLY)) {

And this one stops the files backend from touching all pseudorefs
other than HEAD with this codepath.  That somehow feels totally
opposite from what the log message explained above---weren't we
updating the code to write these pseudorefs through the individual
backends, which the files backend is one example of?  Isn't this
change stopping the backend from writing the pseudorefs other than
HEAD instead?

Puzzled.

>  			if (files_log_ref_write(refs,
>  						lock->ref_name,
>  						&lock->old_oid,


> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 27171f8261..6b8030e8fe 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -476,7 +476,7 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
>  test_expect_success 'given old value for missing pseudoref, do not create' '
>  	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
>  	test_path_is_missing .git/PSEUDOREF &&

The reason why I asked what this patch thinks the definition of
pseudoref is is because of this thing.  Shouldn't this line be fixed
not to depend on the files backend?  Likewise for $(cat .git/PSEUDOREF)
in the remaining two hunks.

> -	test_i18ngrep "could not read ref" err
> +	test_i18ngrep "unable to resolve reference" err
>  '
>  
>  test_expect_success 'create pseudoref' '
> @@ -497,7 +497,7 @@ test_expect_success 'overwrite pseudoref with correct old value' '
>  test_expect_success 'do not overwrite pseudoref with wrong old value' '
>  	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
>  	test $C = $(cat .git/PSEUDOREF) &&
> -	test_i18ngrep "unexpected object ID" err
> +	test_i18ngrep "cannot lock ref.*expected" err
>  '
>  
>  test_expect_success 'delete pseudoref' '
> @@ -509,7 +509,7 @@ test_expect_success 'do not delete pseudoref with wrong old value' '
>  	git update-ref PSEUDOREF $A &&
>  	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
>  	test $A = $(cat .git/PSEUDOREF) &&
> -	test_i18ngrep "unexpected object ID" err
> +	test_i18ngrep "cannot lock ref.*expected" err
>  '
>  
>  test_expect_success 'delete pseudoref with correct old value' '
