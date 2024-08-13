Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF11A01B0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562220; cv=none; b=DHgYbf3M9RzYO/XE1o3F0oKmE7LmchS7qeWdr3m8hdDLz5g8GAGXTDDnddTDsNcccltkr4ypgS+1EuQ4PnUr87an4WUFuv1IBwqPdawnNag7HpRaf4CdB1U4GM85koMq+zaoypX2DbdpDPFy9km4vlCOQJO+3XBxYew7jC1kZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562220; c=relaxed/simple;
	bh=xSuIyQi0n/3Ceo9+xEBIoxoM1RdCWrSqZjq8kgJHXx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=te5Lff5cCTipSpRm6Dx5Hw9fqjs+pf5EOVdSR4lHR5b83klfofdVd07dFcTFIo8i+a4YqSW8I/1J89QyicpoWVUy2z248+wWyOv/h9cQYusL2qvSqr7/18WeY8jo1zVKM+6+OZuZ1JFFi4GI0sweDtDHwzGXE8OPpl5TXjMqZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KFPu4O5p; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KFPu4O5p"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D2DDD1E462;
	Tue, 13 Aug 2024 11:16:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xSuIyQi0n/3Ceo9+xEBIoxoM1RdCWrSqZjq8kg
	JHXx0=; b=KFPu4O5pQNNHTQJxmeScsRe86XHJu4eVVLBR1iTEIL+Rq15iQ8p3rY
	8UsuFqI8fgqs9dRCsQia1tIJ6k5jXVVeRKjpp5X82sC8ecM1cpQdK+vrHVVTtKOH
	fzA/gyPmMdDA2lyQch2ec1xNYqzQ298FPoacKqabVyoV5DR9oyZrc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CAD131E461;
	Tue, 13 Aug 2024 11:16:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 414121E460;
	Tue, 13 Aug 2024 11:16:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Kyle Lippincott <spectral@google.com>,  Josh Steadmon
 <steadmon@google.com>,  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  calvinwan@google.com,  emilyshaffer@google.com,  emrass@google.com,
  rsbecker@nexbridge.com,  mh@glandium.org,  sandals@crustytoothpaste.net,
  Jason@zx2c4.com,  dsimic@manjaro.org
Subject: Re: [PATCH v2 4/5] config: add git_configset_alloc() and
 git_configset_clear_and_free()
In-Reply-To: <92278af3-0ade-4e7a-a024-f66b008b9cd2@gmail.com> (phillip's
	message of "Tue, 13 Aug 2024 10:51:44 +0100")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
	<908ad0b82fa084fc4e56d7f6dff49e4f255af6ec.1723242556.git.steadmon@google.com>
	<47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com>
	<bifcs4ijz4gsnrfjs3naqclo7nj7ajhek6eppgaj6a27ixp372@6oariraac4rz>
	<CAO_smViBnmc4r3MizV5kE406_TvXiwCWtC0jyDb-FT-zp9H9bg@mail.gmail.com>
	<92278af3-0ade-4e7a-a024-f66b008b9cd2@gmail.com>
Date: Tue, 13 Aug 2024 08:16:47 -0700
Message-ID: <xmqqzfpg8nc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0FD4CE30-5987-11EF-9FEB-E92ED1CD468F-77302942!pb-smtp21.pobox.com

phillip.wood123@gmail.com writes:

>> I'm thinking of this patch series as two closely related but
>> technically separable things: the creation of a .a/.so that can be
>> used outside of git, and the rust wrapper around that library. I think
>> these functions would be needed by all users of the library,
>> regardless of what language they're implemented in. i.e. they
>> shouldn't be thought of as 'rust helpers' and instead just the way
>> that the library is designed.
> ...
> Thanks for writing this, I agree we should be designing the library
> wrapper as a general purpose library, not as an implementation detail
> of the rust code.

Excellent.  Yes, make it wrapped for Rust may be a good motivator,
but cleaning up the interface so that it is more pleasant to wrap
for or directly call from any language should be an important goal
of this effort.

Thanks, all.
