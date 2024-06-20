Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E4E1AD3E9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904513; cv=none; b=kMpj/5Czl/5oyJIvmVeR2tkUuUBbM/TQUWki/+vKj+QO5pV8Or8gpjK8Nik+tcPYB0C/n/1buKTXV+zxSNzfRCklE4pHYY8vwGSDfcPmy07JmV+oDHWhNfwJxgDMBI2ngewkiWed086kYanTNmPfrRYGwY9UH97AaENh0M0vBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904513; c=relaxed/simple;
	bh=WWqy4CB1rTVUQ7mIflCsIUBTxFYb06MI49I2TqMroLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RQi0nqbajyHV++tNj2pNRvlAz6/+haCIq3froK5+ROJ19gMgJwpAtUkORkbugpoFLGdqH12M84380Au8nmJIXg9975pD7uGfXYLLVNYZRZLE0HYl/C5v2ljaT+Qcn/FICFfzwnNRkvNOH+ySIxbmGTkzUTWPhXVd7+zlJW1Q/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bvygdBhH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bvygdBhH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3052A2E92C;
	Thu, 20 Jun 2024 13:28:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WWqy4CB1rTVUQ7mIflCsIUBTxFYb06MI49I2Tq
	MroLY=; b=bvygdBhHOQ1hrH+UA0awU4OmmZukscY7ilNWjMwMYFI9xlCL1V3Lpm
	Okt//l6hl/j6p+9jA+cS+MnNElc+NkZmKJhga8OBucVscaI0ktAjPvpL4hEJXQza
	nQoYLo9conA5q67Xl1dhUKKsJCcruGQoCDhhHzegExOvwSmMszreE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AFCE2E92B;
	Thu, 20 Jun 2024 13:28:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C795A2E92A;
	Thu, 20 Jun 2024 13:28:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by
 default
In-Reply-To: <20240619175633.M826655@dcvr> (Eric Wong's message of "Wed, 19
	Jun 2024 17:56:33 +0000")
References: <20240617104326.3522535-1-e@80x24.org>
	<20240617104326.3522535-3-e@80x24.org> <xmqq1q4v5m5a.fsf@gitster.g>
	<20240618213041.M462972@dcvr> <xmqqzfrhyg8j.fsf@gitster.g>
	<20240619175633.M826655@dcvr>
Date: Thu, 20 Jun 2024 10:28:26 -0700
Message-ID: <xmqqiky3wmkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 816D4A86-2F2A-11EF-9F72-C38742FD603B-77302942!pb-smtp20.pobox.com

Eric Wong <e@80x24.org> writes:

> OK, fair enough.  Given t1006 is mostly sh, I prefer keeping v2
> as-is because the Test::More->builder munging of test numbers in
> t9700/test.pl is nasty too and I wouldn't enjoy duplicating
> those bits in a hypothetical t1006/test.pl, either.

That is quite sensible.
