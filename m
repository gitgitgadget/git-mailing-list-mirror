Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E7257A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214735; cv=none; b=Z0MdvIRb/Eo9EwZquIqbS5GKM9p6SM096fZy+ZJCM7qM7HEtSxmCEo9BWvS4+l/RtEQCQKjtAHY4OQrOzVLr+mdjCCB/2eD6OUmBhQ/HE/Ujs/20ZN4LiKTs+ZCJRfuosy1xZUZv6JbBORrDSUobCQzBvuKaMvIKZJN9tvKFd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214735; c=relaxed/simple;
	bh=auzlgP8eKMqodU+zEaluawCxOvgtH37hMjBCcsdyIIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A6lNPPoi84KhhwiN50ViaPMq4/bnkDDVHeF75hyTVyUc5ItrbKnYyyHC6AxwLPuqliQTFIP+uSklvg1P8YJPHeo6Jks8Ygj7T5zCKh+zELE00dHUHVbW64J9uv7XDPPJYTm/5yJAG+Yt/An63ZkysRrl5kAhCOBJab6GZ+S3VQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JZCzq1nH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JZCzq1nH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 892DD1BFF39;
	Thu, 25 Jan 2024 15:32:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=auzlgP8eKMqodU+zEaluawCxOvgtH37hMjBCcs
	dyIIc=; b=JZCzq1nHsH9vpqP09+Y35B3W883B0kLqAL0TQHd/nKr2Rz1Lt5pyVT
	38w2SikbF8OSQog02qJhcP5+LXQyotnyqZ1ZB7Yu4jMVamEY0SbVYYh5zch5PlpT
	y49x4Jrxcozmf2XmpNwp91MwQweypoIe8A3H5bNM1Fx6qyCPMQpi0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F7B31BFF38;
	Thu, 25 Jan 2024 15:32:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 925461BFF37;
	Thu, 25 Jan 2024 15:32:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 06/10] trailer: make trailer_info struct private
In-Reply-To: <ZbK4BcESMfljw7Ym@google.com> (Josh Steadmon's message of "Thu,
	25 Jan 2024 11:35:33 -0800")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<0cbe96421c7bf573e8ddc97b2a0aecc894095399.1704869487.git.gitgitgadget@gmail.com>
	<ZbK4BcESMfljw7Ym@google.com>
Date: Thu, 25 Jan 2024 12:32:04 -0800
Message-ID: <xmqq7cjxw3wb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CDD0CA02-BBC0-11EE-8327-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> The pimpl pattern also seems like it will force us to think harder about
> providing a useful interface, so I am in favor of using it here as
> practice for future libification.

Sounds good.

