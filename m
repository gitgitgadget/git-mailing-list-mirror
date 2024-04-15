Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD21E877
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206686; cv=none; b=pMlDKovf7UBr9TqGVaBgzWGiawqAQr9hvQjJxQadVc4kvCDvHeLYRUqISy0P3ncIrfnmtgbehkxLUBxXor8GNYANhM5ozKEJSLIcQR7GD91Ms+9lMQ3TlVHXl/EOy41QmkyiZFxxojiK4wchDHTHeGtIm2HnmFKde2FgE3Fnc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206686; c=relaxed/simple;
	bh=3sAzW7YKF8nZhUB9tYlLDuTC/P08kkpdc1P+c2rQoIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PCd01jwse20fg+YtnYL+ND60eC/c7nbb+qD5WIIUjy7oBlZNNpVLMQTIvcVr7ZvrZ2gexr9KKp34Fb0aXx37quNiYHaqUHpqYVAfQ6Ca8R+hgdypa4eXUTcqP6i8dO3+T/yH35e+Fb3q7mv8rlq2tNJHAD/cz2rZnsjcgC68MeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OnjQGK57; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OnjQGK57"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AD24E32C2D;
	Mon, 15 Apr 2024 14:44:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3sAzW7YKF8nZ
	hUB9tYlLDuTC/P08kkpdc1P+c2rQoIY=; b=OnjQGK57n3uqsgPrCPs9eqPKfqZM
	99VEiGQfVlO4LxED9tqSsGb4fWkiwLcjJUNua2wfN/w1cSpoJnqYzer53AcA8010
	abhCPC23xwPNBFaTGEhf9iTNOnRCArWD1LcpXNCbTCpcUvvHm6z9gWNMHEWX7IZb
	RtcuH93IpLDdK90=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A5FD032C2C;
	Mon, 15 Apr 2024 14:44:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CEF032C28;
	Mon, 15 Apr 2024 14:44:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  rsbecker@nexbridge.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4] launch_editor: waiting message on error
In-Reply-To: <8ef912a9-78f2-411a-a055-f86f69d78b90@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 15 Apr 2024 19:07:14 +0200")
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
	<96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
	<0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
	<ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
	<e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
	<8ef912a9-78f2-411a-a055-f86f69d78b90@gmail.com>
Date: Mon, 15 Apr 2024 11:44:39 -0700
Message-ID: <xmqqedb6mpns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 37C758AA-FB58-11EE-B85F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> - term_clear_line() is now used in all cases as it is unlikely that any
>   sane editor emits an error message without ending it with a newline.
>
>   This:
>
> 	$ GIT_EDITOR=3Dfalse git commit -a
> 	hint: Waiting for your editor to close the file... error: There was a =
problem with the editor 'false'.
> 	Please supply the message using either -m or -F option.
>
>   becomes:
>
> 	$ GIT_EDITOR=3Dfalse git commit -a
> 	error: There was a problem with the editor 'false'.
> 	Please supply the message using either -m or -F option.

Nobody uses 'false' as their editor, but as you said ':cq' in vim
may be a real-world example of a use case that may benefit from this
change.

Will queue.  Thanks.
