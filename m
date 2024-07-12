Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E515577E
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822608; cv=none; b=sw7luZNEp5oQTXk/wsRYa6L3NdEnpDmC8n/6ktL7s9amRJ6eOtWC16NXCzdiBP9WALY32jwVWz6DULk5M1i82mbh7zCBSW2Igl/vmKor4C4m86UKg60tEWBJm7lwcTp3QemYdMz2mxywXmg1qK0lCSGQd6jT4RRBCkDR7ZSwtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822608; c=relaxed/simple;
	bh=PNn02v7m9/GqtzzKQ146/r3ZBvXkREI+ESMniAtf92I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jv5zJY5IK/BaEF0vw6CeMMcqvdk8teXX8A5k2zmQTu35r+DFMLWiD4rsQrav8DxTC2zpersjAsQzgc6j14V2RjJhUQXH1lz6WEdDlUm/loX8m7+d1vFhbLVmJgPh4WbgtgfTTwvglsQrmz7crANUD1+Xb3wiDKNbABkpV9EZDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jp/np1I/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jp/np1I/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C6B23559D;
	Fri, 12 Jul 2024 18:16:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PNn02v7m9/GqtzzKQ146/r3ZBvXkREI+ESMniA
	tf92I=; b=jp/np1I/HvwKjYIyijBhKRaTfqb2Lqrpj3fTPAkmqmIDIu7NJ2l37e
	QV5soIHfE+Q1DUr7ILWcoy3XLru++qVbnqv0OZ06/aQ3IHAj9W7Jj0XWeMpiDErf
	u3+92TodkLT4CMAYsUcKi9cpyxGD4SE2b/suK2nQm2mXCaRY/zDVg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7402A3559C;
	Fri, 12 Jul 2024 18:16:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 923CE3559B;
	Fri, 12 Jul 2024 18:16:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <3b687707-7aa7-4f4f-8043-0e31fb0c09ce@gmail.com> (Phillip Wood's
	message of "Fri, 12 Jul 2024 14:51:37 +0100")
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<3b687707-7aa7-4f4f-8043-0e31fb0c09ce@gmail.com>
Date: Fri, 12 Jul 2024 15:16:44 -0700
Message-ID: <xmqq5xtal0hf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6CCC9C0C-409C-11EF-9CE3-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Johannes
>
> On 12/07/2024 00:11, Johannes Schindelin via GitGitGadget wrote:
>> Changes since v1:
>>   * This patch series now shares the logic that determines the path
>> of the
>>     Unix shell that Git uses between prepare_shell_cmd() and git var
>>     GIT_SHELL_PATH.
>
> This was a pleasant read, each step was well described and easy to
> follow.

Ditto.

> I've left a couple of comments but I think this is good as it
> is.
>
> Thanks

Thanks, both.
