Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA12941B
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222281; cv=none; b=HRs+B4Xv88My3RqGJR4Hn1QPfykrkn6XhuZB7yb0LqHdkDm7SLBaVb23G7DG9/ZUr7Dl4Hezn6yfjzMbMKvvIKuxK8nF+1SP97BPPyBsNCS7n6ZQMiQPDxqshi4Y5sZVmzuQZNVlKrw4XSXhcttaDS6PFRLcqjT1E4FYqCDNLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222281; c=relaxed/simple;
	bh=KFbz4HfwbjSjqGvTSbraI1MWRCbh7+gOkwkDZkLpx5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ScGPIbwiQhL/3+ut5lENaUb3bIbu5RUdJpJZigsXXr26EdSOUU/xfTgUdiByxuAcG1b5D5IZGg5o5vlaiIGzWpeAfmed5YrItYnOvrZcCxpo0aQGbjRyyMwpwaSAuLbOwZrA3nukVPypixrp2+rDVDvFQI8f70BvfJ4VfSbleMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BrvsydE8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BrvsydE8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE1212CEA8;
	Fri,  9 Aug 2024 12:51:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KFbz4HfwbjSjqGvTSbraI1MWRCbh7+gOkwkDZk
	Lpx5Y=; b=BrvsydE8+NM5mniePjQB8pD9/cSk8qJxxyw7ij1q598g5mc39LZPR8
	T2CeSLF69j0jV4KLya0IeuA+d7TS9znTIWprFEFxMbKBsjgbp12BiZWj2++O0HoX
	sBY+A2qCSD9zMdCiRNmw1s+lKuElIuQpHnhRomGF4fm1TzK9PVulk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A420F2CEA7;
	Fri,  9 Aug 2024 12:51:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 184DB2CEA6;
	Fri,  9 Aug 2024 12:51:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King <peff@peff.net>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <avila.jn@gmail.com>,
  Linus Arver <linusarver@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/3] keep track of unresolved value of symbolic-ref
 in ref iterators
In-Reply-To: <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com> (John
	Cai via GitGitGadget's message of "Fri, 09 Aug 2024 15:37:48 +0000")
References: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
	<pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
Date: Fri, 09 Aug 2024 09:51:10 -0700
Message-ID: <xmqqttftej29.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 957E6160-566F-11EF-922E-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> John Cai (3):
>   refs: keep track of unresolved reference value in iterators
>   refs: add referent to each_ref_fn
>   ref-filter: populate symref from iterator

Looks good.  Let me mark the topic for 'next'.
