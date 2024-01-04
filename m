Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3C2C850
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pueViWqk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A772A205D0;
	Thu,  4 Jan 2024 17:14:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1Yu4zLJPsaMMDAwPvPirRaw4roBd549R+UX11l
	ymYkc=; b=pueViWqk3z9yEVe+nRlEkfStZ878ebrdeBK/HBCUxZXpXjzWpm3TtW
	4cvwlbumPL00z0Dihjgg6h3+7HiWB9ZdfD/FblQb8Slq1xe0ONDXz2WkH0NbDiv5
	Yo3Dykm6iuTMTGMDT5OgUf6YqJQpNmmolPbTMbnEQnPc2T1uUyeQQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A0831205CF;
	Thu,  4 Jan 2024 17:14:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44BD9205CC;
	Thu,  4 Jan 2024 17:14:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: Stefan Haller <lists@haller-berlin.de>,  Taylor Blau <me@ttaylorr.com>,
  Patrick Steinhardt <ps@pks.im>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: Concurrent fetch commands
In-Reply-To: <20240104205408.h5wvcissfbat7acw@glandium.org> (Mike Hommey's
	message of "Fri, 5 Jan 2024 05:54:08 +0900")
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
	<xmqqy1daffk8.fsf@gitster.g> <ZZUNxNciNb_xZveY@tanuki>
	<ZZUWmy3rTjpBsH-w@tanuki> <ZZU1TCyQdLqoLxPw@ugly>
	<ZZU5s4LKQF1NLgnC@tanuki> <ZZWOBObBmLW9Nid6@nand.local>
	<xmqqwmsq83v3.fsf@gitster.g>
	<80efcb43-122c-421a-b763-6da6ff620538@haller-berlin.de>
	<20240104205408.h5wvcissfbat7acw@glandium.org>
Date: Thu, 04 Jan 2024 14:14:50 -0800
Message-ID: <xmqq34vc7nl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AEC492D8-AB4E-11EE-AFB0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Mike Hommey <mh@glandium.org> writes:

> On Thu, Jan 04, 2024 at 01:01:26PM +0100, Stefan Haller wrote:
>> On 03.01.24 23:10, Junio C Hamano wrote:
>> > Folks who invented "git maintenance" designed their "prefetch" task
>> > to perform the best practice, without interfering any foreground
>> > fetches by not touching FETCH_HEAD and the remote-tracking branches.
>> 
>> That's good, but it's for a very different purpose than an IDE's
>> background fetch. git maintenance's prefetch is just to improve
>> performance for the next pull; the point of an IDE's background fetch is
>> to show me which of my remote branches have new stuff that I might be
>> interested in pulling, without having to fetch myself. So I *want* this
>> to be mucking with my remote-tracking branches.
>
> Use `git remote update`?

Hmph, it seems that it does not pass "--no-write-fetch-head" so it
would interfere with the foreground "fetch" or "pull" the end user
consciously makes, exactly the same way Stefan's demonstration in
the first message in the thread, no?
