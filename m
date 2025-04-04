Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9BB2E62B4
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743752494; cv=none; b=Uo+EU3rXIX1/OIZgjHvrK4yccC3dDw6xmq9YBZE2QjYpWySepF2R+11CTIw2xO1peonTrqcoKzWprF4t5mnzJV27YKsY4WiSwFecYXbazDxNuYfKP8z1Kb3wbb95VAPZw4+S7AV7PSqJUIkgn6V9/WRmdatDCvxpeI1Brs6dD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743752494; c=relaxed/simple;
	bh=cDIhfPNnpsTjGCeKg5DJ/RZ8FWYM1d1RjaAGskTdjN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YC9eYA95cG6LU7srfpcbQ4/FcKQ0LfY2RK9NoiAsOPkxSx8qX6vvCEzKip8lq8uD3pgDGYMqK0WXVdOhrem2ORpmrbavUPEY5AcfAO7zRsgM6g96kBeA3yscYF0a4fIrcu6rIN/0p5YoPrE++RBqp95TIZysunGt7MisgZIZcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZTVsg2g4qz9sQ6;
	Fri,  4 Apr 2025 09:41:27 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Apr 2025 09:41:24 +0200
Message-Id: <D8XOO0H2GSK0.JQSNCLB1QUQR@buenzli.dev>
Cc: "Elijah Newren" <newren@gmail.com>, "Martin von Zweigbergk"
 <martinvonz@google.com>, "Git Mailing List" <git@vger.kernel.org>, "Edwin
 Kempin" <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Nico Williams" <nico@cryptonector.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com> <Z+7PDi5y4wXJBK4r@ubby> <D8XC02N85O7W.2LQY7B8Q2Z98G@buenzli.dev> <Z+8GoNrdaJlmNpGm@ubby> <D8XEYQ9TRB10.L5S89IAC2LZ9@buenzli.dev> <Z+9XfLtodUOvqnse@ubby>
In-Reply-To: <Z+9XfLtodUOvqnse@ubby>

I'll try to join some of our threads and summarize... please correct me
if you disagree with that summary (or I've left something out you think
is important).

One of my points was that rebase usually doesn't lead to multiple
visible commits with the same change-id, whereas cherry-pick usually
does. You pointed out that rebase can in fact lead to multiple visible
commits with the same change-id and cherry-pick sometimes doesn't (and
some of these examples represent valid use cases). So making these two
commands behave in a different way that only makes sense in the "common"
case makes them more complicated - and less consistent - in the general
case. I find this convincing and I now agree that both cherry-pick and
rebase should preserve the change-id by default.

The Gerrit developers will be happy about this anyway, and it's worth
repeating that Jujutsu can deal with it perfectly fine while preserving
almost all benefits of change-ids.

When discussing the uniqueness of change-ids or lack thereof, I'd
like to introduce one more factor: At which point in time during the
development cycle a change-id is unique. Jujutsu users derive most
of the benefits of change-ids during active development. The use case
you find most important - tracking (forward- and) back-ports - happens
at a different time during development, when a change has been merged
to a public branch already. So I think there is no conflict at all.
Change-ids will naturally tend to be unique during active development
and once they are merged, whether the change-id stays unique or not
doesn't matter anymore for those active development use cases. We can
have our cake and eat it too.

Remo
