Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53921362
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Tjs6mQzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704369687;
	bh=7LLUOhBgO/61ckg0VPCjuB6GUvHO97jR7JN1HLHGors=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tjs6mQzVFR8olydEoPHX1Wq4vdcqkg7c4gIPz/XhdhTrJQId9SIjDA6oE9o4w3n22
	 ogn8AhpTbMHv87suDOS/sVlz1vwMobIwksqAo2XjbghGao1ZGU5SUMSzc/0ph47vB7
	 VP0YA7RM4E7l2eKmaAPWW2rJtPp1LyVST8eIxoTo5M8tYIekT+YG3dEQJZ22Trg7ve
	 rYQvUDO8AhvQHswxuPZH528buJmaPGQmWq/i0u5/4nGYv+5t1kuNea9WSRmsF17Osh
	 RM23kPhgVS/El+ScHPKFCGP4SexV00U2k4aMyS2F2Abp63L08Ge3tDQnWrkXU9xlLf
	 7tJPS/vbySocw==
Received: from [192.168.42.22] (76-121-142-46.pool.kielnet.net [46.142.121.76])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id E7BAC3C0086;
	Thu,  4 Jan 2024 13:01:26 +0100 (CET)
Message-ID: <80efcb43-122c-421a-b763-6da6ff620538@haller-berlin.de>
Date: Thu, 4 Jan 2024 13:01:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concurrent fetch commands
Content-Language: de-DE, en-US
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g> <ZZUNxNciNb_xZveY@tanuki>
 <ZZUWmy3rTjpBsH-w@tanuki> <ZZU1TCyQdLqoLxPw@ugly> <ZZU5s4LKQF1NLgnC@tanuki>
 <ZZWOBObBmLW9Nid6@nand.local> <xmqqwmsq83v3.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqwmsq83v3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 03.01.24 23:10, Junio C Hamano wrote:
> Folks who invented "git maintenance" designed their "prefetch" task
> to perform the best practice, without interfering any foreground
> fetches by not touching FETCH_HEAD and the remote-tracking branches.

That's good, but it's for a very different purpose than an IDE's
background fetch. git maintenance's prefetch is just to improve
performance for the next pull; the point of an IDE's background fetch is
to show me which of my remote branches have new stuff that I might be
interested in pulling, without having to fetch myself. So I *want* this
to be mucking with my remote-tracking branches.

> Nobody brought up the latter so far on this discussion thread, but
> mucking with the remote-tracking branches behind user's back means
> completely breaking the end-user expectation that --force-with-lease
> would do something useful even when it is not given the commit the
> user expects to see at the remote.  

That's an interesting point that indeed hasn't been brought up yet.
However, don't we all agree that --force-with-lease without specifying a
commit is not a good idea anyway, in general? That's why
--force-if-includes was invented, isn't it?

> Perhaps those third-party tools
> that want to run "git fetch" in the background can learn from how
> "prefetch" task works to avoid the breakage they are inflicting on
> their users?

Again, what you call "breakage" here is the very point of a background
fetch for me, so I don't want it to be avoided. (For FETCH_HEAD, yes,
and I learned that we have --no-write-fetch-head for that, but for
remote-tracking branches, no.)
