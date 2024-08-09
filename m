Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A911684A7
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246599; cv=none; b=a+XbDFoXogxUzTXdcDTvu6PvVS7dxbQBFB788+HSv6VoTpOiMaXhFHHXFDPb/X7a5cp4s8pRBNJ5Y0KvZnAEPHzaDqT1IkM6Iqqoys8SFrWqdjMb6Z1yKZHqYcTZpI1ELkEvdDHX437ojbLFZftIgqTgoIKZEjQ0ErDH+WV7dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246599; c=relaxed/simple;
	bh=5lGRG1LzdTEivkLz8tyHYzBadio8yNVKMJgu/eqH8M8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hW2vtUks3Dmr6RLL/VflZbm/NaTC7oF6RxQX249+66/oB5a1pEvm1W66JlJ/bVcPZkPOOT0s3zzThpfV2Rafjtz4/s2ePgDG+yWyohIEXjyp2OiPu1kdhLlTsqHjUNd8LeF8UDaXlTpFGCfxfPi4vKRUiHyihIp4OUsUhzmdESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jy+fC+MX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jy+fC+MX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F99530E9C;
	Fri,  9 Aug 2024 19:36:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5lGRG1LzdTEivkLz8tyHYzBadio8yNVKMJgu/e
	qH8M8=; b=jy+fC+MX7XegC6uh3FllYrDWgTrieFsCAWHPiz0Z9UINm3rvNBP6vF
	q4oXpyX36Zm4mM9sFKwIeJ9fKO9OkWWcW5Ca8XqniYFDV17A7JxWjfgt2+NkFI0q
	VoUXF3FLoO+u/ueqhd6OsFqQ63BNEFJBywa/Zbr4pZxcUohrJrj0g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EC9CA30E9B;
	Fri,  9 Aug 2024 19:36:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3CDA30E9A;
	Fri,  9 Aug 2024 19:36:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net,  Jason@zx2c4.com,
  dsimic@manjaro.org
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <cover.1723242556.git.steadmon@google.com> (Josh Steadmon's
	message of "Fri, 9 Aug 2024 15:41:12 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1723242556.git.steadmon@google.com>
Date: Fri, 09 Aug 2024 16:36:32 -0700
Message-ID: <xmqqfrrd9slb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 366F1D84-56A8-11EF-821A-BF444491E1BC-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> This series provides two small Rust wrapper libraries around parts of
> Git: "cgit-sys", which exposes a few functions from libgit.a, and
> "cgit", which provides a more Rust-friendly interface to some of those
> functions. In addition to included unit tests, at $DAYJOB we have tested
> building JJ[1] with our library and used it to replace some of the
> libgit2-rs uses.

Thanks, queued.
