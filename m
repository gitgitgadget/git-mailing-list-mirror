Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB314900A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892440; cv=none; b=GjRKn2sd01cHObWL1VQqjrypOWwXoKxDELrE7ZiizBIvkBoAndkvAvpCBRAQi8PIWNohme04iqqVFrpxj1jJ3Iwh6yq6xAHr430ZJlrNlpwpDBHqOKEm1LqEBGklzvW5FScGo88ptfKZW7Hwa5Je5A82CqtGlaA3+xy8ZsN4Rk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892440; c=relaxed/simple;
	bh=bDuvjlFUmKv2d4cxyz+YbtuGY2gFupL/huw/uczn5ww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMRRoi+zQa7laQfnVSCkpQBcF+KEMt1mcBIBKDaDgpgiiL4w1D2u5Q5TFBsHm0Xkp0UGguPUPUPOQMK5vBlnCnfDv0bK10xGLHCQnVExXKw1xZUtBZ8vWucSrqrx3V4tRcqjejtMhvko2HeWlp1lEi7Ej2RL5qggxazybB29odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MJzVYllr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MJzVYllr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA2E51C2203;
	Fri,  2 Feb 2024 11:47:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bDuvjlFUmKv2d4cxyz+YbtuGY2gFupL/huw/uc
	zn5ww=; b=MJzVYllr+gQ1bO7IwjY+xy+wOsTdJF63CBAgGbYt3dQCoBPVG7fU0/
	afVK6uACZ9ATgmq0qaPINK13nU/dzU1rN7LHEHR3kfXdEGl7EYE3fPCHu2d3BAk6
	qf9pn4bbJoKxbdcSVv9J9+VVv/mdiD9bd975YAhITTl3ETQmMaSfE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0DAC1C2202;
	Fri,  2 Feb 2024 11:47:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 333541C2201;
	Fri,  2 Feb 2024 11:47:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with
 --missing=...
In-Reply-To: <CAP8UFD0HwQr+qj=FrDQXJeY8PhVH1e7oErbVopgtv2X8ig7a7Q@mail.gmail.com>
	(Christian Couder's message of "Fri, 2 Feb 2024 12:29:25 +0100")
References: <20240201115809.1177064-1-christian.couder@gmail.com>
	<20240201115809.1177064-4-christian.couder@gmail.com>
	<xmqqo7d0x7fm.fsf@gitster.g>
	<CAP8UFD0HwQr+qj=FrDQXJeY8PhVH1e7oErbVopgtv2X8ig7a7Q@mail.gmail.com>
Date: Fri, 02 Feb 2024 08:47:11 -0800
Message-ID: <xmqq5xz6vmnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B7076378-C1EA-11EE-BF34-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> I am also not happy with adding yet another dump loop like this. I did
> it because I couldn't think of a simple solution to avoid that.

FWIW, that word is "dumB" loop, if you are including the word in
your updated version.

But I am still wondering if this can be unconditionally turned on
any time --missing=... is used.  Have you considered it?  If we can
do that, it would eliminate the need for that extra broken loop that
will fail with "git rev-list --grep --allow-missing-tips -20 HEAD".

