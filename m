Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C3C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F29DB2083B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 21:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VIfXn5CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgI1ViF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:38:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58462 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgI1ViE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 17:38:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F2FFF08DA;
        Mon, 28 Sep 2020 17:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bhopyQt2HAk20RKAQ1gEU+2B3/g=; b=VIfXn5
        CIAYmhVEIdDQBQ6WM0nVVs0XJWQWnNTt0O6df5rEm4tdwKCtlDtjAg0SQOSciLgS
        qYtxKTC0Vdb689S2eJhg/OOmF6laF5u0LC4lFTV1XRedBv36IdsGUNpru/tUEKZZ
        rb0ddtiMB4fbeEVdJDRpPz+PVcbuUhpZ3ObEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNvXEu1rwd9dSmy7+7czdpg0nHpaP1YB
        WLjkirCirTNMB90aP1yUa9hozQRnGBKP5ok7IT7KKqCNgfW1qWjCb+jcaS6kYQHr
        cTLvYjXtm7KKrmbnXki2Q9P5zBYfQLFBE0II8yseSuzuFsX4jIQ/ZZhu/xNAteaz
        In7sERywFyM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 08318F08D9;
        Mon, 28 Sep 2020 17:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D538F08D8;
        Mon, 28 Sep 2020 17:37:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] worktree: teach `list` to mark locked worktree
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
        <20200928154953.30396-2-rafaeloliveira.cs@gmail.com>
Date:   Mon, 28 Sep 2020 14:37:54 -0700
In-Reply-To: <20200928154953.30396-2-rafaeloliveira.cs@gmail.com> (Rafael
        Silva's message of "Mon, 28 Sep 2020 15:49:52 +0000")
Message-ID: <xmqq8sctlgzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF055CBC-01D2-11EB-9B2D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Silva <rafaeloliveira.cs@gmail.com> writes:

> The output of `worktree list` command is extended to mark a locked
> worktree with `(locked)` text. This is used to communicate to the
> user that a linked worktree is locked instead of learning only when
> attempting to remove it.
>
> This is the output of the worktree list with locked marker:
>
>   $ git worktree list
>   /repo/to/main                abc123 [master]
>   /path/to/unlocked-worktree1  456def [brancha]
>   /path/to/locked-worktree     123abc (detached HEAD) (locked)


In our log message, we tend NOT to say "This commit does X" or "X is
done", because such a statement is often insufficient to illustrate
if the commit indeed does X, and explain why it is a good thing to
do X in the first place.

Instead, we 

 - first explain that the current system does not do X (in present
   tense, so we do NOT say "previously we did not do X"), then

 - explain why doing X would be a good thing, and finally

 - give an order to the codebase to start doing X.


For this change, it might look like this:

    The "git worktree list" shows the absolute path to the working
    tree, the commit that is checked out and the name of the branch.
    It is not immediately obvious which of the worktrees, if any,
    are locked.

    "git worktree remove" refuses to remove a locked worktree with
    an error message.  If "git worktree list" told which worktrees
    are locked in its output, the user would not even attempt to
    remove such a worktree.

    Teach "git worktree list" to append "(locked)" to its output.
    The output from the command becomes like so:

          $ git worktree list
          /repo/to/main                abc123 [master]
          /path/to/unlocked-worktree1  456def [brancha]
          /path/to/locked-worktree     123abc (detached HEAD) (locked)



> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 32e8440cde..a3781dd664 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -96,8 +96,9 @@ list::
>  
>  List details of each working tree.  The main working tree is listed first,
>  followed by each of the linked working trees.  The output details include
> -whether the working tree is bare, the revision currently checked out, and the
> -branch currently checked out (or "detached HEAD" if none).
> +whether the working tree is bare, the revision currently checked out, the
> +branch currently checked out (or "detached HEAD" if none), and whether
> +the worktree is locked.

At the first glance, the above gave me an impression that you'd be
adding "(unlocked)" or "(locked)" for each working tree, but that is
not the case.  How about keeping the original sentence intact, and
adding something like "For a locked worktree, the marker (locked) is
also shown at the end"?

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 99abaeec6c..8ad2cdd2f9 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -676,8 +676,12 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
>  		} else
>  			strbuf_addstr(&sb, "(error)");
>  	}
> -	printf("%s\n", sb.buf);
>  
> +	if (!is_main_worktree(wt) &&
> +	    worktree_lock_reason(wt))
> +		strbuf_addstr(&sb, " (locked)");

Is this because for the primary worktree, worktree_lock_reason()
will always yield true?

    ... goes and looks ...

Ah, OK, the callers are not even allowed to ask the question on the
primary one.  That's a bit strange API but OK.

Writing that on a single line would perfectly be readable, by the
way.

	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
		strbuf_addstr(&sb, " (locked)");

> +	printf("%s\n", sb.buf);
>  	strbuf_release(&sb);
>  }
