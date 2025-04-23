Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD726AFB
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370942; cv=none; b=SzzyvLjOAXkCg7B0aEz1y0s4YDDByl7NcOuD6W2jT2SQkGkVbBinjnGa2pfBszyyq2EwZOEqtIkMyLdt114ccrb9tSYWndw+coonmK/F1mT/gbfaJYXiOE8lJJZ0A2NPTI9D7dx5H8K4r3+JrHYz/Ir5cXunyjh6nXjODeLwVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370942; c=relaxed/simple;
	bh=OCjlQWzPATJ9Kv/U8TboBwU2g+ewzsyj558R0vYZxtM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=J1jvPFdVF/hSt3CneEFUUIKsXvLOSvowhFbjjBqBa1ruP4FEW1YUyb5uE+Kt2kiZnxZRg7ZVJJrFfLGfxB5VPLJYd2JzcLhlrJ7ADxBU1Fw4BQwEaRgdwiE37z+KY72ag/DMDLkX6PiOz7H1zvOGdY4oVvBWqRavChdU8RHCg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zj1Pb0GXtz9tww;
	Wed, 23 Apr 2025 03:15:31 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 03:15:28 +0200
Message-Id: <D9DMCVD6EG00.317YDVDW95P45@buenzli.dev>
Cc: "Junio C Hamano" <gitster@pobox.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>, "Martin von
 Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Nico Williams" <nico@cryptonector.com>
References: <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
 <aAgdauFt/mdCY+GZ@ubby> <D9DKHI316ER9.PNEG774QLFL8@buenzli.dev>
 <aAg1ALkWaRQswZtK@ubby>
In-Reply-To: <aAg1ALkWaRQswZtK@ubby>
X-Rspamd-Queue-Id: 4Zj1Pb0GXtz9tww

On Wed Apr 23, 2025 at 2:32 AM CEST, Nico Williams wrote:
> On Wed, Apr 23, 2025 at 01:47:29AM +0200, Remo Senekowitsch wrote:
>> On Wed Apr 23, 2025 at 12:51 AM CEST, Nico Williams wrote:
>> > Using ticket IDs as change IDs implies a globally unique ID assigner,
>> > and should work well enough where things like bugzilla are used.
>>=20
>> This email thread contains recurring ideas of stuffing unrelated
>> metadata into the change-id header (patch-id, ticket-id). I think we
>> should be careful not to do that.
>
> We, the users, have been doing this for decades by convention (i.e.,
> starting commit subject lines with ticket IDs and putting all other
> related ticket IDs in the rest of the commit comment.  Why would that be
> wrong _now_?

You can stuff as much free-form metadata into the commit message as you
want, because git itself doesn't care much about what's in there. The
better analogy would be to put the names of your mom and dad in the
"parent" header as a free-form piece of metadata about the heritage of
the commit author. That's gonna break stuff.

Putting any sort of unrelated metadata into a change-id breaks how it
works. There is no reason to do it, you can put that metadata in its
own, dedicated place. If not the commit message, then at least in its
own header.
