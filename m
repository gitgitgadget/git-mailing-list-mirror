Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFF3BBC2
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711816081; cv=none; b=ZQjwvhxOqkM9tKxrkgrm9xQIT3NAUx8nslAS7oX6jsx0uOVK5ImHXu3y1rmnwUb/1tyBuBy/UCy1nQNO+E7yDMeeUgkG2lNHPEsP9xmvA9F1C+1fnLBUbEKjUUa6y0qGQ3ExwO6tWmBLXoI42HUy7Gq9oQac9UI+eaB25q0efoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711816081; c=relaxed/simple;
	bh=HDWkFjlkL6GenEcbhkkaDx2RycRPM50FIca6wjgHmbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJRo0rYv1Ww5/ldrDczRESigeYdHD6YgZz5OMNzFm4lzqweDyeP8DFZy+EaUFyyfQzLSnD67Zc3mOzjhLhmooUHAywWslg4aR2IxQb9eWZ1Iihc84J9ToKpTndZzJi5bQGupO2W29Azcs3N1Y9aSxcxPyEnxX7Wq9l+a3t0X0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ollw8QcQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ollw8QcQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 448FA376C0;
	Sat, 30 Mar 2024 12:27:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HDWkFjlkL6GenEcbhkkaDx2RycRPM50FIca6wj
	gHmbI=; b=ollw8QcQOZUJPX/znWtV4/8j7SKlDKHmPdbyQBLfLq18DiYPq1/DPF
	0wm+aXNN7SlBRbMUUzOx43AtT0yNxLkvvy+/rMuj3Qyp2a52wVnzqHj9jZlLhB49
	bDCKeFXQo5t0FXBXFLJIrHnZPbTiGpBeQwSNn1F7z/HV6YiLefXPI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 31F19376BF;
	Sat, 30 Mar 2024 12:27:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 968CA376BE;
	Sat, 30 Mar 2024 12:27:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] read-cache: optionally collect pathspec matching
 info
In-Reply-To: <gfwbrhhklmus4yyxkn3gi6jrt54azgqexi6kyb6snvs5dxlu4g@7g77due7iiq3>
	(Ghanshyam Thakkar's message of "Sat, 30 Mar 2024 19:57:21 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-3-shyamthakkar001@gmail.com>
	<xmqqjzlkwwk9.fsf@gitster.g> <xmqqo7awvg2w.fsf@gitster.g>
	<gfwbrhhklmus4yyxkn3gi6jrt54azgqexi6kyb6snvs5dxlu4g@7g77due7iiq3>
Date: Sat, 30 Mar 2024 09:27:52 -0700
Message-ID: <xmqqv853n0qf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75FEFE32-EEB2-11EE-B52C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

>> This is how such a change may look like.  After applying [2/3] and
>> [3/3] steps from your series on top of this patch, the updated tests
>> in your series (2200 and 7501) seem to still pass.
>
> This seems perfect. I hope you're OK with me using this patch as a base
> for patch [2/3] and [3/3]. :)

Yes, as long as you promise to fix typos and grammatical mistakes in
my proposed log messages (there are several I just noticed X-<).

Thanks.
