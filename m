From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Tue, 18 Sep 2012 13:52:13 -0700
Message-ID: <7va9wnkq9u.fsf@alter.siamese.dyndns.org>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE4mP-0001A4-MI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 22:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab2IRUwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 16:52:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755236Ab2IRUwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 16:52:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D739128;
	Tue, 18 Sep 2012 16:52:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFQ6Im8ZHoff3QDFn1ZUbIAIIRg=; b=XTyz0P
	yLCyWJNfM4B1xCZ+ZzWQYzXLynH+a7NYJj6s20GLjNuI0aelqiEzarorsMJ025vi
	omV7ku48E04NVZoeoxKuU/QTI8pd6AKGUE82tys7tkIzUgLfqQeWIb+sAQzBNPvm
	y2JDhi4aKCfVmKKQxZJZFmmThT4dMFeEiNcAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OkQwOVGHZe4+EtY/t9t7w8/LEgYz7MYo
	xA34HKfFJMn9pMUvSvPscJphBRaY2dTqkPkQjZZqEFPwS36SBHBi89PkodAOWrh3
	GPm2Q2kzygqZzUQ1WwKN7VDMTSpxwoL/NbZsfbuS6LOWFkychQslGNNM47gpHxwJ
	tTrnC92g2Kc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 020979127;
	Tue, 18 Sep 2012 16:52:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 496489124; Tue, 18 Sep 2012
 16:52:15 -0400 (EDT)
In-Reply-To: <1347901579-5545-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Mon, 17 Sep 2012 22:36:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA31107E-01D2-11E2-90AA-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205873>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When tests were run without building git, the following error message
> was displayed:
>
>     .: 54: Can't open /path/to/git/source/t/../GIT-BUILD-OPTIONS

Does the test stop due to this error, or it just goes on and hit
another error?  I am guessing that it is the latter, and if that is
the case, a more important change to describe here is

> Change this to display a more user-friendly error message:
>
>      error: you do not seem to have built git yet.

... "and stop the execution."

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t0000-basic.sh |   10 ----------
>  t/test-lib.sh    |    6 ++++++
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index ae6a3f0..08677df 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -18,16 +18,6 @@ swapping compression and hashing order, the person who is making the
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
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f8e3733..c00452a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -51,6 +51,12 @@ then
>  fi
>  GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>  
> +if ! test -r "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +then
> +	echo 'error: you do not seem to have built git yet.' >&2
> +	exit 1
> +fi
> +
>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
