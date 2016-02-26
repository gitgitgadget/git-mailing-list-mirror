From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Fri, 26 Feb 2016 10:47:50 -0800
Message-ID: <xmqqoab3jokp.fsf@gitster.mtv.corp.google.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 19:48:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZNQn-0000hd-6R
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 19:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423155AbcBZSr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 13:47:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932737AbcBZSry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 13:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 350A146A64;
	Fri, 26 Feb 2016 13:47:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+0kzVrVAD6rvXg+DBfkvLKGSac=; b=Fe+1KL
	Nwut9ntawRI6umvyGAcXYtoon8DqHhAG6lLE6CXTas1jZjO+RGu5QJixKI+U1XAU
	3vem/+334cvvaebjJoEn5JMJd2blypV9gs1moxJ7lxyS5YBpIuc/QWUeE0JIX/dH
	W5fjO3NGAmZlCMnAb6w3E8Doph+ZqHaIdYUUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SKP+REQ2xkk6DlrbEUD+kvSMpJH6JDUA
	HKN98rEybipGf656BIZKqt6BaBEVuY8t+9KwoPRiQIw21qF9vttjWVBVfuo5EURK
	X5Di/bxNO0TSG5Hrg5b4Ge2J09v8ZUybKjADUcke4KcEJpnGh3y/9RQzcMoSKnM0
	khcMgxVTgT8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C03646A63;
	Fri, 26 Feb 2016 13:47:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64DA546A61;
	Fri, 26 Feb 2016 13:47:51 -0500 (EST)
In-Reply-To: <1456452282-10325-2-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Fri, 26 Feb 2016 03:04:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 703549DE-DCB9-11E5-A25E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287603>

Stephan Beyer <s-beyer@gmx.net> writes:

> +Bisect next
> +~~~~~~~~~~~
> +
> +Sometimes it can be necessary to check out other branches during a bisect
> +session. If you want to check out the next commit of the bisection again,
> +simply issue the command:
> +
> +------------
> +$ git bisect next
> +------------

Hmph, I am not quite sure what you mean by checking out other
branches during a bisect session.

During bisection, you are on a detached HEAD with refs/bisect/*
holding the current state, and "next" indeed is a way to recompute
the commit to be tested based on that state.

But I wonder if it is safe and sane to encourage "checking out other
branches during a bisect session." as you cannot tell what other
crazy things they will do while on "other branches".  I do not think
we even try to (and I do not think we should) handle a case where
the user tries to merge another branch, sees conflicts and says
"bisect next" without cleaning up, for example.

> +Another typical use case of this command is when you have marked a commit
> +as bad but you do not know a good commit. Instead of crawling through the
> +history yourself, let this command check out a commit for you.

I would say this is the only sensible use of "next", but as you
cannot see ;-) in the comment from the pre-context of the patch
below, "have bad but not good. we could bisect althoguh this is less
optimum.", I am not sure if it is a good idea to say "is also helpful"
as if we are encouraging such a usage.

>  OPTIONS
>  -------
>  --no-checkout::
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 5d1cb00..5c93a27 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -334,16 +334,10 @@ bisect_next_check() {
>  	*)
>  		bad_syn=$(bisect_voc bad)
>  		good_syn=$(bisect_voc good)
> -		if test -s "$GIT_DIR/BISECT_START"
> -		then
> -
> -			eval_gettextln "You need to give me at least one \$bad_syn and one \$good_syn revision.
> -(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
> -		else
> -			eval_gettextln "You need to start by \"git bisect start\".
> -You then need to give me at least one \$good_syn and one \$bad_syn revision.
> -(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
> -		fi
> +		eval_gettextln "You need to give me at least one \$bad_syn revision.
> +Use \"git bisect \$bad_syn\" for that. One \$good_syn revision is also helpful
> +for bisecting (use \"git bisect \$good_syn\"). If you do not know one \$good_syn
> +revision, you can use \"git bisect next\" to find one." >&2
>  		exit 1 ;;
>  	esac
>  }
> @@ -677,7 +671,6 @@ case "$#" in
>  	skip)
>  		bisect_skip "$@" ;;
>  	next)
> -		# Not sure we want "next" at the UI level anymore.
>  		bisect_next "$@" ;;
>  	visualize|view)
>  		bisect_visualize "$@" ;;
