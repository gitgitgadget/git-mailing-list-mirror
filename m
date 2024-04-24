Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F315EFAC
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975288; cv=none; b=al/VFU3OC2Q84hA+euPou+8MNzyh8E9VX7aIgkbP/WwXjMUYzhg1Q6mWq+Mua9vq7e/HN+SjLmI7ChM9RKK95Uzp7tghH1Nqmm7M2E/a9qMeDZvTaPT7DQJm8HOsXpqEk1SvyYSL4JxyfwDrAFlzX0izF9k7/AvLrftao+VWNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975288; c=relaxed/simple;
	bh=MdX1yCUerP8qQ58mwEb0LM3+q6myfSoMqg4v5lwC3RU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mV/ebyuOscfh7Wm/fbHqpL76r0REXPw3vyg7axtaAK4qfxmC/OJGIq22LN0mGocv4Z0Vf/fj+oBJIuCyz5NqY/3/aeCv82nRUneSRKGKtt3f5tc08ZTQpKihNb2GXRKuU/LicrmNzWhqiOQZyoXEPSvdL/RNUvAcruUaYQk8hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ccBJjy63; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ccBJjy63"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713975283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OpD06wTxTQn6WCeZROy01COkvj18ZY+qDkjX8LoJ6U=;
	b=ccBJjy638kRfosTsDkIqfonZRtxKPrlnyKDF3FPsqNIS0+Zv0ejUul7IpdDYbqlMNkZJtZ
	VJUTbSUiB6zwKSDB03moFH42xCpl7e5b7UMbWF6sdsYemwlTIa7wFYDVLl8SMGx8rV8uLR
	j97wOFAnMojI4dWBr1l0dMEMj98361kSxe+Egfy9BA0oq6oL3m9qZiMNVN4aHi7ey0RxLU
	GDo/VCSwVpczUxcrUKtD0E6+PxcdSra1qQ+iyCRCJ96mj/f73RpWzVu4UVTJHB+1N5hlnH
	IU3vAF1vZSrOa0uPO807KVjze9mSyc3SRDsxeuCBTBYiMuHfRi11Znnz3Oua9Q==
Date: Wed, 24 Apr 2024 18:14:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>, James
 Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <ZikSNSszRzBz715c@ncase>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g> <ZiirKgXQPLmtrwLT@tanuki>
 <7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com> <ZikSNSszRzBz715c@ncase>
Message-ID: <9befd5382109eae65e1c177ff6f04f60@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-04-24 16:07, Patrick Steinhardt wrote:
> On Wed, Apr 24, 2024 at 02:52:39PM +0100, Phillip Wood wrote:
>> On 24/04/2024 07:48, Patrick Steinhardt wrote:
>> > On Tue, Apr 23, 2024 at 11:28:03PM -0700, Junio C Hamano wrote:
>> > > Do not close that communication channel on us.
>> >
>> > While I agree that it might not be a good idea to set it for our users,
>> > the usecase mentioned by this patch series is scripting. And here I very
>> > much agree with the sentiment that it makes sense to give an easy knob
>> > to disable all advice (disclosure: James is part of the Gitaly team at
>> > GitLab, and that is where this feature comes from, so I am very much
>> > biased).
>> 
>> Maybe an environment variable would be a better fit for turning advice 
>> off
>> in scripts?
> 
> Sure, an environment variable would work just fine for our purposes. It
> would probably also address the concern that users may disable all
> advice and then miss out on some information.

Sounds good to me.  I'd support the addition of a new environment
variable for this purpose, perhaps GIT_NO_ADVICE or similar.
