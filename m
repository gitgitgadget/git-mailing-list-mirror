Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3638BE6C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423131; cv=none; b=rx3ZrfnLCIeBt9JTVkSxijqTPV/Zpgo6MYudM9P1JBF+kNRuy5Hr01nOnytLMu0X1rWGvEvwCXfLAZtCMI8CCd4+BDv93OjxnR1Gu/SmUYp1SDfME9m5cn/GLfwqy+gbM/vYYULesJ7WbST2lgfKZvJN3h9OW8nEFgFAGAGEIto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423131; c=relaxed/simple;
	bh=3FOJK6y1rLEcGl0Nn0mOwsRNjVDDlyLu2c3hQ/+CBuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqBYk/K+Ifudfb7fykgPJstV02eAvzb2DoHyAbq2Y9qqUlVITkf4tV+hb/CGfJ52V3ASUrCFFwG/MNGPyMfeOEpktHWjwG9EMQYz9T4a2b5yH4XIIB8vG58cmZvU6Ko4MqVioAFhav+PiC23N5VbL07lMWBNvqi1G+Uo6fNiMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HxBc2jLE; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxBc2jLE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E8D6299B6;
	Sat,  6 Apr 2024 13:05:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3FOJK6y1rLEcGl0Nn0mOwsRNjVDDlyLu2c3hQ/
	+CBuc=; b=HxBc2jLEaD2wZqSscEYR+orKVEGo5a1fqxChB9TYyVqvKYGqJiHJyu
	pQ5IFMbEDrgZnPLHC4qzbC4bdzg4Ek+jmVj83b10Z6hhP7OtxxxRFxuElm8LkbF1
	REt/HvoDf+qqnguDCX74BGmbTJUf8bDvAVpVSxYP2tbNaS0jeM4DU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 567A7299B5;
	Sat,  6 Apr 2024 13:05:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3231C299B4;
	Sat,  6 Apr 2024 13:05:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqqwmpbm4lp.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	05 Apr 2024 22:40:02 -0700")
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
	<xmqqwmpbm4lp.fsf@gitster.g>
Date: Sat, 06 Apr 2024 10:05:16 -0700
Message-ID: <xmqq5xwul8vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D82C0674-F437-11EE-B5AF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The whole thing deserves to be a three-patch series, the first one
> being a preliminarly "let's move the final newline out of the
> translatable string" step, followed by "let's have a gap between
> output for each patch sent out".  Perhaps another "even during
> sending a single patch, we may want extra blank lines when use of
> editor and other user interation is involved" patch on top.

Or the latter two could be done in a single patch.  I'll have to
re-review the thing (if I were the only reviewer of the topic) so
doing so would delay the completion of the topic, though.
