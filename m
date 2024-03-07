Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DA64AAA
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845994; cv=none; b=TROzOFsjgQpZ7rk0KRrAcBE2wKVVfP4/lmMKXEbXjSymf6cfgLsxtCs5Zl7zcRt0qDWD+uxsoA2zY0Z6Ai/+m7YduHfniLaOSn3eiJD7adNY82Qox8uS37/orZqtqMH2QLd69JgRkaNqBVr+kXrA5FTSrCVRftHx1cq8csUuNQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845994; c=relaxed/simple;
	bh=YjTBIlyLLtWwdcRs8EjjH1rEKOZHjuCxio4hP45KUBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1TjKRqJ1GrrLDqbsHn3KjA9hmzdanJeHbPAhBF+46Vnb9H3qmqmrenaIRHedQDJwz6mUsmj0VkHOSTGYhLQW9Vng8BiNdgNtei2eQMB1spLe7qtIzQuRbWTd7C0DavS3NOcY9HKGKFASJENW1h4stuwiXyHlpFOnciXVlXzkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aRGRcOy2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aRGRcOy2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 873AE1EF8D4;
	Thu,  7 Mar 2024 16:13:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YjTBIlyLLtWwdcRs8EjjH1rEKOZHjuCxio4hP4
	5KUBg=; b=aRGRcOy2M56UWa7PwMaz+5Ykn/5XN17XMDk/iLicjAdp7Zmd/X6W/6
	npnpp3mDlmaPG8oQUStOkHN7QXVmNGzPcvQ8Yd4G4e8xs3vs/BcCiQEyDrgQb14d
	ZjFV+LucRpWQZB4lrwmQYX797r1wYxWecuEHKTH+t6hnzlW7UtaAw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F7631EF8D3;
	Thu,  7 Mar 2024 16:13:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B44DA1EF8D2;
	Thu,  7 Mar 2024 16:13:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  Jonathan Tan <jonathantanmy@google.com>,
  phillip.wood123@gmail.com, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 3/3] test-stdlib: show that git-std-lib is independent
In-Reply-To: <20240222175033.1489723-4-calvinwan@google.com> (Calvin Wan's
	message of "Thu, 22 Feb 2024 17:50:33 +0000")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-4-calvinwan@google.com>
Date: Thu, 07 Mar 2024 13:13:09 -0800
Message-ID: <xmqqsf11kaoq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80806D84-DCC7-11EE-AB7D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> +	strbuf_commented_addf(sb, '#', "%s", "foo");

Of course, this will need to be adjusted when it meets the "let's
allow more than one byte for a comment character" series by Peff.
It should now read

	strbuf_commented_addf(sb, "#", "%s", "foo");

of course.

This is a usual "a function changes in one topic, while the other
topic adds more callers to it" problem a maintainer is expected to
handle fine, so there is nothing special that needs to be done by
contributors, but just giving you a head's up when you yourself test
your updated version to ensure it works well with other topics in
flight.

