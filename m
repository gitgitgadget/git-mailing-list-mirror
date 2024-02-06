Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E91C68A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260293; cv=none; b=dbcVpwRwxiFLHaGMs6Lvz2mrGZkNDIqFiD+Siv6fxK5DKOvOiC5deDoFkmgTO25byY/LKXWuTdEraQIYuUOAM7rVlNMIqcm7avafA+CYAyfm/u3cd23Qhpk1y676gxpsJhfONwckR0gR+LwyxnUj5spIXdlrwcq3wdApVSsv7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260293; c=relaxed/simple;
	bh=cIDs6EoukZF602kG6iZePtsGOipOC+ylrfg6ZJOTfSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jBuu+rTer2TRH9i5nI+p1xrFggzVU/rPM4Y2AlhdVftbOtWwyk8LWQzUxdA3me+9RKWJ+wVGgoTSnMOzM1Xu1XFskUDVn17KELdxPIqHYzZrDE99HEriyudnwfvcsX6VpWSHyReEjMlSlLW25HRZ0xQ7dcB7cg1Ty3EBnNrJurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DG3fzdUu; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DG3fzdUu"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EB2C23384;
	Tue,  6 Feb 2024 17:58:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cIDs6EoukZF602kG6iZePtsGOipOC+ylrfg6ZJ
	OTfSc=; b=DG3fzdUu2Z+8s7YXkIrOJDov1Qvpro/d4NTOCWRfrll4zQF+7E3lZx
	vxbENCBdvts+DzEPopbrzmSaneapUMHjm7Pjvgs0+EXdHHP3/694ZSbUK6ZJmLlN
	5iYIhRTBpenU8iE2Et9x1yTAXx9qjvjtvtpajCl8xLCg1K2WC6N4Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 474CF23383;
	Tue,  6 Feb 2024 17:58:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA1D123382;
	Tue,  6 Feb 2024 17:58:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/7] completion: improvements for git-bisect
In-Reply-To: <20240206215048.488344-1-britton.kerin@gmail.com> (Britton Leo
	Kerin's message of "Tue, 6 Feb 2024 12:50:41 -0900")
References: <20240206020930.312164-1-britton.kerin@gmail.com>
	<20240206215048.488344-1-britton.kerin@gmail.com>
Date: Tue, 06 Feb 2024 14:58:06 -0800
Message-ID: <xmqq8r3xfbep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 318AE5BA-C543-11EE-BAB7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Britton Leo Kerin <britton.kerin@gmail.com> writes:

> Relative to v5 this makes the following actual changes:
>
>   * Treat COMPREPLY as an array on assignment and test, rather than
>     relying on the bash mechanism of implicitly acting on the first
>     element of the array.
>
>   * Whitespace fixes.
>
> The commit message about __git_complete_log_opts has also been changed
> to indicate that COMPREPLY is emptied and why, and a broken
> Signed-off-by line fixed.

Thanks.  Let's queue this version and mark it for 'next' by -rc0.
