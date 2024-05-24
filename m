Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A622331
	for <git@vger.kernel.org>; Fri, 24 May 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530946; cv=none; b=u1jelDZzNOpCHqRq30MZloLII0Rr+ISMTVzhTCNPoePfQqxuOMnib1NIs9tgukzbvY7Y3Sc/6t6i9gxvdRHm+swlj+42ozfZQEPN56mMOu9zhlrX/tSaF/0SgrjdQcEnPRvqQrmV2XET3S+QXHpt0gveXahZ3zFXihD7Ri7tprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530946; c=relaxed/simple;
	bh=K4RPYLknYyRP/WDeywuIcGvCm9ispsnd14eF77Gk/3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTUpW1BQ/0rsEAbywROHpUgLkh0v0ZIhqvRLpGCQJBYvL7tMJK9HT14/yAxxNQAVeried2aApaX3oN8A4I/ffAqQNse0orZ4c/4aaaZmXMic2i626wR1tAevOXVNCZN5XVEd90MnKzOp7D5xseVjQrpe5HfjiNR6atO0MXvGOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zic3H0ic; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zic3H0ic"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F9FA36E42;
	Fri, 24 May 2024 02:09:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K4RPYLknYyRP/WDeywuIcGvCm9ispsnd14eF77
	Gk/3g=; b=Zic3H0icyyk/FHMm+v9lQCJyX9BefDzCLbJKHT/qfhzSOC/et4FVNb
	UZtDOgOWYIO1ws0R+1uIlxmTOUG8xetxKOsGsfOy7TPF00wV1fhXSkAPKNKTqALC
	JV4A0Lh2CjxlOh9JFfi+sZP6oVtdDScppAnFgVnGamrgEzgFsRq90=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87D1736E41;
	Fri, 24 May 2024 02:09:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81EB236E40;
	Fri, 24 May 2024 02:09:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] run-command: show prepared command
In-Reply-To: <xmqqttiop05y.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 May 2024 16:40:25 -0700")
References: <20240523042143.1220862-1-iwienand@redhat.com>
	<20240523043806.1223032-1-iwienand@redhat.com>
	<20240523043806.1223032-3-iwienand@redhat.com>
	<xmqqpltcwnqm.fsf@gitster.g> <xmqqttiop05y.fsf@gitster.g>
Date: Thu, 23 May 2024 23:09:01 -0700
Message-ID: <xmqq4janpwqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E454572-1994-11EF-B5A3-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Subject: [PATCH] fixup! run-command: show prepared command
>
> Do not assume everybody sets SHELL_PATH to /bin/sh
> ---
>  t/t0014-alias.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 75c8763a6c..0d42d2b454 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -48,7 +48,8 @@ test_expect_success 'tracing a shell alias with arguments shows full prepared co
>  	git config alias.echo "!echo \$*" &&
>  	env GIT_TRACE=1 git echo argument 2>output &&
>  	cp output /tmp/output &&
> -	test_grep "^trace: prepare_cmd: /bin/sh -c '\''echo \$\* \"\$@\"" output
> +	# ".*" can be "sh", or SHELL_PATH (not always "/bin/sh")
> +	test_grep "^trace: prepare_cmd: .* -c '\''echo \$\* \"\$@\"" output
>  '

So with this applied on top of the topic, 'seen' does pass with
SHELL_PATH set to say /bin/dash, but this still fails CI jobs on
Windows.  

A sample run that failed (you'd probably need to be logged in as a
github user there):

  https://github.com/git/git/actions/runs/9216303673/job/25360383492#step:5:237

With the lack of "trace: prepare_cmd:" in the "output" file, on the
platform, perhaps the code is failing to find an executable for
"echo" on the $PATH and taking the early return codepath that sets
errno to ENOENT and returns -1?  Or it is that even prepare_cmd()
is not called?  I do not do Windows, so I'll stop here.

Oh by the way, I just noticed that there is an apparent leftover
debugging statement that accesses outside the test playpen.  When
you reroll the patch, please make sure that "cp output /tmp/output"
is removed.

Thanks.
