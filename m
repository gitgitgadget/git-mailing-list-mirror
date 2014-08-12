From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: fix -f description to match actual git behavior.
Date: Tue, 12 Aug 2014 12:47:27 -0700
Message-ID: <xmqq4mxh5w34.fsf@gitster.dls.corp.google.com>
References: <87bnrq22uf.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 21:47:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHI2z-0000ZA-UA
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 21:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbaHLTrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 15:47:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51161 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866AbaHLTrh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 15:47:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6509730CCC;
	Tue, 12 Aug 2014 15:47:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=orLFhCILqBcCShM1EFaVtRoaPKs=; b=gZomCn
	M+WMYTbFgN0vr6+2nezKL5ZCM+e0NjnFngSgrxtP0ODnN3/SZtTo5IQaX+Tf1mtn
	0oYPuR5lXrgt1R4inSz7oFHtWawAktfTWupO50akfcZUVZ62Hpq6DM+GCkx2t9dx
	3tkwPtDkwXi4G64CHrdMQrOoeJ05TAg5dWEXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zh7HUMvpnTKz95KSCj4Za4/FpHHR257p
	bHqLMojb/oqTuWXCzF9v530kMhEF2xGhE2OMVrmK6db8OLRXSmfQF6CE6J19xk/W
	Do/nq/45aaz4rEezdVyWTbc4PyqyARc940YYOkpFYTwzfc874KVYspZSEVpS8DMJ
	521xJxxZljU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55A3730CCA;
	Tue, 12 Aug 2014 15:47:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B75D30CBB;
	Tue, 12 Aug 2014 15:47:29 -0400 (EDT)
In-Reply-To: <87bnrq22uf.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
	12 Aug 2014 00:22:48 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E31602A-2259-11E4-8F7A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255161>

Sergey Organov <sorganov@gmail.com> writes:

> Previous description of -f option was wrong as "git rebase" does not
> require -f to perform rebase when "current branch is a descendant of
> the commit you are rebasing onto", provided commit(s) to be rebased
> contain merge(s).

Both the above and the updated documentation are a bit hard to read
for me, so let me disect what you are and you are not saying to see
if I understood them correctly:

 - The plain-vanilla "git rebase" that flattens the history will be
   a no-op *only* when the current tip is a linear descendant of the
   "onto" commit without any merge in between.

 - Merge-preserving form of "git rebase -m/-p" is a no-op when the
   current tip is a descendant of the "onto" commit.

 - "rebase -f" is a way to force rebase when it would otherwise be a
   no-op.

 - When you force a rebase that would otherwise be a no-op, only the
   timestamps would change.

I think you are right that 'current branch is a descendant of the
"onto" commit' is not necessarily equal to 'rebase that would
otherwise be a no-op'.  I am not sure if a 'rebase that would
otherwise be a no-op' is equal to 'only timestamp would change',
though.  What happens if you do this, for example?

    $ GIT_COMMITTER_NAME='Somebody Else' git commit
    $ git rebase --force --onto HEAD^ HEAD^ HEAD^0

So I think the reasoning (i.e. "is a descendant" is not quite right)
is correct, but the updated text is not quite right.  Changing it
further to "only the committer timestamps and identities would
change" is probably not an improvement, either.  "Force the rebase
that would otherwise be a no-op" may be a better phrasing that does
not risk going stale even if we update what are preserved and what
are modified in the future.

Also I notice the sentence "Normally non-interactive...in such a
situation" is not helping the reader in this description very much.
I wonder if we should keep it if we are rewriting this paragraph.

Thanks.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-rebase.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 2a93c64..62dac31 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -316,10 +316,9 @@ which makes little sense.
>  
>  -f::
>  --force-rebase::
> -	Force the rebase even if the current branch is a descendant
> -	of the commit you are rebasing onto.  Normally non-interactive rebase will
> -	exit with the message "Current branch is up to date" in such a
> -	situation.
> +	Force the rebase even if the result will only change commit
> +	timestamps. Normally non-interactive rebase will exit with the
> +	message "Current branch is up to date" in such a situation.
>  	Incompatible with the --interactive option.
>  +
>  You may find this (or --no-ff with an interactive rebase) helpful after
