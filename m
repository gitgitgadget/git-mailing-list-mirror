Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776D1448C3
	for <git@vger.kernel.org>; Tue, 14 May 2024 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699303; cv=none; b=klAqyAXV9NqjIOvIORpp85wUF2a3heYnupe1UvEoAM+rPzjpea+OAno405Z+QNpof+DnN514RTVdWc7VENl8e5779tkYaKCmAW7+MJELhTZe/gAhgxMM1DJEPmJn4ttVOfNBGSNc7ELk7fKNDi7M2hPknKlJaQx1yFqGsukrWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699303; c=relaxed/simple;
	bh=OMuhC7X9OAC7IrAnROrv6OGJ6lgSskWo1Wx2JCgGoZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOkaKQoI/AqwZRV5JcXnf6M6ZkR18+cCOTqtBVRpNYBAk+TilkqeVTvDcuKFX4dVXn8M0wle0X0olrb82pF4yO7hnqSpxKBicpYLlqVsoMCMzZtwBSbN+fMpOWgVkLsYioDLXUIyYWzal44TpomF1ZN7wKb6+bsZLGWxKpA3ZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LD7VBqbD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LD7VBqbD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 532673C816;
	Tue, 14 May 2024 11:08:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OMuhC7X9OAC7IrAnROrv6OGJ6lgSskWo1Wx2JC
	gGoZs=; b=LD7VBqbDK9JnfYVLzSoByOhBB5/ddiH8IzsNdAJ6eyW9XHRgG83Ntf
	UbG9RjwSJ00MpYaPLHDTuQMFAKS/JmBK8+FLWPJO0EbOc3w9M8wjmI/DxXuazx/R
	t7AG2SPaVIQBQqFJyJ7RRKh1k06bjcrcXKLvelwOy2XRhOWjaCqNY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BD6D3C815;
	Tue, 14 May 2024 11:08:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1EC13C814;
	Tue, 14 May 2024 11:08:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 2/5] t1517: test commands that are designed to be run
 outside repository
In-Reply-To: <ZkLpTwNgFGFyC4_N@tanuki> (Patrick Steinhardt's message of "Tue,
	14 May 2024 06:32:15 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-3-gitster@pobox.com> <ZkLpTwNgFGFyC4_N@tanuki>
Date: Tue, 14 May 2024 08:08:19 -0700
Message-ID: <xmqqo79877oc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD20A0B6-1203-11EF-95E7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Is there a specific reason why this needs a whole patch suite, as
> opposed to adding the tests to the respective test suites of the
> commands?

Yes, testing out-of-repository operations needs certain trick and
people forget to write such tests using the GIT_CEILING_DIRECTORIES
mechanism.  Having one place where we have an enumeration of
commands that are designed to be usable outside repository is a
handy way to make sure that we have enough test coverage.  It would
make it easy to control how GIT_DEFAULT_HASH environment is set
during these tests to have them in all one place.
