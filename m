Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80167134A4
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241970; cv=none; b=uSNZKu5XaklJWIi0oV699AuJaHHLnZPVkbZEg3i52w4fwUf2YUHiNycof+9Ukem4IHogujlBKP1u1U6MDRMiysbZYA4T0pjYJvv6b3cZ00acNOWiwJ7gwdWjbUZiOdyuELhg4JPvNoYiC9gb+iEtzFKjIjNAG0IZLCsyW5uQJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241970; c=relaxed/simple;
	bh=TMN4VxkrqkZM/i8978c5axS9kZ+QeH2J4cDdQayWtak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y0GHF2j/jykFM1g1vsCHrWfPPxCsbui4DcOstRoluW9gzaAeDsaMdY6UglDPO23lkIb1IEpn2OjEcULA5OeZ6gmWV+BswkljSb9W2giuB0/6aJmdSC+8VJywQPL0coiOpqcteOxtuu1NcFnqDmhTvP5aWN4jMWVd3eaS9j/sXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hk4tSGfk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hk4tSGfk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A81EE20DF6;
	Tue,  6 Feb 2024 12:52:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TMN4VxkrqkZM/i8978c5axS9kZ+QeH2J4cDdQa
	yWtak=; b=Hk4tSGfkW9QFKLaYFed7MDVjMj1Vt8S4h8ahUcEsbtNK+hgOalne4b
	pRdUGlDGYQ8qc4HGzq//h+KfCI5PYQaKtLg0vjRnTdk9NA4mqxLZ1GfhyxLDYB07
	v0JKTSXigVt9Hwwnta12D9uqOJ0cuzNZu6DpYhoxeYDom1JyREHJI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A01C120DF5;
	Tue,  6 Feb 2024 12:52:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 304CD20DF4;
	Tue,  6 Feb 2024 12:52:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>,  Maarten Bosmans
 <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
In-Reply-To: <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
	(Maarten Bosmans's message of "Tue, 6 Feb 2024 10:55:04 +0100")
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
	<20240205204932.16653-2-maarten.bosmans@vortech.nl>
	<xmqqil32l0i6.fsf@gitster.g>
	<CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
Date: Tue, 06 Feb 2024 09:52:38 -0800
Message-ID: <xmqqy1bxiiop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8558B9C2-C518-11EE-A001-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Maarten Bosmans <mkbosmans@gmail.com> writes:

>> I am not sure if we want to accept an approach that feels somewhat
>> narrow/short sighted, like this patch.  When "git show" learns an
>> improved way to show blob objects, who will update the code this
>> patch touches to teach it to use the same improved way to show the
>> notes?

Another thing I forgot to mention was that I suspected the use of
"git show" was so that we can deal with notes trees whose leaves are
*not* blob objects.  As our "git notes" machinery, including how the
initial contents are populated with "git notes add" and how existing
notes on the same object are merged, all assume and depend on that
the leaves are blobs, we can say "we'll just dump to stdout with
write_in_full()", but who knows what kind of custom crap random
third-party tools and IDEs try to use notes trees to store.

Even if we limit ourselves to blobs, they may not be suitable to be
dumped to tty (or a pager, for that matter), and I can see how
textconv could be used as a way out ("detect that the notes payload
is an image and spawn display" kind of hack in a repository full of
images and notes used to store thumbnails, perhaps).

> That is also a cool idea. That would probably use the functionality of
> the cat-file batch mode, right?

Not really.  I was hoping that "git show" that can take multiple
objects from its command line would directly be used, or with a new
option that gives a separator between these objects.

Perhaps we want a new option, e.g., "git notes show --text" that
passes the contents of the leaf blob object to write_in_full(),
bypassing all the things "git show" does, while in a rare case when
the leaf we find is not a blob to invoke "git show".  That might be
a safe approach to move forward, if we wanted to do this.
