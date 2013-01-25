From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browser: avoid errors in terminal when running
 Firefox on Windows
Date: Fri, 25 Jan 2013 11:49:43 -0800
Message-ID: <7v1ud93uw8.fsf@alter.siamese.dyndns.org>
References: <20111111202636.GA20515@sigill.intra.peff.net>
 <3eeabf4989f7f1b4593e89e4c6bcfa8710a7b793.1359125053.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:50:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TypHw-0006OH-VT
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 20:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086Ab3AYTtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 14:49:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab3AYTtu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 14:49:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53384CE73;
	Fri, 25 Jan 2013 14:49:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FzkIgMZu+9jb7cz14xod4LuQOGo=; b=S3j0Au
	bbHuXljXQhb+HAg0DgprEmGWlfpxRYFSjEYBhn/z5AaftMjOLNV7MZXJSXCy9TCY
	bD64zRUIOadLrQyBuQlzKocxrzem2B9ISc8+Xwn47vXUJb4FYRbC3o6SSx9RQ0/B
	f+sg3d/mNOzSDmMn4ea+yb6FFsKSdf8sUUcsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSB4O5FqmyYdZ4dr8Ij7qhi1jhD5IsyS
	NXrc1I7F9lwz4XvJlhMH9LUOCc2rYsIKWRjx/eALZ4wz9lMJA9uJVeCYfKHQPtmT
	JeWYqkwkEjz+bHDgER09GA5cSZlznyJO7nTeFuQ8E58Mw9RmsFKn+jI6BfDvVO+T
	Y/E71v9PATw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 363BFCE69;
	Fri, 25 Jan 2013 14:49:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FB21CE47; Fri, 25 Jan 2013
 14:49:45 -0500 (EST)
In-Reply-To: <3eeabf4989f7f1b4593e89e4c6bcfa8710a7b793.1359125053.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's message of "Fri, 25 Jan 2013 18:44:13 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F388EAC-6728-11E2-93A1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214572>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> Firefox on Windows by default is placed in "C:\Program Files\Mozilla Firefox"
> folder, i.e. its path contains spaces. Before running this browser "git-web--browse"
> tests version of Firefox to decide whether to use "-new-tab" option or not.
>
> Quote browser path to avoid error during this test.
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> Reviewed-by: Jeff King <peff@peff.net>

Thanks, both.

> ---
>  git-web--browse.sh         |  2 +-
>  t/t9901-git-web--browse.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index 1e82726..f96e5bd 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -149,7 +149,7 @@ fi
>  case "$browser" in
>  firefox|iceweasel|seamonkey|iceape)
>  	# Check version because firefox < 2.0 does not support "-new-tab".
> -	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
> +	vers=$(expr "$("$browser_path" -version)" : '.* \([0-9][0-9]*\)\..*')
>  	NEWTAB='-new-tab'
>  	test "$vers" -lt 2 && NEWTAB=''
>  	"$browser_path" $NEWTAB "$@" &


> diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
> index b0a6bad..30d5294 100755
> --- a/t/t9901-git-web--browse.sh
> +++ b/t/t9901-git-web--browse.sh
> @@ -8,8 +8,21 @@ This test checks that git web--browse can handle various valid URLs.'
>  . ./test-lib.sh
>  
>  test_web_browse () {
> -	# browser=$1 url=$2
> +	# browser=$1 url=$2 sleep_timeout=$3
> +	sleep_timeout="$3"
>  	git web--browse --browser="$1" "$2" >actual &&
> +	# if $3 is set
> +	# as far as Firefox is run in background (it is run with &)
> +	# we trying to avoid race condition
> +	# by waiting for "$sleep_timeout" seconds of timeout for 'fake_browser_ran' file appearance
> +	(test -z "$sleep_timeout" || (
> +	    for timeout in $(seq 1 $sleep_timeout); do
> +			test -f fake_browser_ran && break
> +			sleep 1
> +		done
> +		test $timeout -ne $sleep_timeout
> +		)
> +	) &&

Style:

 - do/then/else begin a new line (a good rule of thumb is remember
   this rule is to write control structures without using
   semicolon).

 - do not use "seq"; it is not available in some places.

I do not think of a reason why you want ( nested (subshell) ), but
if you don't need them, perhaps I'd write the above this way:

	if test -n $sleep_timeout
	then
		for timeout in $(test_seq $sleep_timeout)
		do
			test -f fake_browser_ran && break
			sleep 1
		done
		test $timeout -ne $sleep_timeout
	fi &&

> @@ -48,6 +61,48 @@ test_expect_success \
>  '
>  
>  test_expect_success \
> +	'Firefox below v2.0 paths are properly quoted' '

-ECANNOTPARSE.

"Paths to firefox older than v2.0 are properly quoted" you mean,
perhaps?  I dunno.

> +	echo fake: http://example.com/foo >expect &&
> +	rm -f fake_browser_ran &&
> +	cat >"fake browser" <<-\EOF &&
> +	#!/bin/sh

Consider using "write_script" helper so that you get the path to the
shell the user specified via $SHELL_PATH.

> +
> +	: > fake_browser_ran

Style: no SP between redirection operator and filename, i.e.

	: >fake_browser_ran

> +	if test "$1" = "-version"; then

Style (see above).

> +		echo Fake Firefox browser version 1.2.3
> +	else
> +		# Firefox (in contrast to w3m) is run in background (with &)
> +		# so redirect output to "actual"
> +		echo fake: "$@" > actual

Style (see above).

> +	fi
> +	EOF
> +	chmod +x "fake browser" &&
> +	git config browser.firefox.path "`pwd`/fake browser" &&

We tend to prefer $(pwd) over `pwd`.

> +	test_web_browse firefox http://example.com/foo 5
> +'
> +
> +test_expect_success \
> +	'Firefox not lower v2.0 paths are properly quoted' '

s/not lower v2.0/v2.0 and above/, but again -ECANNOTPARSE.

> +	echo fake: -new-tab http://example.com/foo >expect &&

I'd feel safer if you quoted the arguments to "echo", i.e.

	echo "fake: -new-tab http://example.com/foo" >expect &&

The same style comments as above apply to the remainder of patch.

Thanks.
