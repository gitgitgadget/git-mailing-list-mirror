Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F660198A38
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650054; cv=none; b=EgPVaEgW5CObEzWRwtenlSexAxqdkZzZTS402R1XFADWR9LmNHNNxhl1oeZCGpXaeX3AGxgUbKO3tRBJf2CrpqXKstB+njVm1KDRuEFlTdo9Jj0kpnjw/DWQzqzjBZNaM+O5SxdeEz1RwMgylRCLbBg3Paf6z7W+9buNYFV4pSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650054; c=relaxed/simple;
	bh=yje9m9kTPrPV9pNiIt4HEVVUV7ty2OXPy9WcyS7CTBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pf3LdLO2R8tKsnvGGlGNNsHZVzFOx7aoLEzDUGMLwJ4B3MyIdjU7ni8lrCb/MULTd3+DxB6naWf9TMXw/glSER+2QTDHtx5Rk2ZAvX1z1+VsCva5dVOJXlAGINgOrSb50HkIKcQunJuugS27LpDy9ObSheY+5zvpWwNWQDQmt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MStLFmKy; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MStLFmKy"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9233035392;
	Mon, 17 Jun 2024 14:47:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yje9m9kTPrPV9pNiIt4HEVVUV7ty2OXPy9WcyS
	7CTBc=; b=MStLFmKyyDxZwVv6fTxZlQN5KAw9RiOembHwADodAdRk3iAM6MGXF1
	2OH3vA4T5sidct8on2yq8E84MJGckOpZ3j6OSbjMpjjY+H+JJ4usNCzCYQYW04gY
	goZXRW9Xdtxw1PBRAOf9A76Zoqgn+agHc8fOMm11tce1JdmzP1flE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A96F35391;
	Mon, 17 Jun 2024 14:47:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CAE335390;
	Mon, 17 Jun 2024 14:47:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "David C. Rankin" <drankinatty@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
In-Reply-To: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com> (David
	C. Rankin's message of "Sun, 16 Jun 2024 19:36:59 -0500")
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
Date: Mon, 17 Jun 2024 11:47:20 -0700
Message-ID: <xmqq8qz376fb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 083E9950-2CDA-11EF-AE52-C38742FD603B-77302942!pb-smtp20.pobox.com

"David C. Rankin" <drankinatty@gmail.com> writes:

>   Security enhancement in 2.45.1 have broken ability to serve git over
>   https and ssh from local git server running Apache. (web server runs
>   as http:http on Archlinux)
>
>   The fix of adding the following to gitconfig (system-wide and
>   per-user in ~/.gitconfig) does not solve the problem:
>
> [safe]
> 	directory = *

It is not clear what you exactly meant "per-user" above, so just to
make sure.  Is this set in the global configuration file for the
httpd (or whoever Apache runs as) user?

The purpose of "dubious ownershop" thing is to protect the user who
runs Git from random repositories' with potentially malicious hooks
and configuration files, so the user being protected (in this case,
whoever Apache runs as) needs to declare "I trust these
repositories" in its ~/.gitconfig file.  What individual owners of
/srv/my-repo.git/ project has in their ~/.gitconfig file does not
matter when deciding if Apache trusts these repositories.


