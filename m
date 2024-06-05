Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2A624
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611732; cv=none; b=PC3nqY6EQf9CDoS0ogaCi5+UZLNfsrhoL/+Ys8+Gg6VATDpcEnrvn6iXP3Cxd/4gV58qjI6KcTA3rA0OSUvs6tZeLVKos1glWaUvL4q+ap3o8/79B+ev0alZDS+32KYY5IQ0iG5CkQBpQm4jDduVhevA0ssCVjFU/E1pDYUGSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611732; c=relaxed/simple;
	bh=CqvJ8xQd1kAs14hOo+GW6m4f403lrJYQff/7+pQ+K6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpiiVpttJ/OTBlBPg/WuXantDUXxwbHEcPV+/oWgEn1W9c616gGe/oYUCMfT4eW0c9SvAldFY5SQWETS4wmuw3uaWHgw+DOvX4QLHMbvJjZqtcFIxalOageaDz05k8wZ0cUDfRuEnVt9130Fv68DLkKlWeMFSriYU8EfDa43g+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rh3EF7mS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rh3EF7mS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BB821ED78;
	Wed,  5 Jun 2024 14:22:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CqvJ8xQd1kAs14hOo+GW6m4f403lrJYQff/7+p
	Q+K6E=; b=rh3EF7mSD0PHOhiOFlZMxwZ3lWkOHH/0XPGbWDmfC8e2SlJ6aOHMjZ
	aoDz181CsIt+EGiwC30yje6wHgbXv2HABybElrskjGKk6o2Bo65iC3LC4Hpww38Y
	badVaROnv7jpN715gP4IYtUF90nB3Z3COL1oSaMHPKRogU+Xg+DBM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 030F41ED77;
	Wed,  5 Jun 2024 14:22:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 656E81ED76;
	Wed,  5 Jun 2024 14:22:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Subject: Re: RFC: indicating diff strategy in format-patch message headers
In-Reply-To: <20240605-hilarious-dramatic-mushroom-7fd941@lemur> (Konstantin
	Ryabitsev's message of "Wed, 5 Jun 2024 14:01:38 -0400")
References: <20240605-hilarious-dramatic-mushroom-7fd941@lemur>
Date: Wed, 05 Jun 2024 11:22:08 -0700
Message-ID: <xmqq5xuns10v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8573F0BC-2368-11EF-8047-6488940A682E-77302942!pb-smtp2.pobox.com

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Would it make sense to have git-format-patch (and friends) include an
> additional header hinting at the options used to generate the patch? E.g.:
>
>     X-git-diff-options: algo=myers; context=3;

I doubt it.  And newer version of Git _will_ try to improve how
patch text appears to be more useful to human users, so you have
more moving parts than you'd want to even think about enumerating.

If you were to add a new e-mail header, wouldn't it make more sense
to add a patch-id header and agree on the set of options to be used
to generate that patch-id (which might be different from the setting
used to format the real patch for human and "git am" consumption)?

