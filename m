Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF267DDBC
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711317282; cv=none; b=SD3Ffa+/isRiJdncBXnEO5SKU2FRx1lQlDA68E5owiqVenI7Vac7zv7h6ca028u5EPMSU+OCSNRuTm0bY6F/6AXeOs0zXBKIjIFnRq4gOMsiFb4xxQHAiyE1+WqUOzYL4Z/cHgen/ozgFXo3tPuWp147JzMBp7lJ39fuiJ06Tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711317282; c=relaxed/simple;
	bh=MGXIJDQHnA9Hf7qGUPiPytLQxNPS+S8eBy9G/KtzapI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uy4Wz7I669d4K1T7Y5epMFOF7JQEGjwXOWsJ9/ytX7yhM0/XkAszn8AsWQlGLJRYFwqReedYoRQ9d7VIyWUt9tNOPi0cL5m0O9Ki8jQe68RdoeAFFLHeNtOyBl+ZAfegSxTAOCmi0ZRJRa9LW+0Y1Qti4pDijklaL7GpKZSRLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nFQxQrhi; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFQxQrhi"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 01C952AA8F;
	Sun, 24 Mar 2024 17:54:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MGXIJDQHnA9Hf7qGUPiPytLQxNPS+S8eBy9G/K
	tzapI=; b=nFQxQrhiciatErRziKvdSOjLjlNkWn+2DJwDiF03pFAsfUcZHUYZFO
	uPmhIjs46gIoQQr5szHYo0ZsVNvZzD1fsBoMBpgE6xwYs+1yUGh2dxAcfw5QizzI
	hFldymZobgaXuVHDfzFwbiUdItRmN6HjxPeKbqRCMm9Fh17pTRWLw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EF2922AA8E;
	Sun, 24 Mar 2024 17:54:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1C0A2AA8D;
	Sun, 24 Mar 2024 17:54:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Cc: git@vger.kernel.org
Subject: Re: segfault with git rebase --abort
In-Reply-To: <88a694de4a7f767613475ef1d19292a69eaccb07.camel@rohdewald.de>
	(Wolfgang Rohdewald's message of "Sun, 24 Mar 2024 19:28:21 +0100")
References: <88a694de4a7f767613475ef1d19292a69eaccb07.camel@rohdewald.de>
Date: Sun, 24 Mar 2024 14:54:33 -0700
Message-ID: <xmqqle67pa7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A222B1C-EA29-11EE-856E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:

> git rebase -i
>
> git rebase --abort # boom
>
> git status only shows changes to be committed
> I can mail or upload the git archive, that would be 230MB
>
> git fsck;git repack;git prune;git gc does not help

This thread _might_ be relevant.

  https://lore.kernel.org/git/20240218114936.1121077-1-marcel@roethke.info/

The "might" is because the symptom is a sign of corruption of the
rerere database but the discussion or the patch in there do not know
how such a corruption happened in the first place.

If you rebuild Git with Marcel's patch (there is v2 downthread, and
we have been waiting for a v3) and it improves the situation, please
do let us know.

Thanks.
