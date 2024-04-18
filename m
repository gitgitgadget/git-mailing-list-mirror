Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C716F837
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456402; cv=none; b=CqiNBayod798HkN916qQEo+9/mCT/9olq2dvs5oTGlbMc6IMwZ2merwvvdLq5rQE2RzOZYtSghdH0qmvVcRETd7UYAi5X0UPawub9kiTUM62vh0x21Pbg5C+fMKpX+fHeXYbMJlEpAh45xS4mfnqh80t9Iqfjb7aXPPdyjT4P0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456402; c=relaxed/simple;
	bh=5VoTxkDeha/HxDpgOxT07ZNfnW90r1ogQ3ssCmvQqsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGzg4H8ZNyjd5GV42ogNv6vSUepBobJD/hX6NOTCaH0KQdISUwehL+WGYtYgnN/DAI0Ayv1PChJyDesee8CY22BYSJcyyZcqEjryh3XjMjKMqKlqYd2zsiBmC/1BPvseqb5FHKkBBwP/nc7vZ3XzanIzPwt0nkBmLVGO7qApjbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Awd9DZvX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Awd9DZvX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 76E7A29B6D;
	Thu, 18 Apr 2024 12:06:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5VoTxkDeha/HxDpgOxT07ZNfnW90r1ogQ3ssCm
	vQqsQ=; b=Awd9DZvXgznMyubTd7R2pqPfM5q/SBEhgIGVVwC3ft1vOruBAhF2hy
	ETGAAts/Lm1CsrD46h2ykPl7TOpSUqf9b2BNW+kZstd113Gw51lg5OuskhnWxReu
	3oJn+vQgy7rPf5hpWaltByCI3w0KMmBF4VksVtgsof2enSGDGFON8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F31329B6C;
	Thu, 18 Apr 2024 12:06:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3524229B6A;
	Thu, 18 Apr 2024 12:06:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>,  blanet via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] midx: disable replace objects
In-Reply-To: <ZiEee8ySuy6kCvBZ@nand.local> (Taylor Blau's message of "Thu, 18
	Apr 2024 09:22:03 -0400")
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
	<pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>
	<xmqqplun6aws.fsf@gitster.g> <ZiEee8ySuy6kCvBZ@nand.local>
Date: Thu, 18 Apr 2024 09:06:28 -0700
Message-ID: <xmqq5xwe4pvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E48E354-FD9D-11EE-95CF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Apr 17, 2024 at 12:34:27PM -0700, Junio C Hamano wrote:
>> "blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Xing Xin <xingxin.xx@bytedance.com>
>> > ...
>> > Helped-by: Taylor Blau <me@ttaylorr.com>
>> > Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
>> > ---
>>
>> I think this took the review in
>>
>>   https://lore.kernel.org/git/ZhLfqU9VNUW+2mmV@nand.local/
>>
>> into account and is in good shape?
>
> Yes, sorry for not explicitly ack-ing, this version looks good to me.

Thanks.
