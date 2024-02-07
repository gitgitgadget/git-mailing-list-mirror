Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99712B149
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338898; cv=none; b=f/arhC9hsC7p0RMUQx833dGmRgCK66jR/arRj3Ps34kKNn53OkstqzM7yI01EHpzIWSRDVh5fJP01HW6FRk7V5pF1rmUJ7TKOpCkhQ/VFFazDoIFesUFLTX/2YhVVf5gCjasz9QiGDsV/Fiv84N6fVWqmgj/jrnUFfLkrat9cEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338898; c=relaxed/simple;
	bh=09KbFdZUCE3lseE/34yRD7UFOfrP7z8YsBSxEzn/Pvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfq8G+gXGOCxITE8nRvVEObxmuqBjE47fv/2Ls2IuSR10OXAJDvEP/lHE5oRYZwWJx5hzGcKo+8T4w+tglwuWWvj1eRiF19rN7pNz5YWBjFcGqVQBlpgsE3r02wwoFgh67pMBMnNIWpoTQImdK130IX4zQ7MGhwe2XOlbd+0dW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lb1KUdgc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lb1KUdgc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C3FD2EA56;
	Wed,  7 Feb 2024 15:48:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=09KbFdZUCE3lseE/34yRD7UFOfrP7z8YsBSxEz
	n/Pvg=; b=lb1KUdgcw1XuvAsobPGwE15jdfXX1vfyDPhnopJqpB4xmQNG25YDm5
	CUM6pd7yHXaii3Cjh0a8/JQd8Io0GcjcMe8XrE4jYbAnVin1Wjm8+7tDaes7j0Y0
	I1XMlx7kz1jCz9LJp2v3Xo66dGeaOBpaU2BYg//4NabJDbYRuJLQo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 843D72EA55;
	Wed,  7 Feb 2024 15:48:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E9F42EA53;
	Wed,  7 Feb 2024 15:48:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 4/6] test-tool run-command testsuite: support
 unit tests
In-Reply-To: <b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 2 Feb 2024 16:50:29 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<b5665386b56df91fa5d95ee5b11288b5853546f0.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 12:48:10 -0800
Message-ID: <xmqqbk8s80hh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 35473C64-C5FA-11EE-8081-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Teach the testsuite runner in `test-tool run-command testsuite` how to
> run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
> the programs directly from CWD, rather than defaulting to "sh" as an
> interpreter.

Hmph.  It sounds more like "the run-command testsuite subcommand
only runs programs in the current directory", not "assume" (which
implies there is a way to override the assumption).  Not that the
limitation would hurt us in any way, though.

> +	/*
> +	 * If we run without a shell, we have to provide the relative path to
> +	 * the executables.
> +	 */

It sounds more like "If TEST_SHELL_PATH is not given, then we run
them in the current directory.".

It is perfectly fine, because ...

>  	suite.shell_path = getenv("TEST_SHELL_PATH");
>  	if (!suite.shell_path)
> -		suite.shell_path = "sh";
> +		strbuf_addstr(&progpath, "./");
> +	path_prefix_len = progpath.len;
>  
>  	dir = opendir(".");
>  	if (!dir)
> @@ -180,13 +187,17 @@ static int testsuite(int argc, const char **argv)
> ...
>  		for (i = 0; i < argc; i++)
>  			if (!wildmatch(argv[i], p, 0)) {
> -				string_list_append(&suite.tests, p);
> +				strbuf_setlen(&progpath, path_prefix_len);
> +				strbuf_addstr(&progpath, p);
> +				string_list_append(&suite.tests, progpath.buf);
>  				break;
>  			}
>  	}

... this "prefixing" is done to a path discovered by readdir() from
a directory handle obtained by opendir(".").  If there were a way to
pass paths to executables directly, possibly as absolute paths, the
unconditional prefixing of "./" would have been a problem, but we do
not have such a facility, so this should be OK.

