Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4009E570
	for <git@vger.kernel.org>; Tue,  7 May 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104068; cv=none; b=Oi04U2mOjh/zc7cO6RWdnisIY4YQVlsucAts2i71tNKvGyytuc65NF4bTMGKGscxBCU9VEeoD4C9j3zm9VErrtpqk1q7JAEQAa0K1nbE/HZWRBQ5hoi/Xhx9vGCn0tRd4q1xkl1ZiYyZ/M68iLvn/EpkYNg7dadtR7qooXJ6QN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104068; c=relaxed/simple;
	bh=I+Ebgc4Ni2YHWpqO2AtqREi8LRPKF0gxqikkU328ALA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BCdG/pynWy+a+DDlbSh3q40K//aHlggsMcDFdVPYlZ7EklzmOxROkWMh658z84c2mNl86RCT9PITggoQOra6iD4W9uh/3eb/rwfFRtfN7NaqWu3x/t/RcPvO7tsKA5Z/mkrbGx4Zj1scXvW9x0q8LGklJ36QwL7L9wI8TQQ76qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xwd3Hqpc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xwd3Hqpc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 51CA332F00;
	Tue,  7 May 2024 13:47:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=I+Ebgc4Ni2YH
	WpqO2AtqREi8LRPKF0gxqikkU328ALA=; b=Xwd3HqpcwS9jlDYpqIesyum5+wXF
	StNH+pnD0c9/UfartbsqSuHSjWFby+4NwwbgJQx4S/kNnMDKBpLKsRxUJd80dzQI
	EBJiLH2hAZ/KQ4u+WejakUenci5brYEQRZhlEWXeUN1Kgom5/sH4OGjB3RtzT71f
	M7pVKEwLR5BEtTc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 48D5B32EFF;
	Tue,  7 May 2024 13:47:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B890132EFC;
	Tue,  7 May 2024 13:47:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  takimoto-j@kba.biglobe.ne.jp
Subject: Re: [PATCH v1 2/2] strbuf_getcwd() needs precompse_strbuf_if_needed()
In-Reply-To: <20240507084431.19797-1-tboegi@web.de> (tboegi@web.de's message
	of "Tue, 7 May 2024 10:44:31 +0200")
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
	<20240507084431.19797-1-tboegi@web.de>
Date: Tue, 07 May 2024 10:47:41 -0700
Message-ID: <xmqqv83po6o2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E7A5F5D6-0C99-11EF-A96D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When running under macOs a call to strbuf_getcwd() may return

You spelled it as "macOS" in [1/2].  The hits from

    $ git grep -i 'mac *os' \*.[ch]

tell me that we seem to say "macOS", "MacOS X", "Mac OSX" and "Mac
OS X" pretty much interchangeably.  We may want to eventually
consolidate them to whatever the official name Apple uses, but in
the meantime let's make sure we do not add even more.
