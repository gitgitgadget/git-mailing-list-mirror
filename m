From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-completion: add stashes for gitk
Date: Thu, 12 Mar 2015 11:11:03 -0700
Message-ID: <xmqq1tku3x3c.fsf@gitster.dls.corp.google.com>
References: <1426120961-2273-1-git-send-email-sveinung84@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 19:11:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW7Zl-0000pG-ID
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 19:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbCLSLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 14:11:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbbCLSLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 14:11:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65A1A3ED88;
	Thu, 12 Mar 2015 14:11:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CiBdKXjtrIoZqWvV4EfEQ2qfw0M=; b=bWyVlU
	YM37qVjQ8nplafhNU/l6gfw4jgnF28Bm+co9lI+IY8NS3P77Z/ZhsV7JD+9Xa5Ng
	Nn4h+o8Satu7BMGOqx8Rn6QaXriFR9SiajbAm6fb7CfooEHjtdASY7/cJRmhcQX6
	XhjFycZa0EZgXPrZucPgYCa9w96jPJeDxZ+Ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pe8Uz5RB1iCT4vnhOHWp1zMCgqAePoYk
	U1YkOPhHAaUNm6O15gsN12ZsuW7965uSd1l3a6+B64nGHbt9ttvABSo5d5+tJWa2
	IbQrY94WqTEFniVPZrt53nJdjEdp3IO2g3Az+DWXVmuvUtL1OfoO5YN2XLY+Omps
	HxEzkW6sEp8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 549D63ED87;
	Thu, 12 Mar 2015 14:11:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4FFC3ED85;
	Thu, 12 Mar 2015 14:11:04 -0400 (EDT)
In-Reply-To: <1426120961-2273-1-git-send-email-sveinung84@users.sourceforge.net>
	(Sveinung Kvilhaugsvik's message of "Thu, 12 Mar 2015 01:42:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 25EF8B86-C8E3-11E4-A951-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265363>

Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net> writes:

> Auto complete stashed modifications for gitk. This makes them easier to
> discover and faster to view.
>
> Signed-off-by: Sveinung Kvilhaugsvik <sveinung84@users.sourceforge.net>
> ---
>  contrib/completion/git-completion.bash | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21190d..3a23abb 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2644,6 +2644,8 @@ __gitk_main ()
>  		;;
>  	esac
>  	__git_complete_revlist
> +	__gitcomp_nl_append "$(git --git-dir="$(__gitdir)" stash list \
> +			| sed -n -e 's/:.*//p')"

I do not find it particularly useful to expand "gitk st<TAB>" to
"gitk st" and offer "sting stash@{0} stash@{1} stash@{2} stash@{3}"
('sting' happens to be just one of the names of my branches) as
possible choices.

Because I happen to have only four stash entries right now, it may
still be manageable, but the stash entries can be dozens for some
people.

Once you have dozens of branches and tags, you learn to avoid "gitk
<TAB>" (or "git log <TAB>") to prevent the completion code from
dumping all these refnames at you.  Instead, you would give a few
characters before hitting the <TAB> to limit the completion.  But
this change makes it harder if what you want happens to start with
es-tee something, as you would get many stash@{...} entries along
with it.  Also, when you have no ref that is named es-tee something,
"gitk st<TAB>" completes to "gitk stash@{", as if the problem the
change tries to cure is "it is unnecessarily hard to type at-mark
open-brace".

I do not have to be the target audience, though.  Maybe this is
useful for some people.

A bigger question is why this change is made to gitk completion.  If
this completion were useful for "gitk", wouoldn't it be equally
useful for "git log"?

Thanks.
