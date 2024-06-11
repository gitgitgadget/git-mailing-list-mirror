Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4F770FF
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133628; cv=none; b=nQAmkZQz4+JlpTYwqC7K6KEDqhz7Hdd4PV3OwJLRUGhTPBwKNnZ5Yf6Qy9312Gn+S0yu0AIN1zHNwi7Nf+Gic8ByKPd3ETXv1AmaqHu1kSn7pKPoqfqsnBQljAWT74gETHPLXkAhWa+FidBmUDloUDUgny3tn0JmvgzAvLFxO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133628; c=relaxed/simple;
	bh=eF8chUYwIyVN0VylbIdh2bWM5GNS+CAeRiSmscy8Vgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o45BKBwJWr13vQjqeaYsXQxgC8975MhHUiWYnICNPmWwdCr0GoHXH3LqgoJ+kbkMgwdadAM8UCAwpnUFvrn058jFufUmwB7COoAXhpOAhm/TdYsD//DkZvxmVR7k96iSf9p4hbkCqds2JPkFg2fB7ktP3rdu9zkE0Yb/UAIkJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RCiF3At+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RCiF3At+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 07323274A4;
	Tue, 11 Jun 2024 15:20:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eF8chUYwIyVN0VylbIdh2bWM5GNS+CAeRiSmsc
	y8Vgo=; b=RCiF3At+F/JWORsSuaLahRUE3wcBKq/M024lNohShoDrBNi7AmHwlC
	arS8KBa8daXlWLMZcSO5lAWQO+jlKKbFx7b/NJVMJlXPL5zyrvPPe63D4DskIegq
	9w8ybmcmEzPLhugnZVMwa6bomE2h0kEgR26ixjSJ/1K6qddPwn1us=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F362F274A3;
	Tue, 11 Jun 2024 15:20:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AFB442748F;
	Tue, 11 Jun 2024 15:20:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v6 2/3] fetch-pack: expose fsckObjects configuration logic
In-Reply-To: <d21c236b8dec9fd8c81a4224c1f63c511b04d8b9.1718109943.git.gitgitgadget@gmail.com>
	(Xing Xin via GitGitGadget's message of "Tue, 11 Jun 2024 12:45:42
	+0000")
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
	<pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
	<d21c236b8dec9fd8c81a4224c1f63c511b04d8b9.1718109943.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 12:20:22 -0700
Message-ID: <xmqq5xufuw09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A6B2FB4C-2827-11EF-8FEE-C38742FD603B-77302942!pb-smtp20.pobox.com

"Xing Xin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (fetch_fsck_objects >= 0
> -	    ? fetch_fsck_objects
> -	    : transfer_fsck_objects >= 0
> -	    ? transfer_fsck_objects
> -	    : 0)
> -		fsck_objects = 1;
> +	fsck_objects = fetch_pack_fsck_objects();
> ...
> +int fetch_pack_fsck_objects(void)
> +{
> +	fetch_pack_setup();

OK, this one is designed to be as lightweight as possible when it
has already been called, so a potentially duplicated call would not
cause too much worries here.

> +	if (fetch_fsck_objects >= 0)
> +		return fetch_fsck_objects;
> +	if (transfer_fsck_objects >= 0)
> +		return transfer_fsck_objects;
> +	return 0;
> +}

Much easier to follow.  Nicely done.
