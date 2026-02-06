Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB161F4181
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770352918; cv=none; b=b/DSnxcftliGfqCrt2mV0t1rYSFFgATKH/4NZvlrfHX4mCJhGzDJdhhvs/rjnnE4FFKQNRjBuRER/QffwNGXsMYhrMn3K8sb0UjUSoxh4nZDh4QdmdssNo3VtzjVIjx0jP3Y1rhmYNuj4pc3Mqt7/rpJGHSFMrojR8d0mzEFoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770352918; c=relaxed/simple;
	bh=jY+dF76eXWTjC8zafN3qA+YIVsm7AXjeXPhjkUCVPv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9Y2w+mbnSMDGvMKoKe9a2qRudpXnk+hdJGWkNaxwfUVwovkesieVacJ5wRZUBiS4yHSguXgWeymWXdZ65jQU9+2+xENSZMS9+WYDGg9Mgj77wS4WtOT5vRs2TN4lKQ38yJZ86Di0laZJ5aANG6yPBySaKzoW9WHlUKgd6fr6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=r1M1sfAY; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="r1M1sfAY"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 969AFB00539;
	Fri,  6 Feb 2026 05:41:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770352916;
	bh=jY+dF76eXWTjC8zafN3qA+YIVsm7AXjeXPhjkUCVPv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r1M1sfAY0VFiegBkL/0bP4EIALCCXAUEBnqaykuPsoTTTEpOwbSERz/38u6YMYNb8
	 Y9D5QDsaUHBGoTY4MblmJFyVCVOc2ZB6F+4RY6mqEkZx+Vi4+SaLsg2XFK2bD+58t4
	 lk1M1pr7YyTKuwWt88YHPIWJlI+XQwNWj3gcWUdEddvxGb0Lw5RZujWnfmevuGqwUL
	 lltoJGN+gEVgfgfsY+N+HyZP25ZR89HsMNZnAEvpS/hhGhT2hkBKunZTmUc4RL0i95
	 5rexlHqTEcAxfKgL88w1ZgO4goM5XQcwUzC3aa0EnCa4KWJZjfP06cdtDqzACNuB0Q
	 D6ILlupJJJQqQ==
Message-ID: <61926b22-dca1-4e5d-a911-6fc47dee68d6@free.fr>
Date: Fri, 6 Feb 2026 05:41:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] config-batch: implement get v1
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <3de1bba3b10668f0200e27def9128571f51c1f68.1770214803.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <3de1bba3b10668f0200e27def9128571f51c1f68.1770214803.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/02/2026 à 15:19, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <stolee@gmail.com>
> 
> The 'get' command for the 'git config-batch' builtin is the first command
> and is currently at version 1. It returns at most one value, the same as
> 'git config --get <key>' with optional value-based filtering.
> 
> The documentation and tests detail the specifics of how to format requests
> of this format and how to parse the results.
> 
> Future versions could consider multi-valued responses or regex-based key
> matching.
> 
> For the sake of incremental exploration of the potential in the 'git
> config-batch' command, this is the only implementation being presented in
> the first patch series.
> 
> Future extensions could include a '-z' parameter that uses NUL bytes in the
> command and output format to allow for spaces or newlines in the input or
> newlines in the output.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-config-batch.adoc |  53 +++++-
>  builtin/config-batch.c              | 251 +++++++++++++++++++++++++++-
>  config.h                            |   3 +
>  t/t1312-config-batch.sh             | 101 +++++++++++
>  4 files changed, 405 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
> index 9ca04b0c1e..31dd42f481 100644
> --- a/Documentation/git-config-batch.adoc
> +++ b/Documentation/git-config-batch.adoc
> @@ -32,9 +32,58 @@ set. Thus, if the Git version includes the `git config-batch` builtin
>  but doesn't understand an input command, it will return a single line
>  response:
>  
> -```
> +------------
>  unknown_command LF
> -```
> +------------
> +

OK, the change to Asciidoc code block is done here. Would it be possible
to push it up at the introduction of these lines?

> +These are the commands that are currently understood:
> +
> +`get` version 1::
> +	The `get` command searches the config key-value pairs within a
> +	given `<scope>` for values that match the fixed `<key>` and

The rendering of these is correct due to the synopsis formatter, but we
usually prefer to use the direct formatting for placeholders: _<scope>_,
_<key>_,…

> +	filters the resulting value based on an optional `<value-filter>`.
> +	This can either be a regex or a fixed value. The command format
> +	is one of the following formats:
> ++
> +------------
> +get 1 <scope> <key>
> +get 1 <scope> <key> arg:regex <value-pattern>
> +get 1 <scope> <key> arg:fixed-value <value>
> +------------
> ++

If you are using synopsis style in the block, with the upcoming change
of synopsis style block[1], you can format it:

[synopsis]
------------
get 1 <scope> <key>
get 1 <scope> <key> arg:regex <value-pattern>
get 1 <scope> <key> arg:fixed-value <value>
------------

> +The `<scope>` value can be one of `inherited`, `system`, `global`,
> +`local`, `worktree`, `submodule`, or `command`. If `inherited`, then all
> +config key-value pairs will be considered regardless of scope. Otherwise,
> +only the given scope will be considered.
> ++
> +If no optional arguments are given, then the value will not be filtered
> +by any pattern matching. If `arg:regex` is specified, then the rest of
> +the line is considered a single string, `<value-pattern>`, and is
> +interpreted as a regular expression for matching against stored values,
> +similar to specifying a value to `get config --get <key> "<value-pattern>"`.
> +If `arg:fixed-value` is specified, then the rest of the line is
> +considered a single string, `<value>`, and is checked for an exact
> +match against the key-value pairs, simmilar to `git config --get <key>

similar

> +--fixed-value "<value>"`.
> ++

Here I would use a sub definition list for each matching type, instead
of long running description paragraph.

optional arguments can be specified:

no optional arguments;;
the value will not be filteredby any pattern matching.
`arg:regex <value-pattern>`;;
`<value-pattern>` is interpreted as a regular expression for matching
against stored values, similar to specifying a value to `get config
--get <key> "<value-pattern>"`.
`arg:fixed-value <value>`;;
`<value>` is checked for an exact match against the key-value pairs,
similar to `git config --get <key>`.

> +At mmost one key-value pair is returned, that being the last key-value

At most

> +pair in the standard config order by scope and sequence within each scope.
> ++
> +If a key-value pair is found, then the following output is given:
> ++
> +------------
> +get 1 found <key> <scope> <value>
> +------------
> ++
> +If no matching key-value pair is found, then the following output is
> +given:
> ++
> +------------
> +get 1 missing <key> [<value-pattern>|<value>]
> +------------
> ++

Please also apply synopsis block style.

> +where `<value-pattern>` or `<value>` is only supplied if provided in
> +the command.
>  
>  SEE ALSO
>  --------

[1]:
https://lore.kernel.org/git/6a2b94e720862fa07fe9463ebf7f7beaa9a1ccd4.1770351146.git.gitgitgadget@gmail.com/T/#u
