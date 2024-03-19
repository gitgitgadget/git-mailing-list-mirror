Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DC4C63
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710880273; cv=none; b=V3gN7BtvpNUkC7t7opwn4fFG6Qhc/MXT5IPmt00rF4QsZWIDKfXDmnEuCXlMxV6E9oujb7M+P3zE1q6zii3XHNuNs1G3aOxfj0+asAscPSFliPpAcUrWbO2tzQ41z8MFJBZpV+DxpTGETeQyBcuXttHGD6drx0XkK7DUoBhadBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710880273; c=relaxed/simple;
	bh=wRGHdk6IrzUsw3YBCCQgAjgloP5sy1TN+w6VZFdtL4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUB2MLTdNmp/YxItYZ6Y9E2O6ch3DwT6/JDBHCUgsJmANkeAySBqphn/QBNtojERA32oerZViA6GFPcnl4S/ZK78fjrS2QOiybO8Sv71pMyJT9uOHxbxT/O1QGuoO6kYM6rv6rmUO6zrwzgn6LHb9T2GL4uWTfGsCs8gyIV8H1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JwQGzaMz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JwQGzaMz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EA311293DF;
	Tue, 19 Mar 2024 16:31:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wRGHdk6IrzUsw3YBCCQgAjgloP5sy1TN+w6VZF
	dtL4g=; b=JwQGzaMzvIumr+UIXY10zpSSphKqwu8ZCivamRDIjghXMih6LaeTbO
	JcMiPU9Hot6/EzEIIvwApV2LiFM1FHfNlfZ3WB2heI3X8KdOxKRhRHgehPmIHeIi
	aRumbmIOvH4id9uvTrOkzVRQU7Gxcf075H3vArUqaKgfgw0s1qM08=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E2A27293DE;
	Tue, 19 Mar 2024 16:31:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 64FA7293DC;
	Tue, 19 Mar 2024 16:31:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
In-Reply-To: <20240319183722.211300-2-ignacio@iencinas.com> (Ignacio Encinas's
	message of "Tue, 19 Mar 2024 19:37:21 +0100")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<20240319183722.211300-2-ignacio@iencinas.com>
Date: Tue, 19 Mar 2024 13:31:06 -0700
Message-ID: <xmqq8r2eneut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E08BC6E-E62F-11EE-9FD5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ignacio Encinas <ignacio@iencinas.com> writes:

> diff --git a/Makefile b/Makefile
> index 4e255c81f223..561d7a1fa268 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -863,6 +863,7 @@ TEST_BUILTINS_OBJS += test-userdiff.o
>  TEST_BUILTINS_OBJS += test-wildmatch.o
>  TEST_BUILTINS_OBJS += test-windows-named-pipe.o
>  TEST_BUILTINS_OBJS += test-write-cache.o
> +TEST_BUILTINS_OBJS += test-xgethostname.o
>  TEST_BUILTINS_OBJS += test-xml-encode.o
>  
>  # Do not add more tests here unless they have extra dependencies. Add
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 482a1e58a4b6..9318900a2981 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -86,6 +86,7 @@ static struct test_cmd cmds[] = {
>  	{ "truncate", cmd__truncate },
>  	{ "userdiff", cmd__userdiff },
>  	{ "urlmatch-normalization", cmd__urlmatch_normalization },
> +	{ "xgethostname", cmd__xgethostname },
>  	{ "xml-encode", cmd__xml_encode },
>  	{ "wildmatch", cmd__wildmatch },
>  #ifdef GIT_WINDOWS_NATIVE
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index b1be7cfcf593..075d34bd3c0a 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -79,6 +79,7 @@ int cmd__trace2(int argc, const char **argv);
>  int cmd__truncate(int argc, const char **argv);
>  int cmd__userdiff(int argc, const char **argv);
>  int cmd__urlmatch_normalization(int argc, const char **argv);
> +int cmd__xgethostname(int argc, const char **argv);
>  int cmd__xml_encode(int argc, const char **argv);
>  int cmd__wildmatch(int argc, const char **argv);
>  #ifdef GIT_WINDOWS_NATIVE
> diff --git a/t/helper/test-xgethostname.c b/t/helper/test-xgethostname.c
> new file mode 100644
> index 000000000000..285746aef54a
> --- /dev/null
> +++ b/t/helper/test-xgethostname.c
> @@ -0,0 +1,12 @@
> +#include "test-tool.h"
> +
> +int cmd__xgethostname(int argc, const char **argv)
> +{
> +	char hostname[HOST_NAME_MAX + 1];
> +
> +	if (xgethostname(hostname, sizeof(hostname)))
> +		die("unable to get the host name");
> +
> +	puts(hostname);
> +	return 0;
> +}


OK.  Given that xgethostname() is meant as a safe (and improved)
replacement for the underlying gethostname(), I would have used
gethostname() as the name for the above, but that alone is not big
enough reason for another update.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 18fe1c25e6a0..613c766e2bb4 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -395,7 +395,6 @@ test_expect_success 'background auto gc respects lock for all operations' '
>  
>  	# now fake a concurrent gc that holds the lock; we can use our
>  	# shell pid so that it looks valid.
> -	hostname=$(hostname || echo unknown) &&
>  	shell_pid=$$ &&
>  	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
>  	then
> @@ -404,7 +403,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
>  		# the Windows PID in this case.
>  		shell_pid=$(cat /proc/$shell_pid/winpid)
>  	fi &&
> -	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
> +	printf "%d %s" "$shell_pid" "$(test-tool xgethostname)" >.git/gc.pid &&

We should replace the "hostname || echo unknown" in the original,
instead of doing this change, as it loses the exit status from the
"test-tool xgethostname" command.

Thanks.

>  	# our gc should exit zero without doing anything
>  	run_and_wait_for_auto_gc &&
