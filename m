Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095616FF2A
	for <git@vger.kernel.org>; Thu,  2 May 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670148; cv=none; b=qX6y+DnW9/YJUcjkuU3VqazqTln/eLm4H24fgndaN4545EnWACYG6DbDUwOJal1tX83DeldW16pFk211AO34Sofdj/L7Tpdq3PDUnrZu8dfOif+4jsKJ3z85Fk7JkDB6PP0UsJbNMYq0vZCCPAyUIuXGRqtdRUUY866z23pc6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670148; c=relaxed/simple;
	bh=iyKrB4I83EyNotMUvrzgIOJyILCgeLAIiApBNURktks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CdMJNf6YkhilWopjMairtZg8GYjhLwH0BPQiPvkGqgvkUBsjuuEu87UP8dGiTOlGguOxDh6Fv5w2y4/8cmKE9mdDATM2RQLaHa02gp/q84X+ukb9yXOH09dJaqVHtL5i4L27ck3/8x+p5846dj5mA6KswWMwweJDpfDMZwmKl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x28gH1Tp; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x28gH1Tp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0671E30C85;
	Thu,  2 May 2024 13:15:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iyKrB4I83EyNotMUvrzgIOJyILCgeLAIiApBNU
	Rktks=; b=x28gH1TpjPoOhuwTjvjlIT7GmZeh8kGW7/VIFY6qEeGPiiqsik5JvB
	5Il2WyrfFebXVxHHHqb++mz38m3FHdEAJ2zYlOr5zuoc1EpCBa6a44uAz4PPOJIu
	TalfMgoDOYeuex6WUT/Toiv4TH/fiIGNrTcSQx43eVE56s1xnUw+Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F20A330C84;
	Thu,  2 May 2024 13:15:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF55A30C83;
	Thu,  2 May 2024 13:15:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linus@ucla.edu>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 00/10] Make trailer_info struct private (plus
 sequencer cleanup)
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Thu, 02 May 2024 04:54:17 +0000")
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 10:15:41 -0700
Message-ID: <xmqqmsp8dtj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9B44E080-08A7-11EF-96AB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> NOTE: This series is based on the la/format-trailer-info topic branch (see
> its discussion at [1]).

I took Christian's "I ... had only a few minor comments on some
patches." [*] to imply that everything else without comments were
good, so hopefully this is good to go.  I've amended "some some" in
[2/10] while queueing myself.

Let me mark it for 'next' unless there is some objection in a few
days.

Thanks.


[Reference]

 * https://lore.kernel.org/git/CAP8UFD3Vzs2KvsE2qmx_54UX9ktAngr2FkpKfWVjRMD=t1B7Wg@mail.gmail.com/
