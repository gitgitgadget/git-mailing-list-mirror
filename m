Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4E183CDB
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907221; cv=none; b=b78Q6fceXrIYBH+Hje05gkgM1alhcqWuZ4zqD8SV2kw7RDCWmSbq3QWg9sQ9Ql8Q2nOGTKMsMGtJBV0nC7F3Vm+sxlkw4Xlfh+REH5rsFY1bI3NDcVXdw4pLsl65tCaZtI7jCPMuQO02Vj+/KJS+nW9eMhN4NS+KdadOoOtcb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907221; c=relaxed/simple;
	bh=oLA6RvME7GFXvS+kHTrQnqWSWzu4OEGCM0F0K8Wiwfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7CLdYIUxY0Fic0BaYdqNwEpbHiJE6fKOBkYsz3z8VkpMom7amSs5dakb7WPEZm6Nt5LX19WwoeAt5u/udvlXJYa6RLE2FqG+rpFMniB7IVA9L4dwWzGUn2n1v03YbcCKo6CHudmvIvUtpRIjSl+ajqQ9ZxZJiqBPMTxISMLi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cdJIdY17; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cdJIdY17"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89F66214DB;
	Mon,  9 Sep 2024 14:40:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oLA6RvME7GFXvS+kHTrQnqWSWzu4OEGCM0F0K8
	Wiwfk=; b=cdJIdY17xZTS5FnbfZU6OiQmXiZTMQoYzvWnOrsoXfJum+8QVSqxE0
	w31HELBN6LB0HLkQfeS+OKVs/MJu6s3/j9BfEYv9msEBG/t839/n5Wn0f1PMJHF7
	Ygbk4fxaPB0jTn8qXGJRs4odWbm8+YENqw+NnebOVwpDmUR1bdajM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82096214DA;
	Mon,  9 Sep 2024 14:40:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9F97214D9;
	Mon,  9 Sep 2024 14:40:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Okke Timm'" <okke@timm.sh>,  <git@vger.kernel.org>
Subject: Re: [bug?] git diff --cached in a non-git directory
In-Reply-To: <05b501db02ce$3bd49e30$b37dda90$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Mon, 9 Sep 2024 11:37:46 -0400")
References: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>
	<05b501db02ce$3bd49e30$b37dda90$@nexbridge.com>
Date: Mon, 09 Sep 2024 11:40:16 -0700
Message-ID: <xmqqy140pt67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5EEDED4-6EDA-11EF-A422-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

>>error: unknown option `cached'
>>usage: git diff --no-index [<options>] <path> <path> [...]
> ...
> Because you are not in a git repository clone, the --cached option has no
> meaning.

Yes.  "git diff" unfortunately has a mode where a limited subset of
its features is available and that is called the "--no-index" mode.

Because the command is capable of working outside a repository, "You
are not in a repository" is a not a good error message in this
situation, either.  It is not that you stepped outside a repository
that is your error.  It is not that you used "--cached" that is your
error, either.  You used "--cached" outside a repository, that is
where your error is.

A patch to improve the error messages in such a situation is
certainly welcome.

Thanks.

