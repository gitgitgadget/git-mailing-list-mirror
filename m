Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159E39AEC
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741713; cv=none; b=E0rom7FN0wVjqzOSjgmBK3cKbG+odb/9Y5ISPEs+T7Dashd6lPDaSPzVZvS6LRs9zV1xEDPkrtBJhi6hQ5GiDl2Lo00k/yeih8Fd3j6ywLR0xhrJrHJJCStSyJzBBIj1CtQL2uH1R2Lev5bxa9MhNrk+J8lJVtN2K52J4N5S27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741713; c=relaxed/simple;
	bh=r182SHhvog4mzEptxo/1h+s4Ccqb0HHJnm81tdFT6oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WO2EJzAMX5i+W72LO46wwkkgMz3Up6OhOU0FKHVo85W6sq2aT4+Fa6c4zx+GWB698efcPjx2UnT1vXlDvEdJiBx9t4LmVFEsyDBHEEOZT4vxHJK0wKi73vj1k0izGrHGGqsgnJQ//vtVaZ+17w5hdKPhzvck0j9PofA8TDkh/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l8KjHqRQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l8KjHqRQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 151021E132;
	Tue, 18 Jun 2024 16:15:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=r182SHhvog4mzEptxo/1h+s4Ccqb0HHJnm81td
	FT6oU=; b=l8KjHqRQ4uOtPzOWhNQsO+B+oL9ED3iAb66IQFHAnYm1zZFRL/teM5
	arDmBAFQWNLOAwhlpEBDx/4sazQktRNBQVGOwVYfNiK5/Yn3/KbQLRDshJMp4R2n
	9crz7OgxBP/bKNEgLDKc/l25oo8aUAs/Z1+3Mgc1ZwXgHmIrwDclA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5C121E131;
	Tue, 18 Jun 2024 16:15:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4CA7E1E12D;
	Tue, 18 Jun 2024 16:14:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alexey Pelykh <alexey.pelykh@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: Non-blob .gitmodules and .gitattributes
In-Reply-To: <14349714-F8D1-4F7B-BB13-4FA39C6819DE@gmail.com> (Alexey Pelykh's
	message of "Tue, 18 Jun 2024 21:07:24 +0200")
References: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
	<xmqqbk43ilk3.fsf@gitster.g>
	<20240618183156.GB178291@coredump.intra.peff.net>
	<14349714-F8D1-4F7B-BB13-4FA39C6819DE@gmail.com>
Date: Tue, 18 Jun 2024 13:14:57 -0700
Message-ID: <xmqqa5jiypmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6FFE95D8-2DAF-11EF-A9E5-C38742FD603B-77302942!pb-smtp20.pobox.com

Alexey Pelykh <alexey.pelykh@gmail.com> writes:

>> But I'd also suspect that other non-POSIX platforms would see the error
>> at open(), and _would_ actually produce an error message. I seem to
>> recall running into this before with Windows, maybe?
>
> Is there an easy way to verify "what on Windows" part? I'd be happy to
> help, yet I'm not sure I got it right what to look for.

Create a .gitmodules and .gitattributes directory, "git add" it, and
perform various operations that want to read them, probably.  Even a
simple "git diff" should try to consult the attribute system (e.g.
because it wants to know if a path needs use custom function header
regexp pattern).  As Peff said, on Linux and probably on macOS, we
will silently ignore such .gitattributes and that is what we want.
On Windows we may see "cannot open" error reported and visible to
the users.

> Surely, reserved names are reserved for some reason. If there's a legit
> reason alike cost-to-support, having an objection would be dumb. Yet
> if supporting would turn out to be of an effort alike dropping the check
> then it would seem having that check brings no value.
>
> With that said, if those are reserved names, why .gitignore is not reserved?
> For consistency at least.

We do not bother with ".gitignore" since we see no security
implications in that file.  But other two whose name begin with
".git" do have some security implications (actually .gitattributes
is designed not to have any, but .gitmodules certainly does), so
we choose to inspect their sizes, contents, and types.

But that raises a few more questions.

What to do about our future needs that may conflict the needs of
users who want to use names of their choice?  If we declare that
any name that begin with ".git" is reserved, there will be fewer
issues, but do we want to and can we afford to?

Also what if we later find security implications in ".gitignore"
files and decide to inspect their sizes, contents, and types?  The
current system not issuing a warning does not give users any
guarantee that the future systems won't (even though we try hard to
avoid introducing such backward incompatible changes, we are human,
too, and we sometimes screw up).

Thanks.
