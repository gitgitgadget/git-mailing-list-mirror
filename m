Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AD176FA3
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494580; cv=none; b=BJBYR4Arwhh2AfRBoSQmtkvwQOnRVtaJULjRrlPFAwefZQND771K04jn3D3fFgwj2HrxOdgND+7elXyn2C4a4kn2/eT/IRExoh4OsSsEX7Fj0Krr4UmGXH6SSDgES4GjwJHGS/aPl3tqltwoyLQkjC//B/4PgSnXsTtKYasSwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494580; c=relaxed/simple;
	bh=uVgMnFjjTLRg+q5mashjfQ+ydD7NJwn2uMLTrXpoXb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjU7IOdsIK/HqQtvqIXJe2/gct2PO+DLsWvnuSvx30G9Uh9STfJVnYEVOxRZ2h4SM06AGrWEmfIvcpp3MZGejleWO3b5/wehRqZ41BIeW6q2wVE6aDf9nvXc7RNzY9qj8kTTykMKAF1kYc/ElR51auzoGSpQKzmy7hWlLf1PaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=us/KyBy2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="us/KyBy2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CE3C720476;
	Tue, 30 Apr 2024 12:29:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uVgMnFjjTLRg+q5mashjfQ+ydD7NJwn2uMLTrX
	poXb8=; b=us/KyBy2v0CwsQOc3/iWmA67hCE0xEPrhOYVTiVJxZqNNpmRX3W3kS
	5nIHTDu+kR77FCNDqrQHzQzBl2WYYzf88GAOTgSEgSbtEQc9lg5smx6mD+2GgUum
	YdWklHinfMNNPwAWmrO+HY9kC2Qox15wt5XyJUBW/cRCsYazT0UhA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C678A20475;
	Tue, 30 Apr 2024 12:29:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4C9F20474;
	Tue, 30 Apr 2024 12:29:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] advice: add --no-advice global option
In-Reply-To: <20240430014724.83813-2-james@jamesliu.io> (James Liu's message
	of "Tue, 30 Apr 2024 11:47:24 +1000")
References: <20240429010925.93205-1-james@jamesliu.io>
	<20240430014724.83813-1-james@jamesliu.io>
	<20240430014724.83813-2-james@jamesliu.io>
Date: Tue, 30 Apr 2024 09:29:26 -0700
Message-ID: <xmqqbk5qstjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D0F1D84A-070E-11EF-B026-A19503B9AAD1-77302942!pb-smtp21.pobox.com

James Liu <james@jamesliu.io> writes:

> Advice hints must be disabled individually by setting the relevant
> advice.* variables to false in the Git configuration. For server-side
> and scripted usages of Git where hints aren't necessary, it can be
> cumbersome to maintain configuration to ensure all advice hints are

It is not that scripted use decline hints because they are not
"necessary"; it is they find the hints harmful for whatever reason.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7a1b112a3e..ef1d9dce5d 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
>      [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
>      [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
> -    [--config-env=<name>=<envvar>] <command> [<args>]
> +    [--config-env=<name>=<envvar>] [--no-advice] <command> [<args>]

Move the new one near [--no-replace-objects] to group the --no-*
options together.

This is not a fault of this patch, but I notice "--no-lazy-fetch"
and "--no-optional-locks" are not listed here (there may be others,
I didn't check too deeply).  It might make sense to have a separate
clean-up step to move the --no-* "ordinarily we would never want to
disable these wholesale, but for very special needs here are the
knobs to toggle them off" options together in the DESCRIPTION
section and add missing ones to the SYNOPSIS section.

> diff --git a/advice.c b/advice.c
> index 75111191ad..abad9ccaa2 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -2,6 +2,7 @@
>  #include "advice.h"
>  #include "config.h"
>  #include "color.h"
> +#include "environment.h"
>  #include "gettext.h"
>  #include "help.h"
>  #include "string-list.h"
> @@ -126,7 +127,12 @@ void advise(const char *advice, ...)
>  
>  int advice_enabled(enum advice_type type)
>  {
> -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
> +	int enabled;
> +
> +	if (!git_env_bool(GIT_ADVICE, 1))
> +		return 0;

How expensive is it to check git_env_bool() every time without
caching the parsing of the value given to the environment variable?
Everybody pays this price but for most users who do not set the
environment variable it is not a price we want them to pay.

One way to solve that might be to just insert these

	static int advice_enabled = -1;

	if (advice_enabled < 0)
		advice_enabled = git_env_bool(GIT_ADVICE_ENVIRONMENT, 1)
	if (!advice_enabled)
		return 0;

and leave everything else intact.  We do not even need to split the
declalation+initialization into a ...

> +	enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;

... separate assignment.

> +/*
> + * Environment variable used to propagate the --no-advice global option to the
> + * advice_enabled() helper, even when run in a subprocess.
> + * This is an internal variable that should not be set by the user.
> + */
> +#define GIT_ADVICE "GIT_ADVICE"

As Patrick pointed out, this should be GIT_ADVICE_ENVIRONMENT or
something.

> diff --git a/git.c b/git.c
> index 654d615a18..6283d126e5 100644
> --- a/git.c
> +++ b/git.c
> @@ -38,7 +38,7 @@ const char git_usage_string[] =
>  	   "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
>  	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
>  	   "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
> -	   "           [--config-env=<name>=<envvar>] <command> [<args>]");
> +	   "           [--config-env=<name>=<envvar>] [--no-advice] <command> [<args>]");

Ditto.

> diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
> index 0dcfb760a2..2ce2d4668a 100755
> --- a/t/t0018-advice.sh
> +++ b/t/t0018-advice.sh
> @@ -29,4 +29,24 @@ test_expect_success 'advice should not be printed when config variable is set to
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success 'advice should not be printed when --no-advice is used' '
> +	cat << EOF > expect &&

Style.  Between the redirection operator and the file that the
operator operates on, there should be no SP.

> +On branch master
> +
> +No commits yet
> +
> +Untracked files:
> +	README

Something like

	q_to_tab >expect <<\-EOF
	On branch master
	...
	Untracked files:
	QREADME
	
	nothing added to ...
	EOF

or

	sed -e "s/^|//" >expect <<\-EOF
	On branch master
	...
	Untracked files:
	|	README
	
	nothing added to ...
	EOF

would work better.

> +	git init advice-test &&
> +  test_when_finished "rm -fr advice-test" &&

Funny indentation.  Also if "git init" fails in the middle, after
creating the directory but before completing, your when-finished
handler fails to register.

> +  cd advice-test &&

Do not chdir around without being inside a subshell.  If we have to
add new tests later to this script, you do not want them to start in
the directory that you are going to remove at the end of this test.

> +  touch README &&

When you do not care about the timestamp, avoid using "touch".  Writing

	>README &&

instead would make it clear that you ONLY care about the presense of
the file, not even its contents.

> +  git --no-advice status > ../actual &&
> +  test_cmp ../expect ../actual

So, taken together:

	(
		cd advice-test &&
		>README &&
		git --no-advice status
	) >actual &&
	test_cmp expect actual

> +'
> +
>  test_done

Thanks.
