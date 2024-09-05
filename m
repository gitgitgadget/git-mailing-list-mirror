Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016679E1
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558647; cv=none; b=Mg6h0No9s5I9lW8O7K2CveJFxTS9Crlnj2a339Lylfc0sTh1Ci8r/uRmXkfSgS22FLU8aXfLsdlM2GMoYmzRtBi71IByBivkQtE5e7Sxo9OdNOu8dZtkh4G7J1N+h3o60TonGAKft1LECFGXVAN4XvQEGkG9yQUsgZQYOzad0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558647; c=relaxed/simple;
	bh=TkHdtIjq+W2pYrNU2RTCNGp/m8HBexMyjMZW8t5xLac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sXbF7qyVlxAxe6dmhxV88NbfS8ZVJTRrM4jla20qaEVGPaz+BI1lxgE/6Kokcgiy0Bw+nWKrh7T8w+3tiknLPRMPLLrc+r4IjangYkwk4wCoBBlDH+1NdF1Rs7IZaoLZASbhdxL7/7Ckg5eWzyZ7juSGnJp7aq0luoDcKlnLkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pU4qS7fY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pU4qS7fY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFE642D67D;
	Thu,  5 Sep 2024 13:50:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TkHdtIjq+W2pYrNU2RTCNGp/m8HBexMyjMZW8t
	5xLac=; b=pU4qS7fYJu6zd9gCxHsoSbH5MJtX5IfJn09IrKQoqhY1L230B7STJe
	p4WQ3a27wUJEtNq8nUbWKizdWapd7bdh/QaOvVXr1Mk0imY0t/XqeVxTvDhwzpne
	pG6pO3Paftj3STfsPDOpMzzR3sSTnV23AzUlcFmvsUxiZB70EAl+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E4B872D67C;
	Thu,  5 Sep 2024 13:50:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D4CF2D67B;
	Thu,  5 Sep 2024 13:50:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Xing Xin <bupt_xingxin@163.com>,  Xing Xin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Brandon Williams
 <bmwill@google.com>,  Jonathan Tan <jonathantanmy@google.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH 3/4] builtin/clone.c: recognize fetch.serverOption
 configuration
In-Reply-To: <Ztm1w_61vjEkiC4C@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Sep 2024 15:44:41 +0200")
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
	<ZtbgafDQwbU9tBoq@pks.im>
	<366dd64e.7b53.191bc028796.Coremail.bupt_xingxin@163.com>
	<ZtmQZQHnwYLNvT0F@pks.im>
	<3ce04aef.b004.191c21a2159.Coremail.bupt_xingxin@163.com>
	<Ztm1w_61vjEkiC4C@pks.im>
Date: Thu, 05 Sep 2024 10:50:43 -0700
Message-ID: <xmqq7cbq2dn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FD99E08-6BAF-11EF-B525-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I also have to agree that "push.pushOption" would be way more sensible
> if it was configured per remote. I think it would be sensible to also
> introduce "remote.*.pushOption" in the same way and have it override the
> default value of "push.pushOption" if present. So the precedence order
> would become (from high to low):
>
>   - remote.someRemote.pushOption
>   - remote."*".pushOption
>   - push.PushOption
>
> This should be backwards compatible, too.

;-)  Sounds sensible.
