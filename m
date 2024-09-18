Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95644210EC
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678149; cv=none; b=KMrXklStx4GGghuvE3daTyrJUUq5ri0G2p+uabbFq+Um0zJ4oR5i3CZRdamSn5gMV7j8N4yxw6VwB8jqRcdqS69u9E880Q14SLR6numWlQY8EzsLcF3hq/yeR5I7qxn3LBsfT2ejwcbn71CjU0CzsQzr3vwDQO8y4NfwdLbL9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678149; c=relaxed/simple;
	bh=93MZZSrUVgJ5/1K26Pa5uhipT8g4kgScjd5mum/29VQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7PETJyFl41oWZS3FqTd+uFZJCgrZItyVUyOYnzrH2dIKFHqZ8K8assJ9XzKA6iooh4I1lvYcFzO8WiPMnTj+wwB4bf/XBp5WTx0fktq+Njqo3ZJ8WQ8hIfPqEmjjGPnTi/n7RFCS1iFerad0+bB+wIXev0LHF9i6s+lt0qmcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vq8TFBzB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vq8TFBzB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51C1430355;
	Wed, 18 Sep 2024 12:49:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=93MZZSrUVgJ5/1K26Pa5uhipT8g4kgScjd5mum
	/29VQ=; b=Vq8TFBzBVR2etR4k/nxwUp85a0eyL0+QddnMXbU3vo3+bePyUhpTYC
	T3p1YxEYOHaFMlTJpOBvrPQh+V3N51s5tonmsyCBrdYIsw/CpSO8ck41pu1CVEhR
	w8Tgxwn9eY7z/vtjCxGSV8rlWxksYVXbtCfSjZcXLX1AazHvw77Z8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47FD530354;
	Wed, 18 Sep 2024 12:49:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CD7230353;
	Wed, 18 Sep 2024 12:49:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/5] add ref content check for files backend
In-Reply-To: <ZuRzCyjQFilGhj8j@ArchLinux> (shejialuo@gmail.com's message of
	"Sat, 14 Sep 2024 01:14:51 +0800")
References: <Ztb-mgl50cwGVO8A@ArchLinux> <ZuRzCyjQFilGhj8j@ArchLinux>
Date: Wed, 18 Sep 2024 09:49:02 -0700
Message-ID: <xmqqa5g4j4ap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9E5A23A-75DD-11EF-98C4-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> Because I add more commits, I provide the "--interdiff" here to make the
> reviewer's life easier.

Yeah, for the changes from the previous iteration of this series,
range-diff comparison is pretty much useless.  Interdiff is indeed
more usable, but essentially this iteration deserves reviews with
fresh sets of eyes.

> However, because I have not merged the latest ci fixup, so I cannot
> verify some jobs in CIs. May need the help from Junio to verify.

A good way to do so is to fork a temporary branch at the tip of
these 5 commits, and then either merge or cherry-pick the CI fixup.
Such a temporary branch should be usable for CI testing, right?

Thanks.

PS.

I am not feeling well today; please expect delayed and/or sparse
responses.

