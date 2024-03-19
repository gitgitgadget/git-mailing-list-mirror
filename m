Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525B14011
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710807718; cv=none; b=H+R55UibxO2ae4wHudBNQkdOxOiYOs75IYOXfjF5rlbTMb96RG/NmzA7JBy+F+vv9esU40Lz4U26KXhE9LnXXpkbDk4VAWp/uojpFgkZcDQb+8wsosJ6APQZDajV4U3mZm8RqnG4Exu/DMIKOkpF9upWcBASnvqSaqQ9o7biXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710807718; c=relaxed/simple;
	bh=fRS2IFUm0XwdfAyNraBbSckRd/EPAKe2UguAJGjWS34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V64v8LU4vWS2KsJqEhV3xAz3KJBUChalx98ZKhqsSaexbT6an2MQq/5kmRGAmZeQJQ98jKSYQoJlU/xXpvjWMfc7s2liPhKSGTFuEVm8mzCn8yMJ94H+7pUXRrfeSJT3op4fSTjst04cggbWVXGNK0jPUdRJaEzp4phiD91wjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dG5IVz4v; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dG5IVz4v"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D40F31CF8;
	Mon, 18 Mar 2024 20:21:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fRS2IFUm0XwdfAyNraBbSckRd/EPAKe2UguAJG
	jWS34=; b=dG5IVz4vNlIF+ZqlYN53IB3QXNhA9xp6eItWyiRgUdgLkjaHrKA24y
	1/b9mYsLbNHzvDsxBOQiUKAproszD6IvH5jG3wOlU7ipQXgFwvfpGwk5HJS19ZwF
	vY+i2YByUdeWjSB1b1rjjJF/qKaoQU2AtpfFT6Us+f+0EhysUKnmA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 85CC931CF7;
	Mon, 18 Mar 2024 20:21:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2009031CF6;
	Mon, 18 Mar 2024 20:21:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] New config option for git-grep to include untracked
 files
In-Reply-To: <cover.1710781235.git.dsimic@manjaro.org> (Dragan Simic's message
	of "Mon, 18 Mar 2024 18:03:20 +0100")
References: <cover.1710781235.git.dsimic@manjaro.org>
Date: Mon, 18 Mar 2024 17:21:51 -0700
Message-ID: <xmqqwmpzt6jk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AFB770B2-E586-11EE-94FF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> This patch series introduces new config option grep.includeUntracked,
> which makes the untracked files also searched by default when git-grep(1)
> is invoked, in addition to searching the tracked files.

Hmph.  I am moderately negative on any configuration that screws
with the default haystack from which needle is sought for.

I may often do "git grep --cached" but that does not mean I would
welcome an configuration option to make "git grep" search in the
index even when the request by the user does not have "--cached".

Inclusion of untracked sources in a sense is even worse, especially
when an unsuspecting "git grep" user (or a script) fully expects
that any paths found in the output are to be found in "git ls-files
-s" output but when you stray into a repository with the
configuration set, that expectation suddelnly gets broken.

So, I dunno.

