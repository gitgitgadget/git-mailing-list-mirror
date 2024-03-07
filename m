Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B612C813
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817730; cv=none; b=acRFkQHqYL2EC+CnUJDmHuFUKfwvQ/eCES9ur23GlGkuleq3uhrrHD4JcsFiH81qY5heybAA5Q28KlSoS1ehZ5DxqpWV9xebOgsKKZOvtKlWqZIxma5RRFkXnt1JM14YKjAWlioMKzJFwdL1P93mTfYRI+R25PmfFk4KsjwmMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817730; c=relaxed/simple;
	bh=ZYZ4WxEoCf76Uef4OntMgshuw/iwzZs8oF7rQbNo4t4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CNLwC2YaMZFw6PfNxntnuw1nIe42H/F3wZnO1LH5ypzNOxmS1ICBZ/aYwORJakDY3ZpVT47/A0G+qAk2jhdISR5JDYTA61jGLenljTgvsjZqMex3H5JLmutAL7JiL25M0Hb3Yns01H14uH7YyI+EN2l+cT1RBWsy9q6KIlzpa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/KHo0tt; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/KHo0tt"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 00EB4262D0;
	Thu,  7 Mar 2024 08:22:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZYZ4WxEoCf76Uef4OntMgshuw/iwzZs8oF7rQb
	No4t4=; b=c/KHo0ttrDnZxVEQe8vYuUWaltuAhrrjsmsDnVxCcSPNixv8M+OgFq
	i3Hy5m4WJ3ZyF+dpKw+ZC9k3YqFCtjpcHFVQyDlb3M/3gm0lDd7iNPn92Xr0tTxA
	cj8O6LGtLVJsRjvR3fJR92YMasULLQ5vsdOzbYbIMgcxhniWild3A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ED41E262CF;
	Thu,  7 Mar 2024 08:22:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C500262CE;
	Thu,  7 Mar 2024 08:22:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/8] builtin/config: introduce subcommands
In-Reply-To: <ZelfOQ-XvvOpaOzi@tanuki> (Patrick Steinhardt's message of "Thu,
	7 Mar 2024 07:31:21 +0100")
References: <cover.1709724089.git.ps@pks.im> <xmqqil1zs327.fsf@gitster.g>
	<ZekAWSqr9qb8FIAD@nand.local> <ZelfOQ-XvvOpaOzi@tanuki>
Date: Thu, 07 Mar 2024 05:22:02 -0800
Message-ID: <xmqqle6unpmt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B08371EE-DC85-11EE-9EBF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Mar 06, 2024 at 06:46:33PM -0500, Taylor Blau wrote:
>> On Wed, Mar 06, 2024 at 09:06:08AM -0800, Junio C Hamano wrote:
>> > Patrick Steinhardt <ps@pks.im> writes:
>> > >   - `git config --get-urlmatch` -> `git config get-urlmatch`.
>> >
>> > ... is a Meh to me, personally.  I'd not actively push it
>> > enthusiastically, but I'd passively accept its existence.
>> 
>> I don't have strong feelings about this, but I wonder if `--urlmatch`
>> (or `--url-match`) might be an argument to the "get" mode of this
>> sub-command instead. Something like `git config get --urlmatch` feels
>> much more natural to me than `git config get-urlmatch`.
>
> Agreed. I allude to this somewhere in the patch series that I only see
> this as a first incremental step, and that some of the subcommands
> really should be converted to become options eventually. Specifically:
>
>     - `git config get-urlmatch` -> `git config get --urlmatch`
>
>     - `git config get-regexp` -> `git config get --regexp`
>
>     - `git config get-all` -> `git config get --all`
>  
>     - `git config set-all` -> `git config set --all`
>
>     - `git config unset-all` -> `git config unset --all`
>
> I didn't yet do it as part of this patch series because I didn't want to
> make functional changes at the same time (well, except of course for the
> introduction of subcommands). But if we all agree that this patch series
> is something we want _and_ that we don't want to have an intermediate
> step with the above somewhat weird subcommands then I would be happy to
> pile onto the series.
>
> I wouldn't think that keeping this intermediate step would be too bad
> though. While we would eventually omit the above subcommands, the infra
> to keep them around needs to stay anyway to support old syntax like
> `--get-all`. Thus, we can keep the subcommands themselves almost for
> free even if we eventually decide to hide them and replace them with
> flags.

The "more involved" changes along the lines Taylor suggested take
some thought in designing the end-user experience, so even if you do
not initially plan to support them in the implementation, it would
be better to know how the final command line should look like before
starting, so that we won't surprise users, if anything.

The trickies I anticipate offhand are:

 * The urlmatch thing wants name and URL.  In the new syntax, I
   think the URL part should become an option parameter to the --url
   option.  E.g. a request with the current UI

    $ git config --get-urlmatch SECTION.VARIABLE URL

   would become

    $ git config get --url=URL SECTION.VARIABLE

 * The color thing takes the default value to be used when
   unconfigured.  That should also become an option parameter to the
   --default option.

    $ git config --get-color SECTION.VARIABLE DEFAULT

   would become

    $ git config get --type=color --default=DEFAULT SECTION.VARIABLE

   Similarly for --tty=true/false used in --get-colorbool.

 * Now, these extended ones with options introduce possibilities to
   combine them in ways that weren't possible before.  For example,
   "--get" and "--get-all" are distinct, and there is no way to tell
   "--get-urlmatch" to give all values that would match, but it is
   plausible that we may want to handle

    $ git config get --all --url=URL SECTION.VARIABLE

   to do so.  A more interesting one is the --default=DEFAULT
   option.  What we currently write

    $ git config --get no.such.variable || echo 'default value'

   can become

    $ git config get --default='default value' no.such.variable

HTH.

