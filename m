From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Provide branch name in error message when using @{u}
Date: Wed, 11 Apr 2012 11:00:53 -0700
Message-ID: <7v7gxmkv1m.fsf@alter.siamese.dyndns.org>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
 <1334161035-26355-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:01:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1qr-0007Uo-GP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab2DKSA7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 14:00:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756881Ab2DKSA6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 14:00:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3967C7734;
	Wed, 11 Apr 2012 14:00:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=reQ88yEpYE4e
	KLRax+QJtp81T64=; b=gL/ub86kEImwIwRU7YB7hbtCjHlzX8hKCoPoH1Zae3Rn
	FPKbV5675d4jGnLMlXGjw340koCegefvrKeJCnMA/NYIGS9DPasn3EBIR4MB1qvU
	bYtXkAZrBvkc5D/QXnEeyJgUw/7oFFZJ+gWmLC7qIr3u0QrSZLmY1FIZTPg0gDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O/Bk/X
	08LBwu6fEvHSTglY4fv8SIGM0T2602aW7X4z0S1gMuRKXc1YHePNW+s70cyGiDmd
	JSNBtuJepoEftWwU5yFIe8jd+3YLiuDaaMZ44uscfnnlFIIcW6VOamb35eaVROiv
	a+mh5xr9IgAP9ESp/StyebM0pU9elA680/Nqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F32A7732;
	Wed, 11 Apr 2012 14:00:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB9407730; Wed, 11 Apr 2012
 14:00:57 -0400 (EDT)
In-Reply-To: <1334161035-26355-3-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 11 Apr 2012
 18:17:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A2CB256-8400-11E1-88C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195227>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstre=
am.sh
> index 1342915..a00b689 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -135,7 +135,7 @@ test_expect_success 'branch@{u} error message whe=
n no upstream' '
> =20
>  test_expect_success '@{u} error message when no upstream' '
>  	cat >expect <<-EOF &&
> -	error: No upstream branch found for ${sq}${sq}
> +	error: No upstream branch found for ${sq}master${sq}
>  	fatal: Needed a single revision
>  	EOF
>  	test_must_fail git rev-parse --verify @{u} 2>actual &&

I am not sure if saying "... for 'master'" is better or "... for the
current branch" is better.  Using different wording reflects the fact t=
hat
the user gave "@{u}" and not "master@{u}".

But I do not care too deeply.  Either way, it is a vast improvement ove=
r
the current "... for ''" output.

And the "detached" case is definitely better.

> @@ -153,7 +153,7 @@ test_expect_success 'branch@{u} error message wit=
h misspelt branch' '
> =20
>  test_expect_success '@{u} error message when not on a branch' '
>  	cat >expect <<-EOF &&
> -	error: No upstream branch found for ${sq}${sq}
> +	error: HEAD does not point to a branch
>  	fatal: Needed a single revision
>  	EOF

Thanks.
