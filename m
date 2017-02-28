Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18280202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdB1Wcs (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:32:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34879 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbdB1Wcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:32:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so3240864pgz.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 14:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1pcETnMGnB7V9PEvtWn+HsTSsO5wjU8jNls0tIBkgUA=;
        b=JDBi8vYgIjOcnVkrJaP+/Y56JnREJNkcLojgK/Xj6cgedaDyhk4LYYiM7ruA1VmwXE
         4gajAFTMDGZuwUWO+ZAFSIT0yLTKx8INok/rMhHdyJSOH2HnXAeLlyXor/cinDHdRB6y
         XkjSlNaLuqjOwAxbjJGmdlxsWNWmvN2SUV8/cfi8J/y/7X21wF+dCmFECsFdExINn4ZX
         9QyqXQXRTIjnx9sERL16pAug7UlyQ52+w0p2GzIurLt8M3WkyM9e49/nNKDQ8aXmKRfy
         BuKphpeDEWnZxaSFSO1jn+aWUDAcaFIkVDEab3TlrF20XyzTbOxI+zjs/ve7gjEo2sFg
         eYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1pcETnMGnB7V9PEvtWn+HsTSsO5wjU8jNls0tIBkgUA=;
        b=Ni7R/3TbJu5qHrq5oHMxoqr0Bs0V1XlVhdT5vQnj9DyA421iw134kbfXe7K5I9d6RA
         UOF9ZGzu53e3aKNKkdOda2Z8GIFROYDYpSYvoA0bh8zkgTc5QUnECgYTEzCaFzMkR6yN
         UJS5yg/U0QtKmOuvzFZLhASUyRTgwT71ukhBD1/QzLNvISRJ1pdRL/hmYm7V156JI4JN
         6j1NLaBGqwpGqNNsCELnSNGmr4LrXCYoMGU5YNcNeu9aHo6VL2NtNkr320rkiP+SwD5G
         55UFjbd/E5+qZTLXDKxBFOt0RUdnMlMhZWAuVfTRDRcmAxE3cz+9ZgpenRdyWEk5V3EE
         q2Ww==
X-Gm-Message-State: AMke39ke777Dyy3bbjc8fJaMYqEo16MyXYAdItKSsakPbngK1/OzZOs0MSvjqmED8j0Upw==
X-Received: by 10.98.102.129 with SMTP id s1mr4580787pfj.26.1488313667000;
        Tue, 28 Feb 2017 12:27:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id q7sm5867863pfb.98.2017.02.28.12.27.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 12:27:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/8] interpret_branch_name: allow callers to restrict expansions
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
        <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net>
Date:   Tue, 28 Feb 2017 12:27:45 -0800
In-Reply-To: <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Feb 2017 07:14:35 -0500")
Message-ID: <xmqqr32ijc1q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The original purpose of interpret_branch_name() was to be used by
> get_sha1() in resolving refs.  As such, some of its expansions may
> point to refs outside of the local "refs/heads" namespace.

I am not sure the reference to "get_sha1()" is entirely correct.

Until it was renamed at 431b1969fc ("Rename interpret/substitute
nth_last_branch functions", 2009-03-21), the function was called
interpret_nth_last_branch() which was originally introduced for the
name, not sha1, at ae5a6c3684 ("checkout: implement "@{-N}" shortcut
name for N-th last branch", 2009-01-17).  The use of the same syntax
and function for the object name came a bit later.

But I think that is an insignificant detail.  Let's read on.

> Over time, the function has been picked up by other callers
> who want to use the ref-expansion to give the user access to
> the same shortcuts (e.g., allowing "git branch" to delete
> via "@{-1}" or "@{upstream}").  These uses have confusing
> corner cases when the expansion isn't in refs/heads/ (for
> instance, deleting "@" tries to delete refs/heads/HEAD,
> which is nonsense).
>
> Callers can't know from the returned string how the
> expansion happened (e.g., did the user really ask for a
> branch named "HEAD", or did we do a bogus expansion?). One
> fix would be to return some out-parameters describing the
> types of expansion that occurred. This has the benefit that
> the caller can generate precise error messages ("I
> understood @{upstream} to mean origin/master, but that is a
> remote tracking branch, so you cannot create it as a local
> name").
>
> However, out-parameters make calling interface somewhat
> cumbersome. Instead, let's do the opposite: let the caller
> tell us which elements to expand. That's easier to pass in,
> and none of the callers give more precise error messages
> than "@{upstream} isn't a valid branch name" anyway (which
> should be sufficient).
>
> The strbuf_branchname() function needs a similar parameter,
> as most of the callers access interpret_branch_name()
> through it. For now, we'll pass "0" for "no restrictions" in
> each caller, and update them individually in subsequent
> patches.

OK.

> diff --git a/cache.h b/cache.h
> index c67995caa..a8816c914 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1383,8 +1383,17 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
>   *
>   * If the input was ok but there are not N branch switches in the
>   * reflog, it returns 0.
> - */
> -extern int interpret_branch_name(const char *str, int len, struct strbuf *);
> + *
> + * If "allowed" is non-zero, it is a treated as a bitfield of allowable
> + * expansions: local branches ("refs/heads/"), remote branches
> + * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
> + * allowed, even ones to refs outside of those namespaces.
> + */

Answering the question in your follow-up, I personally do not find
"0 means anything goes" too confusing, but for satisfying those who
do, spelling ~0 is not too bad, either.

> +#define INTERPRET_BRANCH_LOCAL (1<<0)
> +#define INTERPRET_BRANCH_REMOTE (1<<1)
> +#define INTERPRET_BRANCH_HEAD (1<<2)
> +extern int interpret_branch_name(const char *str, int len, struct strbuf *,
> +				 unsigned allowed);
>  extern int get_oid_mb(const char *str, struct object_id *oid);

> diff --git a/refs.c b/refs.c
> index 6d0961921..da62119c2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -405,7 +405,7 @@ int refname_match(const char *abbrev_name, const char *full_name)
>  static char *substitute_branch_name(const char **string, int *len)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> -	int ret = interpret_branch_name(*string, *len, &buf);
> +	int ret = interpret_branch_name(*string, *len, &buf, 0);
>  
>  	if (ret == *len) {
>  		size_t size;

This is the one used by dwim_ref/log, so we'd need to allow it to
resolve to anything, e.g. "@" -> "HEAD", and pretend that the user
typed that expansion.  OK.
