Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CC23CB
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490421; cv=none; b=gsO8eLB9loeDUy5Gwk//LYhxZpB8No0zNoxXwah5dVs3gf6Oh48IddVfX1TqVy3CRIZtIu+Qyw0IktA3A7BNTx0weRGzrMh+snLVE+24D5UwLkIu+FcWZSi/ItcaAG95PoxyXu81KMBXAqbo8rUTgYnMxtT0LsUXqo5JprNNQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490421; c=relaxed/simple;
	bh=YJbQqpliWCWjjW53W9Vmvcltu3quhKOwl9IT4zUbnE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SeL2DpEIbWF1DiyMsHoWuOdgIZ6rq6qFl2J49ooOux0nTFsQC13wo7qBVeY0u6YOV9vEYaEoxmI+9zWK2SuZNR9jMPdN/5rM3v58JdnkOAffN2QsRx1ZEDYmPpY7eNFLsPjZdcENlNNJHnOcxQn6bznz37HFEGgE2XckuvmegtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LdjcRRYa; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdjcRRYa"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E0751982A;
	Tue, 26 Mar 2024 18:00:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YJbQqpliWCWjjW53W9Vmvcltu3quhKOwl9IT4z
	UbnE8=; b=LdjcRRYa9WzjZc7H5b7vMN81PWgLcxdUokJBiJ4tcTzh4GVfz5tmyf
	C1IsDGNPfPNp+btxWw8ypxBRSj7X84xzOztBm057uVpdm3T3yDWmQXk+WuAoDKJx
	PXzpIww67O4LrAj0y6qfHg88z7vVZtk/vsYw2X/aZlAfO/fURtDzM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 853F519829;
	Tue, 26 Mar 2024 18:00:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFFF919824;
	Tue, 26 Mar 2024 18:00:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 0/6] Make trailer_info struct private (plus sequencer
 cleanup)
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Sat, 16 Mar 2024 06:27:02 +0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
Date: Tue, 26 Mar 2024 15:00:13 -0700
Message-ID: <xmqqjzlo7ixe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39A71FB2-EBBC-11EE-9C4E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> NOTE: This series is based on the la/format-trailer-info topic branch (see
> its discussion at [1]).

This unfortunately depends on another series, which has seen no
reviews after 10 days X-<.  It did not help that this was sent
almost immediately after that unreviewed series that it depends on.

Any takers?  There must be some folks who know the trailer code very
well, no?

Thanks.
