Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89713C8EC
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451334; cv=none; b=Xhtl0ihHDTM7JFKcctUcAs+1bZaJTFOtIChdyX6Gm1KxyKIZ8KkxrvIC5G76rl3oJeG6Np8KRepl/wEDTI8J2Zay8AN6W4e66yN+KeTR1evBtRdtcN97W8TaS6mGDueLbV8vgIET5S6bduBJGPM+A4G2+3ocysSj8fbSqDEpCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451334; c=relaxed/simple;
	bh=/lNUK2zgkveahsJISM69jJC37EFLZgG5PofU3Hy0WtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmQCDDNDecfZFkCH8ztEhuOKvy/WO58L9jZJS+bEx8pExlRLKD+MJnrOp3rvzS9tmLTyHS1M3ViaLXrN+1srtZoPUfjHrDMFIaByuZzIQVfe82kjDWloqDqbLPAZr/95Gn1WhYeccAb4X/zCk5F+c8D6r93MLwE2tatSUYcHCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZRkm1rx6; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZRkm1rx6"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2769C35895;
	Mon,  3 Jun 2024 17:48:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/lNUK2zgkveahsJISM69jJC37EFLZgG5PofU3H
	y0WtU=; b=ZRkm1rx62BZQCi2QiraEUVMjX5FfvkkgwS9NoSzIkwzBvTsniEByNg
	p7TnM/Nv0C5qEKKeY5nDYgKoSOu5VPA5cP6jG/eqOitYT3l9u0L+aIhCf4gAttM7
	XjwNiFh2ZqUafHCg0BjguyZ7W3ILLHGm8/Aqqz6aQUxssf9Tl6cMo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 201F835894;
	Mon,  3 Jun 2024 17:48:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 397A135893;
	Mon,  3 Jun 2024 17:48:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] ls-remote: introduce --branches and deprecate --heads
In-Reply-To: <CAPig+cQGtgaz3czkg+Faj+CL_-TD0BdbEc1hg6eJuq_yZmvg9w@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Jun 2024 17:42:25 -0400")
References: <xmqq8qzl3mhg.fsf@gitster.g>
	<20240603200539.1473345-1-gitster@pobox.com>
	<20240603200539.1473345-3-gitster@pobox.com>
	<aa9ff9a4-d504-45c7-8b4e-9744bf0b93aa@gmail.com>
	<CAPig+cQGtgaz3czkg+Faj+CL_-TD0BdbEc1hg6eJuq_yZmvg9w@mail.gmail.com>
Date: Mon, 03 Jun 2024 14:48:47 -0700
Message-ID: <xmqqzfs11yv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F7E9900-21F3-11EF-967A-8F8B087618E4-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Unless there is a concrete plan to free up --heads to mean something
> else in the future, I wonder why we need to warn about this at all,

There is no plan to repurpose "--heads", but this is primarily to
make sure "-h" cannot mean anything but "please give me a short
help".

