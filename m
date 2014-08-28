From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge, pull: stop advising 'commit -a' in case of conflict
Date: Thu, 28 Aug 2014 10:28:45 -0700
Message-ID: <xmqqa96obk1e.fsf@gitster.dls.corp.google.com>
References: <xmqq4mwxeqr7.fsf@gitster.dls.corp.google.com>
	<1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:29:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN3Vg-0001JR-IB
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbaH1R3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:29:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52265 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbaH1R3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 13:29:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0083342BB;
	Thu, 28 Aug 2014 13:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6pPgffAyAvxK1RusTpWwSiSm95Q=; b=Zu2u8t
	cKNTODbZ85FZkoRKN25ej2kxYPwLRgMlExPPqi15q2kHorZ4eY8b4+6Y40IvYkJG
	20WDZVRQmu48MiKKi1DvrdW5ug6PDN/7qEYzxjd24chYWDRC+vhuANrufVm+mx3a
	2NfUopIp2egVrWLfE/qzejSYuPpgkgQZQYtn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hHqjFih6qyY6TA8O6Wjkg0HwoRi5cwYv
	O+bGmM1Y5PAt/4EDW9XVEfFwNILTDDHinec2FPWaBAxzbYyecMe2YKPX4+nx8ntZ
	V6oeixc0DyyvHR8oohmVqrcDjKpIBVQiENh+hF5BboWtHUUTPGGKZbj7HtQgQfxF
	j32YC2KHyxo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6CF8342BA;
	Thu, 28 Aug 2014 13:28:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B8125342AE;
	Thu, 28 Aug 2014 13:28:47 -0400 (EDT)
In-Reply-To: <1409219218-9475-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Thu, 28 Aug 2014 11:46:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C4CECBD6-2ED8-11E4-9A11-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256106>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> 'git commit -a' is rarely a good way to mark conflicts as resolved: the
> user anyway has to go manually through the list of conflicts to do the
> actual resolution, and it is usually better to use "git add" on each
> files after doing the resolution.
>
> On the other hand, using 'git commit -a' is potentially dangerous, as it
> makes it very easy to mistakenly commit conflict markers without
> noticing.
>
> While we're there, synchronize the 'git pull' and 'git merge' messages:
> the first was ending with '...  and make a commit.', but not the later.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>>  - Hasty-and-careless new users will be incorrectly enticed to type
>>    the command given by "or use 'git commit -a'" at the end of this
>>    advice message without thinking.  Perhaps it is safer to stop the
>>    sentence at "... and make a commit." and drop that last bit while
>>    there are conflicts still in the working tree files.  We should
>>    use the current end-of-message only when all the conflicts have
>>    been resolved in the working tree.
>
> It was already on my todo-list, as a friend of mine semi-beginner with
> Git complained about the mis-advice the other day, and I had to agree.



> Eventually, git could detect that conflicts have been resolved, but
> then that would be a different message, as not only "use git commit
> -a" could be resurected, but "Fix them up in the work tree" should be
> dropped when it is the case.

This paragraph should be in the log message, shouldn't it, probably
with s/could/should/?

> I guess I'm just taking the low hanging fruit here ;-).

I'd say it is more like scooping a fruit lying on the ground before
it rots, but thanks anyway ;-)

>  advice.c    | 3 +--
>  git-pull.sh | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 9b42033..3b8bf3c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -86,8 +86,7 @@ int error_resolve_conflict(const char *me)
>  		 * other commands doing a merge do.
>  		 */
>  		advise(_("Fix them up in the work tree, and then use 'git add/rm <file>'\n"
> -			 "as appropriate to mark resolution and make a commit, or use\n"
> -			 "'git commit -a'."));
> +			 "as appropriate to mark resolution and make a commit."));
>  	return -1;
>  }
>  
> diff --git a/git-pull.sh b/git-pull.sh
> index 18a394f..4d4fc77 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -20,7 +20,7 @@ die_conflict () {
>      if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
>  	die "$(gettext "Pull is not possible because you have unmerged files.
>  Please, fix them up in the work tree, and then use 'git add/rm <file>'
> -as appropriate to mark resolution, or use 'git commit -a'.")"
> +as appropriate to mark resolution and make a commit.")"
>      else
>  	die "$(gettext "Pull is not possible because you have unmerged files.")"
>      fi
