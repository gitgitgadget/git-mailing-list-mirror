Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7C1E536
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969069; cv=none; b=MbV/BhjLX/iR0MbbcU1aQpHMpBNXQTADaKqeLQ3Y29Gi4Wd6tfcxt95FaEP1AVPkDRNlDjhuKKxVjbWEcCV3ShosLv2BLlXxdAdWLc8AGR0QWmEvqSvCXTxBYiPSwhd1/oy/Q/YNafu7DAJ6SxEEAjBAU7QtwLTHFBKxz4TxRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969069; c=relaxed/simple;
	bh=U9atQdpILbsMqtASYqzxrVdMM5gWj4TGFc1kCBSl4fM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCZgB4AyvC6sZuAhUbkm1w3IKLuCAZh/Y19b4ymyN4yHnN8mVHmecbwRzpUDrdpghGWsXb9HWKc0Cb99EwxK9h/s3AAblOjw8yLkv2Uk/oAWI8jkUMkzSqshKDn1DOZrDcQEmJZNjikPotOlR8tZs+hTeq6pgzGuJh5Lb7XHJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Js4k3f4j; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Js4k3f4j"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCD911ABFA;
	Wed, 24 Apr 2024 10:31:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=U9atQdpILbsMqtASYqzxrVdMM5gWj4TGFc1kCB
	Sl4fM=; b=Js4k3f4j4kri4EpIY+/qHVUQsB4f1cfhGlIO8sAT7xiPY0inIBMxPO
	VBGqX24vPEPDfkuharbvOaczTjMNqIBBwZEaKzpKjcSuEovZsricd0Icp7f8rP3p
	8m6WyCKHvbscrsnM0qilhBHniBAEEa0+U1oOagZK6nGBbhVf8QbvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B4FF91ABF9;
	Wed, 24 Apr 2024 10:31:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E05E51ABF8;
	Wed, 24 Apr 2024 10:31:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: James Liu <james@jamesliu.io>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <ZiirKgXQPLmtrwLT@tanuki> (Patrick Steinhardt's message of "Wed,
	24 Apr 2024 08:48:10 +0200")
References: <20240424035857.84583-1-james@jamesliu.io>
	<xmqqo79z2s24.fsf@gitster.g> <ZiirKgXQPLmtrwLT@tanuki>
Date: Wed, 24 Apr 2024 07:31:04 -0700
Message-ID: <xmqqfrva3k9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48D17838-0247-11EF-9D02-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Do not close that communication channel on us.
>
> While I agree that it might not be a good idea to set it for our users,
> the usecase mentioned by this patch series is scripting. And here I very
> much agree with the sentiment that it makes sense to give an easy knob
> to disable all advice (disclosure: James is part of the Gitaly team at
> GitLab, and that is where this feature comes from, so I am very much
> biased).

Of course, as you mention, the kosher way is to use the plumbing
where there is no advice messages.  If certain functionalitly is
lacking in the set of plumbing commands, adding them would benefit
everybody, not just Gitaly.

If this is for scripting, make it easy for scripts to use while
making it very very hard for users to trigger in their interactive
environments.  A configuration variable, by design, is a very bad
choice to do so, as it is "set it once and forget about it", which
defeats the whole purpose of advice messages.  An environment
variable is very much in the same category in that you can set it in
~/.login or ~/.profile and forget about it.

A "git" wide command line option, similar to "--no-pager" or
"--literal-pathspecs", is probably an acceptable avenue.

Thanks.
