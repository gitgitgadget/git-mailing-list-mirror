Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAD3D555
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316539; cv=none; b=twDxAEoN7rBn4Bw0LtjPqgD7Im3p/R2mY9kdHgB3UYpweRdSyuTXkq558dlwzs1gmqor22xP9iAwlGo7OmSkfgXWr76Ru320HXkkLRs25UQFw0KGJj29/BFYABlGOdkF5CfUO5qMzrp4TaY+gliEKxrHu/bBGxjytumTxZMbEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316539; c=relaxed/simple;
	bh=0rcPzPyIw7RvxzfU8QotNRsCY59dqPTLqik4In9Qi+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAyxh1rgeypKJIZZT5p/9luG5NjlxIbZG3oVbygg1mXFFmHL04dguK775YarK9k9X4mt9/lXbozcycJtWCYTfyaNfMno54aLUI7cmIY4IozYsulXbgUj+dQcp5WYzrOBuotSpZkLrh3RatgSrCszfRPtblMA5jCouqicKKM78CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wn3lvhqZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wn3lvhqZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C43921E10AD;
	Sun, 24 Mar 2024 17:42:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0rcPzPyIw7RvxzfU8QotNRsCY59dqPTLqik4In
	9Qi+k=; b=Wn3lvhqZKj6pbypVmBC6GYetUvSzdF3YFTWibgftoFh0IZEbzwr+C4
	zglJgvniIlPd1efG289QRAHte2KD1RS1RGhCQ+Zy2MYjlgb818130QgpkWkzZ2EZ
	O2Gbj6Oefr9rfqLsD03kCS//bzoMTdp0jG8BQpDTy8KMabpECqLtQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBBF31E10AB;
	Sun, 24 Mar 2024 17:42:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 318731E10AA;
	Sun, 24 Mar 2024 17:42:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Git mailing list
 <git@vger.kernel.org>
Subject: Re: 'git bisect run' not fully automatic when a merge base must be
 tested
In-Reply-To: <CAP8UFD2dNix6OMzCR5Ao8YLD-OVbcOfZOP90G7-QRx=OtRAoYw@mail.gmail.com>
	(Christian Couder's message of "Sun, 24 Mar 2024 18:57:48 +0100")
References: <6ee4b8d8-5acb-3d3c-28e0-be972945e8d7@gmail.com>
	<CAP8UFD2dNix6OMzCR5Ao8YLD-OVbcOfZOP90G7-QRx=OtRAoYw@mail.gmail.com>
Date: Sun, 24 Mar 2024 14:42:08 -0700
Message-ID: <xmqq34sfqpcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5DBA92D0-EA27-11EE-AC37-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> I think the merge bases should only be checked at the beginning of a
> bisection. So it is strange that it happened so late after it was
> started.

Using cherry-pick to alter the shape of the history being bisected
may confuse the algorithm to find the next step to test.  But if it
is not "confused" but "due to dynamic expansion of the search space,
we ended up in a forked history that requires a merge-base test"
that is a legitimate condition, then I tend to agree with Philippe
that it should be automatically tested during "bisect run".
