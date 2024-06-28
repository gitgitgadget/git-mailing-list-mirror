Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27F17C6D
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603262; cv=none; b=bTqk3KUHxZp0EWGF0E8SNtVe1z2ZdY0KdeXdWer05Dcr9IiroRwEBRcwxK1uv2Tzgh8KTMipXpuZ36dVrWovIpbHnOs227V8BAKpoClO8MdtWI1Oicy59tzGNKPXaX8MXA3+DyOBrkysziL97jARF2KSpRhwizANmhm4NTFpAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603262; c=relaxed/simple;
	bh=SAywpMhmTzvop4Eckm8b9F5UbNFhr9YakmeViwvFcT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=blyYeMzR/w7Am5zvvKXlKGvrVOwaaoQqJRJIKocK/aWYk9hYKHJEPHn35ES4n70xhWF7t45EuqfolE4ohRtVbmMty1wLuqywYd2mLr9iNC0lkwXVslPw++v8NQXukI0hoQqUrw/37luiKj5Luc6C0PBWO9u+oLHNCLxUqw0LvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N7ceWAzA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N7ceWAzA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F28532FB0;
	Fri, 28 Jun 2024 15:34:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SAywpMhmTzvop4Eckm8b9F5UbNFhr9YakmeViw
	vFcT8=; b=N7ceWAzAYR2ISQHdG78SzJG28AZWGgDY3pwoyFYRgUTBvc83zqYCZS
	OKKzUMyrUaYSdZfATQjPbqVyzN+HjFR/300Yba2sU52wGIQZQVM749zunL8WTZ/P
	wHFdtkpq4P5pVvvZdzKiCXUGdJT2lS7+otmBNQOPpi72qgJ9wpzm8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 574B632FAF;
	Fri, 28 Jun 2024 15:34:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F01CD32FAE;
	Fri, 28 Jun 2024 15:34:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  anh@canva.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/5] sparse-index: improve
 clear_skip_worktree_from_present_files()
In-Reply-To: <CABPp-BFd7Bk68Omdao5LS0sP5bK1WQ7V6dodB5x8EsncNARxNA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 28 Jun 2024 08:07:44 -0700")
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
	<CABPp-BFd7Bk68Omdao5LS0sP5bK1WQ7V6dodB5x8EsncNARxNA@mail.gmail.com>
Date: Fri, 28 Jun 2024 12:34:15 -0700
Message-ID: <xmqqwmm82760.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6862D6E4-3585-11EF-A49B-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Elijah Newren <newren@gmail.com> writes:

> This version covers the last two outstanding items.
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks both.  Will mark it for 'next'.

