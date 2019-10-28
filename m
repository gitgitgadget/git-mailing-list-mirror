Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830451F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 04:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfJ1Eif (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 00:38:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64523 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfJ1Eif (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 00:38:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 055F7980F0;
        Mon, 28 Oct 2019 00:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZmqmQMecJ7vIpNV8SBnTEMuBP90=; b=LcRvTm
        NXpqsBk1qnjbf3wKXe+TNChlXpv8noZDE3yHeDuhiRkWYkQN8GPRc5hyxaOiwAep
        7ZEKeK3dqBUudvMmwkZAQ+0hqNaUNF5yh8ft+g6rS5WrEtfrt/UsMixmAqvPau0A
        3knEdXuz3z5nuPrm1ggXHQYCiaVhfH7innVtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q48wuDbYvnqdC+zsFtoSsILhOlcAd7T8
        ujKOtqFiloOggkzReTdlE8KP0sZ94anXiptqq8B8PxYy+cwlLrSc3uTwDhj56nj+
        rdpDb9McUmo8ZmqvwhiKwdPgsC7VoZiGcG1tIN/qXBDA8zMTSs5UW2Jjq72x0kfY
        WzHJMYYoSVE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E65A1980EF;
        Mon, 28 Oct 2019 00:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07004980EE;
        Mon, 28 Oct 2019 00:38:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/2] update-index: optionally leave skip-worktree entries alone
References: <pull.355.git.gitgitgadget@gmail.com>
        <c263eb54b30b3e93abb74662d120d8bb882322bb.1569483748.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 13:38:23 +0900
In-Reply-To: <c263eb54b30b3e93abb74662d120d8bb882322bb.1569483748.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 26 Sep 2019
        00:42:31 -0700 (PDT)")
Message-ID: <xmqq36fda3i8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C801F3B2-F93C-11E9-BAFD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> While `git update-index` mostly ignores paths referring to index entries
> whose skip-worktree bit is set, in b4d1690df11 (Teach Git to respect
> skip-worktree bit (reading part), 2009-08-20), for reasons that are not
> entirely obvious, the `--remove` option was made special: it _does_
> remove index entries even if their skip-worktree bit is set.

I think that made sense to notice removal of the path, because
skip-worktree bit was not "apply --cached semantics instead of
looking at the working tree files".  In other words, it was only
about contents inside the files, and not existence of paths.

I am not offhand sure if it still makes sense; if I were being asked
to review that commit today, I suspect that I may be tempted to say
that we should ignore both contents change and presence change for
entries that have skip-worktree bit set.

> However, in preparation for fixing a bug in `git stash` where it
> pretends that skip-worktree entries have actually been removed, we need
> a mode where `git update-index` leaves all skip-worktree entries alone,
> even if the `--remove` option was passed.

We might want to make this the default eventually (is there a known
use case where the current behaviour makes sense, I wonder?), but
I agree that this is a safe thing to do at least for now.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-update-index.txt | 6 ++++++
>  builtin/update-index.c             | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Isn't this something reasonably easy to guard against regression with
a test or two?

>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 1c4d146a41..08393445e7 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	     [--chmod=(+|-)x]
>  	     [--[no-]assume-unchanged]
>  	     [--[no-]skip-worktree]
> +	     [--[no-]ignore-skip-worktree-entries]
>  	     [--[no-]fsmonitor-valid]
>  	     [--ignore-submodules]
>  	     [--[no-]split-index]
> @@ -113,6 +114,11 @@ you will need to handle the situation manually.
>  	set and unset the "skip-worktree" bit for the paths. See
>  	section "Skip-worktree bit" below for more information.
>  
> +
> +--[no-]ignore-skip-worktree-entries::
> +	Do not remove skip-worktree (AKA "index-only") entries even when
> +	the `--remove` option was specified.
> +
>  --[no-]fsmonitor-valid::
>  	When one of these flags is specified, the object name recorded
>  	for the paths are not updated. Instead, these options
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index dff2f4b837..074d563df0 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -35,6 +35,7 @@ static int verbose;
>  static int mark_valid_only;
>  static int mark_skip_worktree_only;
>  static int mark_fsmonitor_only;
> +static int ignore_skip_worktree_entries;
>  #define MARK_FLAG 1
>  #define UNMARK_FLAG 2
>  static struct strbuf mtime_dir = STRBUF_INIT;
> @@ -381,7 +382,8 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
>  		 * so updating it does not make sense.
>  		 * On the other hand, removing it from index should work
>  		 */
> -		if (allow_remove && remove_file_from_cache(path))
> +		if (!ignore_skip_worktree_entries && allow_remove &&
> +		    remove_file_from_cache(path))
>  			return error("%s: cannot remove from the index", path);
>  		return 0;
>  	}
> @@ -1013,6 +1015,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NULL,
>  			N_("clear skip-worktree bit"),
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
> +		OPT_BOOL(0, "ignore-skip-worktree-entries", &ignore_skip_worktree_entries,
> +			 N_("do not touch index-only entries")),
>  		OPT_SET_INT(0, "info-only", &info_only,
>  			N_("add to index only; do not add content to object database"), 1),
>  		OPT_SET_INT(0, "force-remove", &force_remove,
