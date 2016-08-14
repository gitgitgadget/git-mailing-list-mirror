Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C00C1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 22:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbcHNWUm (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 18:20:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751015AbcHNWUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 18:20:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4863F33DBB;
	Sun, 14 Aug 2016 18:20:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PofHKMdm5hpFN+TTKoKuRhzxQP4=; b=MoZb5N
	fVp2oBxnJE1fBEiX2MEUhZ2NC7O4wpHMVdknUu2eLyh+G632DyAA5a1QHRn4KtjL
	3RnoqPe/zTJK6fqYJThjTb/QAjYsghtQ7sL9i11JYQEbAmfHxAp9aToZMGKIF01i
	LEWOFyvCHUAnH6UZruETG5T5elcE/0aKIwl7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vLB2c4X1tubyeIZxHtJ1f+0Hms/nd2HE
	64aAplts4SXjcjyETWrBA5WCtyubcpa/WdN81rDu59+Oc0aQO1uTedk4O0szsZnv
	mQWMZvQg5R+mKgSuEprX7y5Q0X8AI830yjH+Slr+UFygF9ZmjAduoS8TvyVMGGne
	/5SZVunLoWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4048133DBA;
	Sun, 14 Aug 2016 18:20:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C13C33DB9;
	Sun, 14 Aug 2016 18:20:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] doc: rebase: clarify fixup! fixup! constraint
References: <20160814214630.1312-1-philipoakley@iee.org>
	<20160814214630.1312-4-philipoakley@iee.org>
Date:	Sun, 14 Aug 2016 15:20:36 -0700
In-Reply-To: <20160814214630.1312-4-philipoakley@iee.org> (Philip Oakley's
	message of "Sun, 14 Aug 2016 22:46:30 +0100")
Message-ID: <xmqqvaz3j8ln.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54E372AC-626D-11E6-9BC7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> 22c5b13 (rebase -i: handle fixup! fixup! in --autosquash, 2013-06-27)

That's a noun that names a commit object.  What about it?

> I certainly misunderstood what this meant. It sounded like only one fixup! was
> allowed per commit (i.e. one mistake) - fixing two mistakes wouldn't be
> allowed. Hindsight is a wonderful thing.

I think this is about

	git commit -m foo
	... some other commits
        git commit -m 'fixup! foo'
	... even more other commits
        git commit -m 'fixup! fixup! foo'

The last one is technically a fixup of the second one, but as long
as the second one is to be applied _and_ the last one comes after
the second one, we could say that both of them are fix-ups for the
very first one.  And that is what the original text says.

I have a feeling that if the editor session to edit the todo drops
the second one and leaves this:

	pick foo
        fixup fixup! fixup! foo

the command _should_ notice that the second one that is required to
apply the last one is gone and error out, but probably the code does
not do so, and if that is the case, I think "they fix the very first
commit that invited these fixups" is a more reasonable description
than the more technically stringent "fixup! fixup! is to fix what
the fixup! did", which is not what the code implements.

> Also, does 'earliest commit requiring fixup/squash' fully convey that
> its the one to fix.

I cannot tell if that a question or a statement?

> ---
>  Documentation/git-rebase.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 66b789a..91eb107 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -425,9 +425,9 @@ without an explicit `--interactive`.
>  	automatically modify the todo list of rebase -i
>  	so that the commit marked for squashing comes right after the
>  	commit to be modified, and change the action of the moved
> -	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
> -	"fixup! " or "squash! " after the first, in case you referred to an
> -	earlier fixup/squash with `git commit --fixup/--squash`.
> +	commit from `pick` to `squash` (or `fixup`).  Commits with repeated
> +	"fixup! " or "squash! " in the subject line are considered to refer
> +	to the earliest commit requiring fixup/squash.
>  +
>  This option is only valid when the '--interactive' option is used.
>  +
