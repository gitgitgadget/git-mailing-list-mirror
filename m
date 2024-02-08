Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBC149DFF
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421698; cv=none; b=E4ypxezYTr0bAN2wac2P7INtkUPWpYAkV0J1+2SkwaSETslDSCrrhr25JkCs73zh0KsghnrJU1mddciBhuQopYF1p1iP7WIIx4uhiec+uv2gqhPCvd+6ZAy1uB9Zw2SqBHvv8u3LsL9GxEfhDQvQg4cxuQUP7gjOMudtYw9+7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421698; c=relaxed/simple;
	bh=6k0s+b4O6Y2iRHqOi3bheuGI3BItHPrjqZwCExP0Ye4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qng4rPoPrnUDHGv2vGiHphpVdYT4oHKJodJyAcgTp3xambIiVPuoSDXri0ngrbS8oGvrWIAGCNWHd/R+vTqpwpy1XwVIqRrJb5WmQ8VupbvM+uZEVtEPvSnjIe3AVVMOMII+xGjFU6ChBVhXFo3BqHD+XjFlFjqNsiYF7flUXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pyg5MhmM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pyg5MhmM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8478E3765D;
	Thu,  8 Feb 2024 14:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6k0s+b4O6Y2i
	RHqOi3bheuGI3BItHPrjqZwCExP0Ye4=; b=Pyg5MhmMpfnUP/kbvfudkZGsVmKz
	EG7XC1ZhMf0SOBbcxosTghwKs7ZSsqYNpJUoTQ7Pj+y0ELn+IVefa1UuojYCRP5K
	8X3ltxCgIxBgmbTiA9aEvMtvQ31wPBhtVkk+dOpqlUqIFflFYpZqlm7deqd5CF9D
	MImjl75s+va3i0c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CB703765C;
	Thu,  8 Feb 2024 14:48:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 25AD837659;
	Thu,  8 Feb 2024 14:48:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  Chandra Pratap via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Chandra Pratap
 <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] commit.c: ensure strchrnul() doesn't scan beyond range
In-Reply-To: <8313d9d6-f6bd-4fae-be9c-e7a8129768eb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 8 Feb 2024 19:31:51 +0100")
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
	<ce83bd09-dbd2-4c9e-8197-6e4800935523@web.de>
	<20240208010040.GB1059751@coredump.intra.peff.net>
	<8313d9d6-f6bd-4fae-be9c-e7a8129768eb@web.de>
Date: Thu, 08 Feb 2024 11:48:05 -0800
Message-ID: <xmqqil2yn3ey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FAF5F7B4-C6BA-11EE-9AE7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> But anyway: If NULs are of no concern and we currently end parsing when
> we see one in all cases, why do we need a _mem function at all?  The
> original version of the function, find_commit_header(), should suffice.
> check_nonce() could be run against the NUL-terminated sigcheck.payload
> and check_cert_push_options() parses an entire strbuf, so there is no
> risk of out-of-bounds access.

If I recall correctly, the caller that does not pass strlen() as the
payload length gives a length that is shorter than the buffer, i.e.
"stop the parsing here, do not get confused into thinking the
garbage after this point contains useful payload" was the reason why
we have a separate "len".
