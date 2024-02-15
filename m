Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576A145B14
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040615; cv=none; b=BIA6XxSfRuoqa9pvTDU6owIsaEwbpoogsBsCrOIlG8ZhXPRSK/XqfwcnUvbgPm8bFXGQusrp7hUdefRoJ7Q4rCCk777E/6jFSkzxmvBKcOg+/qm6YKzISeY4/QqVMmM08BEUjprqbkHQMG26ZOLoE+1lXAl+JzDdYlPO6EudSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040615; c=relaxed/simple;
	bh=lZkBuize0G7Z3x14msflb8wbgHiMKCRmWkgoX6jbhJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tJ1RNSttZKoffujpoHotmwNLXPkWKh29KffSryV6t+9blFSqKCsJKs/YzNi6tt0J6Hqa/4DwHeqzQnDI+cYdOoAn8VQj91bP6KO0eec9I6gyYg7Owavi2bbXSaiFsuUmDnZLo4hurMap1ZrMh/0StlLyzaxC0NzknCBEJG0+kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NcTf9VBU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcTf9VBU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D28D2A990;
	Thu, 15 Feb 2024 18:43:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lZkBuize0G7Z3x14msflb8wbgHiMKCRmWkgoX6
	jbhJI=; b=NcTf9VBUWMJN7CgO1j3/5bCpJ0cwcCceVuBjUJdhhFLvkMOhUzhoXP
	v83vq+dkpl0yt3lRN2hWeJ65b6tp+bqWnqFgvwND9LYmMaXDR5edAsxaim6RmvFa
	Bh6Fvb0hj2fN7rlYgcF64oB+5yRrr3zmo3hUXHcJ0zwWD8yGn2Las=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EB622A98F;
	Thu, 15 Feb 2024 18:43:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6E7F2A98D;
	Thu, 15 Feb 2024 18:43:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Elia Pinto <gitter.spiros@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
In-Reply-To: <Zc6abO6RV9RwpABR@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 15 Feb 2024 23:12:44 +0000")
References: <20240215094243.147057-1-gitter.spiros@gmail.com>
	<xmqqcysxskd9.fsf@gitster.g>
	<Zc6abO6RV9RwpABR@tapette.crustytoothpaste.net>
Date: Thu, 15 Feb 2024 15:43:27 -0800
Message-ID: <xmqqa5o1mgyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 058895DC-CC5C-11EE-8147-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I will also say that sending one giant patch for this may be a bit hard
> to review.  While I will defer to Junio's opinion as the maintainer, I
> would be more inclined to review this kind of series if it came in in
> smaller patches, a few at a time, in which case I would find it a
> welcome improvement.

True.  As to the specific topic of using "for (int i = 0; ...)",
it is tedious to review for mistakes and 17000+ lines of patch is
not a way to do so.  I do not think I would be able to spot a change
in behaviour caused by a hunk like this

	int i = 3;
	... after some operations ...
-	for (i = 0; i < 5; i++)
+	for (int i = 0; i < 5; i++)
		if (condition_on_i(i))
			break;
	... after some operations ...
	return i;

after scanning similar changes for 1000+ times in a single huge
patch.
