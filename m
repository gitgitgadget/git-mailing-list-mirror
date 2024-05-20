Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3834CDE
	for <git@vger.kernel.org>; Mon, 20 May 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228527; cv=none; b=NvqaNMT0a2ouuW+z1/bEz0+L/0KqhxNTwO6KcN5mcIkxOdv8a1RdgamApiFWPQxvLViIPWaMMq2ThWlfhvM81hWl/gJpfEvTUFB6L88fbeOdERYRPCJDAePb8MGE0XX02KW2D/3KLH+x0t2AjjYlP3WbEMdnPGz8Z7DqKU/2oUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228527; c=relaxed/simple;
	bh=GhoL46d/OW8SJNkwgDt3hcqzml+RrwjS+xwZCohseaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6vmdlzaqehtF/UreYnGnvyCL0aTgUz6XEYOSlP1UjhwkckzWcLjITblSwwBIXAOr8hVx/1LzpbI2P/AuQILv+APoOFOOxdSY/aILfH+EZZSjFQ9YP7Wn5vNVf342MJKNB+wwanmWDMznPmU2gA5LLEooYM25OGQG37Qljnhtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=czy0vs3D; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="czy0vs3D"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 032C027D61;
	Mon, 20 May 2024 14:08:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GhoL46d/OW8S
	JNkwgDt3hcqzml+RrwjS+xwZCohseaE=; b=czy0vs3DX5aPRIl9URkiVrGwJGu2
	9lNW/cMpFJMgGnae2sznJSv/rxqMEatJ8RYDcS81qPR/w1cQNhcSRkjXsNeajVDb
	xJoZadXbBDIW/+9VSS8HQNPOAWGZ41oL80QcRjQQDb99f4eLoII77gLjqWiJBMzD
	eseTn8zSub/A3sk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFB1F27D60;
	Mon, 20 May 2024 14:08:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E63F27D5F;
	Mon, 20 May 2024 14:08:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: "Jun. T" <takimoto-j@kba.biglobe.ne.jp>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] macOS: ls-files path fails if path of workdir is
 NFD
In-Reply-To: <20240520160601.GA29154@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Mon, 20 May 2024 18:06:01 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240509161110.12121-1-tboegi@web.de>
	<98AD4B35-ECE2-4349-AEA9-86F5CA52EA9B@kba.biglobe.ne.jp>
	<20240520160601.GA29154@tb-raspi4>
Date: Mon, 20 May 2024 11:08:43 -0700
Message-ID: <xmqqikz8gxuc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FF0277A6-16D3-11EF-BA07-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks so much for the detailed analysis, that is appreciated.
> To be honest, I have set core.precomposeunicode true globally,
> ...
> ...
> I am happy to provide a patch (a new testcase is already there),
> but for a change in the codebase I would need some help from an expert,
> to get the config-reading right both for hash_initialized
> (that is may be not about the hash-algorithn at all ?)
> and precompose.

It does not sound like an issue with the hash algorithm.

Why isn't the local config (presumably set with auto-probing when
the repository was initialized) being read?  Are we reading the
core.precomposeunicode in some funny ways?  Is per-worktree config
involved that is trying to read from one but the auto-probing code
is setting it to another, or something silly like that?

Thanks for working well together, both of you.

