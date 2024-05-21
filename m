Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE7149C5B
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329707; cv=none; b=O6F9ZFNvjllBXQskNZOvfIC5fNL9e8IS3/PqWSAuMWJA1BiXIVjqDvPlYyyzmDKrhqLZFKQ9kLRCUgicCSddrG/biXcoPjeeAStMi+7FXc3k0/d/DRguVHqslNpcaKcRrD66Qqox1+mpOUvg7V0D5H02pQ22VurFl25j2fa3LBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329707; c=relaxed/simple;
	bh=OxMGt+Tnj0RDb11gye19SSS7zNmbtHx+ydPhwA8ev0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nP3Ax8DJu021IhB7V4rY0ex5fE3rkpy0hOTPGmzfPNPdjzlMnhfwIruRCkerkzts/a7Xtynt9xiUCOSk6rVzoZ25KJO6Z3PLbM1dE58xPpWCB8H7cvSdg2I43ldOZaZr/i7CeCvn+Hlq8t6cTN20ufJtM+MsdWXZDLVl8N0lqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MzXvOuzt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MzXvOuzt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 160D431F23;
	Tue, 21 May 2024 18:15:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OxMGt+Tnj0RD
	b11gye19SSS7zNmbtHx+ydPhwA8ev0M=; b=MzXvOuzt9RSR/Uc8jnl8LFlafqOh
	d1GGaSAZKf/W6TdgRHCg853j6Smm38tQRm/LM+Uf0oipgCgmzAyUZaxsIs+8jSTu
	rHl/iq74AobJuVO0FhlXXPs0w9LYDgKy3LcdcjCiaHi/jUf979Yznm+RfS/M947+
	AG5lwc+Tu6r9DGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0BAB31F21;
	Tue, 21 May 2024 18:15:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0575B31F20;
	Tue, 21 May 2024 18:15:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v3 1/1] macOS: ls-files path fails if path of workdir is
 NFD
In-Reply-To: <20240521205749.GA8165@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Tue, 21 May 2024 22:57:49 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240521141452.26210-1-tboegi@web.de> <xmqqttir9hr2.fsf@gitster.g>
	<20240521205749.GA8165@tb-raspi4>
Date: Tue, 21 May 2024 15:15:02 -0700
Message-ID: <xmqqa5ki95i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 92CD5B9A-17BF-11EF-8C72-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The commit message deserves an update, for sure.
> My suggestion would be too keep it in seen, until I have managed
> to write a better commit message.
> At the same time, I would ask Jun-ichi Takimoto to do a re-test
> of the new version.

Yup, that sounds extremely sensible.  Thanks for working on this.
