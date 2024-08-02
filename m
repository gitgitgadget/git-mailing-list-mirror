Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD51175D3A
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613933; cv=none; b=DUFu2KEiMjKJTZ98f9JEdSKMwj+T7oAMQWZw4NyG5NMMWVxm9twBsfaBer3hYx502rsE3gxXgTvx5LN3QWD6WZrqF4PMYvCjkEKnpyFvWpsj4ULRrP8p5JLYz5hTpFLP+iOPksKkNIxqLp5VISSDB3/7zyv//hdJ6Ybby0tP0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613933; c=relaxed/simple;
	bh=RI3KIaNXkkRi+RsDxlZkY6wsasi2czjjTSZ1SAwJ5Rw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nzfmrGW+0AB/rC59evljBRJrfnrgB9McM/aDMSqm703mOMrcqsJ/ETELT0c47zL7Cp7IKnBrE/klQK1rCbMP23rgwOjG+/lTOfqS8W8KD6q422RVVt54HWDQNTFqEDYXm8J8ChAj3GHyhE7dV+A1an3/wMZA98n7LydASZbsMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IsJO58bM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IsJO58bM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B273A346A4;
	Fri,  2 Aug 2024 11:52:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RI3KIaNXkkRi+RsDxlZkY6wsasi2czjjTSZ1SA
	wJ5Rw=; b=IsJO58bMPLGC8aq1Dkqc9vK6SDhAYKEPC/vb7NPlZhMszBiyzv9FDx
	PEN0lv9l7uU4PWD2R9BbzeON4Z7nmeQX+2QnusmM50JEgJruFJhcPT1tnQSxWY+C
	NCkUg7QoBAkVJ3XbarhxPjg4aPaT+B533FAdy9/TapFFYUxbRXDD4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AAB3B346A3;
	Fri,  2 Aug 2024 11:52:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A46B8346A0;
	Fri,  2 Aug 2024 11:52:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] http: do not ignore proxy path
In-Reply-To: <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com> (Ryan
	Hendrickson via GitGitGadget's message of "Fri, 02 Aug 2024 05:20:07
	+0000")
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 08:52:05 -0700
Message-ID: <xmqq7ccygbx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2BF477A8-50E7-11EF-98C2-92D9AF168FA5-77302942!pb-smtp20.pobox.com

"Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
>
> The documentation for `http.proxy` describes that option, and the
> environment variables it overrides, as supporting "the syntax understood
> by curl". curl allows SOCKS proxies to use a path to a Unix domain
> socket, like `socks5h://localhost/path/to/socket.sock`. Git should
> therefore include, if present, the path part of the proxy URL in what it
> passes to libcurl.
>
> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

The trailer lines should be ordered in chronological order to record
the provenance of the patch.  The last two entries make it look as
if what you assembled and signed-off was relayed by peff, with or
without further modification, with his sign-off to me, to become the
final version, but that is not the story you want to tell.

I'd swap the two lines (i.e., sign-offs) while queuing.

> +			if (!starts_with(proxy_auth.protocol, "socks"))
> +				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
> +				    curl_http_proxy);

Our error messages that are prefixed with "fatal:" do not typically
begin with a capital letter.

But I'll let it pass, as this copies an existing message in this
file.  #leftoverbits clean-up needs to correct the ones added by
this patch and existing "Invalid proxy URL '%s'" by downcasing
"Invalid", possibly enclose the message in _() for i18n, and also
downcase "C" in two "Could not set SSL ..."  messages.

> +			if (strcasecmp(proxy_auth.host, "localhost"))
> +				die("Invalid proxy URL '%s': host must be localhost if a path is present",
> +				    curl_http_proxy);

Ditto.

Or instead of leaving this for a later clean-up after the dust
settles, we could have a separate "preliminary clean-up" patch to
address existing ones first.  Either is fine, but taking "clean-up
after the dust settles" and leaving it a problem for other people is
probably easier.

> diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
> index bb35b87071d..0d6cfebbfab 100755
> --- a/t/t5564-http-proxy.sh
> +++ b/t/t5564-http-proxy.sh
> @@ -39,4 +39,53 @@ test_expect_success 'clone can prompt for proxy password' '
>  	expect_askpass pass proxuser
>  '
>  
> +start_socks() {
> +	mkfifo socks_output &&
> +	{
> +		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
> +		echo $! > "$TRASH_DIRECTORY/socks.pid"
> +	} &&
> +	read line <socks_output &&
> +	test "$line" = ready
> +}
> +
> +# The %30 tests that the correct amount of percent-encoding is applied to the
> +# proxy string passed to curl.
> +test_lazy_prereq SOCKS_PROXY 'test_have_prereq PERL && start_socks "$TRASH_DIRECTORY/%30.sock"'
> +
> +test_atexit 'test ! -e "$TRASH_DIRECTORY/socks.pid" || kill "$(cat "$TRASH_DIRECTORY/socks.pid")"'

Let's line-wrap these overly long ones.

        # The %30 tests that the correct amount of percent-encoding is
        # applied to the proxy string passed to curl.
        test_lazy_prereq SOCKS_PROXY '
                test_have_prereq PERL &&
                start_socks "$TRASH_DIRECTORY/%30.sock"
        '

        test_atexit '
                test ! -e "$TRASH_DIRECTORY/socks.pid" ||
                kill "$(cat "$TRASH_DIRECTORY/socks.pid")"
        '

> +# The below tests morally ought to be gated on a prerequisite that Git is
> +# linked with a libcurl that supports Unix socket paths for proxies (7.84 or
> +# later), but this is not easy to test right now. Instead, we || the tests with
> +# this function.
> +old_libcurl_error() {
> +	grep -Fx "fatal: libcurl 7.84 or later is required to support paths in proxy URLs" "$1"
> +}

Cute.  

This fixes the polarity of the result from the whole "{ test } ||
this helper" construct.  Even if the test proper fails, we will
allow such a failure only when the reason of the failure is due to
this message.

If I were writing this, I would shorten to look for a bit fuzzier
pattern like

    grep "^fatal: .* is required to support paths in proxy URLs" "$1"

as that would allow us to fix the code later without needing to
update the pattern, if we discover reasons, other than being older
than libcURL 7.84, why paths in proxy URLs cannot be supported.

Other than that, very nicely done.

Thanks.
