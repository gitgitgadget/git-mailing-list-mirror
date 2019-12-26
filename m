Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E8C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A842080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="omZj4Lbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfLZS5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:57:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53870 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZS47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 13:56:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFCF138496;
        Thu, 26 Dec 2019 13:56:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5CL3mNOfmZxWsfwjkWWMPZ5dLuE=; b=omZj4L
        bkigXFdsVL1G5hdHfKNAJXuBY1lGxWtFW0HRqEcJeif2cMWTrS/kxWTskhW/l167
        nP4tmxEZb25q3lKhTGRTs2wgddX0p+3kcaM83JyBhAl9OKE3IP8/86i69euny3cH
        aOw3QWUbhO0KJo/J4N63SJhlOuRpctwzRuonM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PmLt7iwqCzGFYIFuIO2nAg+kOY6jvfIu
        7B307vrxYK9xvCPt/Q6N1EXCDXt0U3XlJmvga0fFEcbBUc9MZRKqMGG3h2qR/E1u
        Z0cf4W/IPd4/ceBRH4domdjZJGczOeot2uoVC0pUqzA4M6srVG5W+PNhzcfqPNlJ
        RZoe5X5xe2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C88C038495;
        Thu, 26 Dec 2019 13:56:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 399EA38492;
        Thu, 26 Dec 2019 13:56:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not tree entries
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
        <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 10:56:56 -0800
In-Reply-To: <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 26 Dec 2019
        17:42:31 +0000")
Message-ID: <xmqqr20qlxtz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D738FF0-2811-11EA-B86D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> During a clone of a repository that contained a file with a backslash in
> its name in the past, as of v2.24.1(2), Git for Windows prints errors
> like this:
>
> 	error: filename in tree entry contains backslash: '\'
>
> While the clone still succeeds, a similar error prevents the equivalent
> `git fetch` operation, which is inconsistent.

Yes, inconsistent is bad and it is puzzling.  I would have expected,
if this gate on the transport layer is desirable, such a check would
be implemented as a part of transfer.fsckObjects and covered equally
by fetch and clone codepaths.  What went wrong to allow "clone" to
go through while stopping "fetch"?  Can you describe the root cause
of the difference in the log message?

> Arguably, this is the wrong layer for that error, anyway: As long as the
> user never checks out the files whose names contain backslashes, there
> should not be any problem in the first place.

I do agree that rejecting these tree objects that has a slash in its
path component is probably wrong.  A GIT_WINDOWS_NATIVE box should
be able to host a bare repository on it, and users on machines that
are OK with paths that Windows may not like should be able to
interact with it, by pushing to it, fetching from it, and updating
the repository on that Windows box by going there and fetching from
elsewhere.  Rejecting these names at the object validity level means
Git on Windows would be incompatible with Git elsewhere.

And It hink the same logic apply to those names like prn, con, nul,
etc.  How are the users protected from them?  We should prevent
these names from entering the index the same way, shouldn't we?

> So let's instead prevent such files to be added to the index.

... and loosen the check that (incorrectly) gets triggered from what
codepaths in "git fetch" (but not from "git clone")?

> This addresses https://github.com/git-for-windows/git/issues/2435
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  read-cache.c               | 5 +++++
>  t/t7415-submodule-names.sh | 7 ++++---
>  tree-walk.c                | 6 ------
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index ad0b48c84d..737916ebd9 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1278,6 +1278,11 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>  	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
>  	int new_only = option & ADD_CACHE_NEW_ONLY;
>  
> +#ifdef GIT_WINDOWS_NATIVE
> +	if (protect_ntfs && strchr(ce->name, '\\'))

As I wondered above, names that must not enter the index may not be
limited to those with backslashes in them.  Perhaps you'd want a
separate helper function so that you can extend the logic more
easily, i.e.

	if (protect_ntfs && invalid_name_on_windows(ce->name))

or something like that.

> diff --git a/tree-walk.c b/tree-walk.c
> index b3d162051f..d5a8e096a6 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -43,12 +43,6 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
>  		strbuf_addstr(err, _("empty filename in tree entry"));
>  		return -1;
>  	}
> -#ifdef GIT_WINDOWS_NATIVE
> -	if (protect_ntfs && strchr(path, '\\')) {
> -		strbuf_addf(err, _("filename in tree entry contains backslash: '%s'"), path);
> -		return -1;
> -	}
> -#endif
>  	len = strlen(path) + 1;
>  
>  	/* Initialize the descriptor entry */
