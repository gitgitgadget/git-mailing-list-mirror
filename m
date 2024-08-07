Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60C364A0
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072048; cv=none; b=kwc5EzHsyF4iREZtqDnJxMCI4ohZPTz4hDXa9Pr9KyEaFiA3bjCgobZ+99qQKOJbPsA9I27JBVp0J0No60qIHSjBQS7PuwkaAzioRkER6NcempMEf79zpCBWQSMrBiWPan2vmWJEqEUZCfzQyKm/7IvxSrwDk/zwdZ5dzXyZN2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072048; c=relaxed/simple;
	bh=c63R0kDXPIcjdWOGvuHuE7FEHc72lfE/Z7m8Nnl3/QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ChCTkHvTX/oXf3EZE1LtXl1pMKId8CDn72eoEA/f3VZVB3DxgmTUl4mqcukPON4v2RTMxawjyWy5Xg0HWxAdJQAIfk77b4U7V/ELu00GP1bJ96gfnn/xexLNc8yTZjACBpmXgKBclkCTBtnNI7mVjuP0psa5qrb7kVxPPeC7FHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=okXOXzXE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="okXOXzXE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18968280F7;
	Wed,  7 Aug 2024 19:07:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c63R0kDXPIcjdWOGvuHuE7FEHc72lfE/Z7m8Nn
	l3/QQ=; b=okXOXzXE6gzjRDmhtqKWx6kagKtxNOZY5Vx9zcU7q+HLtUig4mIDxj
	6iYFop/+mnuo3+FIOoL80nLBcPBR1Cz/dgZfaarvvwx0eYaOnU75LtHUyjOrFX8a
	VxZSW8TsvYZkCzJ5R1auaX5Z0RIGwhZAv0IEUAdC4WC72hsZvurTU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FFC1280F6;
	Wed,  7 Aug 2024 19:07:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D211C280F5;
	Wed,  7 Aug 2024 19:07:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Jeppe
 =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Subject: Re: [PATCH 2/6] builtin/clone: propagate ref storage format to
 submodules
In-Reply-To: <e5923c0b3364f28ce504c772f7fa75404f80e651.1723032100.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 7 Aug 2024 14:43:53 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<cover.1723032100.git.ps@pks.im>
	<e5923c0b3364f28ce504c772f7fa75404f80e651.1723032100.git.ps@pks.im>
Date: Wed, 07 Aug 2024 16:07:22 -0700
Message-ID: <xmqqsevglyol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE7B10F8-5511-11EF-B149-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When recursively cloning a repository with a non-default ref storage
> format, e.g. by passing the `--ref-format=` option, then only the
> top-level repository will end up will end up using that ref storage
> format. All recursively cloned submodules will instead use the default
> format. While mixed-format constellations are expected to work alright,
> the outcome still is somewhat surprising as we have essentially ignored
> the user's request.
>
> Fix this by propagating the requested ref format to cloned submodules.

Makes sense.
