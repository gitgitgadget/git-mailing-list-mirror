Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18723749
	for <git@vger.kernel.org>; Fri,  3 May 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752552; cv=none; b=lfwoizpCs9qxLnjUSHSaVKwZyWxJC70ZYFbLimOiMZqFI3WrEOk1tMJiZG5uHTEC1t2Deu1vnh/M2Em489oHWAzSq7OdPZe0R1YoP6Z42oqOKMCRx7YbTS7ytFNDOvCTiHSRBot+fCf+7xFSCPusQYhGcHjv4wM1m7oB2vohg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752552; c=relaxed/simple;
	bh=CvikDWvgPmzyYPqnIriVR4v8P1RSSzPijqybzcl92lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHPQSutQ1Ebr77w8riAarrNSBo7Q7Hopw15ERkjpgfM01l/QonpyGQ0X5PySkqZ+wQNOwzkN6RTItxt+D+qhNPwiraGwXmzfs2kE8cFweSjc6dT+WSRakeK0dOKGwmYvUn0B7ADgK5lxlVBgs9D6sgjansaTMicpZ58B5Cy8o68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i0HHPQqz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i0HHPQqz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AA642617D;
	Fri,  3 May 2024 12:09:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CvikDWvgPmzyYPqnIriVR4v8P1RSSzPijqybzc
	l92lg=; b=i0HHPQqzfWRsC2CSEie/nvTUVFlk9vhSMvU8nV8epBrONx0ocVdt2B
	Purz/NN491FsrG89wLqvyecD2RdysGuXPtO08B7jD1QvXGQgimwoaAd5NQV5k1fi
	eLhHjYe2W3+rJYfIcrsJsYKHmaouc7fB75bX/tqkjv4EckjUNUKzE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12E132617C;
	Fri,  3 May 2024 12:09:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73E7B2617B;
	Fri,  3 May 2024 12:09:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Taylor Blau <me@ttaylorr.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 00/14] builtin/config: introduce subcommands
In-Reply-To: <cover.1714730169.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 3 May 2024 11:56:40 +0200")
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
Date: Fri, 03 May 2024 09:09:08 -0700
Message-ID: <xmqqbk5mandn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 796875D8-0967-11EF-8360-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the fourth version of my patch series that introduces
> subcommands for git-config(1).
>
> Changes compared to v3:
>
>     - Rebased on top of d4cc1ec35f (Start the 2.46 cycle, 2024-04-30).
>
>     - Implemented support for `git config set --comment`. This switch
>       has been added since the last version of this patch series.
>
> Here's hoping that there's a bit more interest in this patch series at
> the beginning of the release cycle :)

As you made the cover letter of v4 a response to the cover letter of
v1, and because the primary motivation of the series has not changed
since the very beginning, it was very easy to find the cover letter
of the original series that outlined the motivation (including why
it does not risk ambiguity) quite well.  People cannot go directly
back to v2 and v3 with the information alone, but at that point, we
can visit https://lore.kernel.org/git/cover.1709724089.git.ps@pks.im/
and everything is there on one page.

Thanks for not forgetting the "comment" thing that was added since
the last round.
