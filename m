Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E9478E3E
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196901; cv=none; b=FqbTc/jOwK8pil6h3400m5Bw6FyM+bm/EQH1fUYJ5pze84ClL9BPzLU3h+l5oLVZc+OIyT0pyfR5pRpSITZW1BhCiGFfR6VyXqHeNTgnjdM5SCQ7fSlV0jqpHrpi1cDWKLhrjkNW9VLabbqkVuZA3dNpKHyCl4oORG/EwMj/gao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196901; c=relaxed/simple;
	bh=w2nY75RGIXvr8j3AmHkOPntmC7iKVoQyKCREKz9DJL4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cnHKVGZXxY5x/Ebx16CTbfWkoTGUp7O8QunU5G503pqiTnCzjA7X/pZBO0D0j2ooMn+Bcd8RGSeSelfXIAY7BQPHIBrhqwPcRkwIN/D3Hl5rlvCX2B9hCdCWBZMa0cMXXLi7G87yZV3Z8tkofkgmftMOJ2NTaWszi5Hauuwr9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=Mzarzsk5; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="Mzarzsk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1791196898; bh=w2nY75RGIXvr8j3AmHkOPntmC7iKVoQyKCREKz9DJL4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Mzarzsk5eafTYxmmSUl3f4+LcJiRBaIaW+3J1yM9sFQW/vcA5ILLM7tSSaQS0P/58
	 AZCgxD4Vzm7sBqiicKdIfvRU5K/PSG5/95er3bHdnj/DvCPI1WTOr/5EdO92rCUHmX
	 0GM2JmbV4aw4L25iv5vdsVaKOiQpFgtjXI3XuHow=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 8EBAD61F3B;
	Mon,  5 Oct 2026 10:41:38 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 06:41:31 -0400
Message-Id: <DLWUB05MOV7T.2XA7NG57870ZD@lfurio.us>
Subject: Re: Question: behavior when reverting a commit from a shallow clone
Cc: <git@vger.kernel.org>
To: "Patrick Steinhardt" <ps@pks.im>, "Sphinx" <sphinx9692@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CALfz8Qx63qNoSbXq7C7u+KwX4=HCL7=uOUahpXd6j7KvW_c_Eg@mail.gmail.com> <asNKZpxiuFhVkVQd@pks.im>
In-Reply-To: <asNKZpxiuFhVkVQd@pks.im>

On Mon Oct 5, 2026 at 2:57 AM EDT, Patrick Steinhardt wrote:
> On Sat, Oct 03, 2026 at 02:24:42PM +0530, Sphinx wrote:
>>=20
>> If an operation is then performed to restore/revert B, I was looking
>> into the behavior when the resulting working tree/index becomes empty
>> =E2=80=94 effectively causing all tracked files to be removed.
>
> Yeah, this can indeed be surprising behaviour. The reason for it is that
> in a shallow clone, we rewrite the boundary commit (so in your case B)
> so that it doesn't have any parents anymore. It thus looks like just
> another root commit that has added all files in a single go. And the
> consequence of that is that reverting it will then delete everything.

Separate question from the sidelines:  As a non shallow clone user, this
makes me wonder if/how these boundary commits might be munged to
preserve original commit ids in the clone?  eg: so a fast-forward
pull still works for future content
