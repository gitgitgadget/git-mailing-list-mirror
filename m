Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9313B5BB
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378282; cv=none; b=mGV+iMiDq/U+RL6d+fdZ2zigLxqiv30aVl8DfF4eooBDjZePMwwyovU9NPOvQ4QKf78GIJEfz1SWMLKhkXYNvNoz0bX/iE0eJru4WUhmoCh1uO9bw3Pbrov7EeMH52CVojDbSpvMTIvC+mjVgL5uJSpvDWpOlT11BKKPF1fMOQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378282; c=relaxed/simple;
	bh=BMG1lOeQpwOhrY9tQIPrw71VgsLpo16+r6iklCLeqwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=paECvVvnf3D66QX6egp8BPedUd+06pMP9jbHSRJgb4rVZcpZNLIlvP9byVl6XF+S8m6MhYw12q1ymu8NmY1OnSXljt/a4NlKGZiTOf59ftMr07+07i0ElJRzvcxItfLy7CKIPWsBI2mLWdqeJhCMUXF2IC+yi7J2sa3Qn8I3ihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x7jM2X88; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x7jM2X88"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5566A1BADF;
	Fri, 10 May 2024 17:57:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BMG1lOeQpwOhrY9tQIPrw71VgsLpo16+r6iklC
	LeqwU=; b=x7jM2X88rAQiYhzk17MCvl2kJH7jKN/6otkrBpGl2SEN0gtiG474Ik
	AzRDkwxkFK9MMiHIKll+ffCnEaPrOoYFpB9DqG9va3BQIIv3gpOSPkUYpbG9KwiF
	NwZ0PXGClBwdZh/TSzlwuekk1zwH/kVI4G80sVRx1zQoKXOz7L15k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DC0A1BADE;
	Fri, 10 May 2024 17:57:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61A0B1BADD;
	Fri, 10 May 2024 17:57:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 08/11] refs/reftable: allow configuring restart interval
In-Reply-To: <bc0bf65553c8dd89bf5fcaa592fc3427507f1993.1715336798.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 May 2024 12:29:55 +0200")
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
	<bc0bf65553c8dd89bf5fcaa592fc3427507f1993.1715336798.git.ps@pks.im>
Date: Fri, 10 May 2024 14:57:46 -0700
Message-ID: <xmqq34qp2uud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56F2FD3C-0F18-11EF-BFF5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +
> +reftable.restartInterval::
> +	The interval at which to create restart points. The reftable backend
> +	determines the restart points at file creation. The process is
> +	arbitrary, but every 16 or 64 records is recommended. Every 16 may be

It is unclear what exactly "The process is arbitrary, but" wants to
say, especially the use of the noun "process".  The process the user
uses to choose the inteval value is?  The default value chosen by us
was arbitrary and out of thin air?

Just striking the whole sentence (or removing up to ", but" part and
starting the sentence with "Every 16 or 64") may make the resulting
paragraph easier to follow, I suspect.

> +	} else if (!strcmp(var, "reftable.restartinterval")) {
> +		unsigned long restart_interval = git_config_ulong(var, value, ctx->kvi);
> +		if (restart_interval > UINT16_MAX)
> +			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);

OK.

