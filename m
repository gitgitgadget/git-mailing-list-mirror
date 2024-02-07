Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60325A100
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322023; cv=none; b=H73bag3ra7jEZWQnbzdRGuNhwfM32fAUqCWMMoHW7w+onJ8SMmd524D5fCoITYzBKdb6b7lviKEM6TojtequWZ4gVw6IuUTsboSvEBv+3UB48QkXolk61SzWTje/imHiBv2uWqjwyhWAhR8NKRvP2cAPDgcEu5r1FSN591CJZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322023; c=relaxed/simple;
	bh=E3b0vp4aE+FX4hd8lmSb4PnQ1nP/DF1Lzuc0Ev3sHlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fyX3kPopyoMltBvnSK2FbhGRBKaJ7ibysDZQtIEi+LJYRJPngy8+9lMMf7/ipbUB9DFrvjHOte1o8yQqxQPs8Sv2MpDiU0BOEB14Ybl42icMrGP35ScpH5sFVX1w02T5hO0jxXb7/XlF+RVpYpFs3zHEVa/xYtRaG/a4jNzivHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lEUZkkJy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lEUZkkJy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24FDA1DD656;
	Wed,  7 Feb 2024 11:07:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E3b0vp4aE+FX4hd8lmSb4PnQ1nP/DF1Lzuc0Ev
	3sHlY=; b=lEUZkkJy/O3hcye6B32C0cAp0jCK2CX/C4WgcxkG+WrmfruLuNyGnx
	rItwh1m5sfBaQkSfrsuU9J+wkYZ1CA9TWbT8g+rW9dQPU5p6y9OXRoxzt1g8eTzv
	R7STtTnNFH4zO5VJ0aKiHMLuoLCCGIMoF8eyKQy4R1xBe2wKnH5FE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AAFD1DD654;
	Wed,  7 Feb 2024 11:07:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7ECCD1DD652;
	Wed,  7 Feb 2024 11:06:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] restore: allow --staged on unborn branch
In-Reply-To: <20240206230357.1097505-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 7 Feb 2024 04:33:50 +0530")
References: <20240206230357.1097505-2-shyamthakkar001@gmail.com>
Date: Wed, 07 Feb 2024 08:06:58 -0800
Message-ID: <xmqqle7wcl7h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EC6B8EE0-C5D2-11EE-A2DB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Some users expect that being on an unborn branch is similar to having an
> empty tree checked out. However, when running "git restore --staged ."
> on unborn branch having staged changes, the follwing error gets printed,
>
>     fatal: could not resolve HEAD

Sounds like a sensible behaviour---there is no HEAD so there is
nothing to resolve.  With "git resetore --staged ." in such a state,
what did the user try to do?  "git reset" (no other arguments)?

BTW, "follwing" -> "following".
