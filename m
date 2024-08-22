Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3508B1CDA03
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343920; cv=none; b=dvvuIvheFfPnFFlp4ZzWXqzdPyIP4q7clS9x5HrS5MewqtkNgMjGnCST399l4Fl/FU1b85kraCSVeKphqeoaPgdL+00WNsoc41nM601tDvt8EBdm00JFa0EOx+/yzoaMO0RSOwNXuIQUxEQew1pz2a3g5qyGJ+kUbF67kmYHYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343920; c=relaxed/simple;
	bh=PYu6JL1euT2AMS2R0mO/bYPfFnbv1woHEaib9xWb73g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FFxEsTlDpcVS9ypKQWE5W3DmXR9yutqMTLOk9aJPgXPnMHeMZjWKCwAEguOhxzTjMv1Kco/z6nvZBGYB+5kja70iAbHcJUHnMtOiZO3Dvvzw8+UU9x0wFWYurmhu1LCtkvRfkFOqDs3AgV24nTP7jvUQvdjyv+MEW/z1fBnmbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RgtKtbsI; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RgtKtbsI"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A1BE61F6B3;
	Thu, 22 Aug 2024 12:25:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PYu6JL1euT2AMS2R0mO/bYPfFnbv1woHEaib9x
	Wb73g=; b=RgtKtbsI6Rs43JD9+MIATs0DcDW3KndCPTpvEH9RBV6O3KexDYdB9e
	KtcQ9MKUtnTkSgREPV0xcpV7zBIerddJt49MZUKxxOh3u0ggDwDJbz5UYT7v3Ej7
	7NpTXPEQ+h6wj2M3PkX80HGLo6r9Cj4idrh5gX+LR8+ADjz3I0ewE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 99B241F6B2;
	Thu, 22 Aug 2024 12:25:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 296711F6B1;
	Thu, 22 Aug 2024 12:25:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  ps@pks.im,
  james@jamesliu.io,  peff@peff.net,  gombasgg@gmail.com
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
In-Reply-To: <e90949ed-8065-4498-9ddb-3d5c6afa7b35@gmail.com> (Derrick
	Stolee's message of "Thu, 22 Aug 2024 09:15:42 -0400")
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
	<e90949ed-8065-4498-9ddb-3d5c6afa7b35@gmail.com>
Date: Thu, 22 Aug 2024 09:25:13 -0700
Message-ID: <xmqqcym0sexi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1CDBCE30-60A3-11EF-B0A1-BF444491E1BC-77302942!pb-smtp20.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 8/21/24 7:02 AM, Derrick Stolee via GitGitGadget wrote:
>> Advice is supposed to be for humans, not machines. Why do we output it when
>> stderr is not a terminal? Let's stop doing that.
>> I'm labeling this as an RFC because I believe there is some risk
>> with this
>> change. 
>
> Thanks, all, for the feedback about the risk of making such a change. I
> agree that we should not pursue this direction.
>
> The main issues are:
>
>  1. Some tools create a wrapper around Git and may want to supply the
>     advice to the user by parsing stderr.

Or they may just pass it through to the user without even parsing.

>  2. The advice system has been on for a long time and we cannot know
>     where other dependencies could be for it.
>
> I'll abandon this RFC, but plan on the following action items:
>
>  * Document GIT_ADVICE in Documentation/git.exe.
>
>  * Modify Documentation/config/advice.txt to mention GIT_ADVICE and
>    recommend that automated tools calling Git commands set it to zero.

FWIW, not documenting it was very much deliberate to discourage
folks placing it in their ~/.login file.  I am OK with the above as
long as "this is for tools" is stressed well enough.
