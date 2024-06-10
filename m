Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8A1BC39
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049411; cv=none; b=ZLQ//CVVFhnl/GQG4aFwo90sYYWDTYP69tGQdHXZMA7Cr5rU749F3B3neRlQD19gjgFhP+QhvlwnFPdjsx+MYW6ahMmtca7RSzwhFDwVQH8TzAxsJQMPwE3mqzSBMCPkypP/UEbyxG2TOM4u+ehc2f4OGBp1nm/RBcj///HGavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049411; c=relaxed/simple;
	bh=wikQs4s91ec+hUMYjiuf90y+74mgZ1McdtDcN5rAtfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfKZ4WLvxoSggV5EpvXraSxv8/LsE1ZZlYbiuUeMl97Q/Q+CMWpRpsVxlO5iCyJa5Swtl6WzEsb1Wzr3BmYqwo540qyWsr/LFY4hGqsElztHYX69Us/iKAZmvN+JvJeP1d43mIitkbTjk4mwZ3XcKWIVG+X60iQBmDVKbe2+a0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hMNsXuRq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hMNsXuRq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 463A421034;
	Mon, 10 Jun 2024 15:56:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wikQs4s91ec+
	hUMYjiuf90y+74mgZ1McdtDcN5rAtfA=; b=hMNsXuRqGfEm9Z/ccTOvCTKmBqd0
	HlcRt6Kx1ee1NLnJDAEsj/ZNOu7gR0tpUwC47Yu6uG2r/tdad7n0t13jRBQYkM/B
	o7N888ogQN7FDTXhCf8ImVNDC9t3fKzBb/XdOKJdUOm6e/86KbUMFrKmb1Eo1/65
	nPixZTekj04aCto=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EDA321033;
	Mon, 10 Jun 2024 15:56:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A34EE21032;
	Mon, 10 Jun 2024 15:56:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Dragan Simic <dsimic@manjaro.org>,  Jeff
 King <peff@peff.net>,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <1f7b27b1-9bb2-49af-854a-762d0e75d508@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 10 Jun 2024 21:14:04 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<20240604101700.GA1781455@coredump.intra.peff.net>
	<xmqqikyo207f.fsf@gitster.g>
	<20240605090935.GF2345232@coredump.intra.peff.net>
	<6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
	<a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
	<219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
	<9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
	<1f7b27b1-9bb2-49af-854a-762d0e75d508@gmail.com>
Date: Mon, 10 Jun 2024 12:56:46 -0700
Message-ID: <xmqq1q543729.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9205669A-2763-11EF-B936-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> On Mon, Jun 10, 2024 at 03:09:48PM +0100, Phillip Wood wrote:
>
>> I'm still not really convinced that the escape sequences are a problem=
.
>
> A concern about the escape sequences was mentioned in this message:
> https://lore.kernel.org/git/b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.=
com/
>
> It arose when exploring the possibility of using the new command "|"
> with tools that do not support escape sequences, e.g.: "| vim -", or
> "| clip.exe" to send the hunk to the clipboard, on Windows.

Let's not bikeshed this for too long.

Pipe "|" stuff that is suitable for pager in the context of Git
(i.e. if color.ui does not forbid coloring with "no", their usual
pager is capable of color, so we send colored output to the pipe),
and if somebody wants uncolored output later, they can use "P" to
pipe or ">" to file or whatever other enhancement they want, but
let's leave them out of this round.
