Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296DC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090A221835
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vJUCAJGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgAUTge (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:36:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58413 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 14:36:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D893AA2871;
        Tue, 21 Jan 2020 14:36:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NjjykgGEA2vRAiXyiQGYvrWYQkg=; b=vJUCAJ
        GtDWAP5X6S41enJCSAxsSiVWFKAvl5BG7XO5m5y40GyjAJ7vmJdsPSUgCUkXHyun
        MGhFNXZGtm763wkJxRw2GblzwPC7YYjNst9qB1uVTUAoJgD0EvkYA1D8/tz2XMqr
        Zu5KkeqcC4PtkSN3uG3uuuEuzIRDtcBCipaSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PZ2Qf2/hFgHD5mnqZJLuRzbUCICG9Zlp
        rU2x4uEqn/ZuvXwMaKQwLvJbIxDsgfN0S4U4J398b8qxSh4KZsGttiJkR+tZzA2u
        cFKNFAtj6ut4rE0HLpxQEYlq7cQTa82jU74D/7iGxIFJN1gRbhCx4esKvDH0FcgI
        6COMn5E5dUw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0815A2870;
        Tue, 21 Jan 2020 14:36:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F3CB6A286F;
        Tue, 21 Jan 2020 14:36:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 2/8] rm: support the --pathspec-from-file option
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <5611e3ae326bb7f61abf870e3b2851226b6af1d8.1579190965.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 11:36:26 -0800
In-Reply-To: <5611e3ae326bb7f61abf870e3b2851226b6af1d8.1579190965.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 16 Jan 2020
        16:09:19 +0000")
Message-ID: <xmqqftg8a9fp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51DF7D80-3C85-11EA-A8B8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> Decisions taken for simplicity:
> 1) It is not allowed to pass pathspec in both args and file.
>
> `if (!argc)` block was adapted to work with --pathspec-from-file. For
> that, I also had to parse pathspec earlier. Now it happens before
> `read_cache()` / `hold_locked_index()` / `setup_work_tree()`, which
> sounds fine to me.

That is not an explanation nor justification.

> In case of empty pathspec, there is now a clear error message instead
> of showing usage.

Hmph, "git rm --pathspec-from-file=/dev/null" would say "nothing
specified, nothing removed" and it makes perfect sense, but I am not
sure "git rm" that gives the same message is better than the output
by usage_with_options(builtin_rm_usage, builtin_rm_options).

> -'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <pathspec>...
> +'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
> +	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> +	  [--] [<pathspec>...]

OK.

> +--pathspec-from-file=<file>::
> +	Pathspec is passed in `<file>` instead of commandline args. If
> +	`<file>` is exactly `-` then standard input is used. Pathspec
> +	elements are separated by LF or CR/LF. Pathspec elements can be
> +	quoted as explained for the configuration variable `core.quotePath`
> +	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
> +	global `--literal-pathspecs`.
> +
> +--pathspec-file-nul::
> +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
> +	separated with NUL character and all other characters are taken
> +	literally (including newlines and quotes).
> +

OK.

> diff --git a/builtin/rm.c b/builtin/rm.c
> index 19ce95a901..8e40795751 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -235,7 +235,8 @@ static int check_local_mod(struct object_id *head, int index_only)
>  }
>  
>  static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
> -static int ignore_unmatch = 0;
> +static int ignore_unmatch = 0, pathspec_file_nul = 0;
> +static char *pathspec_from_file = NULL;

We may want to clean these "explicitly initialize to 0/NULL" up at
some point.  The clean-up itself would not be in the scope of this
patch, of course, but not making it worse is something this patch
can do to help.

> @@ -259,8 +262,24 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, builtin_rm_options,
>  			     builtin_rm_usage, 0);
> -	if (!argc)
> -		usage_with_options(builtin_rm_usage, builtin_rm_options);
> +
> +	parse_pathspec(&pathspec, 0,
> +		       PATHSPEC_PREFER_CWD,
> +		       prefix, argv);
> +
> +	if (pathspec_from_file) {
> +		if (pathspec.nr)
> +			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
> +
> +		parse_pathspec_file(&pathspec, 0,
> +				    PATHSPEC_PREFER_CWD,
> +				    prefix, pathspec_from_file, pathspec_file_nul);
> +	} else if (pathspec_file_nul) {
> +		die(_("--pathspec-file-nul requires --pathspec-from-file"));
> +	}
> +
> +	if (!pathspec.nr)
> +		die(_("Nothing specified, nothing removed"));

I wonder if doing these in this order instead would make more sense
without making unnecessary behaviour change.

    - parse the options (which would make pathspec_f_f available to
      us)

    - if pathspec_f_f is given, call parse_pathspec_file()

    - otherwise complain if pathspec_file_nul is set

    - otherwise check argc and give the usage_with_options()

I dunno.

Thanks.
