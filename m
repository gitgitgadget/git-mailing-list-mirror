Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED167E8
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613108; cv=none; b=YfD9wdfgLrfyxOHJt6FNFfVqWcSC1Cjkgfy+GZ1FFFWZySeq5rUkLEZMQXlfRLJ0weHAU8bm8i93GmYs2VnGsUnoevLfZSbBzDQyjWa3h8i2x4yo5Q/+5E9PamUbzZqCzVyH6BF4zZttKL+Lq18l2M1vtn87LaP840tNELgYn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613108; c=relaxed/simple;
	bh=D4e6TNHgiydr+4QS4HSbOvQgfAL+NW2nO6eBFCCFT9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZLaUWOAniUx8B65gLeNGGqG0gCVg6VBt0LhS1nXh/ZFDUuPePrItwRw2+G8M7ZiOwTEj0NAr7BuqQz4baHSql7BeCfB2nZOLl5oIo034Et26dXdc7VEWgh/cGhy1r6q61HX9Hdv3Q94tzcWThQ3drqkf+1+XcXYwqy4j9Zs2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bIBqknIb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bIBqknIb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 502EE1F51DF;
	Mon,  8 Apr 2024 17:51:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D4e6TNHgiydr+4QS4HSbOvQgfAL+NW2nO6eBFC
	CFT9k=; b=bIBqknIb3NNlM1thSpSa6eT2gLdiI/je6we9hAS4EOsCKXp7a12IBj
	ngvRE64dLsEIlzt0dv/CyR4gt0ZqjOTP+RiagxXC0LesLMYrhllRnU/Z0eVg75Tt
	/pE/h6GZ0xm7JoKeJqs7PyPkKgC3I19/JSinFOH7rPIGB8emDyOh4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 48C831F51DE;
	Mon,  8 Apr 2024 17:51:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B35401F51DD;
	Mon,  8 Apr 2024 17:51:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,  Han-Wen
 Nienhuys <hanwenn@gmail.com>,  Josh Steadmon <steadmon@google.com>,  Luca
 Milanesio <luca.milanesio@gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
In-Reply-To: <ZhQZsq5_NyXmWM-b@tanuki> (Patrick Steinhardt's message of "Mon,
	8 Apr 2024 18:22:10 +0200")
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
	<160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
	<CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
	<xmqqpluzet2z.fsf@gitster.g> <ZhQZsq5_NyXmWM-b@tanuki>
Date: Mon, 08 Apr 2024 14:51:43 -0700
Message-ID: <xmqqfrvv8qvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30F80B2A-F5F2-11EE-B5B4-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> As xargs is supposed to know the system limit, perhaps
>> 
>> 	test_seq 0 9999 | xargs printf "...%d...\n"
>> 
>> should work?
>
> Is there a reason why we want to avoid using awk(1) in the first place?
> We use it in several other tests and I don't think that the resulting
> code is all that bad.

There is no reason.  It was a canned reaction against "gee we will
bust shell's limit" to "use xargs then".

Of course, if we can do the loop in the shell and everything we do
in the loop with shell builtins (printf is often builtin in modern
shells but not always, if I recall correctly), that would be best,
and if the job is _that_ simple that we could do in the shell, it
would make "awk" a horrible choice ;-)
