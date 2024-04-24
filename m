Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23F803
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918438; cv=none; b=TUiOKoYSVFg9BWsb9Yy9pqZa+yki1lxOjbLJc/9/Xns0Zto1S7KaYsV1mhtq7X5K4+k57PjRHpHCtEqRwIsxVTgT6BHMgv+pRHJTtBL3ziDM458pCMa436iZB5Vq8Ae4ZVDZFnJN9huK3c9cJ2+pw2Jrslj84214EU9RKY7V5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918438; c=relaxed/simple;
	bh=CK6Ojk/4LlsORIfugfyzCvkQwgZcrnmLzTrU4D5Nk88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7dvOK01O3lN+nOnZDJXdZXO4ZMf5twadrOphPI4G1cdtngejVnv+LIdkuC38+O+7K8+WVKIr2U9/YmDJ+avrwjQUyqKosrapDt8Y5s7p7YJMdOL+Zn06vj5BHZlLjMPCSjI8Yjl+zRkmMmMYOx7Gj2YRNDm3xgpOIpXqwU2s9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RVdCkwwI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RVdCkwwI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E30321B1D3;
	Tue, 23 Apr 2024 20:27:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CK6Ojk/4LlsORIfugfyzCvkQwgZcrnmLzTrU4D
	5Nk88=; b=RVdCkwwI6UAALo5YpQ6OoFK1YUuBUJDabebHfGJwacfno/a5dYScrr
	bFME3gw0v0lbXLZNz3i2TTL+LCIjpJTZGsGUhjI8ggTPm/4PjmdlSBp7KgJmWa/8
	eychz7CY3voiqjKDgQsMpgSuNpP7HTrjrfwPtTbAC7lxwe6W3wXDQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA4771B1D2;
	Tue, 23 Apr 2024 20:27:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A90C1B1CF;
	Tue, 23 Apr 2024 20:27:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 0/8] Make trailer_info struct private (plus sequencer
 cleanup)
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Fri, 19 Apr 2024 05:22:25 +0000")
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
Date: Tue, 23 Apr 2024 17:27:08 -0700
Message-ID: <xmqqil074nc3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 630AA47A-01D1-11EF-A27B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> NOTE: This series is based on the la/format-trailer-info topic branch (see
> its discussion at [1]).
>
> This series is based on the initial series [2], notably the v4 version of
> patches 17-20 as suggested by Christian [3]. This version addresses the
> review comments for those patches, namely the splitting up of Patch 19 there
> into 3 separate patches [4] (as Patches 05-07 here) .
>
> The central idea is to make the trailer_info struct private (that is, move
> its definition from trailer.h to trailer.c) --- aka the "pimpl" idiom. See
> the detailed commit message for Patch 07 for the motivation behind the
> change.
>
> Patch 04 makes sequencer.c a well-behaved trailer API consumer, by making
> use of the trailer iterator. Patch 03 prepares us for Patch 04. Patch 08
> slightly reduces the weight of the API by removing (from the API surface) an
> unused function.

As we haven't seen any interest or reviews to this series over its
two iterations, I took a look myself and it looked mostly OK to me.

So, I'll mark the topic for 'next' unless somebody objects (I really
was hoping that Christian would utter something on the topic as it
has been his area all along), but given that we'd be in pre-release
freeze for one more week, there is no need to rush.

Thanks.
