Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D39156C7F
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883880; cv=none; b=PiGDJqeYknFpBdclyNAxo1WJSe+QGNUVmkuguywtKES1F+bNMnPqFCVCe0jOy2iUcWB/jodts7W4WEwSwX+gIrfQI8qO6MAx5yNb8Xegl613rAy2DxZXd3apMCZW+tWZZyIxXfSNk1YDTd8kLhr2nQwGNev7SK48G+cGM3t+Tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883880; c=relaxed/simple;
	bh=4vBcycXWkgvWRxBfrgqhG5ZfzEmxbxd/zHZQfrjS4d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mEwrrmHEFDp9LM1TGl/wKk5h/C5G3ytwIdZvBH5PT99qdlVXQBcB4eo2XqYAzMluF4iUcQ41TSSKjsOouvEKstNIqGQKdTPK6g/PSp2/2ArCLY5iDjvXLOWTtAxDMUvMaBkqbw4FmYetWmOcVU9LvPsKpC8OTjdjtPg2lJ2Omns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=g5JNsLPL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g5JNsLPL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C715271BE;
	Thu, 16 May 2024 14:24:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4vBcycXWkgvWRxBfrgqhG5ZfzEmxbxd/zHZQfr
	jS4d0=; b=g5JNsLPLs4JR1l65hvYmJqhPwOWFOqx2nrHLTz0DWKUCQS7oAej835
	5mHxo5hoRecM0a1RRp4d6QWNFJPhwCZeLXGwfBM4fjilJVorMXoV8tyCHlJzxE1r
	usNzdgkVivIjC4OD4oYZTHwCVhw+O7Q/b8QHfhfTkNNQHUklKUgoI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4511D271BD;
	Thu, 16 May 2024 14:24:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD87A271BC;
	Thu, 16 May 2024 14:24:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/16] refs: rename `init_db` callback to avoid confusion
In-Reply-To: <3cc2b4e5501ebe1464a6d75b7aea9f2ad6030c4a.1715836916.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 May 2024 10:04:18 +0200")
References: <cover.1715836916.git.ps@pks.im>
	<3cc2b4e5501ebe1464a6d75b7aea9f2ad6030c4a.1715836916.git.ps@pks.im>
Date: Thu, 16 May 2024 11:24:36 -0700
Message-ID: <xmqqa5kpr4wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8D94ED76-13B1-11EF-91E0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Reference backends have two callbacks `init` and `init_db`. The
> similarity of these two callbacks has repeatedly tripped myself whenever
> I was looking at those, where I always had to look up which of them does
> what.
>
> Rename the `init_db` callback to `create`, which should hopefully be
> clearer.

Hmph, create() may be clearer than init_db(), but then I am not sure
what init() would do, differently from create(), so this rename
takes me back to the puzzled square one state X-<.

I am guessing that create is about creating on-disk structure, while
init is about in-core structure out of an existing on-disk
structure?  Once I understand the differences in these two things,
it is much less troublesome to tell them apart, regardless of what
they are called.  Between .init and .init_db, it would be obvious
that the latter is about on-disk thing, without a rename done by
this step.  On the other hand, contrast between <create, init> is
just as opaque as <init_db, init>---the names do not tell readers
that these two are about on-disk and in-core structures.

Just my confused impression.



