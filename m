Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155515EFBD
	for <git@vger.kernel.org>; Mon, 27 May 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832121; cv=none; b=apPQrtKWLWm6Ac6K1m+wDIVEFjR+0ITCNRIcDWlRk8UGEe2tXSbfV0NZ4YP1FJoUGUxeuSnfTRiFDeGKIaJxq+hoev4enDyGeBUIEukvps2Sfyq9oa28Zgf9Q1hD8qmGMlX3Vtfiv5lAKk3vyyqSroaRZ4EvVaj9/6FMEd5yUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832121; c=relaxed/simple;
	bh=glze3qNohK1rHneTmaFeiq8QjKNgsXn+tK5TdtUb0Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JSXS873IM7Ck+Jkhcv3Lndtf6GPONtLrW2rpKlAZocxQHjXQIwNiCWXDER9PUhrH3efqpj+bd1ChH5mqVv0enptZIat061R2TDydKPCsZ9GuVW6uMr88VpZZa/MqYmvll8SE7G8NQ+B7LyZNYNh93epshAyaR5Zl4SKOrqgdBLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rN0IFvta; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rN0IFvta"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3CFA32E44;
	Mon, 27 May 2024 13:48:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=glze3qNohK1rHneTmaFeiq8QjKNgsXn+tK5Tdt
	Ub0Hk=; b=rN0IFvta9FWI2SKp0q6F5nrYKRzedS7BXLA3gPQm9Dzm2HpvUcpwq+
	gkz/d1l1iO85TXXMlsuUypJxa1KqO7e4U1HjRKdIvFLVFDwgg4kiqNYPvBwHRDpa
	mp48sJ+rrrwakoHVvVLxlYoeRCHcBluCJJAlx6hwXgkteOqM4PM1M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB9E532E43;
	Mon, 27 May 2024 13:48:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 177D032E42;
	Mon, 27 May 2024 13:48:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v7 2/3] Documentation: alias: add notes on shell expansion
In-Reply-To: <20240527003208.1565249-2-iwienand@redhat.com> (Ian Wienand's
	message of "Mon, 27 May 2024 10:30:48 +1000")
References: <20240525234454.1489598-1-iwienand@redhat.com>
	<20240527003208.1565249-1-iwienand@redhat.com>
	<20240527003208.1565249-2-iwienand@redhat.com>
Date: Mon, 27 May 2024 10:48:37 -0700
Message-ID: <xmqqmsob9mdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58E61566-1C51-11EF-B1F6-25B3960A682E-77302942!pb-smtp2.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> When writing inline shell for shell-expansion aliases (i.e. prefixed
> with "!"), there are some caveats around argument parsing to be aware
> of.  This series of notes attempts to explain what is happening more
> clearly.
>
> Signed-off-by: Ian Wienand <iwienand@redhat.com>
> ---
>  Documentation/config/alias.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This one has become much shorter but very much to the point.  

Let's further do "appended via `"$@"`" -> "added at the end".  The
example given in that bullet point would be easier to understand
that way.

Will queue.

> diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
> index 40851ef429..75f9f5e26f 100644
> --- a/Documentation/config/alias.txt
> +++ b/Documentation/config/alias.txt
> @@ -27,3 +27,17 @@ it will be treated as a shell command.  For example, defining
>    repository, which may not necessarily be the current directory.
>  * `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
>    from the original current directory. See linkgit:git-rev-parse[1].
> +* Shell command aliases always receive any extra arguments provided to
> +  the Git command-line as positional arguments.
> +** Care should be taken if your shell alias is a "one-liner" script
> +   with multiple commands (e.g. in a pipeline), references multiple
> +   arguments, or is otherwise not able to handle positional arguments
> +   appended via `"$@"`.  For example: `alias.cmd = "!echo $1 | grep
> +   $2"` called as `git cmd 1 2` will be executed as 'echo $1 | grep $2
> +   1 2', which is not what you want.
> +** A convenient way to deal with this is to write your script
> +   operations in an inline function that is then called with any
> +   arguments from the command-line.  For example `alias.cmd = "!c() {
> +   echo $1 | grep $2 ; }; c" will correctly execute the prior example.
> +** Setting `GIT_TRACE=1` can help you debug the command being run for
> +   your alias.
