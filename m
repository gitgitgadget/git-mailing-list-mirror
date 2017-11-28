Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A156820C11
	for <e@80x24.org>; Tue, 28 Nov 2017 03:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdK1DC1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 22:02:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64109 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751315AbdK1DC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 22:02:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02A50C14B2;
        Mon, 27 Nov 2017 22:02:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j6/8KSUT6h5TrMc7kS1X1KkRuyA=; b=SbzjAl
        YT3aZW7nBoahhXgxzfIVa2WNfyl2O+1BJFTiRKUoPyMQ9iFdHD8uyOHTiJIFVnqR
        ehKEsS6I5mkJBoOGY68BSK+gLZWbkFUDwR9APxJ5Jt9eJNFH25f7Q8UJTgMC78SL
        zYhx2UKyDbx9UFcB+j+iAPgf2g05XvDud3Dbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fI7LpWJ8uuCsKOEU5gQzVRJApBaCOqUM
        H/8KjOns2WxEt7gieAxmiHZFihi0GlQ5DfXv9PGviVRxVHVxHwwpUyywiDxQO9HD
        X0MN4DUD0cIHjVz2dxLqzFVoFuaVNCaIUT5wQRb49O0Yx1zgOy1b/5T6RyHhKQhk
        ooX61mUT3/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC90DC14B1;
        Mon, 27 Nov 2017 22:02:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D83CC14B0;
        Mon, 27 Nov 2017 22:02:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2] builtin/worktree: enhance worktree removal
References: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
        <20171127173621.6707-1-kaartic.sivaraam@gmail.com>
Date:   Tue, 28 Nov 2017 12:02:24 +0900
In-Reply-To: <20171127173621.6707-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 27 Nov 2017 23:06:21 +0530")
Message-ID: <xmqq7eub85rz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FB0034E-D3E8-11E7-878F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index b5afba164..6eab91889 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -605,6 +605,23 @@ static int move_worktree(int ac, const char **av, const char *prefix)
>  	return update_worktree_location(wt, dst.buf);
>  }
>  
> +/* Removes the .git/worktrees/worktree_id directory for
> + * the given worktree_id
> + *
> + * Returns 0 on success and non-zero value in case of failure
> + */

	/*
	 * our multi-line comment should be formatted
	 * more like this, giving slash-asterisk at the
	 * beginning and asterisk-slash at the end their
	 * own line.
	 */

There are other instances of the same in this patch, I suspect, but
because this seemed to depend on other things in 'pu' that are not
ready (if it depends on something that is stalled or abandoned, we
need to first get it unabandoned before this can even come close to
'pu'), I didn't create a topic branch for this RFC patch to view the
resulting file as a whole (this review is based only on the patch
e-mail).

> +static int remove_worktree_entry(char *worktree_id) {
> +	int ret = 0;
> +	struct strbuf we_path = STRBUF_INIT;
> +	strbuf_addstr(&we_path, git_common_path("worktrees/%s", worktree_id));
> +	if (remove_dir_recursively(&we_path, 0)) {
> +		error_errno(_("failed to delete '%s'"), we_path.buf);
> +		ret = -1;
> +	}
> +	strbuf_release(&we_path);
> +	return ret;
> +}
> +

This lifts a small section of remove_worktree() to make it usable
from other places.  But see below.

>  static int remove_worktree(int ac, const char **av, const char *prefix)
>  {
>  	int force = 0;
> @@ -634,6 +651,16 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  			die(_("already locked, reason: %s"), reason);
>  		die(_("already locked, no reason"));
>  	}
> +
> +	if (!file_exists(wt->path)) {
> +	/* There's a worktree entry but the worktree directory
> +	 * doesn't exist. So, just remove the worktree entry.
> +	 */
> +		ret = remove_worktree_entry(wt->id);
> +		free_worktrees(worktrees);
> +		return ret;
> +	}
> +
>  	if (validate_worktree(wt, 0))
>  		return -1;

I actually wonder if this "early check and return" is making the
code unmaintainable.  What if we instead did it with just the
codeflow restructuring, perhaps like so?

	if (!validate_worktree(wt, 0)) {
		/* OK, work tree is sound */
		if (!force) {
			/* protect from information lossage */
		}
		/* do the actual worktree removal */
	}
	/* remove the control info */

There is no need for a new helper function when done that way, which
allows us not to worry about two clean-up places drifting apart over
time.  With this patch, we have two 3-line blocks that call
remove_worktree_entry(wt->id), free_worktrees(worktrees) and returns
ret, and these happen to be identical, but the next person who would
be mucking with the code (perhaps adding more variables that need to
be reset in this codeflow) can easily miss one of these two places.

The resulting code would make the body of "if (!force)" block too
deeply nested, I suspect, but that is an indication that that part
is overlong and overly complex in the context of this function, and
can and should migrate to its own helper function.

Hmm?

> @@ -670,13 +697,7 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  		error_errno(_("failed to delete '%s'"), sb.buf);
>  		ret = -1;
>  	}
> -	strbuf_reset(&sb);
> -	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
> -	if (remove_dir_recursively(&sb, 0)) {
> -		error_errno(_("failed to delete '%s'"), sb.buf);
> -		ret = -1;
> -	}
> -	strbuf_release(&sb);
> +	ret = remove_worktree_entry(wt->id);
>  	free_worktrees(worktrees);
>  	return ret;
>  }
