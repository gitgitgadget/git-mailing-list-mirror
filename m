From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t9902: fix 'test A == B' to use = operator
Date: Mon, 08 Jul 2013 10:20:48 -0700
Message-ID: <7v1u790xzj.fsf@alter.siamese.dyndns.org>
References: <8761wli0fe.fsf@linux-k42r.v.cablecom.net>
	<b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 08 19:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwF7V-0001jJ-In
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 19:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab3GHRU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 13:20:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3GHRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 13:20:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C45F12E4DD;
	Mon,  8 Jul 2013 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2LV/GXNIym3ymiThTsKCSlljcbs=; b=etx0/J
	L443lMN+DgduIOJsghVjx33PFXWePwt3lkNxi3ZP7TjnogptF01ii/91aPPgL1gW
	WmZSYVEPElGd691DcChvNU3h3LWqBrQfcNlK7aYTGMtaak4nWbUp0Zva4q2CSSRV
	NsHzeAAld9o4J3tePlNMbQY9L9M3g5GoNCqCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzXEurYnXhNjydg8I7AuZRsMTaygaNA5
	yCFKkZ2YMqJqLZUcj359D92XmzprXGpoGPy2M4+4ScpoIPTvawsmoNGhSdYKsEU0
	DyZQ4SRVwaKzFcd350NofGxlK+tLe7bHI/9TuOfhkpGGLpKELK0aj5hJJd3tnz7c
	wc05MXFApEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C2D52E4D5;
	Mon,  8 Jul 2013 17:20:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AB762E4B7;
	Mon,  8 Jul 2013 17:20:50 +0000 (UTC)
In-Reply-To: <b9e889a27f648c44179ad39159240867f86525f3.1373296313.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Mon, 8 Jul 2013 17:20:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCF149E4-E7F2-11E2-B662-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229878>

Thomas Rast <trast@inf.ethz.ch> writes:

> The == operator as an alias to = is not POSIX.  This doesn't actually
> matter for the execution of the script, because it only runs when the
> shell is bash.  However, it trips up test-lint, so it's nicer to use
> the standard form.

OK, my knee-jerk reaction was "this is only for bash" as you said,
but the test-lint part I agree with.

But then test-lint _ought_ to also catch the use of "local" in the
ideal world, so perhaps in the longer term we would need to treat
this bash-only script differently from others anyway???

>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  t/t9902-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index d9e3103..272a071 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -69,7 +69,7 @@ run_completion ()
>  	local -a COMPREPLY _words
>  	local _cword
>  	_words=( $1 )
> -	test "${1: -1}" == ' ' && _words+=('')
> +	test "${1: -1}" = ' ' && _words+=('')
>  	(( _cword = ${#_words[@]} - 1 ))
>  	__git_wrap__git_main && print_comp
>  }
