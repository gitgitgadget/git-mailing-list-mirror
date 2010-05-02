From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/5] pretty: add conditional %C?colorname placeholders
Date: Sat, 01 May 2010 20:12:45 -0700
Message-ID: <7vvdb7yp1u.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 05:13:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Pcq-0004mW-9V
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 05:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab0EBDNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 23:13:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0EBDM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 23:12:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1216EAFFC2;
	Sat,  1 May 2010 23:12:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=puCu3zUi3geUP7xUW9E+OHAH00A=; b=kCdWJLGdG4K4v0C6doxRPxV
	UX2jfSYr3Eyp78+VqZ/HyIrmmR7ztJm5gZQ7lT7Qfu0zab4b4JY1vRJInjHkjBX2
	ZfQBg+Acf1vOGErYB1bVkRhNAJ7isocZ0pX4UWmdntRSqsxHjFKu3dBvOIZs/hup
	8MMP0ukO1fZuZkmEzUwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uDLkKufDabJazvphWK1GZLc9jOpwcE5O+kMF79JBu/BxDnmS6
	MjnFTy7ZxAVDbURogw2+yTWtxLIYW+SyQxVg6iQqEqDRiNKPXXQ4s74gcCshui6e
	xwCuYQvRCDMvEwv4uQkntWLTLdGEb7kibydK3N+8Y4xnsjlFdw/jTBKvsg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE8D5AFFC1;
	Sat,  1 May 2010 23:12:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF62BAFFBF; Sat,  1 May
 2010 23:12:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99201F6C-5598-11DF-A060-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146128>

Will Palmer <wmpalmer@gmail.com> writes:

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> new file mode 100755
> index 0000000..b7ec943
> --- /dev/null
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +#
> +# Released into Public Domain by Will Palmer 2010
> +#

Hmm...

> +test_description='Test pretty formats'
> +. ./test-lib.sh
> +
> +test_expect_success "set up basic repos" \
> +	">foo &&
> +	>bar &&
> +	git add foo &&
> +	test_tick &&
> +	git commit -m initial &&
> +	git add bar &&
> +	test_tick &&
> +	git commit -m 'add bar'"

Just a style thing, but it is easier to read to write:

        test_expect_success 'set up basic repos' '
                >foo &&
                >bar &&
                ...
        '

> +for flag in false true always; do
> +for color in red green blue reset; do
> +
> +	make_expected="git config --get-color no.such.slot $color >expected"
> +	test_expect_success "%C$color with color.ui $flag" \
> +		"$make_expected &&
> +		git config color.ui $flag &&
> +		git log -1 --pretty=format:'%C$color' > actual &&
> +		test_cmp expected actual"

I would really prefer to see a test that checks output with real contents,
not just "switch to color".  E.g. --format="Title: %C${color}%s%C(normal)"
or something like that.

Also you probably would want to make this one round into a shell function
e.g.

	make_expected ()
        {
        	git config --get-color no.such.slot "$1"
	}

	run_format_test ()
        {
		flag=$1 color=$2
                test_expect_success "%C$color with ..." '
			make_expected $color >expected
                        git config color.ui $flag &&
                        git log -1 --pretty=format:'%C($color)' >actual &&
                        test_cmp expected actual"
                '
                ...
	}

and then run this loop:

	for flag in flase true always
        do
        	for color in red green blue reset
                do
                	run_format_test $flag $color
		done
	done
