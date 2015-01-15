From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit/status: show the index-worktree with -v -v
Date: Thu, 15 Jan 2015 12:11:15 -0800
Message-ID: <xmqq1tmv7qjg.fsf@gitster.dls.corp.google.com>
References: <xmqq387db6xy.fsf@gitster.dls.corp.google.com>
	<038e08973a5872ea13a0ea76bf2a0443fe3c3b50.1421337740.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:11:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBqlH-0003f9-6R
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 21:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbbAOULS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 15:11:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755403AbbAOULR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 15:11:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5E522F34D;
	Thu, 15 Jan 2015 15:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kolUVg5ZIZMSFO15ZKi1yjERS10=; b=stK9Zc
	jb7dojYyfPqRVpFG0goqiP/yCXFE+nFH65BrA07ieBe/UrQo3HTd+KGt5qHa4FbS
	GS36nq7jYxlU87vZZUqsRlwi6ETlpzvOBSVPLgq+ERkeODR2ORtAQe3SBZWPxD1N
	mfyZUdrIbem0HLB42nJP87rX/QbQjJipDY4s0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fF8IxX0TJq7DnWmwXic89SOmfudlBH70
	eW/1kTy9RMvH58AM126Xx5yzHghqFlQh9HKqGydSNUkfCwGwfv6P236H9Us91YKd
	QwBk2T2JSylfgEASSz/JZf+3+cVm0fo8fMteFxhi2jhEZ3DVHCwT+qdkk9k+nEv7
	lGnDXsW3MSo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABDF12F34B;
	Thu, 15 Jan 2015 15:11:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30E1C2F34A;
	Thu, 15 Jan 2015 15:11:16 -0500 (EST)
In-Reply-To: <038e08973a5872ea13a0ea76bf2a0443fe3c3b50.1421337740.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 15 Jan 2015 17:08:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A92A62B8-9CF2-11E4-B4F6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262506>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git commit and git status in long format show the diff between HEAD
> and the index when given -v. This allows previewing a commit to be made.
>
> They also list tracked files with unstaged changes, but without a diff.
>
> Introduce '-v -v' which shows the diff between the index and the
> worktree in addition to HEAD index diff. This allows to review unstaged
> changes which might be missing from the commit.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Also, the git status man page does not mention -v at all, and the doc
> for git status (long format) and the status parts of the git commit
> man page should really be the same.
>
> In any case, this may have helped the OP with his amend oversight.

Hmm, does this show what change relative to HEAD is committed fully
and then after that show what change relative to the index being
commited remains in the working tree at the end?  

I do not think that output order is very helpful.  Two diffs to the
same file next to each other may make it easier to notice, though.
That is, not like this:

	diff --git a/A b/A
        ...
        diff --git a/B b/B
        ...
        diff --git i/A w/A
        ...

but like this:

	diff --git a/A b/A
        ...
        diff --git i/A w/A
        ...
        diff --git a/B b/B
        ...

or it may want to even be like this:

	diff --git a/A b/A
        ...
        diff --git to-be-committed/A left-out-of-the-commit/A
        ...
        diff --git a/B b/B
        ...

by using a custom, unusual and easy-to-notice prefixes.

>  Documentation/git-commit.txt | 4 ++++
>  wt-status.c                  | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 1e74b75..f14d2ec 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -284,6 +284,10 @@ configuration variable documented in linkgit:git-config[1].
>  	would be committed at the bottom of the commit message
>  	template.  Note that this diff output doesn't have its
>  	lines prefixed with '#'.
> ++
> +If specified twice, show in addition the unified diff between
> +what would be committed and the worktree files, i.e. the unstaged
> +changes to tracked files.
>  
>  -q::
>  --quiet::
> diff --git a/wt-status.c b/wt-status.c
> index b54eac5..75674c2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -874,6 +874,14 @@ static void wt_status_print_verbose(struct wt_status *s)
>  		wt_status_add_cut_line(s->fp);
>  	}
>  	run_diff_index(&rev, 1);
> +	if (s->verbose > 1) {
> +		setup_work_tree();
> +		if (read_cache_preload(&rev.diffopt.pathspec) < 0)
> +			perror("read_cache_preload");

Hmm, as we have run diff-index already, we must have had the index
loaded, no?  What is going on here?

> +		rev.diffopt.a_prefix = 0; /* allow run_diff_files */
> +		rev.diffopt.b_prefix = 0; /* to reset the prefixes */

This is not just "allow to reset the prefixes", but forces the use
of mnemonic prefixes to make sure they look different from the
normal "diff --cached" output that shows what is going to be
committed.  If we were to do this, for consistency, we may want to
use the mnemonic prefix for the "to be commited" part, no?

> +		run_diff_files(&rev, 0);
> +	}
>  }
>  
>  static void wt_status_print_tracking(struct wt_status *s)
