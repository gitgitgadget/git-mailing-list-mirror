Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE208248E
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202873; cv=none; b=eFBTs9yzp52ngUkSThnLyB6sUPmeD2oyyyZJXT0zxC9rdSnenjRwUfliJs6Nx+Vl42U9JCcYTybZBPfm+zFSig6vMB+3dfUIeaimoE5abNhfBv4RCnc8oirKnI/GRIOPqQR8135/WlmykYp2/5BLdh0VzSx11P5D2KPG3Qn92ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202873; c=relaxed/simple;
	bh=ejREvfjluaqVgwLHTnmIudt7D940IspkPxzQGwiTpNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uC2mu0mtCJRTXXfYWx+GP9Ls/JpQMBtgvXgO7WgniE71+ke/CU+YvQ8JWUvCzu2mu9wakeqXpWFhrpOdwlhLfFUHxozVzOJKVR/VjTs2z6E/Wv1dxm+KiQ3iew6FdrpBZO+og2SzQx81BeIk8BSM3s+h5sHgrMCHKRhJWbUWvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fJyU5uPW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fJyU5uPW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 268351FBE12;
	Mon, 15 Apr 2024 13:41:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ejREvfjluaqVgwLHTnmIudt7D940IspkPxzQGw
	iTpNM=; b=fJyU5uPWOsRw7ucCt2+W7iLXDqv4fA9HQlsa643i+7MQtzItuzydEy
	PcXrv2UCvV9hR/IZPSPbujGkH11rlWbaaxZCz9BQDkZOk9uZET4JM2iFB2QVOO6C
	S1NjioFMJtG3eYrcEDhXAt1tse2d0dzCoL5J5jNgi1ajig1sTKyyU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FB291FBE11;
	Mon, 15 Apr 2024 13:41:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83BAF1FBE10;
	Mon, 15 Apr 2024 13:41:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
In-Reply-To: <ZhzqeRIcyR3lmBme@tanuki> (Patrick Steinhardt's message of "Mon,
	15 Apr 2024 10:51:05 +0200")
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
	<a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
	<ZhzqeRIcyR3lmBme@tanuki>
Date: Mon, 15 Apr 2024 10:41:09 -0700
Message-ID: <xmqqil0io762.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58C7AF36-FB4F-11EE-8FA1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Helped-by: Taylor Blau <me@ttaylorr.com>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> Junio, it would be great if we could still land this fix in Git v2.45
> given that it is addressing a regression in Git v2.44. This of course
> assumes that the current version of this patch looks good to Taylor.

Indeed.  It would be nice to see an acked by or something.

Will queue, in the meantime.  Thanks for a ping.
