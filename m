From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git log -p -m: Document, honor --first-parent
Date: Tue, 09 Feb 2010 17:30:29 -0800
Message-ID: <7vpr4dop1m.fsf@alter.siamese.dyndns.org>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
 <20100209235707.GQ9553@machine.or.cz>
 <7v1vguuf8h.fsf@alter.siamese.dyndns.org>
 <20100210011149.GR9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>,
	git list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 10 02:30:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf1Pi-0007VD-2t
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 02:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab0BJBan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 20:30:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094Ab0BJBam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 20:30:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C704498C31;
	Tue,  9 Feb 2010 20:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E5NISFiwnQIv/sm9hUJCq3UR9Oc=; b=byrbGE
	UScE8flDrGBSUe/BKAat1D0LPMi3ukHx8kEOUM3ZbwKf9VqKQduQeA+WGIATfdIw
	3yK+tagB6nEYLF94GeqMZNGeFjfIuprn+gZgpFINOjEMyT8ryCp6nOvuwO95D3Qq
	A+OXKn3oj77KBk0mvJEbgZJyXlFStHwOv5lkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=au6YgQjVS5I9jmX5e1jwM8DhU5Wk8uDw
	WPBfvNgX70SDz1FO4/x+OOEvDSqZE8KTkzD+7TriMyI1ZxNLVE99unFuC8wwUeSP
	EScjj+oEmG27RYZlfS65WqbYwSfrMQVFQBfphe2yHJBgEPSdhef3BNWJVUwD+UqP
	8/1tZTEsOao=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 911AB98C2C;
	Tue,  9 Feb 2010 20:30:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8546998C2B; Tue,  9 Feb
 2010 20:30:31 -0500 (EST)
In-Reply-To: <20100210011149.GR9553@machine.or.cz> (Petr Baudis's message of
 "Wed\, 10 Feb 2010 02\:11\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E30FF40C-15E3-11DF-AA24-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139470>

Petr Baudis <pasky@suse.cz> writes:

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 0e39bb6..a2a2d04 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -118,6 +118,15 @@ git log master --not --remotes=*/master::
>  	Shows all commits that are in local master but not in any remote
>  	repository master branches.
>  
> +git log -p -m --first-parent::
> +
> +	Shows the history including change diffs, but only from the
> +	"main branch" perspective, skipping commits that come only from
> +	merges, and showing full diffs of changes introduced by the merges.
> +	This makes sense only when following a strict policy of merging all
> +	topic branches when staying on a single integration branch and
> +	making sure the merges are not fast-forwards.

I think the tone of the last three lines is too strong.

Why is it necessary to make a merge with a single commit side branch when
fast-forward would do?  And if the side branch is actually two or more
commits, it will show the broken-down changes in more detail, but the fact
that it was made on the "primary" history would also have some
significance (e.g. trivial and obvious fixes made directly on 'master',
other branches merged from topic after cooking).

It is Ok to elaborate on the "policy" issues in the Discussion section,
but otherwise, I would rather see you spend the same number of lines to
clarify "showing full diffs of changes introduced by the merges" a bit
better (e.g. it is unclear if you are showing diff from each parents or
just from the first parent).  Perhaps "s/introduced /& to the first-parent
ancestry /" may suffice.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 6e9baf8..d7d0dee 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -108,8 +108,8 @@ options may be given. See linkgit:git-diff-files[1] for more options.
>  
>  -c::
>  
> -	This flag changes the way a merge commit is displayed.  It shows
> -	the differences from each of the parents to the merge result
> +	This flag forces the default way a merge commit is displayed.  It
> +	shows the differences from each of the parents to the merge result
>  	simultaneously instead of showing pairwise diff between a parent

Sorry, I don't understand this change; "forces the default?"  Any option
"forces" the command to behave differently.  At least the original is
understandable "Ah, without it it shows one way but with this it shows in
a different way", even though that does not carry much useful information
(i.e. what are the two ways?  ah, I need to read further down).

> diff --git a/log-tree.c b/log-tree.c
> index 27afcf6..fb990a1 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -514,6 +514,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>  			return 0;
>  		else if (opt->combine_merges)
>  			return do_diff_combined(opt, commit);
> +		else if (opt->first_parent_only) {
> +			/* Generate merge log entry only for the first
> +			 * parent, showing summary diff of the others
> +			 * we merged _in_. */

Style?

Don't we use --cc as default for "show" (and possibly "log"---I don't
remember the details)?

> +			diff_tree_sha1(parents->item->object.sha1, sha1, "", &opt->diffopt);
> +			log_tree_diff_flush(opt);
> +			return !opt->loginfo;
> +		}

This needs some tests but I think it is a good first step in the right
direction.

Thanks.
