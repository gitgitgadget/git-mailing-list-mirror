Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6C10A26
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937764; cv=none; b=JrQkbiet90m13xMY4POnsIwYpevlD0/qDQTtxeIj6juvH34KMfziq/oV1JwNnRfsCFMU4pGN5DqdSrBeOXquWgq2sOME7MC4EYNMaLGLEd+tF1D6m683AS47f/AUQ6qpnhok7NL/Ws3krRHnhTMkS+zaQ/E5y/ESr6DMPAONTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937764; c=relaxed/simple;
	bh=raBAEnnayqShK8cJHXfQ+4KScxHZkIr0lOqaPqcdXbI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnjmzQQVr4J/v/m2qHqXKe+c/PimKzrFMZBOd9DqOxIwJ5eD+rlsUPWcR9J6ntOuybRfEuji0n0qqUrCq3uIVmowBphXYws6SUo1BP4E73ajtG+7d4tdwMG1ZHq16B4/tvd8JYpN4I36HebHjpFdfD0YF1otqAbP/El6HaYzfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w+SuYmNc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w+SuYmNc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DDAF21066;
	Sat,  3 Feb 2024 00:22:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=raBAEnnayqShK8cJHXfQ+4KScxHZkIr0lOqaPq
	cdXbI=; b=w+SuYmNct2UlD4X0sivV2ZjG8meSw0um3K9O45kcp14mye6wyAGGDb
	T+2M7QBlr4lJJn4m7J1cb4a1qycz81TL779uuG0pmNeLfBtEG5FC2GQvzR2UPL6e
	s7peJ9I88dg315GVW0iwICh6xZ2uFr2FF5MTpnECMT8+Kd5xXZXPA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 67AF321065;
	Sat,  3 Feb 2024 00:22:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C58221064;
	Sat,  3 Feb 2024 00:22:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #01; Fri, 2)
In-Reply-To: <xmqqr0hutm1x.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	02 Feb 2024 16:43:06 -0800")
References: <xmqqr0hutm1x.fsf@gitster.g>
Date: Fri, 02 Feb 2024 21:22:36 -0800
Message-ID: <xmqqzfwirujn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F167FCE-C254-11EE-93FC-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> * jk/diff-external-with-no-index (2024-01-29) 1 commit
>   (merged to 'next' on 2024-01-30 at 30c3e9f91d)
>  + diff: handle NULL meta-info when spawning external diff
>
>  "git diff --no-index file1 file2" segfaulted while invoking the
>  external diff driver, which has been corrected.
>
>  Reverted out of 'next' for now, seems to break "win test (n)" jobs.
>  cf. <xmqqh6irwtkd.fsf@gitster.g>
>  source: <20240129015708.GA1762343@coredump.intra.peff.net>

The above topic is marked as such by mistake.  It is on track to be
merged to 'master'.  What was temporarily reverted was the next one.

> * jk/unit-tests-buildfix (2024-01-31) 3 commits
>   (merged to 'next' on 2024-01-31 at 00df31c4c8)
>  + t/Makefile: get UNIT_TESTS list from C sources
>  + Makefile: remove UNIT_TEST_BIN directory with "make clean"
>  + Makefile: use mkdir_p_parent_template for UNIT_TEST_BIN
>
>  Build dependency around unit tests has been fixed.
>
>  Will merge to 'master'.
>  source: <20240130053714.GA165967@coredump.intra.peff.net>

But Dscho helped to fix the breakage on "win test (n)" jobs so it
has again been queued to 'next'.

