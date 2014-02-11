From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Tue, 11 Feb 2014 11:51:18 -0800
Message-ID: <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
References: <20140210191521.GA3112@sigill.intra.peff.net>
	<20140210212931.GA16154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 11 20:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDJMr-00069R-Be
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 20:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbaBKTvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 14:51:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbaBKTv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 14:51:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98C636B3B2;
	Tue, 11 Feb 2014 14:51:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZiiFl2+8A5kF/I3p/10bzw9Kns=; b=FYYXt6
	/cpVIlSXVJ22yHxTOS8PuE9egLpmaNsIGGR+D2f34+XA2l8+aQ7w2FVZXKXEJ92U
	boeYj/c5Uq9XffoDrUMO5iCTg113+HR8mtQno7TcQqWvdpyfCL6gGJKLmPIftZDL
	IX+Gndy5gxm8zt+LpnYr3PIF0NNkujeHzDbhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ah2iroUVH16WgKxOmyd5EDj2q2yNmbfD
	cC2LTB9+HmNlwwfyiAk0Cn0FIcG+dl53aAzIeb2Swi63m5NkvK79botzPipJeJOG
	awRXEyXrvBEFNB6MsELM3lpJNPmI0TGLuV3GHvut5Ff5E4AWciwGhyU4yFCwvexU
	gDM2wQIym/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 125586B3A8;
	Tue, 11 Feb 2014 14:51:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDEBA6B38A;
	Tue, 11 Feb 2014 14:51:21 -0500 (EST)
In-Reply-To: <20140210212931.GA16154@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Feb 2014 16:29:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1B25124-9355-11E3-B8FB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241958>

Jeff King <peff@peff.net> writes:

> I dug in the history to see if there was any reasoning given for the
> current "off by default" setting. It looks like Junio asked for it when
> the original http-push tests were added, and everything else just
> followed that. The reasoning there was basically "they're heavyweight
> and we might not be able to run them", but hopefully having the option
> variable will make that OK.

Will queue, thanks.

I may have originally asked for it for one reason, thinking that one
reason would be enough while having another reason not to run them
as well.  But there would be countless silent others who have been
depending on that choice.

Those who run buildfarms may want to disable the networking test if
the buildfarms are not isolated well, for example.  They have to be
told somewhere that now they need to explicitly disable these tests
and how.

I am in favor of this change but just pointing out possible fallouts
might be larger than we think.

>  t/lib-git-daemon.sh     |  8 +++++---
>  t/lib-httpd.sh          | 22 +++++++++++-----------
>  t/test-lib-functions.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 14 deletions(-)
>
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index 1f22de2..e623bef 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -16,9 +16,10 @@
>  #	stop_git_daemon
>  #	test_done
>  
> -if test -z "$GIT_TEST_GIT_DAEMON"
> +GIT_TEST_GIT_DAEMON=$(test_tristate "$GIT_TEST_GIT_DAEMON")
> +if test "$GIT_TEST_GIT_DAEMON" = false
>  then
> -	skip_all="git-daemon testing disabled (define GIT_TEST_GIT_DAEMON to enable)"
> +	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
>  	test_done
>  fi
>  
> @@ -58,7 +59,8 @@ start_git_daemon() {
>  		kill "$GIT_DAEMON_PID"
>  		wait "$GIT_DAEMON_PID"
>  		trap 'die' EXIT
> -		error "git daemon failed to start"
> +		test_skip_or_die $GIT_TEST_GIT_DAEMON \
> +			"git daemon failed to start"
>  	fi
>  }
>  
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index b43162e..bb900ca 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -30,9 +30,10 @@
>  # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
>  #
>  
> -if test -z "$GIT_TEST_HTTPD"
> +GIT_TEST_HTTPD=$(test_tristate "$GIT_TEST_HTTPD")
> +if test "$GIT_TEST_HTTPD" = false
>  then
> -	skip_all="Network testing disabled (define GIT_TEST_HTTPD to enable)"
> +	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
>  	test_done
>  fi
>  
> @@ -76,8 +77,7 @@ GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
>  
>  if ! test -x "$LIB_HTTPD_PATH"
>  then
> -	skip_all="skipping test, no web server found at '$LIB_HTTPD_PATH'"
> -	test_done
> +	test_skip_or_die $GIT_TEST_HTTPD "no web server found at '$LIB_HTTPD_PATH'"
>  fi
>  
>  HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
> @@ -89,19 +89,20 @@ then
>  	then
>  		if ! test $HTTPD_VERSION -ge 2
>  		then
> -			skip_all="skipping test, at least Apache version 2 is required"
> -			test_done
> +			test_skip_or_die $GIT_TEST_HTTPD \
> +				"at least Apache version 2 is required"
>  		fi
>  		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
>  		then
> -			skip_all="Apache module directory not found.  Skipping tests."
> -			test_done
> +			test_skip_or_die $GIT_TEST_HTTPD \
> +				"Apache module directory not found"
>  		fi
>  
>  		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
>  	fi
>  else
> -	error "Could not identify web server at '$LIB_HTTPD_PATH'"
> +	test_skip_or_die $GIT_TEST_HTTPD \
> +		"Could not identify web server at '$LIB_HTTPD_PATH'"
>  fi
>  
>  prepare_httpd() {
> @@ -155,9 +156,8 @@ start_httpd() {
>  		>&3 2>&4
>  	if test $? -ne 0
>  	then
> -		skip_all="skipping test, web server setup failed"
>  		trap 'die' EXIT
> -		test_done
> +		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
>  	fi
>  }
>  
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index aeae3ca..3cc09c0 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -716,6 +716,50 @@ perl () {
>  	command "$PERL_PATH" "$@"
>  }
>  
> +# Normalize the value given in $1 to one of "true", "false", or "auto". The
> +# result is written to stdout. E.g.:
> +#
> +#     GIT_TEST_HTTPD=$(test_tristate "$GIT_TEST_HTTPD")
> +#
> +test_tristate () {
> +	case "$1" in
> +	""|auto)
> +		echo auto
> +		;;
> +	*)
> +		# Rely on git-config to handle all the variants of
> +		# true/1/on/etc that we allow.
> +		if ! git -c magic.hack="$1" config --bool magic.hack 2>/dev/null
> +		then
> +			# If git-config failed, it was some non-bool value like
> +			# YesPlease. Default this to "true" for historical
> +			# compatibility.
> +			echo true
> +		fi
> +	esac
> +}
> +
> +# Exit the test suite, either by skipping all remaining tests or by
> +# exiting with an error. If "$1" is "auto", we then we assume we were
> +# opportunistically trying to set up some tests and we skip. If it is
> +# "true", then we report a failure.
> +#
> +# The error/skip message should be given by $2.
> +#
> +test_skip_or_die () {
> +	case "$1" in
> +	auto)
> +		skip_all=$2
> +		test_done
> +		;;
> +	true)
> +		error "$2"
> +		;;
> +	*)
> +		error "BUG: test tristate is '$1' (real error: $2)"
> +	esac
> +}
> +
>  # The following mingw_* functions obey POSIX shell syntax, but are actually
>  # bash scripts, and are meant to be used only with bash on Windows.
