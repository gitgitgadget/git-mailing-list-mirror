Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA4D2EE
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793251; cv=none; b=c2Tsaxr7ze5ZcjU19uSqX+dY0vRwQ4vJbX/Q+un5RQsDfxmFp6CKZjEWYq0uDm1qrncHt9LG/hIE0p4MqaKxt61BqgGu30uZCeo3BCEzdIjOXOs+FKgzuN7CfQJPstYKFB9QUlscf8HAT+yS/7g8bHPNI+AH5v7yRI35W1Fgm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793251; c=relaxed/simple;
	bh=68aqRqJlrEEpRBLubsUHPpYwMemrxjskFV7dmzKhBwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUPAJw9db9eT4shG9FdCs/RGCZwnjKtmMqch2QwYLDNovQ46U7m7OcbUk0n+dFhrpaSW69ph5PzPUTrui+fOdQlPbAZBAOrXNrSVVjFr7MaTAjj58liG24bknPscTntlH7tAf5mujacW6wBJCASbCmpj5k3/4B9DDFzzN+eCfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNomfa9J; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNomfa9J"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E4A42188CD;
	Fri,  7 Jun 2024 16:47:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=68aqRqJlrEEpRBLubsUHPpYwMemrxjskFV7dmz
	KhBwg=; b=bNomfa9JrZA6D95XwicneaP1+UnGHKRoOfJ+QvutVjwkNWFd8PldFg
	Mi5joPSTyv+xFreAq6GCWnE7r+UOGLv41cKeMMJjC7XnwBKb1gnEGcEij7++eXLl
	UKnIQLoeboEUZ6EhUjQU+J6dRTv9cLHYFjHgPbgJlhSOrhEH5NPFc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DEAB8188CC;
	Fri,  7 Jun 2024 16:47:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA4F6188C9;
	Fri,  7 Jun 2024 16:47:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] ci: detect more warnings via `-Og`
In-Reply-To: <cover.1717742752.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 7 Jun 2024 08:46:24 +0200")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717742752.git.ps@pks.im>
Date: Fri, 07 Jun 2024 13:47:25 -0700
Message-ID: <xmqqwmn0eazm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 26567688-250F-11EF-8C90-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the third version of this patch series that adapts one of our CI
> jobs to compile with `-Og` for improved coverage of warnings.
>
> Changes compared to v2:
>
>   - Typo fixes for commit messages.
>
>   - Replaced the `O` variable with `CFLAGS_APPEND`. If that isn't
>     palatable to folks then I'll drop this altogether and will inline it
>     into the CI script, duplicating the default CFLAGS there.
>
>   - Start compiling with V=1 so that the change can actually be seen. It
>     also shouldn't clutter the job output too much given that the build
>     is in a collapsible section on both GitHub and GitLab.

I've taken the "Python 2 - missing 'test'" on a separate topic and
will merge it down to 'next' and 'master' to fast track.

The "override CFLAGS += CFLAGS_APPEND" thing looks good.

I am not sure how annoying people will find the V=1 output.  It is
irrelevant that it is in a collapsible section.  What matters is if
it helps those who *need* to expand that collapsible section to take
a look, or if it clutteres what they have to wade through.

When studying a build failure, I rarely found the exact command line
given by V=1 helpful, but YMMV---while I am not 100% convinced, let's
take the series as-is, because not losing information may sometimes
help even when we need to visually filter out extra clutter.

Thanks.

