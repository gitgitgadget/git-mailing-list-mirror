Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DF33080
	for <git@vger.kernel.org>; Fri, 31 May 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169276; cv=none; b=MDdIJt8I33AC6Z81qnICt478DRL4dwyFomHLLb3TtykbMweYedkKysrSCTudG8xDz5Wu8WXPrxbTNn+w8M5ecvDokAA+344gvS01PM7NX4GC3DwZ9kxh6Fg2rGayF5bHG2bSDMsjZPrPlWwTgScbEdjIkVOpcorLNpL/S7eWDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169276; c=relaxed/simple;
	bh=J0AnGNnYESvTxLOyAYt/OsYNtwoHviwovyjEQ5jsuQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vk54KNljEQM0ADjfDzpz7Yrdc9YbYf4aw21svTlOXwAm7h3MT37v+uh6oWxM1o4h/+6R3QSWOgBDVaRooZoH8X6r07MrAucut2rw0/g7wX0n1QEgeg7NAs1XZ9r6cEcLUS5laYtHyE8aOieWCWsvikNDlYQeHNiiJ3ZUmK7nDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tEKPd5RZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tEKPd5RZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B05E341E7;
	Fri, 31 May 2024 11:27:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=J0AnGNnYESvTxLOyAYt/OsYNtwoHviwovyjEQ5
	jsuQY=; b=tEKPd5RZP9ZESGd+oCfxMgvagpfb4AhIGHB/WibeIpDHJx0h9GOdXU
	YdRZIVfuUna1crjQbU8JIVJzXHBhBvmH01BpSSXG1GdIHCZ1XG2G+pMuzkk39vhk
	gfvJRrTJif1IsCr3+IQY4M0zxTKuZbz1FrSuI6dxi3LE1tM8/ldtk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93CDE341E6;
	Fri, 31 May 2024 11:27:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12ED6341E5;
	Fri, 31 May 2024 11:27:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
In-Reply-To: <ZlnRlRdfbddzYMnO@tanuki> (Patrick Steinhardt's message of "Fri,
	31 May 2024 15:33:09 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
	<xmqqplt4y1gk.fsf@gitster.g> <ZlhjN7K8JKYz6Opd@tanuki>
	<xmqq34pzozsq.fsf@gitster.g> <ZlnJ83qSnGlQ0FWR@tanuki>
	<ZlnRlRdfbddzYMnO@tanuki>
Date: Fri, 31 May 2024 08:27:52 -0700
Message-ID: <xmqqzfs6gfwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58ECF73C-1F62-11EF-B95B-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In any case, I have now invested some more time into the individual
> sites where I was converting to use on-stack strings. In many of the
> cases we were indeed able to avoid the issue altogether without too much
> of a hassle. The end result is more pleasing indeed, I'd say.

Nice to hear that.
Thanks.
