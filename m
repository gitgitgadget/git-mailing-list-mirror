Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B0130A44
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551209; cv=none; b=PMgzwLKKoLV19wYzKGZ+hpqJT5Fdaipxu/dlpzUAa3qXOcVn8wjWDCyJ2+cq/BYaXmsL9bpgkYo5NgElbGcRHmosrJMmYBY5ozwZWZRJq3uDVDwI3UwdVhGK21+hTr7tnOuitZrU6crRD/BoiO5XCHOb4iEu7d8GwurLMMEsjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551209; c=relaxed/simple;
	bh=21BC0dJBDPsa6g6msRZ/LkdVSeoz02aj6414C4KfWJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f4qmWzSrXXoLU9bZY00lU9CBuPuzTp/D0oJd0aTKBz9hbPC118N3bxxQZCYbZVoMz/exhKkPn0r9duEt73Y3VbFYPjkOo3Vgs+n39jkBbaxUhREQumlKpZPAJHrgiDrRUThLkavAYUMMMxRbUJxp89XLUOb5IYRSqtk8/4TD6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yk1BLxiT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yk1BLxiT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEFD91E10E0;
	Wed, 27 Mar 2024 10:53:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=21BC0dJBDPsa6g6msRZ/LkdVSeoz02aj6414C4
	KfWJ0=; b=yk1BLxiTSs7kt/LS1Q2cf2PoadqJUX9zzSAzqX7fuWjippz5HSo8ky
	8pMY8ehADG+O6TCY/AU/vGmgjc5y6i4WsLpq5sO9t7AA89mf2jTrtN3QRgMxp4+E
	IS0tJJCUzw6FrpeU8ZW6WYG8MAf3RmJC+FnVv0eM6mYm6YUN3J0jw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C563C1E10DE;
	Wed, 27 Mar 2024 10:53:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 136481E10DA;
	Wed, 27 Mar 2024 10:53:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Dragan Simic
 <dsimic@manjaro.org>,  Manlio Perillo <manlio.perillo@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
In-Reply-To: <20240327074655.GA831122@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Mar 2024 03:46:55 -0400")
References: <20240312091013.GA95442@coredump.intra.peff.net>
	<20240312091750.GP95609@coredump.intra.peff.net>
	<0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
	<20240315055944.GB1741107@coredump.intra.peff.net>
	<6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
	<20240315081041.GA1753560@coredump.intra.peff.net>
	<xmqq8r247igg.fsf@gitster.g>
	<20240327074655.GA831122@coredump.intra.peff.net>
Date: Wed, 27 Mar 2024 07:53:23 -0700
Message-ID: <xmqqzfuj4tgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C3740AD8-EC49-11EE-98D9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> OK. I don't have a strong opinion. Are you OK with core.commentString as
> a strict synonym (so last-one-wins and either name overwrites previous)?
> Or do you want an override (i.e., commentString always overrides
> commentChar, regardless of order). I think it's mostly academic, and the
> strict synonym version is much easier to implement.

When I wrote it, I meant "String is a successor of Char, if both
exists that is used regardless of the order", but either is OK.
Older versions of Git would not understand the "String" version, so
it matters only to those who uses mixed versions of Git and they can
control the last-one-wins in their configuration file, I would
guess.

Thanks.

