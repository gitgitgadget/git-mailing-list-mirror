Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72C56B6A
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012886; cv=none; b=WCpKn5ut394rmw6cmicYqPKMlldRzDtZiFl6zF8EqAlN2oMlBxqx12IW2kZg79ghfVlnmmHAjqSlvA6V9gHB4ZRb8Yn34BoITlz1ArMw1Ir4252vZWH4BAGy7uwNARqwy3yRmZf0MspB2o59q92Fov8GVU+3hTSi7/qjc+5ss6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012886; c=relaxed/simple;
	bh=egRF8jmberoFZWJlw3HfGdLJm8IB8btImcFiP0X0Q5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=taq8Gu03JeAhRl02Cav/mlEIhr/AJDHtUZIPmVOs2lr5/2bP/zgn6gsAUdZ/7kYN0E5O6EjZ00NtAX0TVSrhfxUUYnxnuLAjRVAaPKInR7fUMk5B/Su7VtTZzLECghFFovCuYUFgNJRdP2gDxtzsHmS9H79WnZVu82PEIKSPlo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kBXy0G7A; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kBXy0G7A"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70CBD1D9D2C;
	Mon,  1 Apr 2024 19:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=egRF8jmberoFZWJlw3HfGdLJm8IB8btImcFiP0
	X0Q5g=; b=kBXy0G7Ai7kCNwBoV3YL+TFffkiy59Gn1/e0ne1e4yU+rffwuWIhGj
	MR8iJG9RzjGmt/bC5mzLeCEzXuosngojO12DA/RrXHqzTnbVVzmYwfSlRZJ2BM2h
	RY0Bpx1qhIiaghGM4PQ4YPCke7TO6L0pOR+OZUOLDLKIjib8PHys0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6787C1D9D2B;
	Mon,  1 Apr 2024 19:08:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6C261D9D2A;
	Mon,  1 Apr 2024 19:08:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #01; Mon, 1)
In-Reply-To: <xmqq7chg91ma.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	01 Apr 2024 15:09:17 -0700")
References: <xmqq4jckaoid.fsf@gitster.g> <Zgskgeg6kXJsb3/c@nand.local>
	<xmqq7chg91ma.fsf@gitster.g>
Date: Mon, 01 Apr 2024 16:08:01 -0700
Message-ID: <xmqqmsqc7kby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B0D2F768-F07C-11EE-A1B6-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>>> * tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
>>> ...
>> Thanks updating the description. I am waiting to reroll until after it
>> has received a little bit of review on the technical front.
>
> In the meantime I've dropped it as it interacts with tb/midx-write
> and Eric's khash-to-khashl update.

I think I got merge-fix for integrating this topic with the rest, so
I'll be resurrecting it and queuing it to 'seen' again.
