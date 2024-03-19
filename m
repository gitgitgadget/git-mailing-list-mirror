Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E03BBC7
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881641; cv=none; b=SRwxbciWtpf2KLlJ9NlA2bHz5LrDlGHvVp+ltOt1aLAMFwUI+qJfu8BkRUewqSLxzo9f9hgctmmdNeDsV14+yhnc7sXmNKkMNzuqwFT7AtDO/LFRQTNU3B6mKtkieMKffUqeItnJaKnLUVAfPIGfnZbsrYIr3iXWg9dE8QOxpl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881641; c=relaxed/simple;
	bh=7HMd+Vl2B9GGH+7lf7MpAKAm13V1p/ldvzB4Y3hJi2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lrv0W+mSaZ5CrIgeziC95ZjmC6FavoIdx07tyYilSZodqWs9ZiUoIRLBWdvu3g8Mhx7PP+oIAZNTlIudo4wKSjL1rCICHp05u3v/ggoF8YuS4KxWMAFcugmpm1ujJYY2UbQAqrGqjWX8OZQiFDR2aRcbCCuTkWXqPdMxuy80oJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HHmxnSv8; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HHmxnSv8"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 87C4229785;
	Tue, 19 Mar 2024 16:53:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7HMd+Vl2B9GGH+7lf7MpAKAm13V1p/ldvzB4Y3
	hJi2M=; b=HHmxnSv8fVcGFgclanqWODxwmo8RcMeHjtvyW7I+8azpzmXUzAnXTg
	JLlMpulOnYobtQMmwlrtJXbnnvSdZGwsQBStLXy018Yzhcv5imb6SoZDDY5eB2DP
	VznfSYhbGsfIeqIQQNx6gPT19FWr1G5vfv0wOzMQetBCxi0exIquo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 80B4E29784;
	Tue, 19 Mar 2024 16:53:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06DC829783;
	Tue, 19 Mar 2024 16:53:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] config: learn the "hostname:" includeIf condition
In-Reply-To: <20240319183722.211300-3-ignacio@iencinas.com> (Ignacio Encinas's
	message of "Tue, 19 Mar 2024 19:37:22 +0100")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<20240319183722.211300-3-ignacio@iencinas.com>
Date: Tue, 19 Mar 2024 13:53:54 -0700
Message-ID: <xmqqsf0mlz8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD320B64-E632-11EE-B5C4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ignacio Encinas <ignacio@iencinas.com> writes:

> Currently, customizing the configuration depending on the machine running
> git has to be done manually.

Drop "currently" (cf. https://lore.kernel.org/git/xmqqle6xbep5.fsf@gitster.g/)

It does not actually have to be done manually.  I and many others
have ~/src/home/dot/ directory where ~/src/home/dot/Makefile uses
information available in the environment (like output from the
`hostname` command), produces the .gitconfig file out of a template,
and the build procedure can even install with "make install" the
resulting file to "~/.gitconfig".  Together with other configuration
files that are kept track of in the ~/src/home/ repository, it is
managed wihtout much manual labor.

Another reason why "[includeif hostname:<name>]" may be useful is
when the same home directory is shared across multiple machines.  
As ~/.gitconfig is shared, if you need to have different settings
depending on the host, you would need to have something that a
single file ~/.gitconfig is read in different ways on these hosts.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e3a74dd1c19d..268a9fab7be0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -186,6 +186,12 @@ As for the naming of this keyword, it is for forwards compatibility with
>  a naming scheme that supports more variable-based include conditions,
>  but currently Git only supports the exact keyword described above.
>  
> +`hostname`::
> +	The data that follows the keyword `hostname:` is taken to be a
> +	pattern with standard globbing wildcards. If the current
> +	hostname (output of gethostname(2)) matches the
> +	pattern, the include condition is met.
> +

I do not think of a better way to phrase to explain what `hostname`
means in this context than the above, either.  This should be good
enough, hopefully ;-).

The entry above this one is really an oddball (it only depends on
what other repositories the current repository interacts with, and
does not care about host, directory, or anything of the sort); we
may want to move it either before the `onbranch` entry.

> diff --git a/config.c b/config.c
> index 3cfeb3d8bd99..50b3f6d24c50 100644
> --- a/config.c
> +++ b/config.c
> @@ -317,6 +317,21 @@ static int include_by_branch(const char *cond, size_t cond_len)
>  	return ret;
>  }
>  
> +static int include_by_hostname(const char *cond, size_t cond_len)
> +{
> +	int ret;
> +	char my_host[HOST_NAME_MAX + 1];
> +	struct strbuf pattern = STRBUF_INIT;
> +
> +	if (xgethostname(my_host, sizeof(my_host)))
> +		return 0;
> +
> +	strbuf_add(&pattern, cond, cond_len);
> +	ret = !wildmatch(pattern.buf, my_host, 0);
> +	strbuf_release(&pattern);
> +	return ret;
> +}

OK.  Just as other conditions, it is a bit annoying that we need to
make a copy of cond string only to NUL terminate it, because
wildmatch() does not take a counted string as its input, but the
above code looks good.

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 5cde79ef8c4f..ef9272fd8e53 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -357,4 +357,46 @@ test_expect_success 'include cycles are detected' '
>  	grep "exceeded maximum include depth" stderr
>  '
>  
> +test_expect_success 'conditional include, hostname' '
> +	cat >>.git/config <<-EOF &&
> +	[includeIf "hostname:$(test-tool xgethostname)a"]
> +		path = bar12
> +	EOF

Exactly the same comment about lost exit status from test-tool
applies here, too.

> +	cat >>.git/bar12 <<-EOF &&
> +	[test]
> +		twelve=12
> +	EOF
> +
> +	test_must_fail git config test.twelve &&
> +
> +	cat >>.git/config <<-EOF &&
> +	[includeIf "hostname:$(test-tool xgethostname)"]
> +		path = bar12
> +	EOF
> +	echo 12 >expect &&
> +	git config test.twelve >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'conditional include, hostname, wildcard' '
> +	cat >>.git/config <<-EOF &&
> +	[includeIf "hostname:$(test-tool xgethostname)a*"]

Hmph, a* is not even "one-or-more a" but "a followed by anything",
so this will not match, OK.

> +		path = bar13
> +	EOF
> +	cat >>.git/bar13 <<-EOF &&
> +	[test]
> +		thirteen = 13
> +	EOF
> +
> +	test_must_fail git config test.thirteen &&
> +
> +	cat >>.git/config <<-EOF &&
> +	[includeIf "hostname:$(test-tool xgethostname)*"]

And this is "exactly what gethostname gives, followed by anything
(including nothing)", so gethostname output should match.  OK.

> +		path = bar13
> +	EOF
> +	echo 13 >expect &&
> +	git config test.thirteen >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
