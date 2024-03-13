Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C3612EF
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354871; cv=none; b=EJTz0h25J2Oyms/nsQ4flZX72uD8wsP91pT/8ymxc/1/4WeYzqeT2F2fxfDLIsmScbZ/f9c1ReTCjUMnBdjekAtLoFdUTAj1oIDL162iBylANXmLNSu0m4uY+j41ItRIH9kpVUwuMZrJwOpKIOqqXaTfRmGbhrJBd+j5kxks3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354871; c=relaxed/simple;
	bh=zYg4ncSSCxEmfx1P8DLLTbFrtpWFM94Iiz+8tSvUm+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETdZgybcvev8iLK/yE9JRRmF2Iix6sC1jBKPRxCgM0D5Af6sgNNhWZg9JA+/UxegyIn/JnEQTl6MPg7a+llzGkSUkSWo8bMg0zVaQCLymBNzm5lO94M9NMSLFOJpCgllyzWzAVu4Y1aLm7+CaSZNTvBElh12zdrn91MPV/7m9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WxXPRwEy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WxXPRwEy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 615821D4D1E;
	Wed, 13 Mar 2024 14:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zYg4ncSSCxEm
	fx1P8DLLTbFrtpWFM94Iiz+8tSvUm+k=; b=WxXPRwEyabUXogGKP3tf9xnH5xh+
	EfmVka7NyEaDGNHSahXX3joA1piOhtlHx6d7xeI+HnSS+olSnkS7SyiIWcB5mCOL
	7FloSKoE3EHeZI4ECRPTzjc8rXeUNFHLuSdQzQbXBAQ/CzNiWGYUnwBNl9UWzwda
	7bsLHZf4/HDRYfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58B961D4D1D;
	Wed, 13 Mar 2024 14:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACBC11D4D1A;
	Wed, 13 Mar 2024 14:34:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeppe =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Sparse worktree always contains root files
In-Reply-To: <CA+osTZWsGv01xinFPKbTQOF9mpvfwWs4wJczHSZXLdRxf1OmwA@mail.gmail.com>
	("Jeppe =?utf-8?Q?=C3=98land=22's?= message of "Wed, 13 Mar 2024 11:16:46
 -0700")
References: <CA+osTZWsGv01xinFPKbTQOF9mpvfwWs4wJczHSZXLdRxf1OmwA@mail.gmail.com>
Date: Wed, 13 Mar 2024 11:34:26 -0700
Message-ID: <xmqqr0geaslp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 52CFC876-E168-11EE-A31C-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeppe =C3=98land <joland@gmail.com> writes:

> I'm trying to use sparse checkouts in a large project, and one oddity
> (bug?) came up.
>
> If I do a normal full clone of a repository, then do:
>     git worktree add ../sparse --no-checkout
>     cd ../sparse
>     git sparse-checkout set somepath
>     git checkout
> Now indeed it is a sparse worktree, but the files from the root
> directory are also there.

I think this is working as intended.

Without knowing about the non-tree entries' object names, you cannot
create your next commit on top, as you need to be able to compute
the tree object's contents.  You'd update some files in "somepath",
and that directory being populated you can compute the object name
of the tree that represents the state of "somepath" after your
update.  But that object name must be mixed with other things in the
same directory as "somepath" (i.e. in the root tree), so they must
be known.
