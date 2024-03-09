Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2847A7D
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710014183; cv=none; b=o1XC5x0Pv9PUee/XcKvccwbMaKdBSeeiXA7kiJvnHjy+ZkmJaXboyUCdJd38Ije7lM9WSuae8psO9naS7YOgqYogcobVx9/wN2CqpAgP7ZA0p4E7lhHxmXZmFqiFSrw38dPMYJyo6RyuPYRADmfZZtWpGGzYnZrL9gvEiJE2ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710014183; c=relaxed/simple;
	bh=mEzUmTJPGujevmuQEQAYvfQRG1RCP0LcNcW9guUAaao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGFHQugMGZ6xfVDGvSWpRHm28FdWmxxfA0fft5P1pVZ9TMwoldFtcbf7hQPNRmSBYn3NS0iF0xHHVYI82Si97cV/91lOSpl1wGMLd4rZaoNUy4hFnoOsTq53KC5LlWRjkfIRD0S9A8gvGvIWMkvBRWqwzENMhE7G9LZnvmxdreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=roIr6sJo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="roIr6sJo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B8551B28B;
	Sat,  9 Mar 2024 14:56:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mEzUmTJPGujevmuQEQAYvfQRG1RCP0LcNcW9gu
	UAaao=; b=roIr6sJoFZJqYM5SDGKYl+8BsoYSEcF4XuzC/w+ZCS+opF3jq5awBt
	2S1flEvjneqB2c+qcr9GjMIAlDIevAgWNMvVH4yXP86fySFgZYCTENjqyHUGcCwh
	q76cd/YWuqPxQ1cjhRZtAo9AILxYH/GNrlrn+J/N5sXcq61pwaGzk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4494C1B28A;
	Sat,  9 Mar 2024 14:56:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E91B91B289;
	Sat,  9 Mar 2024 14:56:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Philippe Blain via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
In-Reply-To: <b52a8678-a13f-455b-a817-2df2b4fab795@gmail.com> (Phillip Wood's
	message of "Sat, 9 Mar 2024 19:15:16 +0000")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
	<6a31efcc-c6c2-4729-80b9-eecff4ec9e31@gmail.com>
	<xmqqy1axq3t1.fsf@gitster.g>
	<12c84208-23a7-5ba7-18a9-822d9a8f66fa@gmail.com>
	<b52a8678-a13f-455b-a817-2df2b4fab795@gmail.com>
Date: Sat, 09 Mar 2024 11:56:16 -0800
Message-ID: <xmqqh6hfch7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17E4375E-DE4F-11EE-AEC9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Maybe just 'advice.mergeConflict' ?
>
> 'advice.mergeConflict' sounds good to me

Yup, looks good to me, too.


