Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25518654
	for <git@vger.kernel.org>; Fri, 10 May 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362824; cv=none; b=D1ZJ9dpeIbS7Svruj/UzeqtHmZrZfbVARJKintXShr0r4rgR4gGd4BCkvEzQC0R00mFC89KkOmnfTOQWZksRzs7a4Zecx0Rmu6BpqPhQ4ZNtosqTqfN9EJwkKOMPHKOHxOSh0bVL4Sdmr2DwrDKME5e+N+mmKE6R3WJ+OM50vDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362824; c=relaxed/simple;
	bh=bbBHWYTTLQ6JAfl+qWwTMMG3PDG+9hrtwR7uG7U3djs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mBGzLe4SzDGGAHA+FJCaOaPMT4BmMulydMy4tqzFEMBiwXZClPUr8PaIJTPXAUKtCsLKZqIhZ/q1Z9Upcob+asgkoI1+LIGyIfvz7ofCuJ7Tf6eC2GAl7xLi730CatJe2IsWmGxL+f0JOUxLhVt+Cnh9QcKscpofvq44zLBeUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wH0/AdwN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wH0/AdwN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB889256A4;
	Fri, 10 May 2024 13:40:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bbBHWYTTLQ6JAfl+qWwTMMG3PDG+9hrtwR7uG7
	U3djs=; b=wH0/AdwNcq9HQWPFsA71g82rDZ92ho+nkkTIsYECQZ2f327ers5PmA
	Vzeg5nD7gql0TImQe0ebM9PWdMWv1iC7Skn9c1p8xQbitb3CFbZqZpDiDCu6WgFV
	w84XrKorw+VuHCR5HTa3BsQpMl87rqjZHN5wanNlhiYu7LZh0lriQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3003256A3;
	Fri, 10 May 2024 13:40:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53366256A2;
	Fri, 10 May 2024 13:40:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/21] builtin/config: remove global state
In-Reply-To: <cover.1715339393.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 10 May 2024 13:24:23 +0200")
References: <cover.1715339393.git.ps@pks.im>
Date: Fri, 10 May 2024 10:40:20 -0700
Message-ID: <xmqq4jb55zwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FC8DEA0-0EF4-11EF-95C6-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> we have quite a lot of global state in git-config(1). For one, this
> global state is used to track options passed by the user. And second,
> there is a lot of global state that is really only used to pass data
> between caller and callbacks.

Long overdue.  It is very nice to see this happen finally.  

Even though I somehow feel that the clean-up should have done before
the "subcommand" series, it may probably not worth the churn to flip
the order of the series around.

Will take a look.
