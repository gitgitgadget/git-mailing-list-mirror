Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D41193064
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503236; cv=none; b=UmnPH5Q5NxVpnx1mGCr7QzE1HvhLvtR1SMqhay9o9EG8j5Ti612dXeoY/c4kRt2aXwlyiBTZ4/nJD7YegMMdMp3XLd1vCuZERvM32LjLJpzmaS9WLMTFrmLq91VuRvppbM+iKkUii929s7t81i8+voRL29LTBvXE3KrkXKHHt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503236; c=relaxed/simple;
	bh=Rg59ST0yQn7JC55nw3+Y5uiz9L8AFeQMXDthoWtP7hw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ys+tXeLY659UY7bTR440K+O/gE/vllev1w3wa4orqvPyxhiPsRZC6mgRfkGDKgfeO7G3+DyN8ej9EODo9nMsy+X6vgYYlMj1jq47FNgJtZ+T+rJVmXHuHufIJQ3mpc4A4bK3xr/CG4ikI2S42jyR3mcChLF+oKjDb2qxOBin4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NJmbFUIV; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NJmbFUIV"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 007C71B3EE;
	Thu, 27 Jun 2024 11:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Rg59ST0yQn7JC55nw3+Y5uiz9L8AFeQMXDthoW
	tP7hw=; b=NJmbFUIVIY7IuKiImsudaLFATfe7/il3gjmB/3eSWQAkblu8m0DDUe
	QbHDw8n+mzx/cxOI1QEaJthPDxo3pNF9OH8wNguslHoI/4djzeW3xE/LqMBDcn3i
	lAsfHWOrglzQVlFa+WL+yg6tCEDhUrhNxC//Uqw6Cncq0AfyCnS7E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DD02A1B3ED;
	Thu, 27 Jun 2024 11:47:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C0DF1B3EC;
	Thu, 27 Jun 2024 11:47:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  Paul Millar <paul.millar@desy.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
In-Reply-To: <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com> (Abhijeet
	Sonar's message of "Thu, 27 Jun 2024 00:55:01 +0530")
References: <xmqqpls3zhc2.fsf@gitster.g>
	<20240626190801.68472-1-abhijeet.nkt@gmail.com>
	<03628ece-4f47-40d5-a926-acce684a21e5@gmail.com>
Date: Thu, 27 Jun 2024 08:47:02 -0700
Message-ID: <xmqqfrsyv155.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80580916-349C-11EF-875E-C38742FD603B-77302942!pb-smtp20.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> I have a question:
>
> Why does --dirty code path also not call git-update-index and instead does
>
> 	setup_work_tree();
> 	prepare_repo_settings(the_repository);
> 	the_repository->settings.command_requires_full_index = 0;
> 	repo_read_index(the_repository);
> 	refresh_index(...);
> 	fd = repo_hold_locked_index(...);
> 	if (0 <= fd)
> 		repo_update_index_if_able(the_repository, &index_lock);
>
> I assume they are equivalent?

Now we are going back full circles ;-)?

Your earliest attempt indeed copied the above to the code paths used
to handle "--broken", but then Phillip corrected the course

  https://lore.kernel.org/git/054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com/

to avoid triggering an in-process error and instead run an
equivalent "update-index --refresh" via the run_command() interface,
so that we can catch potential errors.  The code in the more recent
rounds of your patch uses that, no?

> The commit which introduced this --
> bb571486ae93d02746c4bcc8032bde306f6d399a (describe: Refresh the index
> when run with --dirty) seems to be for the same objective as mu patch.

Yes, but the cited message above explains the reason why the two
code paths in your patch use different implementations, I would
think.
