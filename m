Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3504E2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 21:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdBWVRz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 16:17:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35035 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdBWVRw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 16:17:52 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so354255pgz.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 13:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PfWz5/yAuHAck5b9Lr//wUWigBkkm7ZNmLqjhlG4ebo=;
        b=m0s1Jw1oloCPLn3ecbVy1YoEQkdU/+wW2BaJb8G0Xe4rnUdf7cjAS1OYZxXSNpSVZA
         ZWjcsIe+9/szz8364OdKajhmUHmumP9vQawjl4KSQGwJWw9KJcfvME7cWG0DFxGmFB7e
         Ooxb/TyJd0Xu3K9GvrqEI3OXuWVPfC6fsFa2K2um9Xf2Y6J34Q73Ecab7vffX8V/OBHo
         dLwN5aoOWj838+sTI9Xkgbq6fXbQ2jlInp9bGlSsv8isL2jHAaAjoR9V6pdKGKimrX0M
         XO1pm2+jiAQcCFwHHl8hI0WDvug5JfIzT9kRnqcNuMrSxXsRXE+rNAHscEcpacKF16In
         CTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PfWz5/yAuHAck5b9Lr//wUWigBkkm7ZNmLqjhlG4ebo=;
        b=tk3L2WiGvMYznngBlBepkT/vM/SSUKAPJsxA+AXRo8njR+uPCafumYotO0+Gu6bAfd
         4ZqBCBR4SeNl087GZGSj0Veqbn56AFFF2bqQs0cQJX87XBzc2UyZcx1W4xKzpHyp55Tu
         5WjvzWle5kYKNYPaT68v1TkVVK8KKxPGba/7AiLIBreKUUKxUhjjtkbEIiOter/iZaQo
         NCuYFHii6UYGbgLo4sFTnk7lV/jgqL/v16x0DMpBYoGfGJWbCJyhpLD2PS0NlJoMzjAF
         0vj0dJht0cdMwQXxioxMB0Leia5UcFZBt2LuxKHIFchqIGorSdmPIkgadBuU23OPjNtT
         genQ==
X-Gm-Message-State: AMke39nb+5fMbc5F8XpAAZCONw6ZONIGHKT6Zpy/j+zZ2doIHu9nGvjfN9xslbtBqFOfLQ==
X-Received: by 10.99.113.92 with SMTP id b28mr15390933pgn.180.1487884671038;
        Thu, 23 Feb 2017 13:17:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id a2sm11428977pfc.72.2017.02.23.13.17.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 13:17:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>,
        Pierre Habouzit <madcoder@debian.org>
Cc:     git@vger.kernel.org, "Devin J. Pohly" <djpohly@gmail.com>
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless commits
References: <20170223082736.31283-1-djpohly@gmail.com>
        <20170223082736.31283-3-djpohly@gmail.com>
Date:   Thu, 23 Feb 2017 13:17:49 -0800
In-Reply-To: <20170223082736.31283-3-djpohly@gmail.com> (Devin J. Pohly's
        message of "Thu, 23 Feb 2017 02:27:35 -0600")
Message-ID: <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Devin J. Pohly" <djpohly@gmail.com> writes:

> Previously, the git_commit_non_empty_tree function would always pass any
> commit with no parents to git-commit-tree, regardless of whether the
> tree was nonempty.  The new commit would then be recorded in the
> filter-branch revision map, and subsequent commits which leave the tree
> untouched would be correctly filtered.
>
> With this change, parentless commits with an empty tree are correctly
> pruned, and an empty file is recorded in the revision map, signifying
> that it was rewritten to "no commits."  This works naturally with the
> parent mapping for subsequent commits.
>
> Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
> ---

I am not sure if a root that records an empty tree should be pruned
with --prune-empty to begin with.

When we are pruning consecutive commits in the other parts of the
history because they have identical (presumably non-empty) trees,
should an empty root that the original history wanted to create be
pruned because before the commit it was void, after the commit it is
empty?  Should "void" (lack of any tree) and "empty" (the tree is
there, but it does not have anything in it) be treated the same?
Shouldn't root be treated as a bit more special thing?

I myself do not have a good answer to the above questions.

I think the updated code makes sense, provided if we decide that
void to empty is just like transitioning between two identical
(presumably non-empty) trees.  The updated documentation is a lot
more readable as well.

Comments from those who have been involved in filter-branch?

>  Documentation/git-filter-branch.txt | 14 ++++++--------
>  git-filter-branch.sh                |  2 ++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 0a09698c0..6e4bb0220 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -167,14 +167,12 @@ to other tags will be rewritten to point to the underlying commit.
>  	project root. Implies <<Remap_to_ancestor>>.
>  
>  --prune-empty::
> -	Some kind of filters will generate empty commits, that left the tree
> -	untouched.  This switch allow git-filter-branch to ignore such
> -	commits.  Though, this switch only applies for commits that have one
> -	and only one parent, it will hence keep merges points. Also, this
> -	option is not compatible with the use of `--commit-filter`. Though you
> -	just need to use the function 'git_commit_non_empty_tree "$@"' instead
> -	of the `git commit-tree "$@"` idiom in your commit filter to make that
> -	happen.
> +	Some filters will generate empty commits that leave the tree untouched.
> +	This option instructs git-filter-branch to remove such commits if they
> +	have exactly one or zero non-pruned parents; merge commits will
> +	therefore remain intact.  This option cannot be used together with
> +	`--commit-filter`, though the same effect can be achieved by using the
> +	provided `git_commit_non_empty_tree` function in a commit filter.
>  
>  --original <namespace>::
>  	Use this option to set the namespace where the original commits
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 86b2ff1e0..2b8cdba15 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -46,6 +46,8 @@ git_commit_non_empty_tree()
>  {
>  	if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}"); then
>  		map "$3"
> +	elif test $# = 1 && test "$1" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904; then
> +		:
>  	else
>  		git commit-tree "$@"
>  	fi
