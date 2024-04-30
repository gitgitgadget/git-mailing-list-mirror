Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBD179654
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497087; cv=none; b=DW3Z0Z5LEWj5hjomItyAbGBi94V+WK5054V7MFl8cYxtN0tAR2Qnp1uWbSsp41hCVOdj9oSAY6Dq229QIPILhl/1CX5z1nO4XVfSujfBydw0CLpkaiP1fSvKjZTiZBb0yLbPbaCidiA5aDX+xWyrqZDcJavPrO651egwu6QS1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497087; c=relaxed/simple;
	bh=H0oZkagxejRXPq/8iqazC1ZdHHSz49rh+7qB3BzF4Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=El4z0uQchoDpEhL60kYpsAMu0Mdy4kIx3KnntLqV0a2Mw6O9FnPUxg7yFmPbVKATF+57fFae8EAz+Fai2X5CJ39wE/KxK69JXFuq9WYi4809zwm6Js4oNo37OGyp7t/cAlc8abvDabhq9c1YRjhzqakrGOBcrhOl5eCc2urlG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fTeBgFPR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fTeBgFPR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D5F039006;
	Tue, 30 Apr 2024 13:11:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H0oZkagxejRXPq/8iqazC1ZdHHSz49rh+7qB3B
	zF4Z4=; b=fTeBgFPRfAK0DG07mqpcmqpTz1ypM++DbSW3MbGdM5/6qlKOpHQiCX
	gsuuxNnSFZ4M0VsOimuW1uUzLuFQzknRWGjJy1yCAlq8RN53HWRIiVKjyS6ZTEc2
	XMBtPYNKD9tEa0TsacU5BGcZs+4Qd/nALfsOwtMLBZOt3ioenpSxg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0500C39005;
	Tue, 30 Apr 2024 13:11:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6704D39004;
	Tue, 30 Apr 2024 13:11:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
In-Reply-To: <20240430105256.GH1279403@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Apr 2024 06:52:56 -0400")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
	<10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
	<xmqqfrv4ug3l.fsf@gitster.g>
	<20240430105256.GH1279403@coredump.intra.peff.net>
Date: Tue, 30 Apr 2024 10:11:17 -0700
Message-ID: <xmqqikzyrd1m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A8CAE0D6-0714-11EF-A1FA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I am tempted to suggest that it borders on too-clever, and writing out
> "stdout" everywhere with vfprintf() and fputs() would be more obvious.
> But in a little self-contained function like this I don't know that it
> matters much.

I share your preference (and that was the way I wrote "it would look
like this" version earlier) but I agree that this is too small to
matter.

Thanks.
