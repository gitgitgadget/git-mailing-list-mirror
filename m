Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE115ECC2
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838097; cv=none; b=lw++jkoZvhGDrJwdXJ2NSWYe2vfSlHDcuk+xC6vAjj87LPdBgmbhbrW9cmuQU05g0uWc7ZcZ0DKTqKO2aRZz+OwfLGcE41fZcW5N8R4wYnOmg+XFhbqiutqXS/t82DloQl9/KAssrCp7j0846KnVQaeUT9UNDvbO6+o8ErvLdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838097; c=relaxed/simple;
	bh=oBKtuTBcMuZTEr2sJ9thXjEsrmW9nfQ3cOZv1CDCfOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0PdybzHu4N2744ukcBTOs/IN8ZIc3Gtg5JbQMJ7La8yAngLKoaGD4VY/9WKaFZBhMVOrUiwMavEbB02NzIVzC8TxDhxV1H1zDesFjXmUfpGi7Ua73v07f4SxvYYue5G1BNxuVfJ5fHj9cCI6LrjSU+/CSU42B5IWODsnNxO8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t7lBkTgV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t7lBkTgV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A14218F82;
	Wed, 24 Jul 2024 12:21:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oBKtuTBcMuZTEr2sJ9thXjEsrmW9nfQ3cOZv1C
	DCfOQ=; b=t7lBkTgVHjQjd+0xpT9Wl8pgrfRM/crYvrZuycJ6n947AGLgItBoHu
	ne3VUZ7A5dSy3bJZB/SPJubRAUNMVeCRUL5TF+SeCN8he6JBcLvM3jeCAPYQslRV
	7U0oFdfPOKBICcBGAnFO8JXq3znivyZKzywYtRHVb5VGmyhxLEZr0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60A6C18F81;
	Wed, 24 Jul 2024 12:21:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C76E718F80;
	Wed, 24 Jul 2024 12:21:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Randall Becker <randall.becker@nexbridge.ca>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  "Randall S. Becker"
 <the.n.e.key@gmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
In-Reply-To: <DS0PR17MB60312EE0F4B6679DBEEDAB42F4AA2@DS0PR17MB6031.namprd17.prod.outlook.com>
	(Randall Becker's message of "Wed, 24 Jul 2024 13:36:03 +0000")
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
	<20240621180947.64419-3-randall.becker@nexbridge.ca>
	<80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de>
	<DS0PR17MB60311800BF14CC1C5C7E707FF4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
	<0bec87dc-d852-4133-1e6d-11e9a1c5df2c@gmx.de>
	<DS0PR17MB60312EE0F4B6679DBEEDAB42F4AA2@DS0PR17MB6031.namprd17.prod.outlook.com>
Date: Wed, 24 Jul 2024 09:21:33 -0700
Message-ID: <xmqqed7iyd4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB89D030-49D8-11EF-BAC0-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Randall Becker <randall.becker@nexbridge.ca> writes:

> What I actually proposed was splitting --build-options with
> runtime (some representative argument). This would allow the
> headers used at build time (--build-options) to be reported *and*
> the runtime (probably) DLL versions (but would also report static
> linked library versions) to be reported. Both are useful from a
> support standpoint.

That certainly is a reasonable future plan.

> However, the --build-options argument was
> intended to report an invariant set of values used during the
> build, so I would rather not conflate the two distinctly different
> semantic values.

This reasoning makes sense to me, too.

Please wrap overly long lines to reasonable width, by the way.
