Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E651339B1
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000341; cv=none; b=GaY93Qro+IZ/NgnXpjXa4OHERAw8mZxX5LnaJWiShPKD6rfIMXD8zHCiHvhs5ZynunjSmO0Hb2mePhjLjfd10Y8oIHpop2v/dZbl0Hh6LcUBgkAWVkjXwpaGTEBU28Xc+4cKqVM2dH1PUFz7iLpDumYX+KvQhXmFueno8z/p8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000341; c=relaxed/simple;
	bh=pG9WSaTejQsCPgk2SCqXB+1X7QPLaiVgRWToF3EyUR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RynZ0deKqiuKqE/GCnDPxspS6rY1O8X6EODd4nnATXBX8QEmKRT/9rmlO+PddvwzXuxsHOuPaHgboyn6HQgt1XDP9G+ADBRK+UMHkjDS4tS4dAbd6owwi+xgBlXMCZ+8VhNa0mfFkBUg/wczdscnmgzosXGHxDXB42qdjhkoAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CgAJCCV7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CgAJCCV7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C66212222D;
	Mon,  1 Apr 2024 15:38:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pG9WSaTejQsC
	Pgk2SCqXB+1X7QPLaiVgRWToF3EyUR4=; b=CgAJCCV7bqiz2WsfsCoqqzHQTufH
	VAYgkZGa8XbJH/GDHK8/1JMt29TNdT92UPVcNpQSOQY+0lAU+R6qT0aK2CrTtk+7
	ATPYIvO4GWVImNqNhcqnM0sD/IcwnHFRqBh9eWqi5ZTCx2X2CQXSRh0xcFid7mps
	gYApFdSaThaiplg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BEED12222C;
	Mon,  1 Apr 2024 15:38:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4ED5D2222A;
	Mon,  1 Apr 2024 15:38:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] completion: fix prompt with unset SHOWCONFLICTSTATE in
 nounset mode
In-Reply-To: <CABr9L5CLNCYFcta0aMApkyxr_jW9wycY8GmJsUPr9kg1smv+Kg@mail.gmail.com>
	("Ville =?utf-8?Q?Skytt=C3=A4=22's?= message of "Mon, 1 Apr 2024 19:10:30
 +0000")
References: <20240401113033.28709-1-ville.skytta@iki.fi>
	<xmqqttklcd6d.fsf@gitster.g>
	<CABr9L5A_zz6ZvBWUoX_Px6Upyiur3+SPp8U91uw3OXO0mXZgeg@mail.gmail.com>
	<xmqqh6gl9eq5.fsf@gitster.g>
	<CABr9L5CLNCYFcta0aMApkyxr_jW9wycY8GmJsUPr9kg1smv+Kg@mail.gmail.com>
Date: Mon, 01 Apr 2024 12:38:54 -0700
Message-ID: <xmqqwmpg98kx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7A886548-F05F-11EE-8AD1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> TBH, I'd personally just rather patch the "vulnerable" reference to
> guard against this. Sent that approach in another mail with subject
> "[PATCH] completion: protect prompt against unset SHOWUPSTREAM in
> nounset mode".

Yup, that would be more future-proof.  Will queue.  Thanks.
