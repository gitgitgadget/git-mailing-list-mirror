From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
Date: Mon, 29 Sep 2014 09:26:27 -0700
Message-ID: <xmqq7g0m75qk.fsf@gitster.dls.corp.google.com>
References: <87r3z72wiu.fsf@osv.gnss.ru> <87k34mn0ht.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 18:29:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYdmk-0002Au-SS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 18:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbaI2Q0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 12:26:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60700 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754978AbaI2Q0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 12:26:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B6AE3D889;
	Mon, 29 Sep 2014 12:26:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZDXIjLOSve4gNF1N6iNlRG4QXfU=; b=WRdWG+
	DGGw0GzK/nl/tZncY1RpRfcYm2aVx9VlASO35G7oJwgfOibJl7hyjGNhH+u5TF7R
	meZutg9FtHk6efgqBPuyvZ4HuWpIrquPpwaFY8di5iDh6g+GVGAkkIAiZdYpYQbl
	Xv4qzleRMlDHVIXStQ+woffT83x54io8UL2Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s+Onw6ccIus5z63lQf8bannbMh/YN5uV
	VDtMkC9BrFDmUgP6pl9gc+zjR5BITROYSM33gzNm6B6Khgo0dmELgZYukPdeVyF7
	ApB4r8BJhGsRQQfKJhoJgNG8uHRpmzFxoVMtmo6iJLtb2hGebvrefskos6K2Z11F
	usf7OiA36pU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FF113D887;
	Mon, 29 Sep 2014 12:26:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 845983D884;
	Mon, 29 Sep 2014 12:26:29 -0400 (EDT)
In-Reply-To: <87k34mn0ht.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	18 Sep 2014 23:03:25 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5DE0F7A6-47F5-11E4-B46F-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257625>

Sergey Organov <sorganov@gmail.com> writes:

> Vanilla "git rebase" defaults to --fork-point that in some cases
> makes behavior very different from "git rebase <upstream>",
> where --no-fork-point is assumed. This fact was not mentioned in
> the DESCRIPTION section of the manual page, even though the case of
> omitted <upstream> was otherwise discussed. That in turn made actual
> behavior of vanilla "git rebase" hardly discoverable.
>
> While we are at it, clarify the --fork-point description itself as well.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
> As asked by Junio C Hamano <gitster@pobox.com>, the newly introduced
> 'fork_point' term has been described.
>

I suspect "will be used as a fallback" might be easier to understand
what is going on instead of "will be used instead", but other than
that, the new explanation of what fork-point is is a very welcome
update, I think.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 4138554..2e6f125 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -21,15 +21,17 @@ If <branch> is specified, 'git rebase' will perform an automatic
>  it remains on the current branch.
>  
>  If <upstream> is not specified, the upstream configured in
> +branch.<name>.remote and branch.<name>.merge options will be used (see
> +linkgit:git-config[1] for details) and the `--fork-point` option is
> +assumed.  If you are currently not on any branch or if the current
> +branch does not have a configured upstream, the rebase will abort.
>  
>  All changes made by commits in the current branch but that are not
>  in <upstream> are saved to a temporary area.  This is the same set
> +of commits that would be shown by `git log <upstream>..HEAD`; or by
> +`git log 'fork_point'..HEAD`, if --fork-point is either specified or
> +assumed (see --fork-point description below); or by `git log HEAD`, if
> +--root is specified.

It is easier to read with "is either specified or assumed" shortened
to "is active", I think, because that is the word you use to explain
how the commit is computed for --fork-point processing.

> @@ -327,13 +329,18 @@
> link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To]
> for details)
>  
>  --fork-point::
>  --no-fork-point::
> +	Use reflog to find a better common ancestor between <upstream>
> +	and <branch> when calculating which commits have been
> +	introduced by <branch>. 
>  +
> +When --fork-point is active, 'fork_point' will be used instead of
> +<upstream> to calculate the set of commits to rebase, where
> +'fork_point' is the result of `git merge-base --fork-point <upstream>
> +<branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
> +ends up being empty, the <upstream> will be used instead.
> ++
> +If either <upstream> or --root is given on the command line, then the
> +default is `--no-fork-point`, otherwise the default is `--fork-point`.
>  
>  --ignore-whitespace::
>  --whitespace=<option>::


The patch failed to apply

Applying: Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
fatal: corrupt patch at line 38

but the fix-up is trivial, so no need to resend.

Thanks.
