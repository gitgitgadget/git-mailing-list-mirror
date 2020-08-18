Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB74C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C4C20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 21:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eGQT5Wvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHRVFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:05:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53378 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRVFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 17:05:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE483E6550;
        Tue, 18 Aug 2020 17:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kWmSwHaT9+juPTDuv1LtRciZx9g=; b=eGQT5W
        vbnVfbSqwhtZKLeLIMS61HRF39qTjgBrcrSzhMUxz7lWgtNjNRnwj+kS81s4IRS8
        0OL+0ylafZcI+pjrp0ZUFUG4J9qj7rMmYFQ6/Voc+qpPWCuZW6/d0LDc735fq6Zo
        w5kmo++ETrP1NQhATiKIr9QalKfetxnEBMyw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ykKiqf1qlpUXyP2/WhXapHY+U8F+O+Ht
        ceZ2e+oS+ExAZcSYK4295D8ptFe6YCmazuDouNLPeE+GQ7ZC/QROlwLMI3MUAGXI
        3wLIO2t/KNq6ysnLnDwvC2l8PrXgqFgUqv6MTtI/fQ4QbQaal3aP9xRp6tyfBI2R
        aSpxsitc9KA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91277E654F;
        Tue, 18 Aug 2020 17:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9D97E654D;
        Tue, 18 Aug 2020 17:05:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] Treat CHERRY_PICK_HEAD as a pseudo ref
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
        <06a8e8cbd1370ba3d4ea8a0a9f1e69d27b1d62c4.1597753075.git.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:05:16 -0700
In-Reply-To: <06a8e8cbd1370ba3d4ea8a0a9f1e69d27b1d62c4.1597753075.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Tue, 18 Aug 2020
        12:17:54 +0000")
Message-ID: <xmqqsgcjwtpv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84D9CE0A-E196-11EA-9B15-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Check for existence and delete CHERRY_PICK_HEAD through ref functions.
> This will help cherry-pick work with alternate ref storage backends.

These two sentences are true, but this patch does another thing that
is not advertised here.  It stops recommending removal of
CHERRY_PICK_HEAD from the filesystem with "rm" (or using "git
update-ref -d" for that matter) as a way to avoid recording the
current commit as a cherry-pick.

The intent of the warning message touched by this patch, I think, is
that there is CHERRY_PICK_HEAD, but that might be a leftover one
that does not have to do anything to do with the commit the user is
making, and continuing blindly may record the commit incorrectly
(perhaps 'cherry-picked-from' trailer is added incorrectly?
existing notes data would be copied to the newly created commit?).

To recover from the situation, the user would want to abort the
commit while keeping the changes made to the working tree and to the
index to avoid the result recorded as a cherry-pick of an irrelevant
commit, get rid of CHERRY_PICK_HEAD and then attempt the "git
commit" again.

Does "git cherry-pick --abort" only remove CHERRY_PICK_HEAD without
doing any other damage to the working tree files and to the index?

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  builtin/commit.c | 34 +++++++++++++++++++---------------
>  builtin/merge.c  |  2 +-
>  path.c           |  1 -
>  path.h           |  7 ++++---
>  sequencer.c      | 42 ++++++++++++++++++++++++++----------------
>  wt-status.c      |  4 ++--
>  6 files changed, 52 insertions(+), 38 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 69ac78d5e5..619b71bcb4 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -847,21 +847,25 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
>  				!merge_contains_scissors)
>  				wt_status_add_cut_line(s->fp);
> -			status_printf_ln(s, GIT_COLOR_NORMAL,
> -			    whence == FROM_MERGE
> -				? _("\n"
> -					"It looks like you may be committing a merge.\n"
> -					"If this is not correct, please remove the file\n"
> -					"	%s\n"
> -					"and try again.\n")
> -				: _("\n"
> -					"It looks like you may be committing a cherry-pick.\n"
> -					"If this is not correct, please remove the file\n"
> -					"	%s\n"
> -					"and try again.\n"),
> -				whence == FROM_MERGE ?
> -					git_path_merge_head(the_repository) :
> -					git_path_cherry_pick_head(the_repository));
> +			if (whence == FROM_MERGE)
> +				status_printf_ln(
> +					s, GIT_COLOR_NORMAL,
> +
> +					_("\n"
> +					  "It looks like you may be committing a merge.\n"
> +					  "If this is not correct, please remove the file\n"
> +					  "	%s\n"
> +					  "and try again.\n"),
> +					git_path_merge_head(the_repository));
> +			else
> +				status_printf_ln(
> +					s, GIT_COLOR_NORMAL,
> +
> +					_("\n"
> +					  "It looks like you may be committing a cherry-pick.\n"
> +					  "If this is not correct, please run\n"
> +					  "	git cherry-pick --abort\n"
> +					  "and try again.\n"));
>  		}

I do not know about this change (see above).

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 74829a838e..b9a89ba858 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1348,7 +1348,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		else
>  			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
>  	}
> -	if (file_exists(git_path_cherry_pick_head(the_repository))) {
> +	if (ref_exists("CHERRY_PICK_HEAD")) {

This, and all the rest, look quite sensible.

> diff --git a/wt-status.c b/wt-status.c
> index d75399085d..c6abf2f3ca 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1672,8 +1672,8 @@ void wt_status_get_state(struct repository *r,
>  		state->merge_in_progress = 1;
>  	} else if (wt_status_check_rebase(NULL, state)) {
>  		;		/* all set */
> -	} else if (!stat(git_path_cherry_pick_head(r), &st) &&
> -			!get_oid("CHERRY_PICK_HEAD", &oid)) {
> +	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
> +		   !get_oid("CHERRY_PICK_HEAD", &oid)) {
>  		state->cherry_pick_in_progress = 1;
>  		oidcpy(&state->cherry_pick_head_oid, &oid);
>  	}
