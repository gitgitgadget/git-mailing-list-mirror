Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02411718
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705772261; cv=none; b=uv/ZgwOUFNg5LnTiUTaqO1O9UaAMQk4pVKL8jeeAE4PAFTeUiBHsPgGdcZO1WynfL2ja/1UkfphLhKK4Wx92nv6AIHHv6S6nXm/waPlANUrNTh0Db/v5lClcrSc6f2mrkbX37x7KgwUF12tHOWpoIhlEzXh1+R7eaGeoZ913FY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705772261; c=relaxed/simple;
	bh=PE2LINMUUf6B1UE+wAhJtJ5ivQjC2D9AuUyt6b2Sg1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mEb1je2thpP5y/asS+qsczOklNC1QoZEzsQ1oJ7g88fqMUo7saBxKPB99VIVtXpzrzU/z4ENy6ocV6qec0c+mwgW8hr8BtevJCCDRIEwhxS2v/CYfo8pq1eijXf4nL7CHoZg1o3uSybAC3++vJUxX7HZER8t+Ph7iAhWMDrbP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Drmxw8yp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Drmxw8yp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C8011DCD54;
	Sat, 20 Jan 2024 12:37:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PE2LINMUUf6B1UE+wAhJtJ5ivQjC2D9AuUyt6b
	2Sg1w=; b=Drmxw8ypACjG1WK9SBOmbcOQKjEKtpY8x+NYOwqpqvmRyIh0uEAic1
	yUWSbzIKy0V/msRQOyNLsDfFgMIbenA84t4HTYJqiDD+Wi5Sqwm4Melxl8k4wQAt
	8MqBW5yHQ607K69MheR1fLwvpZBhJFdTh69ImqB0S2kiMwzdL8Jx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3216A1DCD53;
	Sat, 20 Jan 2024 12:37:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B3271DCD52;
	Sat, 20 Jan 2024 12:37:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v3] merge-ll: expose revision names to custom drivers
In-Reply-To: <82624802-aa7f-4856-b819-9a2990b25a69@gmail.com> (Phillip Wood's
	message of "Sat, 20 Jan 2024 14:13:50 +0000")
References: <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
	<pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
	<82624802-aa7f-4856-b819-9a2990b25a69@gmail.com>
Date: Sat, 20 Jan 2024 09:37:30 -0800
Message-ID: <xmqqsf2rgb39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96C7ADA0-B7BA-11EE-985C-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Not part of this patch but I noticed that we're passing the filenames
> for '%A' etc. unquoted which is a bit scary.

May be scary but safe, as long as create_temp() gives a reasonable
temporary filename.  We pass ".merge_file_XXXXXX" to xmkstemp(),
which calls into mkstemp(), which should give us a shell safe name?

It also should be a safe conversion to change strbuf_addstr() used
for these three to sq_quote_buf(), as the string with these %[OAB]
placeholders are passed to the shell that eats the quoting before
invoking the end-user supplied external merge driver, which means
the merge driver would not notice any difference.

Thanks for being careful ;-)

