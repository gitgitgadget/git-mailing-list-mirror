Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BC54F8F
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YdTsxaHe"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 595BE1E35C3;
	Mon,  8 Jan 2024 13:37:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lNMWY+dBUP/sxXH+L6h1xGcssbd55U19VWMHay
	WoU2Q=; b=YdTsxaHe707nw6U1HCfDtev7twZIyeu0+aYBUpFuCWqCljRhERvGQ4
	vxoYTXbZnN8/5ok5/MVa4g38d8LZutwrKyR8VWsuCIr/WcYT1L1nBUP8le/iMhs7
	x6EOCGjSAUlT/bKkqlH6pDeKqGGL3Y2sZslDXgg4vMb20IfSAwvLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 515F61E35C2;
	Mon,  8 Jan 2024 13:37:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8C411E35C1;
	Mon,  8 Jan 2024 13:37:56 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Britton Leo Kerin" <britton.kerin@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] completion: dir-type optargs for am, format-patch
In-Reply-To: <8a8dfcfc-3369-42b8-8387-f1af33202b16@smtp-relay.sendinblue.com>
	(Britton Leo Kerin's message of "Sun, 7 Jan 2024 12:42:00 -0900")
References: <20240107214200.29684-1-britton.kerin@gmail.com>
	<8a8dfcfc-3369-42b8-8387-f1af33202b16@smtp-relay.sendinblue.com>
Date: Mon, 08 Jan 2024 10:37:55 -0800
Message-ID: <xmqqttnnk6ws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A8FE596-AE55-11EE-8CCB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Britton Leo Kerin" <britton.kerin@gmail.com> writes:

> +	local context_dir=$(__git rev-parse --show-toplevel --show-prefix 2>/dev/null | paste -s -d '/' 2>/dev/null)

Is there a practical difference with the above with

	context_dir=$(pwd)

other than that it will give an empty string outside a git working tree?

If not, I suspect

	local inside

	inside=$(__git rev-parse --is-inside-work-tree) &&
	test "$inside" = true || return

	local context_dir=$(pwd)

might be clearer on the intent.

> +	[ -d "$context_dir" ] || return
> +
> +	COMPREPLY=$(cd $context_dir 2>/dev/null && compgen -d -- "$cur_")

Can $context_dir contain $IFS whitespaces here?

> +}
