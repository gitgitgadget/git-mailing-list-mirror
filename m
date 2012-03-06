From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.3
Date: Tue, 06 Mar 2012 12:08:19 -0800
Message-ID: <7v8vjdsdak.fsf@alter.siamese.dyndns.org>
References: <7vliney6k7.fsf@alter.siamese.dyndns.org>
 <A518E7E7-25D5-429C-A1C1-35F94EC8F043@bjhargrave.com>
 <87y5rd4wci.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: BJ Hargrave <bj@bjhargrave.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:08:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S50gO-0003ZL-QP
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374Ab2CFUIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 15:08:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030369Ab2CFUIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 15:08:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65F1F6A27;
	Tue,  6 Mar 2012 15:08:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n1mYGV7IfGlmhUhtJf2XGOu+DiE=; b=UuYNJA
	LtCJjMb7psbY4Ok75+uff09kp8WE9+mleMl0Uk/e2z/jNtWwhNDUqcM+sHF2THNZ
	yrdh2RQnvDhKl56BXf13sOO+dHufvLGxtoh36NYSgXKhW7fATbvZg55G7iuQveoP
	a0cA7crk9HjLJo/P2CMY5JzYRc5XqkaLz+NFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LEwMejNXRI5Q2j2GQPiHiSIxAEWeD/nO
	5hIOnbMizQfvjBoBlJV7BLHGwyjkd3BJh4qVvp2hUeXnwFKzGrPD5ho77eizWa83
	K0giOxXfev0N+JzQQ+rm0omUR2JgrAPebShGFs9ePwq6xM/HLT2weHytqR+Hb9ml
	e/4LvOLyws4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D8026A26;
	Tue,  6 Mar 2012 15:08:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D966A6A25; Tue,  6 Mar 2012
 15:08:20 -0500 (EST)
In-Reply-To: <87y5rd4wci.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 6 Mar 2012 15:50:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EFFBBCC-67C8-11E1-98ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192384>

Thomas Rast <trast@inf.ethz.ch> writes:

> This can be fixed with the change below, which then gets us into the
> next one
>
>   grep: Regular expression too big
>
> Sheesh, Apple, are you kidding me?!  So we also need to change the grep
> expression.
>
> ----- 8< -----
> Subject: [PATCH] t5704: fix nonportable sed/grep usages
>
> OS X's sed and grep would complain with (respectively)
>
>   sed: 1: "/^-/{p;q}": extra characters at the end of q command
>   grep: Regular expression too big
>
> For sed, use an explicit ; to terminate the q command.
>
> For grep, spell the "40 hex digits" explicitly in the regex, instead
> of being lazy with the shell pattern $_x40.
> ---

Actually the shell pattern $_x40 was invented so that it can be used
in both shell, grep and sed; there is nothing *lazy* about it.

I share the "are you kidding me?!" with you.  I cannot fathom which
part of that regular expression is too big for them to swallow.

In any case, thanks for a quick fix; can I consider it as signed-off?

>  t/t5704-bundle.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
> index a51c8b0..9e43731 100755
> --- a/t/t5704-bundle.sh
> +++ b/t/t5704-bundle.sh
> @@ -54,8 +54,8 @@ test_expect_success 'ridiculously long subject in boundary' '
>  	git bundle list-heads long-subject-bundle.bdl >heads &&
>  	test -s heads &&
>  	git fetch long-subject-bundle.bdl &&
> -	sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
> -	grep "^-$_x40 " boundary
> +	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
> +	grep "^-[0-9a-f]\\{40\\} " boundary
>  '
>  
>  test_done
> -- 
> 1.7.6.557.gcee4
