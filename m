Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B2156C7C
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940096; cv=none; b=mWR3wcpqg7QZgQwjm9/lWnw0WX98JkFdweTKnnSq/KSv3xzh7ESSB5nhdDes0ghgVl+UZ609QzjXP+PUGO2obQAR4Py47uOC8IVoflhrfZReL6XlF+gzmcXo6rLGeKX1tsOUL2ROh2zPxLSwpzNrSGdwWZ6YPzxBvoA82bDcZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940096; c=relaxed/simple;
	bh=5hVpmw0uGiBwywE4XTwcrySe6v91Q236VidQqraydoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGFGvxoV60MAWA1UYwqIGTUO/QYklm4s+4VJMgU0jHNeOuoBSn/J0vHaeqSOgDVSQ0vPmF+6uzcWNL3GOWb72M0LlcK2jygV0SGjHtMKNJ3ceXmdNPFTw3ectolvGiia9BT+OSTAwfitwU+9auXuSGd7MxeI2JoZLxAPDKWc+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PaFIIyZI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PaFIIyZI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1151A37204;
	Wed, 24 Apr 2024 02:28:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5hVpmw0uGiBwywE4XTwcrySe6v91Q236VidQqr
	aydoY=; b=PaFIIyZISnRYw8tjLDwkHSm4vHRPr1vOyR3+rxRKKQxHC4fw3EFr3G
	HDd2BPASfq0Q8iPJNTuiggDp4QwAauUiTDXeKqjrMJlTMNhmkL3kfiWV5/l+l6if
	tgXDmU8GtgnU+4XaEWCUp/tXcmxxryFcpxuvH8fqMG8NvMd6c2G+E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 09EC937203;
	Wed, 24 Apr 2024 02:28:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 649F637202;
	Wed, 24 Apr 2024 02:28:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <20240424035857.84583-1-james@jamesliu.io> (James Liu's message
	of "Wed, 24 Apr 2024 13:58:55 +1000")
References: <20240424035857.84583-1-james@jamesliu.io>
Date: Tue, 23 Apr 2024 23:28:03 -0700
Message-ID: <xmqqo79z2s24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF16392C-0203-11EF-AA17-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

James Liu <james@jamesliu.io> writes:

> This patch series adds an "all" advice hint type that can be used as a
> convenience option for disabling all advice hints.

Hmph.  I thought this was rejected already and not in so distant
past, but I am not finding a discussion thread in the archive.

The design to support the advice.* variables to let individual ones
to be squelched, without allowing "all", is very much deliberate.

A user may think they are familiar with all the advices already, but
with "all", they'll never get a chance to learn new ones added after
they set the configuration.  Looking from the other direction, a new
advice message is a way for us to tell our users something important
for them to know.  For example, we may plan to improve a high-level
Porcelain command so that it will eventually error out when given an
input that used to be accepted but behaved in a way that newbies
felt confusing.  In the first step of such a transition, we will
introduce a new (and hopefully better) way to achieve what the user
wants to do, and add an advice message to tell the user, when they
trigger the codepath whose behaviour will change in the future, in
the old way that will eventually go away.

Do not close that communication channel on us.

Thanks.

