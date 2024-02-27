Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CF1EEE7
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058613; cv=none; b=KAc3Mx4WB7YKui9bVB7SWPjTMc7HP+kIXBG9rPRh1SRCcsa/0nPHkiILcqRaxj2qEEmQzx6fLwVoPllY3+sINQ3g9YvT8V6toHWsBduJemfuYdv/kVdbyajctoDcanoZKGcTMMYVEZRwaLDdZxFh/gvQTj+SyCVElX8Zmiudm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058613; c=relaxed/simple;
	bh=YzkNdHKvEuBZmHaouqGLCAKLasX2MzBuv2eRiDX0UWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwNx56hmxMq7o7SMLN0L3GeQeYoEZUylIdRA2jjakP0itNbZfsOSHOnkHprUH9/+AVrz/OpQ5VkkD0RN2rvaSqlCDOZgQSX3dTTMIf5AvvVe2+q9BGAvheikXeZZfpcv77f8Gy4ou8cgoiNHO3D34VNlRU0s2BodK4kxoTFzAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lEW4kaqW; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lEW4kaqW"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDEA51DD141;
	Tue, 27 Feb 2024 13:30:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YzkNdHKvEuBZ
	mHaouqGLCAKLasX2MzBuv2eRiDX0UWs=; b=lEW4kaqWSHhC0H17iMuwRcoAuq/s
	C1VYZKEPWYafguuJUnd3rzn/ypvsgl13z/vj+oZo4Ayup6oDI8D53tLPUOvaS5WY
	uk1Y3XdQHDvixuPSHbuZSq02RTeV0vNfCyk1c8tXKH8KJX5bOoaWW1ibswE1wIg3
	GLjkGbxRHRu5Kwc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E08231DD13F;
	Tue, 27 Feb 2024 13:30:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E62F61DD137;
	Tue, 27 Feb 2024 13:30:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  git@vger.kernel.org,
  Johannes Sixt <j6t@kdbg.org>,  Elijah Newren <newren@gmail.com>,  Michael
 Lohmann <mial.lohmann@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>,  Michael
 Lohmann <mi.al.lohmann@gmail.com>
Subject: Re: [PATCH v5 0/2] Implement `git log --merge` also for
 rebase/cherry-pick/revert
In-Reply-To: <ff5a3954-4e7a-42b7-988e-f306b45918bf@gmail.com> (Phillip Wood's
	message of "Tue, 27 Feb 2024 14:00:22 +0000")
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
	<20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
	<ff5a3954-4e7a-42b7-988e-f306b45918bf@gmail.com>
Date: Tue, 27 Feb 2024 10:30:01 -0800
Message-ID: <xmqqmsrlsqty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3A0094A4-D59E-11EE-89E7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 25/02/2024 21:56, Philippe Blain wrote:
>> Changes in v5:
>> - Marked error messages for translation and tweaked them as suggested =
by Phillip
>> - Reworded the message of 2/2 as suggested by Phillip
>> - Removed the change to gitk's doc in 2/2 as pointed out by Johannes
>> - Fixed the trailers in 2/2
>> - Improved the doc in 2/2 as suggested by Phillip and Jean-No=C3=ABl
>
> These changes look good, thanks for making them. I agree with the
> other reviewers that it would be nice to improve the wording of the
> error message when we find a symbolic ref. Everything else looks good
> to me.
>
> Thanks
>
> Phillip

Thanks for a review.  Queued.
