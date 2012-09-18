From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 00:00:46 -0700
Message-ID: <7v627bq0gx.fsf@alter.siamese.dyndns.org>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com>
 <7v7grstlp9.fsf@alter.siamese.dyndns.org>
 <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:01:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDrnx-0002Yp-E6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010Ab2IRHAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:00:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756976Ab2IRHAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 03:00:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DD9E4471;
	Tue, 18 Sep 2012 03:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A4yt7+TkyXfy0Uu7emEQnb1hNjE=; b=fYPQSC
	OR0vSXOcZIk3rtRO6gmF5RRLPnhN6dvy3KH/UXPYdF5E9Hqt957eHJmYjuj4ULyp
	Uv/b+eJBy4rZq7CJ9ps7Hhsh0auo8x6cq4XwarY7FNPu91OCzlE2LUATQrJdkJYz
	gss1Pu6wnAqFPqTSJ85rWWEMtEYdBhadvhpYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dlZgT3FqIH0yZspRipuPADdahVszE9rB
	i9oJ31PYHZrJnTNvFtNH854mEA/meAuW35MZrihdr+Hn8qqFSdiX8+lUnOm7nzEc
	41I5e+33D1XWctgJ/RFH2EaqxjJvVXGenm1SQ0hhQPezl9VT7axpphJqFkcVkZyd
	db1isEJqfag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE9364470;
	Tue, 18 Sep 2012 03:00:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 527914466; Tue, 18 Sep 2012
 03:00:48 -0400 (EDT)
In-Reply-To: <CALkWK0k9P9-K5R2Amipujq2DFvJTXy8T3ZyfFa31CcxeKSFL2g@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 18 Sep 2012 12:22:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 933EC8FE-015E-11E2-A39F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205802>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Junio,
>
> Junio C Hamano wrote:
>> Is this a sufficient replacement for what you removed from 0000?
>> Can the BUILD-OPTIONS file exist when your build of git failed?
>
> Oops, I didn't realize that BUILD-OPTIONS would be written when the
> build fails.  How about something like this instead:

Yeah, but why change it so much?  Wouldn't writing

	"$GIT_BUILD_DIR/git" >/dev/null
	if test $? != 1
        then
		: You haven't built git!
	fi

just like the original in 0000 be sufficient??

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index ae6a3f0..08677df 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -18,16 +18,6 @@ swapping compression and hashing order, the person
> who is making the
>  modification *should* take notice and update the test vectors here.
>  '
>
> -################################################################
> -# It appears that people try to run tests without building...
> -
> -../git >/dev/null
> -if test $? != 1
> -then
> -	echo >&2 'You do not seem to have built git yet.'
> -	exit 1
> -fi
> -
>  . ./test-lib.sh
>
>  ################################################################
> 	Modified   t/test-lib.sh
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f8e3733..8cc7755 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -51,6 +51,12 @@ then
>  fi
>  GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>
> +if ! test -x "$GIT_BUILD_DIR"/git || "$GIT_BUILD_DIR"/git && test $? != 1
> +then
> +	echo 'error: you do not seem to have built git yet.' >&2
> +	exit 1
> +fi
> +
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
